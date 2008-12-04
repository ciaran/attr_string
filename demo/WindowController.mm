#import "WindowController.h"
#import "../attr_string.h"
using namespace attr_string;

@implementation WindowController
- (void)awakeFromNib
{
	// Simple underlined text
	[self addLabel:(attr_string_t(style::underline) << "Foo bar")];

	// Bold label with text
	[self addLabel:(attr_string_t([NSFont systemFontOfSize:12]) << style::bold << "Foo: " << style::unbold << "Bar")];

	// Multi-colour text
	[self addLabel:(attr_string_t(style::background([NSColor whiteColor])) << [NSColor blueColor] << "Blue" << [NSColor redColor] << "Red")];

	// A link
	// Uses another attr_string_t to keep the URL attribute self-contained within the text we want linked
	NSURL* link        = [NSURL URLWithString:@"http://www.apple.com"];
	NSTextField* label = [self addLabel:(attr_string_t("Click here to visit the ") << (attr_string_t(link) << "Apple") << " website")];
	// To make the link clickable within the NSTextField
	[label setSelectable:YES];
	[label setAllowsEditingTextAttributes:YES];

	// An image
	NSString* filePath = [NSString stringWithUTF8String:__FILE__];
	NSImage* icon  = [[NSWorkspace sharedWorkspace] iconForFile:filePath];
	[icon setSize:NSMakeSize(16, 16)];
	[self addLabel:(attr_string_t() << "File icon " << icon << " for " << [filePath lastPathComponent])];

	// Using the global << shortcut
	[self addLabel:(style::underline << "Foo" << style::nounderline << "Bar")];

	NSMutableParagraphStyle* paragraph = [[NSMutableParagraphStyle new] autorelease];
	[paragraph setLineBreakMode:NSLineBreakByTruncatingTail];
	[self addLabel:(attr_string_t(paragraph) << [@"" stringByPaddingToLength:102 withString:@"foo" startingAtIndex:0])];

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

- (NSTextField*)addLabel:(NSAttributedString*)title;
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

	return label;
}
@end
