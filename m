From: Samuel Just <sam.just@inktank.com>
Subject: Re: osd/OSDMap.h: 330: FAILED assert(is_up(osd))
Date: Tue, 17 Jul 2012 17:03:00 -0700
Message-ID: <CA+4uBUb237Z-dqyCTe49Ce73Csxz_Kop7U9vbYj35L9CLXiNag@mail.gmail.com>
References: <5005CFDE.5010100@sandia.gov>
	<CA+4uBUZ1j6dx3Z68_BG=eS+nas+mf75Dqf9qV+-0C_UFC=oDAA@mail.gmail.com>
	<5005DEFC.7020701@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:49131 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752177Ab2GRADB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Jul 2012 20:03:01 -0400
Received: by pbbrp8 with SMTP id rp8so1585536pbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 17 Jul 2012 17:03:01 -0700 (PDT)
In-Reply-To: <5005DEFC.7020701@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

master should now have a fix for that, let me know how it goes.  I opened
bug #2798 for this issue.

Thanks for the info!
-Sam

On Tue, Jul 17, 2012 at 2:54 PM, Jim Schutt <jaschut@sandia.gov> wrote:
> On 07/17/2012 03:44 PM, Samuel Just wrote:
>>
>> Not quite.  OSDService::get_osdmap() returns the most recently
>> published osdmap.  Generally, OSD::osdmap is safe to use when you are
>> holding the osd lock.  Otherwise, OSDService::get_osdmap() should be
>> used.  There are a few other things that should be fixed surrounding
>> this issue as well, I'll put some time into it today.  The map_lock
>> should probably be removed all together.
>
>
> Thanks for taking a look.  Let me know when
> you get something, and I'll take it for a spin.
>
> Thanks -- Jim
>
>> -Sam
>
>
>
