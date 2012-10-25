From: =?UTF-8?B?Q2zDoXVkaW8=?= Martins <ctpm@ist.utl.pt>
Subject: Number of object replicas
Date: Thu, 25 Oct 2012 21:05:16 +0100
Message-ID: <20121025210516.122513f4.ctpm@ist.utl.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp2.ist.utl.pt ([193.136.128.22]:50390 "EHLO smtp2.ist.utl.pt"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935931Ab2JYUFV (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 25 Oct 2012 16:05:21 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp2.ist.utl.pt (Postfix) with ESMTP id 9ADFF7000488
	for <ceph-devel@vger.kernel.org>; Thu, 25 Oct 2012 21:05:17 +0100 (WEST)
Received: from smtp2.ist.utl.pt ([127.0.0.1])
	by localhost (smtp2.ist.utl.pt [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id UNwFyYTTodLL for <ceph-devel@vger.kernel.org>;
	Thu, 25 Oct 2012 21:05:17 +0100 (WEST)
Received: from mail2.ist.utl.pt (mail.ist.utl.pt [IPv6:2001:690:2100:1::8])
	by smtp2.ist.utl.pt (Postfix) with ESMTP id 5E63A70003F7
	for <ceph-devel@vger.kernel.org>; Thu, 25 Oct 2012 21:05:16 +0100 (WEST)
Received: from coyote.ist.utl.pt (unknown [IPv6:2001:690:2100:2:21d:92ff:fea9:c53d])
	(Authenticated sender: ist146506)
	by mail2.ist.utl.pt (Postfix) with ESMTPSA id ADB33200D097
	for <ceph-devel@vger.kernel.org>; Thu, 25 Oct 2012 21:05:16 +0100 (WEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


 Hello,

 The text at=20

http://ceph.com/docs/master/cluster-ops/pools/

 appears to have a slight inconsistency. At the top it says

"Replicas: You can set the desired number of copies/replicas of an obje=
ct. A typical configuration stores an object and one additional copy (i=
=2Ee., size =3D 2), but you can determine the number of copies/replicas=
=2E"


 But on the last section, at the bottom of the page, one reads:

"Ceph will list the pools, with the rep size attribute highlighted. By =
default, Ceph creates two replicas of an object for a total of three co=
pies."


 Which does not seem to be in agreement with the 1st paragraph on that
page or, at least, is ambiguous.


 Best regards

Cl=C3=A1udio

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
