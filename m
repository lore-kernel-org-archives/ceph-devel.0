From: =?UTF-8?B?Q2zDoXVkaW8=?= Martins <ctpm@ist.utl.pt>
Subject: Increasing the number of PGs
Date: Mon, 26 Mar 2012 21:34:59 +0100
Message-ID: <20120326213459.e8ace6f3.ctpm@ist.utl.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.ist.utl.pt ([193.136.128.21]:38313 "EHLO smtp1.ist.utl.pt"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756785Ab2CZUo6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 26 Mar 2012 16:44:58 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp1.ist.utl.pt (Postfix) with ESMTP id 316CD700042A
	for <ceph-devel@vger.kernel.org>; Mon, 26 Mar 2012 21:35:00 +0100 (WEST)
Received: from smtp1.ist.utl.pt ([127.0.0.1])
	by localhost (smtp1.ist.utl.pt [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id mNWxIfpSP+Y2 for <ceph-devel@vger.kernel.org>;
	Mon, 26 Mar 2012 21:35:00 +0100 (WEST)
Received: from mail2.ist.utl.pt (mail.ist.utl.pt [IPv6:2001:690:2100:1::8])
	by smtp1.ist.utl.pt (Postfix) with ESMTP id F09897000427
	for <ceph-devel@vger.kernel.org>; Mon, 26 Mar 2012 21:34:59 +0100 (WEST)
Received: from coyote.ist.utl.pt (unknown [IPv6:2001:690:2100:2:21d:92ff:fea9:c53d])
	(Authenticated sender: ist146506)
	by mail2.ist.utl.pt (Postfix) with ESMTPSA id 9F9F62007385
	for <ceph-devel@vger.kernel.org>; Mon, 26 Mar 2012 21:34:59 +0100 (WEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


 Greetings,

 I've been testing Ceph on a cluster where I have added new OSDs
several times, to the point where I now have 46 OSDs and only a total
of 192 PGs per pool, which now seems rather far from what the
documentation suggests (about 100 per OSD in each pool).

 Some past messages on this list and some documentation suggest that
increasing pg_num on a cluster with data won't give good results and
that PG splitting is not functional at this time.

 Can anyone clarify if this is still the case as of v0.43 and/or v0.44,
or is it safe to increase pg_num on a pool with live data?

Thanks in advance

Best regards

Cl=C3=A1udio

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
