From: Sage Weil <sage@newdream.net>
Subject: gcov/lcov
Date: Mon, 31 Jan 2011 21:21:14 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1101312121050.8040@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51254 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828Ab1BAFUc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Feb 2011 00:20:32 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: tv@newdream.net
Cc: ceph-devel@vger.kernel.org

We should set up gcov/lcov as part of the testing infrastructure so we can 
track what code paths are tested:

        http://ltp.sourceforge.net/coverage/lcov.php

sage



