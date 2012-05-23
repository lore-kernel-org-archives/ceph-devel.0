From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: how to debug slow rbd block device
Date: Wed, 23 May 2012 11:22:25 +0400
Message-ID: <CABYiri8LESPay495HX2s03nL0drOKqWgnXDQW3K71CQJ4MzuzQ@mail.gmail.com>
References: <4FBB8A5B.9010500@profihost.ag> <B141A2FBE87F4859AF931D71A339468E@inktank.com>
 <4FBBEBC8.1000205@profihost.ag> <1C70F3FB753C4AEC97247E04FAE3C733@inktank.com>
 <4FBBF74C.9020608@profihost.ag> <45F1742481D84E7A90951816DB23609F@inktank.com>
 <4FBBFE7B.4060406@profihost.ag> <65E9589544C4489F93761035433ADC01@inktank.com>
 <4FBC811F.5060004@profihost.ag> <4FBC83F3.7070400@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:63819 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756306Ab2EWHWr convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 May 2012 03:22:47 -0400
Received: by wgbdr13 with SMTP id dr13so6835778wgb.1
        for <ceph-devel@vger.kernel.org>; Wed, 23 May 2012 00:22:46 -0700 (PDT)
In-Reply-To: <4FBC83F3.7070400@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>, Greg Farnum <greg@inktank.com>, ceph-devel@vger.kernel.org

Hi,

=46or Stefan:

Increasing socket memory gave me about some percents on fio tests
inside VM(I have measured
'max-iops-until-ceph-throws-message-about-delayed-write' parameter).
What is more important, osd process, if possible, should be pinned to
dedicated core or two, and all other processes should not use this
core(you may do it via cg or manually), because even one four-core
non-pinned VM process during test causes a drop of osd` throughput
almost twice, same for any other heavy process on the host.

net.core.rmem_max =3D 16777216
net.core.wmem_max =3D 16777216
net.ipv4.tcp_rmem =3D 4096 87380 16777216
net.ipv4.tcp_wmem =3D 4096 65536 16777216



On Wed, May 23, 2012 at 10:30 AM, Josh Durgin <josh.durgin@inktank.com>=
 wrote:
> On 05/22/2012 11:18 PM, Stefan Priebe - Profihost AG wrote:
>>
>> Hi,
>>
>>>> So try enabling RBD writeback caching =E2=80=94 see http://marc.in=
fo
>>>> /?l=3Dceph-devel&m=3D133758599712768&w=3D2
>>>> will test tomorrow. Thanks.
>>
>> Can we path this to the qemu-drive option?
>
>
> Yup, see http://article.gmane.org/gmane.comp.file-systems.ceph.devel/=
6400
>
> The normal qemu cache=3Dwriteback/writethrough/none option will work =
in qemu
> 1.2.
>
> Josh

By the way, is it possible to flush cache outside? I may need that for
VM live migration and such hook will be helpful.


>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
