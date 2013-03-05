From: Xing Lin <xinglin@cs.utah.edu>
Subject: Re: When ceph synchronizes journal to disk?
Date: Mon, 04 Mar 2013 21:08:43 -0700
Message-ID: <51356FCB.3020308@cs.utah.edu>
References: <513343D8.8050402@cs.utah.edu> <alpine.DEB.2.00.1303040831470.12663@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from rio.cs.utah.edu ([155.98.64.241]:48283 "EHLO
	mail-svr1.cs.utah.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932462Ab3CEEIr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Mar 2013 23:08:47 -0500
In-Reply-To: <alpine.DEB.2.00.1303040831470.12663@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

No, I am using xfs. The same thing happens even if I specified the 
journal mode explicitly as follows.

         filestore journal parallel = false
         filestore journal writeahead = true

Xing

On 03/04/2013 09:32 AM, Sage Weil wrote:
> Are you using btrfs?  In that case, the journaling is parallel to the fs
> workload because the btrfs snapshots provide us with a stable checkpoint
> we can replay from.  In contrast, for non-btrfs file systems we need to do
> writeahead journaling.

