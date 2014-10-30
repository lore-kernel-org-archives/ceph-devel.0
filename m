From: Sage Weil <sage@inktank.com>
Subject: rados import/export session
Date: Thu, 30 Oct 2014 14:16:10 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1410301415040.17264@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48106 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933193AbaJ3VQL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Oct 2014 17:16:11 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id DBB0080481
	for <ceph-devel@vger.kernel.org>; Thu, 30 Oct 2014 14:16:10 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id AFC7680481
	for <ceph-devel@vger.kernel.org>; Thu, 30 Oct 2014 14:16:10 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Created several tickets:

9963 librados: improve get_objects and get_position interfaces
9964 rados: new export [range] to pipe/file
9966 librados: set user_version operation
9965 rados: new import from pipe/file
9967 rados: pool rollback

http://pad.ceph.com/p/hammer-rados_export_import

Most of these are pretty straightforward and accessible for new 
contributors!

sage
