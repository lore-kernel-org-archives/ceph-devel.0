From: Jimmy Tang <jtang@tchpc.tcd.ie>
Subject: tiering of storage pools in ceph in general
Date: Thu, 22 Nov 2012 12:33:51 +0000
Message-ID: <5DC113BE-8B3F-44C1-8585-612CDE601856@tchpc.tcd.ie>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tabaet.tchpc.tcd.ie ([134.226.112.12]:50673 "EHLO
	tabaet.tchpc.tcd.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932147Ab2KVTJk convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Nov 2012 14:09:40 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by tabaet.tchpc.tcd.ie (Postfix) with ESMTP id 80078835F3
	for <ceph-devel@vger.kernel.org>; Thu, 22 Nov 2012 12:35:06 +0000 (GMT)
Received: from tabaet.tchpc.tcd.ie ([127.0.0.1])
	by localhost (tabaet.tchpc.tcd.ie [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Cptn12rlwBif for <ceph-devel@vger.kernel.org>;
	Thu, 22 Nov 2012 12:35:00 +0000 (GMT)
Received: from x00.tchpc.tcd.ie (x00.tchpc.tcd.ie [134.226.112.149])
	by tabaet.tchpc.tcd.ie (Postfix) with ESMTP id DD0AF835E5
	for <ceph-devel@vger.kernel.org>; Thu, 22 Nov 2012 12:35:00 +0000 (GMT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi All,

Is it possible at this point in time to setup some form of tiering of storage pools in ceph by modifying the crush map? For example I want to have my most recently used data on a small set of nodes that have SSD's and over time migrate data from the SSD's to some bulk spinning disk using a LRU policy?

Regards,
Jimmy Tang

--
Senior Software Engineer, Digital Repository of Ireland (DRI)
Trinity Centre for High Performance Computing,
Lloyd Building, Trinity College Dublin, Dublin 2, Ireland.
http://www.tchpc.tcd.ie/ | jtang@tchpc.tcd.ie

