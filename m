From: Mike Almateia <mike.almateia@gmail.com>
Subject: Re: NIC with Erasure offload feature support and Ceph
Date: Tue, 10 Nov 2015 11:28:14 +0300
Message-ID: <5641AA9E.7050509@gmail.com>
References: <5638973D.6090100@gmail.com>
 <CAJ4mKGbA39sAek3oG9-KrvpuQcOx=9iMCojGwmE8fa_3HkLXUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:36127 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078AbbKJI2U (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Nov 2015 03:28:20 -0500
Received: by lbblt2 with SMTP id lt2so96580322lbb.3
        for <ceph-devel@vger.kernel.org>; Tue, 10 Nov 2015 00:28:19 -0800 (PST)
In-Reply-To: <CAJ4mKGbA39sAek3oG9-KrvpuQcOx=9iMCojGwmE8fa_3HkLXUQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

03-Nov-15 18:07, Gregory Farnum =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> On Tue, Nov 3, 2015 at 3:15 AM, Mike <mike.almateia@gmail.com> wrote:
>> Hello!
>>
>> In our project we planing build a petabayte cluster with Erasure poo=
l.
>> Also we looking on Mellanox ConnectX-4 Lx EN Cards/ConnectX-4 EN Car=
ds
>> for using its a offloading erasure code feature.
>>
>> Someone use this feature in test lab/prodaction?
>
> Nope. Ceph's erasure coding is very configurable (in terms of what
> kind of EC it's doing) but the offload features in NICs that we've
> seen aren't quite flexible enough for what Ceph is doing =E2=80=94 it=
's an
> unusual use case and set of requirements where these offload cards ar=
e
> concerned. (We need to take an incoming stream, look at the raw
> stream, then erasure code it into an unknown set of pieces, and then
> send those pieces back out over the network to different addresses.)
> -Greg
>

Thanks for reply.
Mellanox said that offload Erasure Code (RedSolomon algorithm) feature=20
support
on NICs will be released around April 2016.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
