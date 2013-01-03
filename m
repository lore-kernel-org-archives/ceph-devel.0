From: "emyr.james" <emyr.james@sussex.ac.uk>
Subject: Looking to Use Ceph
Date: Thu, 03 Jan 2013 12:29:35 +0000
Message-ID: <50E579AF.10206@sussex.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from chip.uscs.susx.ac.uk ([139.184.14.86]:53303 "EHLO
	chip.uscs.susx.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753303Ab3ACM5D (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Jan 2013 07:57:03 -0500
Received: from pollux.phys.susx.ac.uk ([139.184.131.63]:53495)
	by chip.uscs.susx.ac.uk with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.76)
	(envelope-from <emyr.james@sussex.ac.uk>)
	id MG1UPC-000JZS-9W
	for ceph-devel@vger.kernel.org; Thu, 03 Jan 2013 12:29:36 +0000
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

I'm thinking of starting to use ceph initially for evaluation...seeing 
how it compares to our existing lustre file system.
One thing that I would like confirmation of is how ceph stores large 
files. If I store a large file in CephFS is it automatically split up 
into chunks with the various chunks stored and replicated automatically 
across the whole cluster, or does it store the whole file as one object 
on one individial OSD and then has individual replicants of the whole 
file on a small number of other OSD's ? What is the typical block size 
used if files are split up....can this be configured ?

Regards,

Emyr

