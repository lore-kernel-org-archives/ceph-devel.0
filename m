From: Gregory Farnum <greg@inktank.com>
Subject: Re: Ceph Development with Eclipse
Date: Tue, 5 Feb 2013 13:52:20 -0800
Message-ID: <CAPYLRziwaNaDjVj3Zpy7qvJY4MKu-JRCPWziW+5dMW6u5w86Cw@mail.gmail.com>
References: <DUB116-W12467CE5C3C0CAECA94D647E0030@phx.gbl>
	<CBC0FE06F6854C9E8071A40270E28FA8@inktank.com>
	<DUB116-W124FC6A2EE7FCBDD873D42E0010@phx.gbl>
	<DUB116-W13850868466A31861CC70B6E0000@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:36372 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756282Ab3BEVwV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Feb 2013 16:52:21 -0500
Received: by mail-qa0-f46.google.com with SMTP id o13so2027085qaj.12
        for <ceph-devel@vger.kernel.org>; Tue, 05 Feb 2013 13:52:21 -0800 (PST)
In-Reply-To: <DUB116-W13850868466A31861CC70B6E0000@phx.gbl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: charles L <charlesboy009@hotmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I haven't done the initial setup in several years, but as I recall,
once Ceph was built it was a simple matter of doing "New Makefile
Project with Existing Code" in Eclipse. Make sure you've got the C++
version of Eclipse.
Other than that, I'm afraid you'll need to go through the Eclipse
support systems. :)
-Greg

On Mon, Feb 4, 2013 at 9:18 PM, charles L <charlesboy009@hotmail.com> wrote:
>
> hi Greg ...
>
> I waited all day for your reply ...guess u had much to do today...
>
> I can see that no one else can help from the community ..they seems not to be familiar with my scenario...and I see you are the only one that understand my tout...
>
> Pls kindly find time to respond with the steps i need to take ...thanks a million...
>
>
> Regards,
>
> Charles.
>
> ----------------------------------------
>> From: charlesboy009@hotmail.com
>> To: greg@inktank.com
>> CC: ceph-devel@vger.kernel.org; post.the.reply@gmail.com
>> Subject: RE: Ceph Development with Eclipse
>> Date: Mon, 4 Feb 2013 14:01:25 +0100
>>
>>
>> Hi Greg,
>>
>> I guess setting Ceph up outside of Eclipse include doing the following on any linux system:
>>
>> 1. To prepare the source tree after it has been git cloned,
>> $ git submodule update --init
>>
>> 2. To build the server daemons, and FUSE client, execute the following:
>> $ ./autogen.sh
>> $ ./configure
>> $ make
>> 3. Creating a C/C++ project on eclipse and importing the Makefile into Eclipse ...to put the ceph project under Eclipse control...
>>
>> BUT its not working!!! Makefile not visible in Eclipse and wont import... I guess i have missed some steps in setting it up outside Eclipse or the process of importing ...
>>
>>
>> ... I will appreciate your guidance and guidance from the community too...
>>
>>
>> Regards,
>>
>> Charles.
>>
>>
>>
>>
>> > Date: Sat, 2 Feb 2013 18:16:08 -0800
>> > From: greg@inktank.com
>> > To: charlesboy009@hotmail.com
>> > CC: ceph-devel@vger.kernel.org; post.the.reply@gmail.com
>> > Subject: Re: Ceph Development with Eclipse
>> >
>> > I actually still do this. Set it up Ceph outside of Eclipse initially, then import it as a project with an existing Makefile. It should pick up on everything it needs to well enough. :)
>> > -Greg
>> >
>> >
>> > On Saturday, February 2, 2013 at 9:40 AM, charles L wrote:
>> >
>> > >
>> > >
>> > > Hi
>> > >
>> > > I am a beginner at c++ and eclipse. I need some startup help to develop ceph with eclipse. If you could provide your config file on eclipse, it will be a great starting point and very appreciated.
>> > >
>> > > Regards,
>> > >
>> > > Charles.
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at http://vger.kernel.org/majordomo-info.html
>>
>
