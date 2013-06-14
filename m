From: =?iso-8859-1?Q?J=E4ger=2C_Philipp?= <Philipp.Jaeger@cgm.com>
Subject: radosgw- bind user to pool
Date: Fri, 14 Jun 2013 13:59:01 +0000
Message-ID: <5EFBD28BA42C604BB012164C72CA560450CBBE16@SMBXKO3.cgm.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smxko1.compugroup.com ([193.47.161.177]:51752 "EHLO
	SMXKO1.compugroup.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363Ab3FNN7N convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Jun 2013 09:59:13 -0400
Received: from localhost (localhost [127.0.0.1])
	by SMXKO1.compugroup.com (Postfix) with ESMTP id 50A7C6125
	for <ceph-devel@vger.kernel.org>; Fri, 14 Jun 2013 15:59:01 +0200 (CEST)
Received: from SMXKO1.compugroup.com ([127.0.0.1])
	by localhost (smxko1.compugroup.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T+ORG4zvXhUG for <ceph-devel@vger.kernel.org>;
	Fri, 14 Jun 2013 15:59:01 +0200 (CEST)
Received: from SCASKO2.cgm.ag (unknown [10.0.0.162])
	by SMXKO1.compugroup.com (Postfix) with ESMTPS id 25C196079
	for <ceph-devel@vger.kernel.org>; Fri, 14 Jun 2013 15:59:01 +0200 (CEST)
Content-Language: de-DE
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello,

We have several projects, which needs to save data to a rados object st=
ore via radosgw.

Is it possible to bind a rgw user to a specific pool?

Perhaps it is also possible to bind a whole rgw to a specific pool? We =
have set up 2 rgws, but when I add a certain pool in rgw1, it's synchro=
nized in the other one/ rgw2 . It's the same with the user database. So=
 is it possible to separate it? We thought about 1RGW per project, but =
because of the sync, it's not possible I think?

When you add more than one pool to the radosgw, in which pool will data=
 be written? Is it random?

Thank you very much.

Regards

Philipp J=E4ger
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
