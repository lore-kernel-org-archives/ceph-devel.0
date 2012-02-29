From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 0/4] ceph: minor cleanups
Date: Tue, 28 Feb 2012 19:09:40 -0800
Message-ID: <4F4D96F4.3080707@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:60565 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965286Ab2B2DJl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 22:09:41 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 0C20A24318
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:09:41 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id F0C3724314
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:09:40 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

These are mostly small cleanups.  Only the second one has any
significant changes in it--using a masked atomic rather than
a spinlocked mod operation for determining an index to use
on a fixed-size array.

					-Alex
