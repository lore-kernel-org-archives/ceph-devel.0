From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 0/5] rbd: cleanups related to argument parsing
Date: Tue, 28 Feb 2012 19:56:26 -0800
Message-ID: <4F4DA1EA.3080705@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:40095 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757605Ab2B2D42 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 22:56:28 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 2ED2F24318
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:56:28 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 21FFD24314
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:56:28 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This series affects the way arguments are parsed in rbd_add().
It first encapsulates the code into its own helper function.
Then it uses a few simple tokenization functions instead of
sscanf() to parse the string provided, which makes it possible
to do a better job of error checking the input.  It makes use
of the ability to check for certain invariants at build time
rather than runtime.  And by reworking what information gets
passed around, eliminates the need to allocate a buffer to
hold the monitor addresses.

					-Alex
