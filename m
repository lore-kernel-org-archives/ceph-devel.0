From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: libkeyutils is now required
Date: Tue, 29 Mar 2011 13:36:33 -0700
Message-ID: <20110329203633.GA25743@dreamer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:37775 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459Ab1C2Ugg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Mar 2011 16:36:36 -0400
Received: from dreamer (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 438ED2C173
	for <ceph-devel@vger.kernel.org>; Tue, 29 Mar 2011 13:36:36 -0700 (PDT)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello. I recently pushed commit bee85518 to master; it makes Ceph use
the Linux kernel key retention service[1], instead of passing crypto
secrets in mount options.

However, to be able to use this API, I needed to add a dependency:
libkeyutils. On Debian-based systems, run:

   sudo apt-get install libkeyutils-dev

./configure will complain if this library is not found.

Debian Build-Dependencies have been updated.


[1]: http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=Documentation/keys.txt;h=6523a9e6f293675a104ce77d78a896d0e9d190e5;hb=HEAD

-- 
:(){ :|:&};:
