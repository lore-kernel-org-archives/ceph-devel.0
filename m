From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: how to debug slow rbd block device
Date: Wed, 23 May 2012 11:10:42 +0200
Message-ID: <4FBCA992.6090702@profihost.ag>
References: <4FBB8A5B.9010500@profihost.ag> <B141A2FBE87F4859AF931D71A339468E@inktank.com> <4FBBEBC8.1000205@profihost.ag> <1C70F3FB753C4AEC97247E04FAE3C733@inktank.com> <4FBBF74C.9020608@profihost.ag> <45F1742481D84E7A90951816DB23609F@inktank.com> <4FBBFE7B.4060406@profihost.ag> <65E9589544C4489F93761035433ADC01@inktank.com> <4FBCA035.2050507@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:47158 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895Ab2EWJKf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 May 2012 05:10:35 -0400
In-Reply-To: <4FBCA035.2050507@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Greg Farnum <greg@inktank.com>
Cc: ceph-devel@vger.kernel.org

Am 23.05.2012 10:30, schrieb Stefan Priebe - Profihost AG:
> Am 22.05.2012 23:11, schrieb Greg Farnum:
>> On Tuesday, May 22, 2012 at 2:00 PM, Stefan Priebe wrote:
>>> Am 22.05.2012 22:49, schrieb Greg Farnum:
>>>> Anyway, it looks like you're just paying a synchronous write penal=
ty
>>> =20
>>> =20
>>> What does that exactly mean? Shouldn't one threaded write to four =20
>>> 260MB/s devices gives at least 100Mb/s?
>>
>> Well, with dd you've got a single thread issuing synchronous IO requ=
ests to the kernel. We could have it set up so that those synchronous r=
equests get split up, but they aren't, and between the kernel and KVM i=
t looks like when it needs to make a write out to disk it sends one req=
uest at a time to the Ceph backend. So you aren't writing to four 260MB=
/s devices; you are writing to one 260MB/s device without any pipelinin=
g =E2=80=94 meaning you send off a 4MB write, then wait until it's done=
, then send off a second 4MB write, then wait until it's done, etc.
>> Frankly I'm surprised you aren't getting a bit more throughput than =
you're seeing (I remember other people getting much more out of less be=
efy boxes), but it doesn't much matter because what you really want to =
do is enable the client-side writeback cache in RBD, which will dispatc=
h multiple requests at once and not force writes to be committed before=
 reporting back to the kernel. Then you should indeed be writing to fou=
r 260MB/s devices at once. :)
>=20
> OK i understand that but still the question where is the bottlenek in
> this case. I mean i see not more than 40% network load, not more than
> 10% cpu load and only 40MB/s to the SSD. I would still expect a netwo=
rk
> load of 70-90%.

*gr* i found a broken SATA cable ;-(

this is now with the replaced SATA cable and with rbd cache turned on:

systembootimage:/mnt# dd if=3D/dev/zero of=3Dtest bs=3D4M count=3D1000
1000+0 records in
1000+0 records out
4194304000 bytes (4,2 GB) copied, 57,9194 s, 72,4 MB/s

systembootimage:/mnt# dd if=3Dtest of=3D/dev/null bs=3D4M count=3D1000
1000+0 records in
1000+0 records out
4194304000 bytes (4,2 GB) copied, 46,3499 s, 90,5 MB/s

rados write bench 8 threads:
Total time run:        60.222947
Total writes made:     1519
Write size:            4194304
Bandwidth (MB/sec):    100.892

Average Latency:       0.317098
Max latency:           1.88908
Min latency:           0.089681

Stefan
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
