From: Pete Zaitcev <zaitcev@kotori.zaitcev.us>
Subject: Client debugging  and rados_conf_set()
Date: Tue, 24 Feb 2015 19:45:01 -0700
Message-ID: <20150224194501.38982e51@guren.zaitcev.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from takane.zaitcev.us ([96.126.117.152]:41046 "EHLO
	takane.zaitcev.us" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752331AbbBYCvl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Feb 2015 21:51:41 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Pete Zaitcev <zaitcev@kotori.zaitcev.us>

Hello:

I noticed that RadosClient.cc is full of interesting printouts, like so:

  ldout(cct, 1) << "setting wanted keys" << dendl;

So, I tried to enable them by doing this:

	rc = rados_conf_set(rados, "debug_rados", "20/20");

However, the above produces no output. What am I missing? How are these
printouts made visible conventionally?

Thanks in advance,
-- Pete
