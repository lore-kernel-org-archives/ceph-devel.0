From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: less cores more iops / speed
Date: Fri, 9 Nov 2012 00:52:14 +0300
Message-ID: <CABYiri90hXqbVUf+AWrf5sB0UYY42j3aGCTJ9KVJLsBROF+8qQ@mail.gmail.com>
References: <509BCC58.3070003@profihost.ag> <021c4865-424b-41bd-b81d-62b6771dabc3@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:59610 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757161Ab2KHVwg convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Nov 2012 16:52:36 -0500
Received: by mail-ob0-f174.google.com with SMTP id uo13so3371324obb.19
        for <ceph-devel@vger.kernel.org>; Thu, 08 Nov 2012 13:52:34 -0800 (PST)
In-Reply-To: <021c4865-424b-41bd-b81d-62b6771dabc3@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>, Joao Eduardo Luis <joao.luis@inktank.com>, ceph-devel@vger.kernel.org, Mark Nelson <mark.nelson@inktank.com>

On Thu, Nov 8, 2012 at 7:53 PM, Alexandre DERUMIER <aderumier@odiso.com=
> wrote:
>>>So it is a problem of KVM which let's the processes jump between cor=
es a
>>>lot.
>
> maybe numad from redhat can help ?
> http://fedoraproject.org/wiki/Features/numad
>
> It's try to keep process on same numa node and I think it's also doin=
g some dynamic pinning.

Numad keeps only memory chunks on the preferred node, cpu pinning,
which is a primary goal there, should be done separately via libvirt
or manually for qemu process via cpuset(libvirt does pinning via
taskset and seems that it is broken at least in debian wheezy - even
affinity mask is set for qemu process, load spreads all over numa
node, including cpus outside the set).

>
> ----- Mail original -----
>
> De: "Stefan Priebe - Profihost AG" <s.priebe@profihost.ag>
> =C3=80: "Mark Nelson" <mark.nelson@inktank.com>
> Cc: "Joao Eduardo Luis" <joao.luis@inktank.com>, ceph-devel@vger.kern=
el.org
> Envoy=C3=A9: Jeudi 8 Novembre 2012 16:14:32
> Objet: Re: less cores more iops / speed
>
> Am 08.11.2012 14:19, schrieb Mark Nelson:
>> On 11/08/2012 02:45 AM, Stefan Priebe - Profihost AG wrote:
>>> Am 08.11.2012 01:59, schrieb Mark Nelson:
>>>> There's also the context switching overhead. It'd be interesting t=
o
>>>> know how much the writer processes were shifting around on cores.
>>> What do you mean by that? I'm talking about the KVM guest not about=
 the
>>> ceph nodes.
>>
>> in this case, is fio bouncing around between cores?
>
> Thanks you're correct. If i bind fio to two cores on a 8 core VM it r=
uns
> with 16.000 iops.
>
> So it is a problem of KVM which let's the processes jump between core=
s a
> lot.
>
> Greets,
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
