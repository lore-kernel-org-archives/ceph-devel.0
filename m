From: Smart Weblications GmbH - Florian Wiessner
	<f.wiessner@smart-weblications.de>
Subject: Re: Integration work
Date: Tue, 28 Aug 2012 20:57:02 +0200
Message-ID: <503D147E.9020003@smart-weblications.de>
References: <503D0A00.2080905@inktank.com> <20120828185116.GC9872@oder.mch.fsc.net>
Reply-To: f.wiessner@smart-weblications.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx04.smart-weblications.de ([188.65.144.39]:39507 "EHLO
	mx04.smart-weblications.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753117Ab2H1S4w (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Tue, 28 Aug 2012 14:56:52 -0400
In-Reply-To: <20120828185116.GC9872@oder.mch.fsc.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dieter Kasper <d.kasper@kabelmail.de>
Cc: Ross Turk <ross@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 28.08.2012 20:51, schrieb Dieter Kasper:

> Performance enhancements - especially to reduce the latency of a sing=
le IO / increase IOPS -
> and a stronger engagement on the CephFS client would be very much app=
reciated.
> A stable and fast CephFS client would allow an efficient integration =
with
> - (clustered) NFS (v3 and v4)
> - (clustered) Samba v4

Have you tried ocfs2 ontop of rbd in the meanwhile until cephFS gets re=
ady?


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
