From: Sage Weil <sage@newdream.net>
Subject: cephx auth
Date: Wed, 4 Apr 2012 23:18:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1204042317560.28065@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53159 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753635Ab2DEGSu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Apr 2012 02:18:50 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id DA5EBBCAF5
	for <ceph-devel@vger.kernel.org>; Wed,  4 Apr 2012 23:18:49 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id AAE59BCAF5
	for <ceph-devel@vger.kernel.org>; Wed,  4 Apr 2012 23:18:49 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Should we make cephx auth the default?  Currently it is still 'none', but 
this code is 2 years old now and I haven't seen an auth-related bug in at 
least half a year.

sage
