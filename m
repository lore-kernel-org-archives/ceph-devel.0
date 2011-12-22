From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 0/3] ceph: fix a few problems in ceph_dir_*_complete()
Date: Thu, 22 Dec 2011 11:50:49 -0600
Message-ID: <1324576249.3957.105.camel@doink>
Reply-To: elder@dreamhost.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:35754 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752814Ab1LVRuv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Dec 2011 12:50:51 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id BC20BC065
	for <ceph-devel@vger.kernel.org>; Thu, 22 Dec 2011 10:01:29 -0800 (PST)
Received: from [172.22.22.65] (c-71-193-71-178.hsd1.mn.comcast.net [71.193.71.178])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 715A0C064
	for <ceph-devel@vger.kernel.org>; Thu, 22 Dec 2011 10:01:29 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This series fixes a possible null pointer dereference in
ceph_dir_set_complete().

It also fixes the ceph-private implementation of
__d_find_any_alias() so it takes a reference to the
returned dentry.  In addition, getting that reference
to the dentry requires the Linux inode lock, so ensure
that is taken by (duplicating and) using the locking
form of that function, d_find_any_alias().

					-Alex

