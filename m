From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: how to debug slow rbd block device
Date: Wed, 23 May 2012 08:18:07 +0200
Message-ID: <4FBC811F.5060004@profihost.ag>
References: <4FBB8A5B.9010500@profihost.ag> <B141A2FBE87F4859AF931D71A339468E@inktank.com> <4FBBEBC8.1000205@profihost.ag> <1C70F3FB753C4AEC97247E04FAE3C733@inktank.com> <4FBBF74C.9020608@profihost.ag> <45F1742481D84E7A90951816DB23609F@inktank.com> <4FBBFE7B.4060406@profihost.ag> <65E9589544C4489F93761035433ADC01@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:35429 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751899Ab2EWGSB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 May 2012 02:18:01 -0400
In-Reply-To: <65E9589544C4489F93761035433ADC01@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Greg Farnum <greg@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi,

>> So try enabling RBD writeback caching =E2=80=94 see http://marc.info
>> /?l=3Dceph-devel&m=3D133758599712768&w=3D2
>> will test tomorrow. Thanks.
Can we path this to the qemu-drive option?

Stefan


Am 22.05.2012 23:11, schrieb Greg Farnum:
> On Tuesday, May 22, 2012 at 2:00 PM, Stefan Priebe wrote:
>> Am 22.05.2012 22:49, schrieb Greg Farnum:
>>> Anyway, it looks like you're just paying a synchronous write penalt=
y
>> =20
>> =20
>> What does that exactly mean? Shouldn't one threaded write to four =20
>> 260MB/s devices gives at least 100Mb/s?
>=20
> Well, with dd you've got a single thread issuing synchronous IO reque=
sts to the kernel. We could have it set up so that those synchronous re=
quests get split up, but they aren't, and between the kernel and KVM it=
 looks like when it needs to make a write out to disk it sends one requ=
est at a time to the Ceph backend. So you aren't writing to four 260MB/=
s devices; you are writing to one 260MB/s device without any pipelining=
 =E2=80=94 meaning you send off a 4MB write, then wait until it's done,=
 then send off a second 4MB write, then wait until it's done, etc.
> Frankly I'm surprised you aren't getting a bit more throughput than y=
ou're seeing (I remember other people getting much more out of less bee=
fy boxes), but it doesn't much matter because what you really want to d=
o is enable the client-side writeback cache in RBD, which will dispatch=
 multiple requests at once and not force writes to be committed before =
reporting back to the kernel. Then you should indeed be writing to four=
 260MB/s devices at once. :)
>=20
>> =20
>>> since with 1 write at a time you're getting 30-40MB/s out of rados =
bench, but with 16 you're getting>100MB/s.
>>> (If you bump up past 16 or increase the size of each with -b you ma=
y =20
>> =20
>> find yourself getting even more.)
>> yep noticed that.
>> =20
>>> So try enabling RBD writeback caching =E2=80=94 see http://marc.inf=
o/?l=3Dceph-devel&m=3D133758599712768&w=3D2
>> will test tomorrow. Thanks.
>> =20
>> Stefan =20
>=20
>=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
