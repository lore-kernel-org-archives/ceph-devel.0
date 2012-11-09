From: Alex Elder <elder@inktank.com>
Subject: Re: rbd volume upgrades
Date: Fri, 09 Nov 2012 13:27:06 -0600
Message-ID: <509D590A.2010807@inktank.com>
References: <CAPYLRziMQAR3tiN7syxBMTiiJ-xRVGYCK1MUYHrii5-UHMCnGA@mail.gmail.com> <509D53BD.6020706@inktank.com> <CAC-hyiEx3DatO+-5GEP7DiiZZEOgyYYFfNKhW1ebSpYmo464Tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:39781 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752689Ab2KIT1F (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Nov 2012 14:27:05 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so6435462iea.19
        for <ceph-devel@vger.kernel.org>; Fri, 09 Nov 2012 11:27:05 -0800 (PST)
In-Reply-To: <CAC-hyiEx3DatO+-5GEP7DiiZZEOgyYYFfNKhW1ebSpYmo464Tw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: Josh Durgin <josh.durgin@inktank.com>, Gregory Farnum <greg@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 11/09/2012 01:08 PM, Yehuda Sadeh wrote:
> On Fri, Nov 9, 2012 at 11:04 AM, Josh Durgin <josh.durgin@inktank.com> wrote:
>> On 11/09/2012 11:01 AM, Gregory Farnum wrote:
>>>
>>> I was asked today if there's a way to upgrade RBD volumes from v1 to
>>> v2. I didn't think so, but wanted
>>> 1) to make sure I'm right,
>>> 2) to ask how hard it would be,
>>> 3) to ask if we haven't done it because it didn't occur to us or
>>> because it's too hard.
>>> -Greg
>>>
>>
>> This was addressed in the original discussions about format 2.
>>
>> You need to export and then import the volume as format 2. Format 2 uses
>> different names for objects, so providing an 'upgrade' path would still
>> require copying all the data around.
>>
> Couldn't we just set a flag in the header specifying the object naming
> version, which would then only require updating the header?

That's an interesting thought.  A bit confusing, but only
to the code...

I think it's worth considering.

					-Alex


> Yehuda
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

