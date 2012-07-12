From: ramu <ramu.freesystems@gmail.com>
Subject: How to compile Java-Rados.
Date: Thu, 12 Jul 2012 09:22:46 +0000 (UTC)
Message-ID: <loom.20120712T111906-426@post.gmane.org>
References: <loom.20120712T065146-882@post.gmane.org> <CAPrxi59LMX7aPuG3FrzgAsWS++6kNdi_11DnZQwZifDStdmWYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:51465 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753544Ab2GLJXH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 12 Jul 2012 05:23:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1SpFby-0006fP-MN
	for ceph-devel@vger.kernel.org; Thu, 12 Jul 2012 11:23:03 +0200
Received: from 81-254-187-203.static.youbroadband.in ([81-254-187-203.static.youbroadband.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 12 Jul 2012 11:23:02 +0200
Received: from ramu.freesystems by 81-254-187-203.static.youbroadband.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 12 Jul 2012 11:23:02 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi Noah Watkins,

When I compiling Java-rados am getting following error,

compile-rados:
    [javac] Compiling 8 source files to /home/vu/java-rados/build/java
    [javac] /home/vu/java-rados/src/java/net/newdream/ce
ph/rados/RadosObject.java:60: cannot find symbol
    [javac] symbol  : method writeFull(java.lang.String,byte[],long,long)
    [javac] location: class net.newdream.ceph.rados.IOContext
    [javac]         ioctx.writeFull(key, buf, len, off);
    [javac]              ^
    [javac] 1 error









