From: Sage Weil <sage@newdream.net>
Subject: v0.20.1 released
Date: Mon, 17 May 2010 10:50:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1005171045200.2404@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52026 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755473Ab0EQRq6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 May 2010 13:46:58 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 3480ABC776
	for <ceph-devel@vger.kernel.org>; Mon, 17 May 2010 10:50:16 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 0C230BC776
	for <ceph-devel@vger.kernel.org>; Mon, 17 May 2010 10:50:16 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We've released a stable update with a bunch of bug fixes since v0.20.  
Notably, we'e fixed

    * mkfs problems with osd journal file
    * librados aio api issues
    * misc osd fixes (crashes, hangs)
    * inconsistent readdir results across nodes

and lots of other small stuff.  To get it:

    * Direct download at http://ceph.newdream.net/download/ceph-0.20.1.tar.gz
    * For Debian packages see http://ceph.newdream.net/wiki/Debian

sage
