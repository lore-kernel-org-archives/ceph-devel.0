From: Smart Weblications GmbH <info@smart-weblications.de>
Subject: Re: host settings in ceph.conf when ipaddress != hostname
Date: Thu, 16 Aug 2012 22:02:28 +0200
Message-ID: <502D51D4.5010606@smart-weblications.de>
References: <CACkq2moqr-VpwLpG2xcTvUfJ4Xm0EKazis4pW_M4FLuATqOHVg@mail.gmail.com> <CADvuQRFZRwL4oBvJW2H25VFME3pTk4rDZxr4WzwMT=sp-K8h6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx01.smart-weblications.de ([188.65.144.36]:46819 "EHLO
	mx01.smart-weblications.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030304Ab2HPULs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Thu, 16 Aug 2012 16:11:48 -0400
In-Reply-To: <CADvuQRFZRwL4oBvJW2H25VFME3pTk4rDZxr4WzwMT=sp-K8h6g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: Travis Rhoden <trhoden@gmail.com>, ceph-devel@vger.kernel.org

Am 16.08.2012 21:56, schrieb Tommi Virtanen:

> It sounds like you want to set set public_network and cluster_network
> in [global] both to 10.30.0.0/8.

10.0.0.0/8 or 10.30.0.0/16, nor? ;-)


--=20

Mit freundlichen Gr=C3=BC=C3=9Fen,


Smart Weblications GmbH
Martinsberger Str. 1
D-95119 Naila

fon.: +49 9282 9638 200
fax.: +49 9282 9638 205
24/7: +49 900 144 000 00 - 0,99 EUR/Min*
http://www.smart-weblications.de

--
Sitz der Gesellschaft: Naila
Gesch=C3=A4ftsf=C3=BChrer: Florian Wiessner
HRB-Nr.: HRB 3840 Amtsgericht Hof
*aus dem dt. Festnetz, ggf. abweichende Preise aus dem Mobilfunknetz
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
