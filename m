From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: widening Messenger::create
Date: Fri, 30 Jan 2015 01:05:16 +0800
Message-ID: <CACJqLyb1Vyf+Eb+fUtEYeBxRvFgiS1nN0gTdcQtTbF5ocgAXVQ@mail.gmail.com>
References: <alpine.DEB.2.00.1501290841420.13723@cobra.newdream.net>
	<572257343.60.1422549896361.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:47973 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752139AbbA2RFT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Jan 2015 12:05:19 -0500
Received: by mail-wi0-f173.google.com with SMTP id r20so29156525wiv.0
        for <ceph-devel@vger.kernel.org>; Thu, 29 Jan 2015 09:05:18 -0800 (PST)
In-Reply-To: <572257343.60.1422549896361.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Matt W. Benjamin" <matt@cohortfs.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel <ceph-devel@vger.kernel.org>

I think it may better that Messenger impl can introspect itself by
"type", "policy", config and related infos?

On Fri, Jan 30, 2015 at 12:44 AM, Matt W. Benjamin <matt@cohortfs.com> wrote:
> Hi,
>
> ----- "Sage Weil" <sage@newdream.net> wrote:
>
>> On Thu, 29 Jan 2015, Matt W. Benjamin wrote:
>> > Hi,
>> >
>> > I'm looking at ways to pass potentially messenger-specific options
>> through the Messenger factory.
>> > The immediate parameter I need to provide is the number of Accelio
>> portals to set up (this should
>> > vary by Messenger instance), but I expect others will be needed in
>> future.  I don't think this fits
>> > cleanly on to the Policy mechanism, though I looked at that.  I
>> think I'd like to provide a
>> > generalized argument to the Messenger factory, which can do the
>> right thing for a given Messenger
>> > (e.g., constructor).
>>
>> In the past we've mostly gotten away with impl-specific config
>> options.
>> Is that not sufficient here?  Because you need to pass different
>> parameters to different instances maybe?
>
> Yes, exactly.
>
>>
>> sage
>
>
> --
> Matt Benjamin
> CohortFS, LLC.
> 315 West Huron Street, Suite 140A
> Ann Arbor, Michigan 48103
>
> http://cohortfs.com
>
> tel.  734-761-4689
> fax.  734-769-8938
> cel.  734-216-5309
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards,

Wheat
