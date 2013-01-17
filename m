From: Christopher Kunz <chrislist@de-punkt.de>
Subject: Current OSD weight vs. target weight
Date: Thu, 17 Jan 2013 16:58:41 +0100
Message-ID: <50F81FB1.2060909@de-punkt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-2.de-punkt.de ([93.190.64.238]:60063 "EHLO
	mail-2.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756824Ab3AQQFJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Jan 2013 11:05:09 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail-2.de-punkt.de (Postfix) with ESMTP id E6FF83A332
	for <ceph-devel@vger.kernel.org>; Thu, 17 Jan 2013 16:58:42 +0100 (CET)
Received: from mail-2.de-punkt.de ([127.0.0.1])
	by localhost (mail-10.de-punkt.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UnP4HSYgv-Vk for <ceph-devel@vger.kernel.org>;
	Thu, 17 Jan 2013 16:58:42 +0100 (CET)
Received: from Christophers-MacBook-Pro.local (p4FD072C0.dip.t-dialin.net [79.208.114.192])
	(Authenticated sender: chris@de-punkt.de)
	by mail-2.de-punkt.de (Postfix) with ESMTPSA id B92393A310
	for <ceph-devel@vger.kernel.org>; Thu, 17 Jan 2013 16:58:42 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

if run during a user-issued reweight (i.e. "ceph osd crush reweight x
y"), "ceph osd tree" shows the target weight of an OSD. Is there a way
to see the *current* weight of the OSD?

We would like to be able to approximate the amount of rollback necessar=
y
per OSD if we need to cancel a larger reweight at some point. This seem=
s
impossible, though, without knowing the current weight.

Any hints how to do this?

Regards,

--ck

--=20
filoo GmbH
Dr. Christopher Kunz

E-Mail: chris@filoo.de
Tel.: (+49) 0 52 41 8 67 30 -18
=46ax: (+49) 0 52 41 / 8 67 30 -20

Please sign & encrypt mail wherever possible, my key:
C882 8ED1 7DD1 9011 C088 EA50 5CFA 2EEB 397A CAC1

Moltkestra=DFe 25a
33330 G=FCtersloh

HRB4355, AG G=FCtersloh
Gesch=E4ftsf=FChrer: S.Grewing, J.Rehp=F6hler, Dr. C.Kunz

=46iloo im Web: http://www.filoo.de/
=46olgen Sie uns auf Twitter: http://twitter.com/filoogmbh
Werden Sie unser Fan auf Facebook: http://facebook.com/filoogmbh
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
