From: Sage Weil <sage@newdream.net>
Subject: wip-makefile
Date: Thu, 12 Jan 2012 09:27:07 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1201120922340.18796@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58098 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751860Ab2ALR1I (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Jan 2012 12:27:08 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id EE6F9BC87D
	for <ceph-devel@vger.kernel.org>; Thu, 12 Jan 2012 09:27:07 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id C8973BC87D
	for <ceph-devel@vger.kernel.org>; Thu, 12 Jan 2012 09:27:07 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Kacper (from gentoo) sent us some Makefile cleanups to do pthread 
detection properly.  Anybody with stronger autotool-fu wanna take a quick 
look before it hits master?

https://github.com/NewDreamNetwork/ceph/commits/wip-makefile

sage


