From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: [ceph-users] Ceph Hammer OSD Shard Tuning Test Results
Date: Mon, 2 Mar 2015 16:54:44 +0100 (CET)
Message-ID: <1503408885.2666492.1425311684298.JavaMail.zimbra@oxygem.tv>
References: <54EEA49F.40606@redhat.com> <1096993261.2346577.1425017442692.JavaMail.zimbra@oxygem.tv> <770882624.2513660.1425220699487.JavaMail.zimbra@oxygem.tv> <54F4761C.4070208@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:35187 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460AbbCBPyq convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Mar 2015 10:54:46 -0500
In-Reply-To: <1210381094.2666418.1425311646322.JavaMail.zimbra@oxygem.tv>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@lists.ceph.com>, Vu Pham <vuhuong@mellanox.com>

>> This would be a good thing to bring up in the meeting on Wednesday.=20
yes !

>>I wonder how much effect flow-control and header/data crc had.=20
yes. I known that sommath also disable crc for his bench

>>Were the simplemessenger tests on IPoIB or native?=20

I think it's native, as the Vu Pham benchmark was done on mellanox sx10=
12 (ethernet).
And xio messenger was on Roce (rdma over ethernet)

>>How big was the RBD volume that was created (could some data be=20
>>locally cached)? Did network data transfer statistics match the=20
>>benchmark result numbers?=20



I @cc Vu pham to this mail maybe it'll be able to give us answer.


Note that I'll have same mellanox switches (sx1012) for my production c=
luster in some weeks,
so I'll be able to reproduce the bench. (with 2x10 cores 3,1ghz nodes a=
nd clients).





----- Mail original -----
De: "Mark Nelson" <mnelson@redhat.com>
=C3=80: "aderumier" <aderumier@odiso.com>
Cc: "ceph-devel" <ceph-devel@vger.kernel.org>, "ceph-users" <ceph-users=
@lists.ceph.com>
Envoy=C3=A9: Lundi 2 Mars 2015 15:39:24
Objet: Re: [ceph-users] Ceph Hammer OSD Shard Tuning Test Results

Hi Alex,=20

I see I even responded in the same thread! This would be a good thing=20
to bring up in the meeting on Wednesday. Those are far faster single=20
OSD results than I've been able to muster with simplemessenger. I=20
wonder how much effect flow-control and header/data crc had. He did=20
have quite a bit more CPU (Intel specs say 14 cores @ 2.6GHz, 28 if you=
=20
count hyperthreading). Depending on whether there were 1 or 2 CPUs in=20
that node, that might be around 3x the CPU power I have here.=20

Some other thoughts: Were the simplemessenger tests on IPoIB or native?=
=20
How big was the RBD volume that was created (could some data be=20
locally cached)? Did network data transfer statistics match the=20
benchmark result numbers?=20

I also did some tests on fdcache, though just glancing at the results i=
t=20
doesn't look like tweaking those parameters had much effect.=20

Mark=20

On 03/01/2015 08:38 AM, Alexandre DERUMIER wrote:=20
> Hi Mark,=20
>=20
> I found an previous bench from Vu Pham (it's was about simplemessenge=
r vs xiomessenger)=20
>=20
> http://www.spinics.net/lists/ceph-devel/msg22414.html=20
>=20
> and with 1 osd, he was able to reach 105k iops with simple messenger=20
>=20
> . ~105k iops (4K random read, 20 cores used, numjobs=3D8, iopdepth=3D=
32)=20
>=20
> this was with more powerfull nodes, but the difference seem to be qui=
te huge=20
>=20
>=20
>=20
> ----- Mail original -----=20
> De: "aderumier" <aderumier@odiso.com>=20
> =C3=80: "Mark Nelson" <mnelson@redhat.com>=20
> Cc: "ceph-devel" <ceph-devel@vger.kernel.org>, "ceph-users" <ceph-use=
rs@lists.ceph.com>=20
> Envoy=C3=A9: Vendredi 27 F=C3=A9vrier 2015 07:10:42=20
> Objet: Re: [ceph-users] Ceph Hammer OSD Shard Tuning Test Results=20
>=20
> Thanks Mark for the results,=20
> default values seem to be quite resonable indeed.=20
>=20
>=20
> I also wonder is cpu frequency can have an impact on latency or not.=20
> I'm going to benchmark on dual xeon 10-cores 3,1ghz nodes in coming w=
eeks,=20
> I'll try replay your benchmark to compare=20
>=20
>=20
>=20
> ----- Mail original -----=20
> De: "Mark Nelson" <mnelson@redhat.com>=20
> =C3=80: "ceph-devel" <ceph-devel@vger.kernel.org>, "ceph-users" <ceph=
-users@lists.ceph.com>=20
> Envoy=C3=A9: Jeudi 26 F=C3=A9vrier 2015 05:44:15=20
> Objet: [ceph-users] Ceph Hammer OSD Shard Tuning Test Results=20
>=20
> Hi Everyone,=20
>=20
> In the Ceph Dumpling/Firefly/Hammer SSD/Memstore performance comparis=
on=20
> thread, Alexandre DERUMIER wondered if changing the default shard and=
=20
> threads per shard OSD settings might have a positive effect on=20
> performance in our tests. I went back and used one of the PCIe SSDs=20
> from our previous tests to experiment with a recent master pull. I=20
> wanted to know how performance was affected by changing these paramet=
ers=20
> and also to validate that the default settings still appear to be cor=
rect.=20
>=20
> I plan to conduct more tests (potentially across multiple SATA SSDs i=
n=20
> the same box), but these initial results seem to show that the defaul=
t=20
> settings that were chosen are quite reasonable.=20
>=20
> Mark=20
>=20
> _______________________________________________=20
> ceph-users mailing list=20
> ceph-users@lists.ceph.com=20
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com=20
>=20
> _______________________________________________=20
> ceph-users mailing list=20
> ceph-users@lists.ceph.com=20
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in=20
> the body of a message to majordomo@vger.kernel.org=20
> More majordomo info at http://vger.kernel.org/majordomo-info.html=20
>=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
