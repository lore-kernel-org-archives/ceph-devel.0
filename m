From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: libs3 build errors
Date: Fri, 11 May 2012 16:24:40 -0700
Message-ID: <32649264-9077-48F0-AF8B-B59EACDBD6B1@cs.ucsc.edu>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:53181 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754567Ab2EKXYl convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 May 2012 19:24:41 -0400
Received: from [192.168.50.124] (soenat3.cse.ucsc.edu [128.114.60.41])
	by mail-01.cse.ucsc.edu (Postfix) with ESMTPSA id 99E1A1009C35
	for <ceph-devel@vger.kernel.org>; Fri, 11 May 2012 16:24:40 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The latest master branch passes ./configure and dpkg-checkbuilddeps tests, but the the build fails:

Making all in libs3
make[3]: Entering directory `/home/nwatkins/projects/ceph/ceph/src/libs3'
make[3]: *** No rule to make target `libxml/parser.h', needed by `build/obj/simplexml.do'.  Stop.
make[3]: Leaving directory `/home/nwatkins/projects/ceph/ceph/src/libs3'
make[2]: *** [all-recursive] Error 1
make[2]: Leaving directory `/home/nwatkins/projects/ceph/ceph/src'
make[1]: *** [all] Error 2
make[1]: Leaving directory `/home/nwatkins/projects/ceph/ceph/src'
make: *** [all-recursive] Error 1

Any work around? I'm on Ubuntu 11.04.. the only thing I see in the repositories is a libxml2-dev, but includes <libxml2/parser.h>.

Thanks,
- Noah