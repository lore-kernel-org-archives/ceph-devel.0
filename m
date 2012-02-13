From: Sage Weil <sage@newdream.net>
Subject: Re: OSD id in configuration file
Date: Mon, 13 Feb 2012 09:07:16 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1202130905260.13736@cobra.newdream.net>
References: <8512670932FB654F81AF0FEF1BE6D49DE23C32@WHQBEMAIL1.whq.wistron>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36647 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752876Ab2BMRHR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Feb 2012 12:07:17 -0500
In-Reply-To: <8512670932FB654F81AF0FEF1BE6D49DE23C32@WHQBEMAIL1.whq.wistron>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Eric_YH_Chen@wistron.com
Cc: ceph-devel@vger.kernel.org

On Mon, 13 Feb 2012, Eric_YH_Chen@wistron.com wrote:
> Hi, all:
> 
> For the scalability consideration, we would like to name the first
> harddisk as "00101" on first server.
> 
> And named the first harddisk as "00201" on second server. The ceph.conf
> seems like this:
> 
> [osd]
> osd data = /srv/osd.$id
> osd journal = /srv/osd.$id.journal
> osd journal size = 1000
> 
> [osd.00101]

The leading 0's are meaningless (or at worst, misleading) here.  ceph-osd 
identifiers are integers.

> host = server-001
> btrfs dev= /dev/sda
> 
> [osd.00102]
> host = server-001
> btrfs dev= /dev/sdb
> 
> [osd.00103]
> host = server-001
> btrfs dev= /dev/sdc
> 
> [osd.00201]
> host = server-002
> btrfs dev= /dev/sda
> 
> [osd.00202]
> host = server-002
> btrfs dev= /dev/sdb
> 
> [osd.00203]
> host = server-002
> btrfs dev= /dev/sdc
> 
> [osd.00301]
> host = server-003
> btrfs dev= /dev/sda
> 
> [osd.00302]
> host = server-003
> btrfs dev= /dev/sdb
> 
> [osd.00303]
> host = server-003
> btrfs dev= /dev/sdc
> 
> But we are worried about if it is an acceptable configuration for ceph.
> 
> As I see, the maximum osd is 304 now, although there are only 9 osds in
> the cluster. 
> Will this configuration influence about the performance? 
> And what if we add osd.00204 in the future?

They are stored as an array currently, so if the max is 304 using anything 
below that is better, not worse.  ~300 is a small number, so this isn't 
really problematic.  Just don't label an OSD osd.200302 or you'll be 
unhappy.

sage

