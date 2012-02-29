From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 0/4] rbd: miscellaneous cleanups
Date: Tue, 28 Feb 2012 19:31:02 -0800
Message-ID: <4F4D9BF6.5070102@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:49107 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030686Ab2B2DbC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 22:31:02 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 6C44624318
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:31:02 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 6101324314
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:31:02 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This series makes a few small unrelated changes to the rbd code.
The first is a set of simple cleanups.  The second makes
ceph_parse_options() return a pointer to make the interface
a little more obvious.  The third gets rid of a duplicate
copy of the pointer to a ceph_client held in an rbd_device,
and the last one makes it so RBD_SNAP_HEAD_NAME is the only
way used for identifying the head snapshot.

					-Alex
