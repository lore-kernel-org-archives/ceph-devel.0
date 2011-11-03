From: Amon Ott <a.ott@m-privacy.de>
Subject: Feature request: "max mon" setting
Date: Thu, 3 Nov 2011 13:02:50 +0100
Message-ID: <201111031302.51236.a.ott@m-privacy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www.m-privacy.de ([85.214.138.176]:41877 "EHLO www.m-privacy.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932592Ab1KCMDB convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Nov 2011 08:03:01 -0400
Received: from localhost (localhost [127.0.0.1])
	by www.m-privacy.de (Postfix) with ESMTP id 57B3485F13
	for <ceph-devel@vger.kernel.org>; Thu,  3 Nov 2011 13:02:59 +0100 (CET)
Received: from www.m-privacy.de ([127.0.0.1])
 by localhost (www.m-privacy.de [127.0.0.1]) (amavisd-maia, port 10024)
 with ESMTP id 15698-01 for <ceph-devel@vger.kernel.org>;
 Thu,  3 Nov 2011 13:02:53 +0100 (CET)
Received: from gw.compuniverse.de (unknown [85.183.4.97])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.m-privacy.de (Postfix) with ESMTPSA id D584485F10
	for <ceph-devel@vger.kernel.org>; Thu,  3 Nov 2011 13:02:52 +0100 (CET)
Received: from tgham.compuniverse.de (tgham.compuniverse.de [192.168.201.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by gw.compuniverse.de (Postfix) with ESMTPS id 43A5326B52
	for <ceph-devel@vger.kernel.org>; Thu,  3 Nov 2011 13:02:52 +0100 (CET)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi all,

currently, all defined monitors are started automatically and included =
in the=20
mon cluster. In a big cluster, you either need to define many monitors =
or=20
risk a cluster failure, if the majority of monitors fails.

Documentation recommends three monitors. In our special cluster configu=
ration,=20
this would mean that if accidentially two nodes with monitors fail (e.g=
=2E one=20
in maintenance and one crashes), the whole cluster dies. What I would r=
eally=20
like would be that I can define a monitor on each node and e.g. set "ma=
x mon=20
=3D 3". Each monitor starting up can then check how many monitors are a=
lready=20
up and go to standby, if the number has already been reached. Regular=20
rechecking could allow another monitor to become active, if one of the=20
previously active monitors has died. Just like "max mds" actually.

A special case that gives me most headaches is the case of just two act=
ive=20
nodes. According to documentation, the monitor problem means that one f=
ailing=20
monitor kills the cluster whatever the number of defined monitors (1 or=
 2),=20
even if we have all data safely placed on both nodes.

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
