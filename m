From: Sage Weil <sage@inktank.com>
Subject: a few more mon patches...
Date: Mon, 8 Jul 2013 22:24:59 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1307082218460.22858@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39636 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751500Ab3GIFZA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Jul 2013 01:25:00 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: joao.luis@inktank.com
Cc: ceph-devel@vger.kernel.org

Two more series:

- simplify trimming code:
	https://github.com/ceph/ceph/pull/412
- make 'osd crush rm ...' (more) idempotent:
	https://github.com/ceph/ceph/pull/413

I'm going to run some final tests on newsync and wait for Greg's feedback 
before merging that one.

Thanks!
sage

