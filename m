From: Smart Weblications GmbH - Florian Wiessner
	<f.wiessner@smart-weblications.de>
Subject: Re: Ceph fs stability
Date: Thu, 02 Aug 2012 19:26:49 +0200
Message-ID: <501AB859.4040402@smart-weblications.de>
References: <501AB499.1080706@gmail.com>
Reply-To: f.wiessner@smart-weblications.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx01.smart-weblications.de ([188.65.144.36]:56616 "EHLO
	mx01.smart-weblications.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754513Ab2HBR0Y (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Aug 2012 13:26:24 -0400
In-Reply-To: <501AB499.1080706@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Niko! <nicola.ranaldo@gmail.com>
Cc: ceph-devel@vger.kernel.org

Am 02.08.2012 19:10, schrieb Niko!:
> Hi!
>=20
> we are using ceph 0.48 on three nodes to provide rbd images for furth=
er four kvm
> nodes (not kernel mapped) with no big issues and would mount the ceph=
 fs on the
> kvm nodes just to store xml virtual machine definitions in order to h=
ave them
> immediately in the case an host crashes (we are in multimds configura=
tion). As
> ceph fs is not production ready what are the possible problems? May t=
he fs
> corrupt the rbd pool or damages will be limited only to the data/meta=
data pools
> (acceptable for us)? may the fs hang the entire cluster or kvm client=
 nodes?
>=20



Don't use it for now, it is too buggy - you sometimes cannot delete fil=
es or
rename them, or the fuse client crashes..


what we do instead is use a mapped rbd device with ocfs2 - works stable=
=2E

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
