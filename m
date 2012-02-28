From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: about attaching rbd volume from instance on KVM
Date: Mon, 27 Feb 2012 16:18:40 -0800
Message-ID: <4F4C1D60.2050002@dreamhost.com>
References: <CAM2zNoMCEb+8m1SJrS_oXHhQw18L5axNRQY-RB53GfgACNN9Hg@mail.gmail.com> <CAJafhzSa=tUJpOyLaQvde__hM+5wwN4wDjRei+HGrm5nf7VX0w@mail.gmail.com> <CAM2zNoPg88JM=VOGUz6vE=n=xWzgOZ+Nkz2hM=ip33ojw94-nQ@mail.gmail.com> <4F332B19.5090206@dreamhost.com> <CAM2zNoNeaNpR4N+WE2X6+eAMiQXJRspvyKNZPYGWfhnPeJOwAw@mail.gmail.com> <4F3F11AB.8080206@dreamhost.com> <CAM2zNoNunP2AK43ZWeSUjKXoEeTd5VYeK-=DVTjTX-neR7whqQ@mail.gmail.com> <4F4A7082.7020303@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:37074 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755069Ab2B1ASk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Feb 2012 19:18:40 -0500
In-Reply-To: <4F4A7082.7020303@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Masuko Tomoya <tomoya.masuko@gmail.com>
Cc: christian@brunner-muc.de, ceph-devel@vger.kernel.org

On 02/26/2012 09:48 AM, Josh Durgin wrote:
> (resending since the list didn't receive it)
>
> On 02/20/2012 01:37 AM, Masuko Tomoya wrote:
>> Hi Josh,
>>
>> Thank you for reply.
>> Your advice is very helpful!!
>>
>> I applied your patch to libvirt 0.9.8 and rebuilt it.
>> But same error was occured.
>>
>> Could you advise me ?
>
> That workaround patched the wrong function. I sent a patch to libvirt
> that deals with the problem generically:
>
> https://www.redhat.com/archives/libvir-list/2012-February/msg01044.html
> (also at https://github.com/NewDreamNetwork/libvirt.git for easier access)
>
> Josh

This was merged as f27f616ff899732fe90ce1f0f4abb3887cea5e17 upstream.
