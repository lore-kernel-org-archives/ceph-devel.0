From: Ajit K Jena <ajit@iitb.ac.in>
Subject: Very basic problems on my CEPH testbed
Date: Thu, 20 Jan 2011 23:52:01 +0530
Message-ID: <1295547721.3271.37.camel@indica.cc.iitb.ac.in>
Reply-To: ajit@iitb.ac.in
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.iitb.ac.in ([59.162.23.13]:54254 "HELO smtp1.iitb.ac.in"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751254Ab1ATSWz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 20 Jan 2011 13:22:55 -0500
Received: from [10.100.106.210] (indica.cc.iitb.ac.in [10.100.106.210])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-auth.iitb.ac.in (Postfix) with ESMTP id DB6781390D
	for <ceph-devel@vger.kernel.org>; Thu, 20 Jan 2011 23:52:01 +0530 (IST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Dear List members,

We have setup a CEPH testbed based on Fedora Core 14
machines with 4 GB memory on all. We are using CEPH
version 0.24 with the components as below:

        one mds and one cmon (physically on the same machine)
        two ods (ods1 and ods2)
        btrfs is used

The distributed volume is mounted on two client machines.
When we created small files (basically text files running
to hundreds of bytes) we have no issues. The files (both
the metadata and the contents) are consistently visible
on both the clients.

The moment we try to store files of sizes 1 megabyte and
beyond the clients start hanging. The only way out is
"HARD REBOOT".

I am very much aware that CEPH is not yet fit for live
deployment and is still undergoing rapid developments.
However, I wish to know if others have got results
better than this.

Regards.

--ajit


