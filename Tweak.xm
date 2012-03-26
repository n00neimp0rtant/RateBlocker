%hook UIAlertView
-(void)show
{
	BOOL canShow = YES;
	
	if([self numberOfButtons] == 1)
		%orig;
	else
	{
		NSArray* array = [[self title] componentsSeparatedByString:@" "];
		for(NSString* string in array)
		{
			if([[string lowercaseString] isEqualToString:@"rate"])
				canShow = NO;
		}
		array = [[self message] componentsSeparatedByString:@" "];
		for(NSString* string in array)
		{
			if([[string lowercaseString] isEqualToString:@"rate"])
				canShow = NO;
		}
	}
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