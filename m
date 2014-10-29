From: Sage Weil <sage@inktank.com>
Subject: rgw: a few CDS takeaways
Date: Wed, 29 Oct 2014 09:56:22 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1410290952300.21641@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37391 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933822AbaJ2Q4X (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Oct 2014 12:56:23 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 24BF780068
	for <ceph-devel@vger.kernel.org>; Wed, 29 Oct 2014 09:56:23 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id E3FC480068
	for <ceph-devel@vger.kernel.org>; Wed, 29 Oct 2014 09:56:22 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

rgw: map new swift 'storage policy' API to existing rgw functionality
  http://tracker.ceph.com/issues/9932

rgw: implement S3 RR (reduced redundancy) API
  http://tracker.ceph.com/issues/9933

rgw: document backing pool capabilities and usage
  http://tracker.ceph.com/issues/9934
