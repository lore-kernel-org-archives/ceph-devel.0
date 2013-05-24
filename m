From: Oliver Francke <Oliver.Francke@filoo.de>
Subject: qemu-1.5.0 savevm error -95 while writing vm with ceph-rbd as storage-backend
Date: Fri, 24 May 2013 09:46:53 +0200
Message-ID: <519F1AED.80005@filoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-1.de-punkt.de ([93.190.64.237]:52253 "EHLO
	mail-1.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759956Ab3EXHq5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 May 2013 03:46:57 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "qemu@nongnu.org" <qemu-devel@nongnu.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

with a running VM I encounter this strange behaviour, former=20
qemu-versions don't show up such an error.
Perhaps this comes from the rbd-backend in qemu-1.5.0 in combination=20
with ceph-0.56.6? Therefore my
crosspost.

Even if I have no real live-snapshot avail - they know of this=20
restriction -, it's more work for the customers
to perform a shutdown before the wonna do some changes to their VM ;)

Any hints welcome,

Oliver.

--=20

Oliver Francke

filoo GmbH
Moltkestra=DFe 25a
33330 G=FCtersloh
HRB4355 AG G=FCtersloh

Gesch=E4ftsf=FChrer: S.Grewing | J.Rehp=F6hler | C.Kunz

=46olgen Sie uns auf Twitter: http://twitter.com/filoogmbh

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
