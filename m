From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: ceph 0.86 : rbd_cache=true, iops a lot slower on randread 4K
Date: Mon, 20 Oct 2014 08:39:12 +0200 (CEST)
Message-ID: <f954e23b-9940-4f7f-8b20-2efd148eb0c6@mailpro>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2822D508@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:54702 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752322AbaJTGjV convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Oct 2014 02:39:21 -0400
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F2822D508@SACMBXIP02.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: ceph-devel@vger.kernel.org

>>Could you please check whether the following commit is there in your =
branch or not ?=20
>>
>>82175ec94acc89dc75da0154f86187fb2e4dbf5e=20

I'm this debian repository
http://gitbuilder.ceph.com/ceph-deb-wheezy-x86_64-basic/ref/v0.86

Don't known how to check if the commit was inside or not.


But the good new,
I just tried on last master
http://gitbuilder.ceph.com/ceph-deb-wheezy-x86_64-basic/ref/master


and Indeed, the problem is fixed !


Thanks for help,

Alexandre


----- Mail original -----=20

De: "Somnath Roy" <Somnath.Roy@sandisk.com>=20
=C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>, ceph-devel@vger.ker=
nel.org=20
Envoy=C3=A9: Lundi 20 Octobre 2014 08:18:48=20
Objet: RE: ceph 0.86 : rbd_cache=3Dtrue, iops a lot slower on randread =
4K=20

Hi Alexandre,=20

Yes, it is related to the defect I filed.=20
I think with librbd engine , direct =3D1 is a noop. It is going through=
 librbd engine not through kernel. Whether it will use cache or not dep=
ends upon the rbd_cache flag.=20
This is supposed to be fixed on the latest code but I didn't have time =
to test this out.=20
It seems the fix is not there in 0.86.=20
Could you please check whether the following commit is there in your br=
anch or not ?=20

82175ec94acc89dc75da0154f86187fb2e4dbf5e=20

Thanks & Regards=20
Somnath=20

-----Original Message-----=20
=46rom: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.=
kernel.org] On Behalf Of Alexandre DERUMIER=20
Sent: Sunday, October 19, 2014 11:02 PM=20
To: ceph-devel@vger.kernel.org=20
Subject: ceph 0.86 : rbd_cache=3Dtrue, iops a lot slower on randread 4K=
=20

Hi,=20

I'm not sure it's related to this bug=20
http://tracker.ceph.com/issues/9513=20

But, when with this fio-rbd benchmark=20

[global]=20
ioengine=3Drbd=20
clientname=3Dadmin=20
pool=3Dtest=20
rbdname=3Dtest=20
invalidate=3D0=20
rw=3Drandread=20
bs=3D4k=20
direct=3D1=20
numjobs=3D8=20
group_reporting=3D1=20
size=3D10G=20

[rbd_iodepth32]=20
iodepth=3D32=20



I have around=20

40000iops (cpu bound on client) with rbd_cache=3Dfalse=20

vs=20

13000iops (40%cpu usage on client) with rbd_cache=3Dtrue=20


(Note that it should be direct ios, so It should bypass the cache).=20
Seem to be a lock or something like that, as the cpu usage is a lot low=
er too.=20

Is it the expected behavior ?=20
--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n the body of a message to majordomo@vger.kernel.org More majordomo inf=
o at http://vger.kernel.org/majordomo-info.html=20

________________________________=20

PLEASE NOTE: The information contained in this electronic mail message =
is intended only for the use of the designated recipient(s) named above=
=2E If the reader of this message is not the intended recipient, you ar=
e hereby notified that you have received this message in error and that=
 any review, dissemination, distribution, or copying of this message is=
 strictly prohibited. If you have received this communication in error,=
 please notify the sender by telephone or e-mail (as shown above) immed=
iately and destroy any and all copies of this message in your possessio=
n (whether hard copies or electronically stored copies).=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
