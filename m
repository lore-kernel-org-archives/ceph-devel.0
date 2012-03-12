From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 0/5] ceph: ceph file layout helper fixes
Date: Mon, 12 Mar 2012 17:50:13 -0500
Message-ID: <4F5E7DA5.4040802@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:41328 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752534Ab2CLWuK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Mar 2012 18:50:10 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 392F7243A2
	for <ceph-devel@vger.kernel.org>; Mon, 12 Mar 2012 15:50:44 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net [71.195.31.37])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 0EA922439E
	for <ceph-devel@vger.kernel.org>; Mon, 12 Mar 2012 15:50:43 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This series makes a set of changes to the file layout helper macros
used in Ceph.  First, their definitions are moved into a more
appropriate source file.  Then they are changed to take a pointer
rather than a struct argument.  Next, changes are made so they're
always used for accessing a Ceph inode's file layout information,
and a symbolic value is used to represent "no preferred placement
group."  And finally, some changes ensure close attention is paid
to the types of these values and what they get assigned to, and
for most of them they're changed to use 64-bit unsigned values.

					-Alex
