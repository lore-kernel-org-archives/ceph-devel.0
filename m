From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: rbd volume upgrades
Date: Fri, 9 Nov 2012 11:08:52 -0800
Message-ID: <CAC-hyiEx3DatO+-5GEP7DiiZZEOgyYYFfNKhW1ebSpYmo464Tw@mail.gmail.com>
References: <CAPYLRziMQAR3tiN7syxBMTiiJ-xRVGYCK1MUYHrii5-UHMCnGA@mail.gmail.com>
	<509D53BD.6020706@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:64901 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751689Ab2KITIx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Nov 2012 14:08:53 -0500
Received: by mail-bk0-f46.google.com with SMTP id jk13so1782893bkc.19
        for <ceph-devel@vger.kernel.org>; Fri, 09 Nov 2012 11:08:52 -0800 (PST)
In-Reply-To: <509D53BD.6020706@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: Gregory Farnum <greg@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Nov 9, 2012 at 11:04 AM, Josh Durgin <josh.durgin@inktank.com> wrote:
> On 11/09/2012 11:01 AM, Gregory Farnum wrote:
>>
>> I was asked today if there's a way to upgrade RBD volumes from v1 to
>> v2. I didn't think so, but wanted
>> 1) to make sure I'm right,
>> 2) to ask how hard it would be,
>> 3) to ask if we haven't done it because it didn't occur to us or
>> because it's too hard.
>> -Greg
>>
>
> This was addressed in the original discussions about format 2.
>
> You need to export and then import the volume as format 2. Format 2 uses
> different names for objects, so providing an 'upgrade' path would still
> require copying all the data around.
>
Couldn't we just set a flag in the header specifying the object naming
version, which would then only require updating the header?

Yehuda
