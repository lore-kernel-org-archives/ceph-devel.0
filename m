From: Smart Weblications GmbH - Florian Wiessner
	<f.wiessner@smart-weblications.de>
Subject: Re: ceph-osd not starting
Date: Sun, 18 Dec 2011 13:51:03 +0100
Message-ID: <4EEDE1B7.6090406@smart-weblications.de>
References: <4EEB3848.8080202@smart-weblications.de> <CACLRD_0HD9iFLDQBsccHibPGA6rqjos51c4w13qChB0Xw9nQsw@mail.gmail.com> <4EEBB685.4090906@smart-weblications.de> <CACLRD_1TwMN+YNoyizt7+ZnvEtjRWKW21yJuJpnucnY=QwQtGQ@mail.gmail.com>
Reply-To: f.wiessner@smart-weblications.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx03.smart-weblications.de ([188.65.144.38]:52038 "EHLO
	mx03.smart-weblications.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751615Ab1LRMvh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Sun, 18 Dec 2011 07:51:37 -0500
In-Reply-To: <CACLRD_1TwMN+YNoyizt7+ZnvEtjRWKW21yJuJpnucnY=QwQtGQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

Am 17.12.2011 00:55, schrieb Samuel Just:
> There is no further output?  Does the process die at that point, or
> does it hang?

it just dies - is the cephfs from the previous version incompatible wit=
h the
newer version?

strace of the osd not starting:

http://office.smart-weblications.net//osd-trace.txt




--=20

Mit freundlichen Gr=C3=BC=C3=9Fen,

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
Gesch=C3=A4ftsf=C3=BChrer: Florian Wiessner
HRB-Nr.: HRB 3840 Amtsgericht Hof
*aus dem dt. Festnetz, ggf. abweichende Preise aus dem Mobilfunknetz

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
