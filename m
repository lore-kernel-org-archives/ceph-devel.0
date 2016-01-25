From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: About ceph_clock_now()
Date: Mon, 25 Jan 2016 21:22:14 +0100
Message-ID: <56A683F6.7030604@digiware.nl>
References: <alpine.DEB.2.11.1601130846500.26381@cpach.fuggernut.com>
 <56A4C8D2.6020303@digiware.nl>
 <20160125000337.GA19230@ultraspiritum.redhat.com>
 <56A5E61E.80705@digiware.nl>
 <2002283349.16405061.1453715910495.JavaMail.zimbra@redhat.com>
 <56A5FF84.8080107@digiware.nl>
 <20160125172252.GA2818@ultraspiritum.redhat.com>
 <56A66099.4030501@digiware.nl>
 <1523354716.24670379.1453744826329.JavaMail.zimbra@redhat.com>
 <56A679BB.4090801@digiware.nl>
 <20160125201451.GC2818@ultraspiritum.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:49205 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932246AbcAYUWZ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 25 Jan 2016 15:22:25 -0500
In-Reply-To: <20160125201451.GC2818@ultraspiritum.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Benjamin <mbenjamin@redhat.com>, Erwan Velu <evelu@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>

On 25-1-2016 21:14, Adam C. Emerson wrote:
> On 25/01/2016, Willem Jan Withagen wrote:
>> 1)
>> Currently the code in Adam's looks like:
>> #if defined(CLOCK_MONOTONIC_COARSE)
>>         // Linux systems have _COARSE clocks.
>>         clock_gettime(CLOCK_MONOTONIC_COARSE, &ts);
>> #elif defined(CLOCK_MONOTONIC_FAST)
>>         // BSD systems have _FAST clocks.
>>         clock_gettime(CLOCK_MONOTONIC_FAST, &ts);
>> #else
>>         // And if we find neither, you may wish to consult your system's
>>         // documentation.
>> #warning Falling back to CLOCK_MONOTONIC, may be slow.
>>         clock_gettime(CLOCK_MONOTONIC, &ts);
>> #endif
>>
>> And this is repeated in a few more locations.
>> Moreover, it will be required to do that a few times everytime
>> clock_getime is used.
> 
> I was originally thinking of just specifying the time constant, but I figured
> that somehow somewhere someone might want to compile on a system without
> clock_gettime. (Windows? I don't know.) Or use the fasttime library or something
> where just switching out the constant wouldn't work.
> 
> I wouldn't worry about people having to do this every tie they call
> clock_gettime, though, since they really ought to be going through the C++ Clock
> abstraction. (At least, in the context of the Ceph codebase.)
> 
Well that is the essential part of all of this. If other parts of the
Ceph code are expected to go through the ceph_time abstraction, then
this is the only place we need to care for OS differences. And the more
clear and obvious, the better it is.

And we should stick with your version.

--WjW

