From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: how to debug slow rbd block device
Date: Wed, 23 May 2012 10:30:45 +0200
Message-ID: <4FBCA035.2050507@profihost.ag>
References: <4FBB8A5B.9010500@profihost.ag> <B141A2FBE87F4859AF931D71A339468E@inktank.com> <4FBBEBC8.1000205@profihost.ag> <1C70F3FB753C4AEC97247E04FAE3C733@inktank.com> <4FBBF74C.9020608@profihost.ag> <45F1742481D84E7A90951816DB23609F@inktank.com> <4FBBFE7B.4060406@profihost.ag> <65E9589544C4489F93761035433ADC01@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:50920 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757466Ab2EWIai (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 May 2012 04:30:38 -0400
In-Reply-To: <65E9589544C4489F93761035433ADC01@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Greg Farnum <greg@inktank.com>
Cc: ceph-devel@vger.kernel.org

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

OK i understand that but still the question where is the bottlenek in
this case. I mean i see not more than 40% network load, not more than
10% cpu load and only 40MB/s to the SSD. I would still expect a network
load of 70-90%.

Greets and thanks,
Stefan
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
