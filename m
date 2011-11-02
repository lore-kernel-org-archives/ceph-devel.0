From: Sage Weil <sage@newdream.net>
Subject: ceph on freebsd
Date: Wed, 2 Nov 2011 08:49:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1111020846310.10797@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46833 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932383Ab1KBPtx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Nov 2011 11:49:53 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id CD722BC98C
	for <ceph-devel@vger.kernel.org>; Wed,  2 Nov 2011 08:49:52 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id A13EBBC98C
	for <ceph-devel@vger.kernel.org>; Wed,  2 Nov 2011 08:49:52 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I just merged the wip-freebsd branch into 'master' (thanks, stass!).  
This involves a range of small changes to #includes and #defines and so 
forth, so please be on the lookout for strangeness.

The 'next' branch (which will become v0.38) does not include any of these 
changes, so freebsd support will land in v0.39.

sage
