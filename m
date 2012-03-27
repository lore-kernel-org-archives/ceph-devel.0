From: Wido den Hollander <wido@widodh.nl>
Subject: Unmount btrfs when stopping OSD's
Date: Tue, 27 Mar 2012 16:20:45 +0200
Message-ID: <4F71CCBD.4070501@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:49910 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977Ab2C0OUr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Mar 2012 10:20:47 -0400
Received: from [IPv6:2a00:f10:113:1:16da:e9ff:fe71:cc37] (unknown [IPv6:2a00:f10:113:1:16da:e9ff:fe71:cc37])
	by smtp02.mail.pcextreme.nl (Postfix) with ESMTPSA id 8A48D40060
	for <ceph-devel@vger.kernel.org>; Tue, 27 Mar 2012 16:20:45 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

It's something I noticed some time ago, but never really paid attention to.

When we start an OSD we automatically mount the btrfs filesystem if 
"btrfs devs" is set, but we do not unmount when we stop the OSD.

I see the init script is prepared for this:

dobtrfsumount=0
..
     --btrfsumount)
	    dobtrfsumount=1
..
if [ $dobtrfsumount -eq 1 ] && [ -n "$btrfs_devs" ]; then

Why would this be set to 0 by default? Any reason?

I like my daemons/init scripts to clean up their 'mess' when they stop.

I'd vote for setting this to 1 by default.

Wido
