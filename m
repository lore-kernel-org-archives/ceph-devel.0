From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: Is rbd_discard enough to wipe an RBD image?
Date: Mon, 21 Dec 2015 15:25:15 +0100 (CET)
Message-ID: <1255550760.10644674.1450707915260.JavaMail.zimbra@oxygem.tv>
References: <56771BEE.4050705@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:34842 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009AbbLUOZR convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Dec 2015 09:25:17 -0500
In-Reply-To: <56771BEE.4050705@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

>>I just want to know if this is sufficient to wipe a RBD image?

AFAIK, ceph write zeroes in the rados objects with discard is used.

They are an option for skip zeroes write if needed

OPTION(rbd_skip_partial_discard, OPT_BOOL, false) // when trying to dis=
card a range inside an object, set to true to skip zeroing the range.
----- Mail original -----
De: "Wido den Hollander" <wido@42on.com>
=C3=80: "ceph-devel" <ceph-devel@vger.kernel.org>
Envoy=C3=A9: Dimanche 20 D=C3=A9cembre 2015 22:21:50
Objet: Is rbd_discard enough to wipe an RBD image?

Hi,=20

I'm busy implementing the volume wiping method of the libvirt storage=20
pool backend and instead of writing to the whole RBD image with zeroes=20
I'm using rbd_discard.=20

Using a 4MB length I'm starting at offset 0 and work my way through the=
=20
whole RBD image.=20

A quick try shows me that my partition table + filesystem are gone on=20
the RBD image after I've run rbd_discard.=20

I just want to know if this is sufficient to wipe a RBD image? Or would=
=20
it be better to fully fill the image with zeroes?=20

--=20
Wido den Hollander=20
42on B.V.=20
Ceph trainer and consultant=20

Phone: +31 (0)20 700 9902=20
Skype: contact42on=20
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
