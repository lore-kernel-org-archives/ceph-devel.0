From: Sage Weil <sage@inktank.com>
Subject: stuff for v0.56.4
Date: Tue, 5 Mar 2013 15:10:38 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1303051503480.1162@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38506 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886Ab3CEXKi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Mar 2013 18:10:38 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 5953980060
	for <ceph-devel@vger.kernel.org>; Tue,  5 Mar 2013 15:10:38 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 412D380060
	for <ceph-devel@vger.kernel.org>; Tue,  5 Mar 2013 15:10:38 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

There have been a few important bug fixes that people are hitting or 
want:

- the journal replay bug (5d54ab154ca790688a6a1a2ad5f869c17a23980a)
- the - _ pool name vs cap parsing thing that is biting openstack users
- ceph-disk-* changes to support latest ceph-deploy

If there are other things that we want to include in 0.56.4, lets get them 
into the bobtial branch sooner rather than later.

Possible items:

- pg log trimming (probably a conservative subset) to avoid memory bloat
- omap scrub?
- pg temp collection removal?
- buffer::cmp fix from loic?

Are there other items that we are missing?

sage

