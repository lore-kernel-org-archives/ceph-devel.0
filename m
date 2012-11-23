From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: rbd import from stdin
Date: Fri, 23 Nov 2012 11:25:16 +0100 (CET)
Message-ID: <9a1238da-8eb3-4080-b331-26890d51b9aa@mailpro>
References: <50AF4CAF.2090402@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:45946 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161128Ab2KWKZr convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Nov 2012 05:25:47 -0500
In-Reply-To: <50AF4CAF.2090402@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: ceph-devel@vger.kernel.org


import for stdin already work like this:

rbd import --size=3Dxxx - image < stdin

from this patch

http://permalink.gmane.org/gmane.comp.file-systems.ceph.devel/6315


(so I think you just need to specify --size)



----- Mail original -----=20

De: "Stefan Priebe - Profihost AG" <s.priebe@profihost.ag>=20
=C3=80: ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Vendredi 23 Novembre 2012 11:15:11=20
Objet: rbd import from stdin=20

Hello,=20

i was looking at the wip-rbd-export-stdout branch which also allows to=20
import from stdin.=20

But it doesn't seem to work:=20

gzip -d -c vm-101-disk-1.img.gz | rbd import - kvmpool1/vm-101-disk-1=20
rbd: unable to get size of file/block device: (25) Inappropriate ioctl=20
for device=20
rbd: import failed: (25) Inappropriate ioctl for device=20

Greets,=20
Stefan=20
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
