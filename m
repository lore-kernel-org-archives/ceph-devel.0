From: Dan Mick <dan.mick@inktank.com>
Subject: Re: rbd STDIN import does not work / wip-rbd-export-stdout
Date: Mon, 26 Nov 2012 09:34:03 -0800
Message-ID: <CAHybQB3qhoAXwhyDz16-D6EOidcPYg4p=hRwc7ag_tAq_Z_edA@mail.gmail.com>
References: <50B36C9F.80107@profihost.ag>
	<50B36ED1.1020108@filoo.de>
	<50B37027.5000701@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:48338 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756771Ab2KZReE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Nov 2012 12:34:04 -0500
Received: by mail-we0-f174.google.com with SMTP id d7so3549789wer.19
        for <ceph-devel@vger.kernel.org>; Mon, 26 Nov 2012 09:34:03 -0800 (PST)
In-Reply-To: <50B37027.5000701@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Oliver Francke <Oliver.Francke@filoo.de>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Yes, it's broken too (there's an issue open on it). I have some test
code done over the weekend
and will be pushing it after review.

Be aware that import/export to stdin/stdout are limited in that they
cannot preserve sparseness
of the image, but they should both be working soon at least.

On Mon, Nov 26, 2012 at 5:35 AM, Stefan Priebe - Profihost AG
<s.priebe@profihost.ag> wrote:
> Am 26.11.2012 14:29, schrieb Oliver Francke:
>>
>> Well...
>
>
> makes no difference:
> gzip -dc vm-101-disk-1.img.gz | rbd import --format=2 --size=40960 -
> kvmpool1/vm-101-disk-1
>
> rbd: error reading file: (29) Illegal seek
> Importing image: 0% complete...failed.
> rbd: import failed: (29) Illegal seek
>
> I think the problem is that ceph seeks in File when it get's zeros (not
> filled content). But seeking doesn't work on stdin. It has to read from
> stdin until there are no more zeros.
>
> Stefan
>
>
>> On 11/26/2012 02:20 PM, Stefan Priebe - Profihost AG wrote:
>>>
>>> Hello list,
>>>
>>> i know branch wip-rbd-export-stdout is work in progress but it is more
>>> than useful ;-)
>>>
>>> When i try to import an image i get:
>>>
>>> # gzip -dc vm-101-disk-1.img.gz | rbd import --format=2
>>> --size=42949672960 - kvmpool1/vm-101-disk-1
>>> rbd: error reading file: (29) Illegal seek
>>> Importing image: 0% complete...failed.
>>> rbd: import failed: (29) Illegal seek
>>>
>>> Anything i've tried wrong?
>>
>>
>> I would assume, that size is already in MiB? Seems to be a slightly too
>> big value... Not tried myself, though...
>>
>> Oliver.
>>
>>>
>>> Greets,
>>> Stefan
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>
