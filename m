From: Sage Weil <sweil@redhat.com>
Subject: signature check overhead
Date: Fri, 19 Dec 2014 08:15:12 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1412190748100.10128@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35456 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751218AbaLSQPR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 19 Dec 2014 11:15:17 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: andreas.bluemle@itxperts.de, ceph-devel@vger.kernel.org

Hi Andreas,

I took a look at the signature check code that your profiling identified.  
I made a small optimization and pushed it to wip-auth that may help.  

...and now I just noticed that nss_aes_operation is doing some really 
silly things, like copying the entire input buffer to avoid a const-cast 
(or iteration of the input bufferlist buffers).  I'll look at that next if 
someone doesn't have an interest and beat me to it!

sage

