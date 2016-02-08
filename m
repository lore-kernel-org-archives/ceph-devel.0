From: Loic Dachary <loic@dachary.org>
Subject: Infernalis RGW failure investigation
Date: Mon, 8 Feb 2016 10:52:45 +0700
Message-ID: <56B8110D.8040401@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:38214 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753022AbcBHDwx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 7 Feb 2016 22:52:53 -0500
Received: from mfilter29-d.gandi.net (mfilter29-d.gandi.net [217.70.178.160])
	by relay6-d.mail.gandi.net (Postfix) with ESMTP id 94A1CFB8A0
	for <ceph-devel@vger.kernel.org>; Mon,  8 Feb 2016 04:52:51 +0100 (CET)
Received: from relay6-d.mail.gandi.net ([IPv6:::ffff:217.70.183.198])
	by mfilter29-d.gandi.net (mfilter29-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id rkN3CyhfM6AL for <ceph-devel@vger.kernel.org>;
	Mon,  8 Feb 2016 04:52:50 +0100 (CET)
Received: from [10.7.10.93] (node-ar2.pool-118-172.dynamic.totbb.net [118.172.54.110])
	(Authenticated sender: loic@dachary.org)
	by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id B5261FB883
	for <ceph-devel@vger.kernel.org>; Mon,  8 Feb 2016 04:52:49 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Dear RGW developers,

We ran into http://tracker.ceph.com/issues/14665 on the infernalis bran=
ch. It would be great if someone could shed some light on why it happen=
s.

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
