From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 0/4] rbd: client list locking improvements
Date: Tue, 28 Feb 2012 19:44:14 -0800
Message-ID: <4F4D9F0E.4080804@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:46334 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030731Ab2B2DoO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 22:44:14 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id C794424318
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:44:14 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id BB0BD24314
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:44:14 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This series reduces the window during which the client list
lock is held, gives it a more meaningful name, and moves the
locking calls closer to the places they're really needed.

					-Alex
