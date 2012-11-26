From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: rbd STDIN import does not work / wip-rbd-export-stdout
Date: Mon, 26 Nov 2012 20:35:08 +0100
Message-ID: <2EC6C33E-4909-4AE5-B8C0-5D7A5856EA57@profihost.ag>
References: <50B36C9F.80107@profihost.ag> <50B36ED1.1020108@filoo.de> <50B37027.5000701@profihost.ag> <CAHybQB3qhoAXwhyDz16-D6EOidcPYg4p=hRwc7ag_tAq_Z_edA@mail.gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:59835 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752581Ab2KZTfN convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Nov 2012 14:35:13 -0500
In-Reply-To: <CAHybQB3qhoAXwhyDz16-D6EOidcPYg4p=hRwc7ag_tAq_Z_edA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Mick <dan.mick@inktank.com>
Cc: Oliver Francke <Oliver.Francke@filoo.de>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

Export isn't a problem. But import should handle this correctly. Or does it  write zeros to the object file

But even if it write zeros to the file shouldn't a fstrim fix this?

Stefan

Am 26.11.2012 um 18:34 schrieb Dan Mick <dan.mick@inktank.com>:

> Yes, it's broken too (there's an issue open on it). I have some test
> code done over the weekend
> and will be pushing it after review.
> 
> Be aware that import/export to stdin/stdout are limited in that they
> cannot preserve sparseness
> of the image, but they should both be working soon at least.
> 
> On Mon, Nov 26, 2012 at 5:35 AM, Stefan Priebe - Profihost AG
> <s.priebe@profihost.ag> wrote:
>> Am 26.11.2012 14:29, schrieb Oliver Francke:
>>> 
>>> Well...
>> 
>> 
>> makes no difference:
>> gzip -dc vm-101-disk-1.img.gz | rbd import --format=2 --size=40960 -
>> kvmpool1/vm-101-disk-1
>> 
>> rbd: error reading file: (29) Illegal seek
>> Importing image: 0% complete...failed.
>> rbd: import failed: (29) Illegal seek
>> 
>> I think the problem is that ceph seeks in File when it get's zeros (not
>> filled content). But seeking doesn't work on stdin. It has to read from
>> stdin until there are no more zeros.
>> 
>> Stefan
>> 
>> 
>>> On 11/26/2012 02:20 PM, Stefan Priebe - Profihost AG wrote:
>>>> 
>>>> Hello list,
>>>> 
>>>> i know branch wip-rbd-export-stdout is work in progress but it is more
>>>> than useful ;-)
>>>> 
>>>> When i try to import an image i get:
>>>> 
>>>> # gzip -dc vm-101-disk-1.img.gz | rbd import --format=2
>>>> --size=42949672960 - kvmpool1/vm-101-disk-1
>>>> rbd: error reading file: (29) Illegal seek
>>>> Importing image: 0% complete...failed.
>>>> rbd: import failed: (29) Illegal seek
>>>> 
>>>> Anything i've tried wrong?
>>> 
>>> 
>>> I would assume, that size is already in MiB? Seems to be a slightly too
>>> big value... Not tried myself, though...
>>> 
>>> Oliver.
>>> 
>>>> 
>>>> Greets,
>>>> Stefan
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
