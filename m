From: Amon Ott <a.ott@m-privacy.de>
Subject: Multiple named clusters on same nodes
Date: Wed, 23 May 2012 11:00:27 +0200
Message-ID: <201205231100.28327.a.ott@m-privacy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www.m-privacy.de ([85.214.237.71]:44939 "EHLO www.m-privacy.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752563Ab2EWJAi convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 May 2012 05:00:38 -0400
Received: from localhost (localhost [127.0.0.1])
	by www.m-privacy.de (Postfix) with ESMTP id 29F1B63CBD
	for <ceph-devel@vger.kernel.org>; Wed, 23 May 2012 11:00:34 +0200 (CEST)
Received: from www.m-privacy.de ([127.0.0.1])
 by localhost (www.m-privacy.de [127.0.0.1]) (amavisd-maia, port 10024)
 with ESMTP id 11866-09 for <ceph-devel@vger.kernel.org>;
 Wed, 23 May 2012 11:00:27 +0200 (CEST)
Received: from gw.compuniverse.de (unknown [85.183.4.97])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.m-privacy.de (Postfix) with ESMTPSA id 2AF2063CBC
	for <ceph-devel@vger.kernel.org>; Wed, 23 May 2012 11:00:27 +0200 (CEST)
Received: from tgham.compuniverse.de (tgham.compuniverse.de [192.168.201.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by gw.compuniverse.de (Postfix) with ESMTPS id 673A520BD9
	for <ceph-devel@vger.kernel.org>; Wed, 23 May 2012 11:00:29 +0200 (CEST)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello all!

We would like to have two independent clusters on the same cluster node=
s,=20
specially one for user home directories (called homeuser) and one for b=
ackups=20
(backup). The reason is that in case the homeuser cephfs breaks (like i=
t has=20
done several times in our tests), we still have independent storage of =
the=20
backups without the need of seperate server nodes.

So I started experimenting with the new "cluster" variable, but it does=
 not=20
seem to be well supported so far. mkcephfs does not even know about it =
and=20
always uses "ceph" as cluster name. Setting a value for "cluster" in gl=
obal=20
section of ceph.conf (homeuser.conf, backup.conf, ...) does not work, i=
t is=20
not even used in the same config file, instead it has the fixed value "=
ceph".

My questions:
1) Has someone here ever tried such a setup?
2) Is there an official (documented) way to at least setup ceph cluster=
s with=20
individual cluster names?
3) Are there plans to support cluster names in mkcephfs?

Amon Ott
--=20
Dr. Amon Ott
m-privacy GmbH           Tel: +49 30 24342334
Am K=F6llnischen Park 1    Fax: +49 30 24342336
10179 Berlin             http://www.m-privacy.de

Amtsgericht Charlottenburg, HRB 84946

Gesch=E4ftsf=FChrer:
 Dipl.-Kfm. Holger Maczkowsky,
 Roman Maczkowsky

GnuPG-Key-ID: 0x2DD3A649
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
