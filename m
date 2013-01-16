From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: flashcache
Date: Wed, 16 Jan 2013 22:57:37 +0100
Message-ID: <CAJH6TXhfLpuaf31O-bjtHvmnFcy3YysrPVk-EkX1KmGd63egBg@mail.gmail.com>
References: <CAJH6TXiJjEq4C7k5p39Eo+pgwoq372r29RJriBee+irJPLvLpw@mail.gmail.com>
	<alpine.DEB.2.00.1301161325280.27925@cobra.newdream.net>
	<CAJH6TXhCFvA6UF7e+wYOJAxuHi5Q1ug=TQao24Uxd7_AV_ppkg@mail.gmail.com>
	<alpine.DEB.2.00.1301161342580.27925@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:46115 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757860Ab3APV5i (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Jan 2013 16:57:38 -0500
Received: by mail-wi0-f169.google.com with SMTP id hq12so4024347wib.4
        for <ceph-devel@vger.kernel.org>; Wed, 16 Jan 2013 13:57:37 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1301161342580.27925@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

2013/1/16 Sage Weil <sage@inktank.com>:
> You should not worry, except to the extent that 2 might fail
> simultaneously, and failures in general are not good things.

Are you talking about 2 OSDs failure (with the same replicated data)?
Ok, but it's very very hard.

> You could use the first (single) disk for os and logs.  You might not even
> bother with raid1, since you will presumably be replicating across hosts.
> When the OSD disk dies, you can re-run your chef/juju/puppet rule or
> whatever provisioning tool is at work to reinstall/configure the OS disk.
> The data on the SSDs and data disks will all be intact.

OS failure will result in the whole node down. This will cause a
rebalance of many TB of data that I prefer to avoid, if possible.
I also prefer to avoid a dedicated disks for the OS. I'll loose to much space.
With OS in a RAID-1 partition of the first and second spinning disks
(the same disks will also act as OSD with another, bigger, partition),
OS failure will not bring down anything and I can hot-replace the
failed disk.

RAID1 will handle OS reconstruction, ceph will handle the cluster rebalance
