From: Noah Watkins <jayhawk@soe.ucsc.edu>
Subject: Updated hadoop patch
Date: Wed, 9 Nov 2011 15:15:41 -0800 (PST)
Message-ID: <1183389798.47687.1320880541074.JavaMail.root@mail-01.cse.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:51743 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754250Ab1KIXPl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Nov 2011 18:15:41 -0500
Received: from mail-01.cse.ucsc.edu (mail-01.cse.ucsc.edu [128.114.48.32])
	by mail-01.cse.ucsc.edu (Postfix) with ESMTP id 2AD78775C005
	for <ceph-devel@vger.kernel.org>; Wed,  9 Nov 2011 15:15:41 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

The Ceph/Hadoop wiki page now points to an updated patch
that applies to Hadoop (and setup instructions). The
patch in Ceph @ src/client/hadoop is outdated and can
probably be either deleted or replaced with the patch
found here:

  http://www.soe.ucsc.edu/~jayhawk/hadoop-0.20.205.0-cephfs1.patch

If the patch gets shoved in Git I'll update the wiki.

Thanks,
Noah
