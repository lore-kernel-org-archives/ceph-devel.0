From: Smart Weblications GmbH - Florian Wiessner
	<f.wiessner@smart-weblications.de>
Subject: Re: How to build ceph upon zfs filesystem.
Date: Wed, 29 Aug 2012 15:50:29 +0200
Message-ID: <503E1E25.6060704@smart-weblications.de>
References: <loom.20120826T033818-148@post.gmane.org> <503A2142.2000505@inktank.com> <loom.20120827T063044-980@post.gmane.org> <loom.20120829T153702-223@post.gmane.org>
Reply-To: f.wiessner@smart-weblications.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx01.smart-weblications.de ([188.65.144.36]:53346 "EHLO
	mx01.smart-weblications.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752785Ab2H2NuN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 29 Aug 2012 09:50:13 -0400
In-Reply-To: <loom.20120829T153702-223@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ramu eppa <ramu.freesystems@gmail.com>
Cc: ceph-devel@vger.kernel.org

Am 29.08.2012 15:47, schrieb ramu eppa:
> 2012-08-29 10:55:07.384739 7f6e98598780 -1 filestore(/data/osd.1) _de=
tect_fs=20
> unable to create /data/osd.1/xattr_test: (28) No space left on device
> 2012-08-29 10:55:07.385077 7f6e98598780 -1 OSD::mkfs: couldn't mount =
=46ileStore:=20
> error -28
> 2012-08-29 10:55:07.385252 7f6e98598780 -1 ^[[0;31m ** ERROR: error c=
reating=20
> empty object store in /data/osd.1: (28) No space left on device^[[0m


no space left on device?! - zfs full?

--=20

Mit freundlichen Gr=FC=DFen,

=46lorian Wiessner

Smart Weblications GmbH
Martinsberger Str. 1
D-95119 Naila

fon.: +49 9282 9638 200
fax.: +49 9282 9638 205
24/7: +49 900 144 000 00 - 0,99 EUR/Min*
http://www.smart-weblications.de

--
Sitz der Gesellschaft: Naila
Gesch=E4ftsf=FChrer: Florian Wiessner
HRB-Nr.: HRB 3840 Amtsgericht Hof
*aus dem dt. Festnetz, ggf. abweichende Preise aus dem Mobilfunknetz
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
