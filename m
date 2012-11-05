From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: BUG: kvm crashing in void librbd::AioCompletion::complete_request
Date: Mon, 5 Nov 2012 23:20:40 +0300
Message-ID: <CABYiri8mQtnzd=WCoMNg2Go2p_7zUt5+ZfyO003Qpu5iX4cmfQ@mail.gmail.com>
References: <50967583.8000109@profihost.ag> <alpine.DEB.2.00.1211040604530.30792@cobra.newdream.net>
 <509676B9.1040505@profihost.ag> <alpine.DEB.2.00.1211040611470.30792@cobra.newdream.net>
 <50981480.4050300@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:60660 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754024Ab2KEUVB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Nov 2012 15:21:01 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so6219353oag.19
        for <ceph-devel@vger.kernel.org>; Mon, 05 Nov 2012 12:21:00 -0800 (PST)
In-Reply-To: <50981480.4050300@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Nov 5, 2012 at 11:33 PM, Stefan Priebe <s.priebe@profihost.ag> wrote:
> Am 04.11.2012 15:12, schrieb Sage Weil:
>>
>> On Sun, 4 Nov 2012, Stefan Priebe wrote:
>>>
>>> Can i merge wip-rbd-read into master?
>>
>>
>> Yeah.  I'm going to do a bit more testing first before I do it, but it
>> should apply cleanly.  Hopefully later today.
>
>
> Thanks - seems to be fixed with wip-rbd-read but i have a memory leak now.
>
> kvm process raises and raises and raises which each new test around 5GB of
> memory. Should i write a new mail?

Do you use qemu 1.2.0? It has a memory leak, at least with rbd
backend, but I didn`t profiled it yet, so it may be something generic
:)


> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
