From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: RBD fio Performance concerns
Date: Mon, 19 Nov 2012 16:28:21 +0100 (CET)
Message-ID: <d4bdfae3-9a87-4815-994f-cfc20be355a7@mailpro>
References: <CAOLwVUknn4hH20P+iRbrqeNTQbFxcVFqWo=ZUM5-RQTNgqyWSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:55571 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753173Ab2KSP2x convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Nov 2012 10:28:53 -0500
In-Reply-To: <CAOLwVUknn4hH20P+iRbrqeNTQbFxcVFqWo=ZUM5-RQTNgqyWSQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?utf-8?Q?S=C3=A9bastien?= Han <han.sebastien@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Mark Kampe <mark.kampe@inktank.com>

>>why the
>>sequential read/writes are lower than the randoms onces? Or maybe do =
I
>>just need to care about the bandwidth for those values?

If I remember, you use fio with 4MB block size for sequential.
So it's normal that you have less ios, but more bandwith.



----- Mail original -----=20

De: "S=C3=A9bastien Han" <han.sebastien@gmail.com>=20
=C3=80: "Mark Kampe" <mark.kampe@inktank.com>=20
Cc: "ceph-devel" <ceph-devel@vger.kernel.org>=20
Envoy=C3=A9: Lundi 19 Novembre 2012 15:56:35=20
Objet: Re: RBD fio Performance concerns=20

Hello Mark,=20

=46irst of all, thank you again for another accurate answer :-).=20

> I would have expected write aggregation and cylinder affinity to=20
> have eliminated some seeks and improved rotational latency resulting=20
> in better than theoretical random write throughput. Against those=20
> expectations 763/850 IOPS is not so impressive. But, it looks to=20
> me like you were running fio in a 1G file with 100 parallel requests.=
=20
> The default RBD stripe width is 4M. This means that those 100=20
> parallel requests were being spread across 256 (1G/4M) objects.=20
> People in the know tell me that writes to a single object are=20
> serialized, which means that many of those (potentially) parallel=20
> writes were to the same object, and hence serialized. This would=20
> increase the average request time for the colliding operations,=20
> and reduce the aggregate throughput correspondingly. Use a=20
> bigger file (or a narrower stripe) and this will get better.=20


I followed your advice and used a bigger file (10G) and an iodepth of=20
128 and I've been able to reach ~27k iops for rand reads but I=20
couldn't reach more than 870 iops in randwrites... It's kind of=20
expected. But the thing a still don't understand is: why the=20
sequential read/writes are lower than the randoms onces? Or maybe do I=20
just need to care about the bandwidth for those values?=20

Thank you.=20

Regards.=20
--=20
Bien cordialement.=20
S=C3=A9bastien HAN.=20


On Fri, Nov 16, 2012 at 11:59 PM, Mark Kampe <mark.kampe@inktank.com> w=
rote:=20
> On 11/15/2012 12:23 PM, S=C3=A9bastien Han wrote:=20
>=20
>> First of all, I would like to thank you for this well explained,=20
>> structured and clear answer. I guess I got better IOPS thanks to the=
 10K=20
>> disks.=20
>=20
>=20
> 10K RPM would bring your per-drive throughput (for 4K random writes)=20
> up to 142 IOPS and your aggregate cluster throughput up to 1700.=20
> This would predict a corresponding RADOSbench throughput somewhere=20
> above 425 (how much better depending on write aggregation and cylinde=
r=20
> affinity). Your RADOSbench 708 now seems even more reasonable.=20
>=20
>> To be really honest I wasn't so concerned about the RADOS benchmarks=
=20
>> but more about the RBD fio benchmarks and the amont of IOPS that com=
es=20
>> out of it, which I found =C3=A0 bit to low.=20
>=20
>=20
> Sticking with 4K random writes, it looks to me like you were running=20
> fio with libaio (which means direct, no buffer cache). Because it=20
> is direct, every I/O operation is really happening and the best=20
> sustained throughput you should expect from this cluster is=20
> the aggregate raw fio 4K write throughput (1700 IOPS) divided=20
> by two copies =3D 850 random 4K writes per second. If I read the=20
> output correctly you got 763 or about 90% of back-of-envelope.=20
>=20
> BUT, there are some footnotes (there always are with performance)=20
>=20
> If you had been doing buffered I/O you would have seen a lot more=20
> (up front) benefit from page caching ... but you wouldn't have been=20
> measuring real (and hence sustainable) I/O throughput ... which is=20
> ultimately limited by the heads on those twelve disk drives, where=20
> all of those writes ultimately wind up. It is easy to be fast=20
> if you aren't really doing the writes :-)=20
>=20
> I would have expected write aggregation and cylinder affinity to=20
> have eliminated some seeks and improved rotational latency resulting=20
> in better than theoretical random write throughput. Against those=20
> expectations 763/850 IOPS is not so impressive. But, it looks to=20
> me like you were running fio in a 1G file with 100 parallel requests.=
=20
> The default RBD stripe width is 4M. This means that those 100=20
> parallel requests were being spread across 256 (1G/4M) objects.=20
> People in the know tell me that writes to a single object are=20
> serialized, which means that many of those (potentially) parallel=20
> writes were to the same object, and hence serialized. This would=20
> increase the average request time for the colliding operations,=20
> and reduce the aggregate throughput correspondingly. Use a=20
> bigger file (or a narrower stripe) and this will get better.=20
>=20
> Thus, getting 763 random 4K write IOPs out of those 12 drives=20
> still sounds about right to me.=20
>=20
>=20
>> On 15 nov. 2012, at 19:43, Mark Kampe <mark.kampe@inktank.com> wrote=
:=20
>>=20
>>> Dear Sebastien,=20
>>>=20
>>> Ross Turn forwarded me your e-mail. You sent a great deal=20
>>> of information, but it was not immediately obvious to me=20
>>> what your specific concern was.=20
>>>=20
>>> You have 4 servers, 3 OSDs per, 2 copy, and you measured a=20
>>> radosbench (4K object creation) throughput of 2.9MB/s=20
>>> (or 708 IOPS). I infer that you were disappointed by=20
>>> this number, but it looks right to me.=20
>>>=20
>>> Assuming typical 7200 RPM drives, I would guess that each=20
>>> of them would deliver a sustained direct 4K random write=20
>>> performance in the general neighborhood of:=20
>>> 4ms seek (short seeks with write-settle-downs)=20
>>> 4ms latency (1/2 rotation)=20
>>> 0ms write (4K/144MB/s ~ 30us)=20
>>> -----=20
>>> 8ms or about 125 IOPS=20
>>>=20
>>> Your twelve drives should therefore have a sustainable=20
>>> aggregate direct 4K random write throughput of 1500 IOPS.=20
>>>=20
>>> Each 4K object create involves four writes (two copies,=20
>>> each getting one data write and one data update). Thus=20
>>> I would expect a (crude) 4K create rate of 375 IOPS (1500/4).=20
>>>=20
>>> You are getting almost twice the expected raw IOPS ...=20
>>> and we should expect that a large number of parallel=20
>>> operations would realize some write/seek aggregation=20
>>> benefits ... so these numbers look right to me.=20
>>>=20
>>> Is this the number you were concerned about, or have I=20
>>> misunderstood?=20
--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
