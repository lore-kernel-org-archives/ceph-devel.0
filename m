From: Dieter Kasper <d.kasper@kabelmail.de>
Subject: send/receive feature to determine the difference between snapshots
Date: Mon, 6 Aug 2012 09:24:10 +0200
Message-ID: <20120806072410.GA27179@oder.kd-bie.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtpa1.mediabeam.com ([194.25.41.13]:55575 "EHLO
	smtpa2.mediabeam.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752714Ab2HFHY5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Aug 2012 03:24:57 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: "Dieter Kasper (KD)" <d.kasper@kabelmail.de>

@All,

I just read about a 
  "send/receive feature in Kernel-3.6 for btrfs which can be used by backup solutions to determine the difference between snapshots"

http://www.h-online.com/open/news/item/First-release-candidate-of-Linux-kernel-version-3-6-1659576.html
http://lwn.net/Articles/506244/

This is a very efficient interface for backup tools, especially for large Cluster File Systems!
Can we put it on the feature list for Ceph-FS ?


Best Regards,
-Dieter

