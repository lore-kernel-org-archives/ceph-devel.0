From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: BUG: kvm crashing in void librbd::AioCompletion::complete_request
Date: Mon, 05 Nov 2012 21:25:54 +0100
Message-ID: <509820D2.1090700@profihost.ag>
References: <50967583.8000109@profihost.ag> <alpine.DEB.2.00.1211040604530.30792@cobra.newdream.net> <509676B9.1040505@profihost.ag> <alpine.DEB.2.00.1211040611470.30792@cobra.newdream.net> <50981480.4050300@profihost.ag> <CABYiri8mQtnzd=WCoMNg2Go2p_7zUt5+ZfyO003Qpu5iX4cmfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:34841 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751642Ab2KEUZ5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Nov 2012 15:25:57 -0500
In-Reply-To: <CABYiri8mQtnzd=WCoMNg2Go2p_7zUt5+ZfyO003Qpu5iX4cmfQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 05.11.2012 21:20, schrieb Andrey Korolyov:
> On Mon, Nov 5, 2012 at 11:33 PM, Stefan Priebe <s.priebe@profihost.ag> wrote:
>> Am 04.11.2012 15:12, schrieb Sage Weil:
>>>
>>> On Sun, 4 Nov 2012, Stefan Priebe wrote:
>>>>
>>>> Can i merge wip-rbd-read into master?
>>>
>>>
>>> Yeah.  I'm going to do a bit more testing first before I do it, but it
>>> should apply cleanly.  Hopefully later today.
>>
>>
>> Thanks - seems to be fixed with wip-rbd-read but i have a memory leak now.
>>
>> kvm process raises and raises and raises which each new test around 5GB of
>> memory. Should i write a new mail?
>
> Do you use qemu 1.2.0? It has a memory leak, at least with rbd
> backend, but I didn`t profiled it yet, so it may be something generic
> :)

Yes i'm using kvm-qemu 1.2. But i dought that in my case it is a qemu 
problem. Memory usage is constant using ceph git master. When i merge 
ceph wip-rbd-read into master kvm process raises massivly while reading 
from disk.

Greets,
Stefan
