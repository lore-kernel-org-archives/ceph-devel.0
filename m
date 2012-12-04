From: Smart Weblications GmbH - Florian Wiessner
	<f.wiessner@smart-weblications.de>
Subject: Re: Removed directory is back in the Ceph FS
Date: Tue, 04 Dec 2012 23:37:35 +0100
Message-ID: <50BE7B2F.8020404@smart-weblications.de>
References: <CAOGW2pyKcL=vs7p2i3yDNCC1Vxoh6cx053vECVCm=Twt7H4M5A@mail.gmail.com> <CAOGW2pzG466Q3p-EXwx6_jxOjazPa3yxO8H6UtDDaLxVgu7rbg@mail.gmail.com>
Reply-To: f.wiessner@smart-weblications.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx04.smart-weblications.de ([188.65.144.39]:42331 "EHLO
	mx04.smart-weblications.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751807Ab2LDWiF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Dec 2012 17:38:05 -0500
In-Reply-To: <CAOGW2pzG466Q3p-EXwx6_jxOjazPa3yxO8H6UtDDaLxVgu7rbg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Franck Marchand <fmarchand@agaetis.fr>
Cc: ceph-devel@vger.kernel.org

Am 13.11.2012 12:23, schrieb Franck Marchand:
> Hi,
>=20
> I have a weird pb. I remove a folder using a mounted fs partition. I
> did it and it worked well.
> I checked later to see if I had all my folders in ceph fs ... : the
> folder I removed was back and I can't remove it ! Here is the error
> message I got :
>=20
> rm -rf 2012-11-10/
> rm cannot remove `2012-11-10': Directory not empty
>=20
> This folder is empty ...
> So anybody had the same pb ? Am I doing something wrong ?
>=20

I had the same problem when i tried to untar a kernel-tree on cephfs, a=
fter
deleting it with rm -r linux the rm process seemed to work, but the fol=
der was
still there with some (~20) subfolders all empty but cannot be removed =
with
error message "directory not empty". My setup was 4 osds, 4 mons, 4 mds
configured, one running.

However, i currently have no hardware left to test or debug this right =
now.




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
