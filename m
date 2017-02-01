From: Boris Yakovich <Boris.Yakovich@cewit.stonybrook.edu>
Subject: Complete failure
Date: Wed, 1 Feb 2017 11:55:42 -0500
Message-ID: <00714C12C9081745920784D8E0927CCF03B87890E130@E2K7CCR.cewit.stonybrook.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from edge2.cewit.stonybrook.edu ([130.245.190.107]:2268 "EHLO
        edge2.cewit.stonybrook.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753251AbdBAQ4L (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Feb 2017 11:56:11 -0500
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Guys,

I have a three node test environment I have been playing with. 
Each node has two hard drives one runs the OS, the second ceph data.
One node had a hard disk failure on the OS disk. I reinstalled the OS (Ubuntu 14),
And tried to add it back into the cluster. Now the entire cluster is failing.
I'm pretty new to this and completely lost how to get it back up.
Ceph -s just shows lines and lines of fault errors. It seems all the monitors are down. 

Please help.

Thanks,
boris

