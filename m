From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: firefly integration branch for v0.80.9 ready for QE
Date: Mon, 9 Mar 2015 11:07:36 -0400 (EDT)
Message-ID: <437340232.36512595.1425913656022.JavaMail.zimbra@redhat.com>
References: <54F5E1B2.7020801@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:54091 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752124AbbCIPIk convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Mar 2015 11:08:40 -0400
In-Reply-To: <54F5E1B2.7020801@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

QE validation is finished for this release and v0.80.9 is ready for nex=
t steps.

Summary of all runs is in http://tracker.ceph.com/issues/10641 with det=
ails.

The following suites were executed and passed as part of this validatio=
n:

rados
rbd
rgw
fs
krbd
kcephfs
samba
ceph-deploy
upgrade/firefly
upgrade/dumpling-firefly-x (to giant)
powercycle=20

Alfredo, the ticket is in your hands.

Thx
YuriW

----- Original Message -----
=46rom: "Loic Dachary" <loic@dachary.org>
To: "Yuri Weinstein" <yweinste@redhat.com>
Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
Sent: Tuesday, March 3, 2015 8:30:42 AM
Subject: firefly integration branch for v0.80.9 ready for QE

Hi Yuri,

The firefly branch for v0.80.9 as found at https://github.com/ceph/ceph=
/commits/firefly has been approved by Greg, Yehuda, Josh and Sam and is=
 ready for QE.=20
=46or the record, the head is https://github.com/ceph/ceph/commit/edd37=
e39d155fbe36012008df3d49e33ec3117cc and the details of the tests run ar=
e at http://tracker.ceph.com/issues/10641

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
