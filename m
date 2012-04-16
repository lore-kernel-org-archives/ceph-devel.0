From: Sage Weil <sage@newdream.net>
Subject: librados aio completion
Date: Sun, 15 Apr 2012 21:44:38 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1204152141160.14018@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34075 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734Ab2DPEol (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Apr 2012 00:44:41 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id BB5A9BCB0A
	for <ceph-devel@vger.kernel.org>; Sun, 15 Apr 2012 21:44:40 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 4D1B5BCB0A
	for <ceph-devel@vger.kernel.org>; Sun, 15 Apr 2012 21:44:40 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We just switched the completion callbacks so that they are called 
asynchronously from another thread.  This makes the locking less weird for 
certain callers and lets you call back into librados in your callback 
safely.

This breaks one of the functional tests, which sets a bool in the 
callback, does wait_for_complete() on the aio handle, and then asserts 
that the bool is set.  There's now a race between the caller's thread and 
the completion thread.

Do we just call this a broken test, or do we want some way of blocking on 
the aio handle until the completion has been called?

sage
