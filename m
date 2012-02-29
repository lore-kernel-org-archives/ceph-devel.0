From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 0/3] rbd: minor cleanups in rbd_add()
Date: Tue, 28 Feb 2012 19:50:30 -0800
Message-ID: <4F4DA086.7050601@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:33998 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752773Ab2B2Dub (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 22:50:31 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 2B50624322
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:50:31 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 1A80824318
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:50:31 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This series affects rbd_add().  It calls rbd_get_client(), and by
making that function return a client pointer it makes it more
obvious that the client pointer is getting assigned.  It also
reduces the amount of memory allocated to hold the monitor
address and options passed from the user.  And it cleans up
the error handling path in that function.

					-Alex
