From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 0/2] rbd: support additional Boolean rbd_dev flags
Date: Tue, 28 Feb 2012 20:40:40 -0800
Message-ID: <4F4DAC48.7060804@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:54698 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932134Ab2B2Ekk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 23:40:40 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id B69FB24318
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 20:40:40 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id A5ACE24314
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 20:40:40 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This series actually added another flag to the rbd_dev, but the
need for that went away.  Still, I thought these two changes
added value so I kept them.

					-Alex
