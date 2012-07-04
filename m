From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: Slow request warnings on 0.48
Date: Wed, 04 Jul 2012 18:58:19 +0200 (CEST)
Message-ID: <44469a6e-79a3-4eaa-be25-c47192c8fc80@mailpro>
References: <45F11B42CB5830479EF0E56A27F4E68D7F2E2E@exchange1.ad.100it.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:46006 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751369Ab2GDQ6l convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Jul 2012 12:58:41 -0400
In-Reply-To: <45F11B42CB5830479EF0E56A27F4E68D7F2E2E@exchange1.ad.100it.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Blundell <David.Blundell@100percentit.com>
Cc: ceph-devel@vger.kernel.org

Hi, I see same messages here after upgrade to 0.48.

with random write benchmark.

I have more lags than before with 0.47 (but disks are at 100% usage, so=
 can't tell if it's normal or not)


----- Mail original -----=20

De: "David Blundell" <David.Blundell@100percentit.com>=20
=C3=80: ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Mercredi 4 Juillet 2012 18:53:02=20
Objet: Slow request warnings on 0.48=20

I have three servers running mon and osd using Ubuntu 12.04 that I have=
 been testing with RADOS storing RBD KVM instances=20

0.47.3 worked extremely well (once I got over a few btrfs issues). The =
same servers running 0.48 give a large number of "[WRN] slow request" m=
essages whenever I generate a lot of random IO in the KVM instances usi=
ng iozone. The slow responses eventually leads to disk timeouts on the =
KVM instances.=20

I have erased the osds and recreated on new btrfs volumes with the same=
 result.=20

I have also tried switching to xfs using mkfs.xfs -n size=3D64k with no=
atime, inode64,delaylog,logbufs=3D8,logbsize=3D256k=20

Xfs gives the same result - the iozone tests run fine until the random =
IO starts and then there are lots of slow request warnings.=20

Does anyone have any ideas about the best place to start troubleshootin=
g / debugging?=20

Thanks,=20

David=20
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
