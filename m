From: Jimmy Tang <jtang@tchpc.tcd.ie>
Subject: Re: v0.52 released
Date: Fri, 28 Sep 2012 21:00:56 +0100
Message-ID: <B6D240B4-51FD-4F37-B6CE-5ECE36C58EF9@tchpc.tcd.ie>
References: <alpine.DEB.2.00.1209271306120.13352@cobra.newdream.net> <225281A5-AFB6-4A4F-9AA5-F73ACA236298@tchpc.tcd.ie>  <sfid-H20120928-161608-+068.25-1@marduk.tchpc.tcd.ie> <alpine.DEB.2.00.1209280813401.10331@cobra.newdream.net>  (sfid-H20120928-161608-+068.25-1@marduk.tchpc.tcd.ie)
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tabaet.tchpc.tcd.ie ([134.226.112.12]:39553 "EHLO
	tabaet.tchpc.tcd.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031108Ab2I1UA7 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Sep 2012 16:00:59 -0400
In-Reply-To: <alpine.DEB.2.00.1209280813401.10331@cobra.newdream.net>  (sfid-H20120928-161608-+068.25-1@marduk.tchpc.tcd.ie)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi Sage,

On 28 Sep 2012, at 16:16, Sage Weil wrote:

> 
> Ah, good point.  You can do that today with the debian repos, but we 
> lumped all the rpms into ceph.com/rpms.  Currently
> 
> debian			symlink to debian-argonaut (latest stable)
> debian-argonaut		stable argonaut releases
> debian-testing		dev releases
> 
> We can do the same with the rpms...
> 
> rpm
> rpm-argonaut
> rpm-testing
> 
> ?

That sounds reasonable to do ;) +1 for something similar to what you are proposing.

Jimmy.

