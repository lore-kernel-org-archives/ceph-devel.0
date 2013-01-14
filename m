From: =?ISO-8859-15?Q?Simon_Frerichs_=7C=A0Fremaks_GmbH?=
	<frerichs@fremaks.de>
Subject: Another rbd compatibility issue between 0.48.2argonaut-2 and 0.56.1
 ?
Date: Mon, 14 Jan 2013 08:16:55 +0100
Message-ID: <50F3B0E7.3090809@fremaks.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.fremaks.net ([46.19.89.69]:36423 "EHLO mail.fremaks.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755244Ab3ANHXm (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 14 Jan 2013 02:23:42 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.fremaks.net (Postfix) with ESMTP id B46F83A00C
	for <ceph-devel@vger.kernel.org>; Mon, 14 Jan 2013 08:16:54 +0100 (CET)
Received: from mail.fremaks.net ([127.0.0.1])
	by localhost (mail.fremaks.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5w1xm51j50QN for <ceph-devel@vger.kernel.org>;
	Mon, 14 Jan 2013 08:16:54 +0100 (CET)
Received: from bump.local (unknown [46.19.88.242])
	by mail.fremaks.net (Postfix) with ESMTPSA id 625B139F3B
	for <ceph-devel@vger.kernel.org>; Mon, 14 Jan 2013 08:16:54 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

we've updated ceph on one node from argonaut to 0.56.1.
The osds are working fine but i see the following error:

rbd info kvm1395
rbd: error opening image kvm1395: (5) Input/output error
2013-01-14 06:09:10.162206 7efff3aed760 -1 librbd: Error getting lock
info: (5) Input/output error

rbd --version
ceph version 0.56.1 (e4a541624df62ef353e754391cbbb707f54b16f7)

Switching rbd back to argonaut fixes this error.

Any hints?
=20

--=20
Mit freundlichen Gr=FC=DFen
Simon Frerichs

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
