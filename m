From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: poor OSD performance using kernel 3.4
Date: Sun, 27 May 2012 13:33:49 +0200 (CEST)
Message-ID: <eaec3e6f-4cf2-4a8b-a6ee-22805243ddef@mailpro>
References: <4FC1EFB1.5090800@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:34798 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941Ab2E0LeL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 27 May 2012 07:34:11 -0400
In-Reply-To: <4FC1EFB1.5090800@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: ceph-devel@vger.kernel.org, Mark Nelson <mark.nelson@inktank.com>

> how much time to flush from journal to disks ?
>>I don't know how to measure this.=20
Do an iostat, you must see timelapse of write inactivity on disk (datas=
 are written to journal) , then after a timelapse of write activity on =
disk.(data flushed from journal to disk)

>>As ceph starts to write to journal and=20
>>disk in parallel=20

this is strange, from doc:
http://ceph.com/wiki/OSD_journal

the journal mode should be write-ahead with xfs.
So write to journal first then flush to disk each 30sec.

maybe your tmpfs is too small, and flushs occurs at 50% of free space o=
n journal.
If by exemple, your flush occurs each 1 or 2seconds, this can cause ver=
y slow write.



>>and tmpfs isn't even shown in iostat.
indeed, iostat doesn't work with tmpfs...


----- Mail original -----=20

De: "Stefan Priebe - Profihost AG" <s.priebe@profihost.ag>=20
=C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
Cc: ceph-devel@vger.kernel.org, "Mark Nelson" <mark.nelson@inktank.com>=
=20
Envoy=C3=A9: Dimanche 27 Mai 2012 11:11:13=20
Objet: Re: poor OSD performance using kernel 3.4=20

Can really nobody help?=20

Am 25.05.2012 17:47, schrieb Alexandre DERUMIER:=20
> Hi Stephan,=20
> Do you have same performance with read ?=20

Read is fine for both versions see here:=20

3.0.30=20

Write:=20
Total time run: 30.872357=20
Total writes made: 1095=20
Write size: 4194304=20
Bandwidth (MB/sec): 141.874=20

Average Latency: 0.450187=20
Max latency: 2.00672=20
Min latency: 0.091783=20

Read:=20
Total time run: 22.907021=20
Total reads made: 1095=20
Read size: 4194304=20
Bandwidth (MB/sec): 191.208=20

Average Latency: 0.333954=20
Max latency: 1.71987=20
Min latency: 0.041373=20

3.4.0=20

Write:=20
Total time run: 124.573247=20
Total writes made: 647=20
Write size: 4194304=20
Bandwidth (MB/sec): 20.775=20

Average Latency: 3.08058=20
Max latency: 65.2522=20
Min latency: 0.089587=20

Read:=20
Total time run: 13.191562=20
Total reads made: 647=20
Read size: 4194304=20
Bandwidth (MB/sec): 196.186=20

Average Latency: 0.322895=20
Max latency: 1.22392=20
Min latency: 0.043784=20


> Did you have done some iostats ?=20
Yes - I/O is heavily jumping between 0 and 60MB/s but of the time it's =
0=20
or around 10MB/s.=20

> how much time to flush from journal to disks ?=20
I don't know how to measure this. As ceph starts to write to journal an=
d=20
disk in parallel and tmpfs isn't even shown in iostat.=20

Greets,=20
Stefan=20



--=20

--=20




	Alexandre D erumier=20
Ing=C3=A9nieur Syst=C3=A8me=20
=46ixe : 03 20 68 88 90=20
=46ax : 03 20 68 90 81=20
45 Bvd du G=C3=A9n=C3=A9ral Leclerc 59100 Roubaix - France=20
12 rue Marivaux 75002 Paris - France=20
=09
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
