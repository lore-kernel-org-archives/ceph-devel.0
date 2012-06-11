From: Sage Weil <sage@inktank.com>
Subject: class exec test
Date: Sun, 10 Jun 2012 22:03:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206102200490.3347@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33988 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752116Ab2FKFDu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Jun 2012 01:03:50 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: josh.durgin@inktank.com
Cc: ceph-devel@vger.kernel.org

Hey-

The librados api tests were calling a dummy "test_exec" method in cls_rbd 
that apparently got removed.  We probably want to replace the test with 
*something*, though...  maybe a "version" or similar command that just 
returns the version of the class?  Or an OSD built-in dummy class with 
no-op methods?

sage
