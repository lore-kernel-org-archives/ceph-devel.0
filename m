From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: OSD auto weights
Date: Sat, 03 Dec 2011 10:40:40 -0800
Message-ID: <4EDA6D28.9060005@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:60898 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754607Ab1LCSkn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 3 Dec 2011 13:40:43 -0500
Received: from [128.114.52.36] (kyoto.soe.ucsc.edu [128.114.52.36])
	by mail-01.cse.ucsc.edu (Postfix) with ESMTPSA id 4F77F775C007
	for <ceph-devel@vger.kernel.org>; Sat,  3 Dec 2011 10:40:43 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We have a cluster with disks that have large differences in performance. 
I noticed that wiki page on OSD auto weights 
(http://ceph.newdream.net/wiki/Osd_auto_weight), but it seems to have 
been last updated in 2008. Are there any developments in this area or 
recommended techniques for setting up weights?

Thanks,
Noah
