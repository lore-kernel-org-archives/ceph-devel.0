From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: rbd export speed limit
Date: Wed, 13 Feb 2013 20:25:32 +0100
Message-ID: <511BE8AC.3090600@profihost.ag>
References: <511AA47B.3020309@profihost.ag> <CABYiri_QzZaOeXp5Rcys3HZRRwF2nexh4GvmA5WMFw9Z+GVZjQ@mail.gmail.com> <511B46A2.4060107@profihost.ag> <alpine.DEB.2.00.1302130812090.23349@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:45251 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759463Ab3BMTZd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Feb 2013 14:25:33 -0500
In-Reply-To: <alpine.DEB.2.00.1302130812090.23349@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Andrey Korolyov <andrey@xdel.ru>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

first sorry i got this totally wrong. The speed is not correct and i 
mixed this with another operation going on at the same time.

The problem isn't the rbd export in my case it the fstrim issued on all VMs.

This results in writes up to 400Mb/s per OSD and then results in aborted 
/ hanging task in VMs. Is it possible to give trim commands lower priority?

Greets,
Stefan
Am 13.02.2013 17:13, schrieb Sage Weil:
> On Wed, 13 Feb 2013, Stefan Priebe - Profihost AG wrote:
>> Hi,
>> Am 12.02.2013 21:45, schrieb Andrey Korolyov:
>>> you may be interested in throttle(1) as a side solution with stdout
>>> export option.
>> What's throttle? Never seen this. Wouldn't it be possible to use tc?
>>
>>> By the way, on which interconnect you have manage to
>>> get such speeds,
>> Bonded Intel 2x 10GBE
>>
>>> if you mean 'commited' bytes(e.g. not almost empty
>>> allocated image)?
>> Yes commited images.
>
> FWIW I'm pretty sure the rbd export is doing a single IO at a time
> (reading one chunk, 4MB by default).  Are there lots of them in parallel,
> or is a single export operation significantly affecting performance?
> That would be a bit surprising to me..
>
> sage
>
