From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: Ceph benchmarks
Date: Tue, 28 Aug 2012 03:40:50 +0200 (CEST)
Message-ID: <1db8be05-341f-4651-8645-6fab46b2c12d@mailpro>
References: <CAOLwVUn-Xs=3c4YDizYPcRfWaKpf79zgpjRp=52ge3nZEusrLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:39470 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917Ab2H1BlQ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Aug 2012 21:41:16 -0400
In-Reply-To: <CAOLwVUn-Xs=3c4YDizYPcRfWaKpf79zgpjRp=52ge3nZEusrLw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?utf-8?Q?S=C3=A9bastien?= Han <han.sebastien@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi,
Nice benchmark !

Maybe It could be great if you can add some fio benchmark.

I'm interested to see random iops values, as I never be able to reach m=
ore than 8000iops with a rbd cluster.




random read: (iops)
fio --filename=3D/dev/[device] --direct=3D1 --rw=3Drandread --bs=3D4k -=
-size=3D1G --iodepth=3D100 --runtime=3D120 --group_reporting --name=3Df=
ile1 --ioengine=3Dlibaio

random read: (iops)
fio --filename=3D/dev/[device] --direct=3D1 --rw=3Drandwrite --bs=3D4k =
--size=3D1G --iodepth=3D100 --runtime=3D120 --group_reporting --name=3D=
file1 --ioengine=3Dlibaio



seq read: (bandwith)
fio --filename=3D/dev/[device] --direct=3D1 --rw=3Dread --bs=3D4M --siz=
e=3D1G --iodepth=3D100 --runtime=3D120 --group_reporting --name=3Dfile1=
 --ioengine=3Dlibaio

seq write: (bandwith)
fio --filename=3D/dev/[device] --direct=3D1 --rw=3Dwrite --bs=3D4M --si=
ze=3D1G --iodepth=3D100 --runtime=3D120 --group_reporting --name=3Dfile=
1 --ioengine=3Dlibaio


Regards,

Alexandre

----- Mail original -----=20

De: "S=C3=A9bastien Han" <han.sebastien@gmail.com>=20
=C3=80: "ceph-devel" <ceph-devel@vger.kernel.org>=20
Envoy=C3=A9: Lundi 27 Ao=C3=BBt 2012 22:47:06=20
Objet: Ceph benchmarks=20

Hi community,=20

=46or those of you who are interested, I performed several benchmarks o=
f=20
RADOS and RBD on different types of hardware and use case.=20
You can find my results here:=20
http://www.sebastien-han.fr/blog/2012/08/26/ceph-benchmarks/=20

Hope it helps :)=20

=46eel free to comment, critic... :)=20

Cheers!=20
--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20



--=20

--=20



=09

Alexandre D e rumier=20

Ing=C3=A9nieur Syst=C3=A8mes et R=C3=A9seaux=20


=46ixe : 03 20 68 88 85=20

=46ax : 03 20 68 90 88=20


45 Bvd du G=C3=A9n=C3=A9ral Leclerc 59100 Roubaix=20
12 rue Marivaux 75002 Paris=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
