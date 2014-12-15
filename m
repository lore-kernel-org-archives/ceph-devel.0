From: "Atchley, Scott" <atchleyes@ornl.gov>
Subject: Accessing file layout information
Date: Mon, 15 Dec 2014 18:54:27 +0000
Message-ID: <A22702E7-D4A3-43D0-AB43-ADF64A2AADDA@ornl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mta01.ornl.gov ([128.219.177.14]:8387 "EHLO mta01.ornl.gov"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750955AbaLOTEL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Dec 2014 14:04:11 -0500
Received: from EXCHOS32.ornl.gov (exchos32.ornl.gov [128.219.12.152])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by emgwy2.ornl.gov (Postfix) with ESMTPS id 85B49E0306
	for <ceph-devel@vger.kernel.org>; Mon, 15 Dec 2014 13:54:29 -0500 (EST)
Content-Language: en-US
Content-ID: <F5CE94F5A1057A46B29116B04A753FED@ornl.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel Development <ceph-devel@vger.kernel.org>

Hi all,

For a given file in cephfs, I would like to determine:

1) the number of PGs
2) the PG IDs
3) the offsets handles by each PG
4) the stripe unit (i.e. bytes per block of data)

preferably using a C API.

I found the getfattr command line tool which provides (1) and (4).

It appears that cephfs command line tool provides some of the info, but the manpage is not clear as to what is provided by show_layout versus show_location. Does show_layout provide (1) and (4)? Does show_location include (2) and (3)?

I found a Java CephFileExtent() that provides (1) and a list of OSDs for the stripe unit that contains the provided file extent.

On the architecture page (http://ceph.com/docs/next/architecture/) under DATA STRIPING, does cephfs client use the same set of PGs used for Object Set 1 for Object Set 2 or does it use a different PGs?

Scott


=======================================
Scott Atchley
HPC Systems Engineer
Oak Ridge Leadership Computing Facility
atchleyes@ornl.gov

