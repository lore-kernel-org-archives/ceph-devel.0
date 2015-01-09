From: Sage Weil <sweil@redhat.com>
Subject: /usr/bin/cephfs tool
Date: Fri, 9 Jan 2015 07:20:46 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1501090719200.10528@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53281 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751414AbbAIPUt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 9 Jan 2015 10:20:49 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t09FKmxK003190
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Fri, 9 Jan 2015 10:20:49 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: gfarnum@redhat.com
Cc: ceph-devel@vger.kernel.org

Should we drop this entirely in hammer?  If I remember correctly all of 
the layout stuff is fully supported using virtual xattrs and standard 
tools.  The only thing left is the tool that shows you how file blocks map 
to objects map to OSDs (or something like that), which I've never used and 
have never seen anyone use...

sage
