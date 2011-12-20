From: Matt Weil <mweil@genome.wustl.edu>
Subject: how many MDS active daemons to run
Date: Tue, 20 Dec 2011 17:30:11 -0600
Message-ID: <4EF11A83.2030006@genome.wustl.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from gscsmtp.wustl.edu ([128.252.233.26]:43371 "HELO
	gscsmtp.wustl.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753303Ab1LTXaL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Dec 2011 18:30:11 -0500
Received: from dhcp-10-0-108-185.gsc.wustl.edu (dhcp-10-0-108-185.gsc.wustl.edu [10.0.108.185])
	by gscsmtp.wustl.edu (Postfix) with ESMTPSA id 0305A407E3
	for <ceph-devel@vger.kernel.org>; Tue, 20 Dec 2011 17:30:11 -0600 (CST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello all:

given six osd servers does it make any difference of each one also runs 
a mds or not?

How many mds's is to many.  How does this effect metadata performance.

Thanks

Matt
