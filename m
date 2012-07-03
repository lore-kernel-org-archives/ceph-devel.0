From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: bad performance fio random write - rados bench random write to
 compare?
Date: Tue, 03 Jul 2012 09:31:17 +0200
Message-ID: <4FF29FC5.1050002@profihost.ag>
References: <4FE07B2A.7080209@profihost.ag> <5b71e1e3-b1be-4c12-897d-0bffbbcf8d33@mailpro> <CAPYLRzhUsvweP-J7Be+XvLy7deJJUsFpzMHA8RvygA542uLuBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:48524 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752086Ab2GCHbT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Jul 2012 03:31:19 -0400
In-Reply-To: <CAPYLRzhUsvweP-J7Be+XvLy7deJJUsFpzMHA8RvygA542uLuBA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Alexandre DERUMIER <aderumier@odiso.com>, ceph-devel@vger.kernel.org

Am 02.07.2012 21:52, schrieb Gregory Farnum:
> On Tue, Jun 19, 2012 at 7:05 AM, Alexandre DERUMIER <aderumier@odiso.=
com> wrote:
>> Hi,
>> Is it possible to do random write bench with rados bench command ?
>>
>> I have very base random write performance with 4K block size inside =
qemu-kvm,
>> 1000 iops/s max with 3 nodes with 3x 5 disk 15k
>> (Maybe it's related to my constant disk writes, like datas are not f=
lushed sequentially to disk)
>>
>> seekwatcher movie of 1 osd here :
>> http://odisoweb1.odiso.net/random-write-4k.mpg
>>
>> I would like to do tests on kvm host with rados command to compare.
>> (I don't have rbd module in my kvm host kernel,so I can't use fio on=
 the host)
>
> Unfortunately, nobody's implemented a random write test in rados benc=
h
> yet (this might be a good bug for somebody who's interested in gettin=
g
> in to the project =97 rados bench is pretty simple). I'd offer more
> suggestions but I think we've already discussed this elsewhere. :)

I think random I/O is very important for a lot of people at least for=20
people using KVM on top of ceph. Sadly i can't implement it.

Stefan
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
