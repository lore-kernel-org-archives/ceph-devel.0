From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: rbd STDIN import does not work / wip-rbd-export-stdout
Date: Mon, 26 Nov 2012 14:35:35 +0100
Message-ID: <50B37027.5000701@profihost.ag>
References: <50B36C9F.80107@profihost.ag> <50B36ED1.1020108@filoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:59201 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753837Ab2KZNfi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Nov 2012 08:35:38 -0500
In-Reply-To: <50B36ED1.1020108@filoo.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Oliver Francke <Oliver.Francke@filoo.de>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Dan Mick <dan.mick@inktank.com>

Am 26.11.2012 14:29, schrieb Oliver Francke:
> Well...

makes no difference:
gzip -dc vm-101-disk-1.img.gz | rbd import --format=2 --size=40960 - 
kvmpool1/vm-101-disk-1
rbd: error reading file: (29) Illegal seek
Importing image: 0% complete...failed.
rbd: import failed: (29) Illegal seek

I think the problem is that ceph seeks in File when it get's zeros (not 
filled content). But seeking doesn't work on stdin. It has to read from 
stdin until there are no more zeros.

Stefan

> On 11/26/2012 02:20 PM, Stefan Priebe - Profihost AG wrote:
>> Hello list,
>>
>> i know branch wip-rbd-export-stdout is work in progress but it is more
>> than useful ;-)
>>
>> When i try to import an image i get:
>>
>> # gzip -dc vm-101-disk-1.img.gz | rbd import --format=2
>> --size=42949672960 - kvmpool1/vm-101-disk-1
>> rbd: error reading file: (29) Illegal seek
>> Importing image: 0% complete...failed.
>> rbd: import failed: (29) Illegal seek
>>
>> Anything i've tried wrong?
>
> I would assume, that size is already in MiB? Seems to be a slightly too
> big value... Not tried myself, though...
>
> Oliver.
>
>>
>> Greets,
>> Stefan
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
