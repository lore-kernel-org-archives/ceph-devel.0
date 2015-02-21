From: Sage Weil <sweil@redhat.com>
Subject: -fno-omit-frame-pointer
Date: Sat, 21 Feb 2015 13:43:56 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1502211252520.27009@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42196 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751725AbbBUVn6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 21 Feb 2015 16:43:58 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t1LLhveJ016313
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Sat, 21 Feb 2015 16:43:57 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: mnelson@redhat.com
Cc: ceph-devel@vger.kernel.org

Hey Mark,

I just watched Brendan Gregg's talk at SCALE (which was extremely good) 
and one of the things he mentioned is the importance of 
-fno-omit-frame-pointer.  I notice we are setting it via do_autogen.sh 
(i.e., for developers) but not in the production builds.  Should we be?  
I think it's important to be able to get meaningful callgraph output from 
production deployments and I suspect there is minimal performance impact.

http://www.slideshare.net/brendangregg/scale2015-linux-perfprofiling

sage
