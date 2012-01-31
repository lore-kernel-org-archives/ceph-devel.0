From: Amon Ott <a.ott@m-privacy.de>
Subject: Cannot delete some empty dirs and weird sizes
Date: Tue, 31 Jan 2012 13:00:20 +0100
Message-ID: <201201311300.20787.a.ott@m-privacy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www.m-privacy.de ([85.214.138.176]:49303 "EHLO www.m-privacy.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752742Ab2AaMAa convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 31 Jan 2012 07:00:30 -0500
Received: from localhost (localhost [127.0.0.1])
	by www.m-privacy.de (Postfix) with ESMTP id 2212185FBE
	for <ceph-devel@vger.kernel.org>; Tue, 31 Jan 2012 13:00:29 +0100 (CET)
Received: from www.m-privacy.de ([127.0.0.1])
 by localhost (www.m-privacy.de [127.0.0.1]) (amavisd-maia, port 10024)
 with ESMTP id 28992-08 for <ceph-devel@vger.kernel.org>;
 Tue, 31 Jan 2012 13:00:22 +0100 (CET)
Received: from gw.compuniverse.de (unknown [85.183.4.97])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.m-privacy.de (Postfix) with ESMTPSA id 46F4085FBD
	for <ceph-devel@vger.kernel.org>; Tue, 31 Jan 2012 13:00:22 +0100 (CET)
Received: from tgham.compuniverse.de (tgham.compuniverse.de [192.168.201.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by gw.compuniverse.de (Postfix) with ESMTPS id B59D2262D5
	for <ceph-devel@vger.kernel.org>; Tue, 31 Jan 2012 13:00:21 +0100 (CET)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi again!

We are running Ceph 0.41 and kernel 3.2.2 with current for-linus code (=
commit =20
3d882ce47de80e0294a536bec771b5651885b4d3) now.

After some heavy workloads we see quite a few directories that cannot b=
e=20
deleted, although ls and find show that they are empty. rmdir says they=
 are=20
not empty.

Additionally, ceph reports various weird size values for some, but not =
all of=20
them:
ls -la .tmp/tiny61/.mozilla/firefox/default.yat/
insgesamt 0
drwxr-xr-x 1 tiny61 users 18446744073705748665 25. Jan 10:02 .
drwxr-xr-x 1 tiny61 users 18446744073705748665 25. Jan 10:02 ..

Is this a known or a new bug? Can it be related to .snap pseudo dirs? T=
he=20
problem appeared without ever using snapshots, though.

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
