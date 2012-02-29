From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 0/5] rbd: improve how rbd ids are selected
Date: Tue, 28 Feb 2012 19:38:13 -0800
Message-ID: <4F4D9DA5.8050101@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:54264 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030686Ab2B2DiO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 22:38:14 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 61CDC24318
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:38:14 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 5655524314
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:38:14 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

New rbd devices are granted a unique identifiers based on how many
devices are already in existence.  This series rearranges how that
is done, switching from using a spinlock to using an atomic variable
to select the next rbd id to use.  In the process a bit of the code
got a bit more isolated.

					-Alex
