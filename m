From: Quenten Grasso <QGrasso@onq.com.au>
Subject: Openstack
Date: Sat, 25 Aug 2012 02:31:28 +0000
Message-ID: <35DD34C9-6FDC-4735-A363-CB69C1F6E18B@onqtel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.onqtel.net ([120.88.69.160]:46486 "EHLO mx1.onqtel.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752304Ab2HYCiQ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Aug 2012 22:38:16 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx1.onqtel.net (Postfix) with ESMTP id 5A55C8D07D
	for <ceph-devel@vger.kernel.org>; Sat, 25 Aug 2012 12:31:58 +1000 (EST)
Received: from mx1.onqtel.net ([127.0.0.1])
	by localhost (mx1.onqtel.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yEplxA5Qvvvx for <ceph-devel@vger.kernel.org>;
	Sat, 25 Aug 2012 12:31:53 +1000 (EST)
Received: from ex01.onqtel.local (ex01.onqtel.local [10.21.0.30])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mx1.onqtel.net (Postfix) with ESMTPS id E76C48D077
	for <ceph-devel@vger.kernel.org>; Sat, 25 Aug 2012 12:31:52 +1000 (EST)
Content-Language: en-US
Content-ID: <75B331B53B9AEE4D93D010F2D401777B@onq.com.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi All

Just wondering if anyone has any tips on getting openstack Essex working with boot from RBD with the dashboard.

Glance and RBD is fairly well documented and Nova with attaching ceph RBD vols,   However I haven't found much on getting boot from RBD to work.

Regards,
Quenten Grasso
Sent from my iPhone