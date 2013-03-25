From: Sage Weil <sage@inktank.com>
Subject: prototype incremental rbd backup
Date: Mon, 25 Mar 2013 16:38:34 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1303251635540.12444@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54501 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951Ab3CYXif (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Mar 2013 19:38:35 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 0454B80068
	for <ceph-devel@vger.kernel.org>; Mon, 25 Mar 2013 16:38:35 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id C723580068
	for <ceph-devel@vger.kernel.org>; Mon, 25 Mar 2013 16:38:34 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The wip-rbd-diff branch has an early prototype of rbd incremental 
backup/restore.  Currently it works like:

 rbd export-diff myimage@to --from-snap from - | \
 rbd import-diff - myimagecopy 

The import apply the update stream and then create the final 'to' snap 
(which is referenced in the stream itself).  A filename can be used in 
place of -, naturally.

It's still very rough around the edges, but it's passing my basic tests; 
feedback is welcome!

sage
