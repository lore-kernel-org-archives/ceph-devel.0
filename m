From: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Subject: Compile error in rgw/rgw_xml.h in 0.46
Date: Wed, 09 May 2012 15:46:13 +0200
Message-ID: <3675148.h66agqk253@pc10>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from unknownsite.de ([62.48.69.106]:33528 "EHLO hartes-hannover.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753115Ab2EINqS (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 9 May 2012 09:46:18 -0400
Received: from pc10.localnet (pc10.asys-h.de [193.98.1.90])
	by hartes-hannover.de (Postfix) with ESMTPSA id 6834F10C866
	for <ceph-devel@vger.kernel.org>; Wed,  9 May 2012 15:46:17 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Compiling Ceph 0.46 fails at rgw/rgw_dencoder.cc with the following errors:

In file included from rgw/rgw_dencoder.cc:7:
rgw/rgw_acl_s3.h:9:19: error: expat.h: No such file or directory
In file included from rgw/rgw_acl_s3.h:11,
                 from rgw/rgw_dencoder.cc:7:
rgw/rgw_xml.h:59: error: 'XML_Parser' does not name a type
make[3]: *** [ceph_dencoder-rgw_dencoder.o] Error 1
make[3]: Leaving directory `/root/ceph-0.46/src'
make[2]: *** [all-recursive] Error 1
make[2]: Leaving directory `/root/ceph-0.46/src'
make[1]: *** [all] Error 2
make[1]: Leaving directory `/root/ceph-0.46/src'
make: *** [all-recursive] Error 1

This is on CentOS 6.2.

I managed to get it to compile by installing expat-devel first. Maybe the 
configure script should check for the existence of the expat header files?

	Guido
