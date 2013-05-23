From: Isaac Otsiabah <zmoo76b@yahoo.com>
Subject: using ceph-deploy, how do i specify the cluster address?
Date: Thu, 23 May 2013 10:22:05 -0700 (PDT)
Message-ID: <1369329725.73945.YahooMailNeo@web121901.mail.ne1.yahoo.com>
Reply-To: Isaac Otsiabah <zmoo76b@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from nm11-vm1.bullet.mail.ne1.yahoo.com ([98.138.91.40]:27336 "EHLO
	nm11-vm1.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757965Ab3EWRWH convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 23 May 2013 13:22:07 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>



Hello, before ceph-deply arrived, i used mkcephfs and specified the clu=
ster address in ceph.conf as:


[osd.0]
=A0=A0=A0=A0=A0=A0=A0 host =3D gluster3
=A0=A0=A0=A0=A0=A0=A0 public addr =3D 192.168.0.102
=A0=A0=A0=A0=A0=A0=A0 cluster addr =3D 192.168.1.102=A0=A0 <-----------=
- My cluster address
=A0=A0=A0=A0=A0=A0=A0 btrfs devs =3D /dev/sdc
=A0=A0=A0=A0=A0=A0=A0 osd journal =3D /dev/sdb5

Now with ceph-deploy, how do i specify the cluster address since i do n=
ot want osd to osd communication to go through the monitor address? Tha=
nk you very much.


Isaac
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
