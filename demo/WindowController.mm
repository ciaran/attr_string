#import "WindowController.h"
#import "../attr_string.h"

@implementation WindowController
- (void)awakeFromNib
{
	// Simple underlined text
	[self addLabel:(attr_string_t(style::underline) << "Foo bar")];

	// Bold label with text
	[self addLabel:(attr_string_t([NSFont systemFontOfSize:12]) << style::bold << "Foo: " << style::unbold << "Bar")];

	// Multi-colour text
	[self addLabel:(attr_string_t(style::background([NSColor whiteColor])) << [NSColor blueColor] << "Blue" << [NSColor redColor] << "Red")];

	// An image
	NSString* filePath = [NSString stringWithUTF8String:__FILE__];
	NSImage* icon  = [[NSWorkspace sharedWorkspace] iconForFile:filePath];
	[icon setSize:NSMakeSize(16, 16)];
	[self addLabel:(attr_string_t() << "File icon " << icon << " for " << [filePath lastPathComponent])];

	// Using the global << shortcut
	[self addLabel:(style::underline << "Foo" << style::nounderline << "Bar")];

	// A more complex example
	attr_string_t msg;
	msg.add(style::emboss);
	msg.add([NSFont systemFontOfSize:12]);
	msg.add([NSColor darkGrayColor]);
	msg.add("Viewing record ");
	msg.add([NSColor blackColor]);
	msg.add(style::bold);
	msg.add("Foo");
	[self addLabel:msg];
}

- (void)addLabel:(NSAttributedString*)title;
{
	static NSRect rect = NSMakeRect(20, self.window.frame.size.height - 20, self.window.frame.size.width - 20, 23);
	rect.origin.y -= 50;

	NSTextField* label = [[[NSTextField alloc] initWithFrame:rect] autorelease];
	[label setEditable:NO];
	[label setBordered:NO];
	[label setDrawsBackground:NO];
	[label setStringValue:@"foo"];
	[label setAttributedStringValue:title];
	[self.window.contentView addSubview:label];
}
@end
