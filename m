From: Sage Weil <sage@inktank.com>
Subject: ceph-fuse on os x
Date: Tue, 30 Oct 2012 09:13:35 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1210300912250.13553@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48137 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933852Ab2J3QNg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Oct 2012 12:13:36 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id C99028004F
	for <ceph-devel@vger.kernel.org>; Tue, 30 Oct 2012 09:13:35 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 9F5468004F
	for <ceph-devel@vger.kernel.org>; Tue, 30 Oct 2012 09:13:35 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

It is probably a relatively straighforward porting job (fixing up 
#includes, etc.) to get ceph-fuse working under OS X with macfuse or 
osxfuse or whatever the latest and greatest is.

Any Mac users out there interested?

sage

