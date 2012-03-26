%hook UIAlertView
-(void)show
{
	BOOL canShow = YES;
	NSRange textRange;
	textRange = [[[self title] lowercaseString] rangeOfString:[NSString stringWithFormat:@"rate"]];
	if(textRange.location != NSNotFound)
	{
		canShow = NO;
	}
	textRange = [[[self message] lowercaseString] rangeOfString:[NSString stringWithFormat:@"rate"]];
	if(textRange.location != NSNotFound)
	{
		canShow = NO;
	}
	if(canShow)
		%orig;
}
%end

%ctor
{
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	if([NSHomeDirectory() hasPrefix:@"/var/mobile/Applications/"])	// only hook App Store applications
	{
		%init;
	}
	[pool drain];
}