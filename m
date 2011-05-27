From: Sage Weil <sage@newdream.net>
Subject: Re: Config File Problem for new =?UTF-8?Q?clusters=3F?=
Date: Thu, 26 May 2011 22:11:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1105262155040.20085@cobra.newdream.net>
References: <ba77d656c1e15f1dc3190cfee883de01@pl1.haspere.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48640 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776Ab1E0FJe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 May 2011 01:09:34 -0400
In-Reply-To: <ba77d656c1e15f1dc3190cfee883de01@pl1.haspere.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dyweni - Ceph-Devel <YS3fpFE2ykfB@dyweni.com>
Cc: Ceph Devel <ceph-devel@vger.kernel.org>

On Thu, 26 May 2011, Dyweni - Ceph-Devel wrote:
> Hi,
> 
> For testing purposes, I tried to specify the default pg_size which will be
> used to create the default pg_pools (data, metadata, rbd).
> 
> By default, the pg_size is 2.  However, regardless of where I add 'osd pool
> default size' to the ceph.conf file (I've tried the [mon] and [osd] sections),
> the pg_size is always 2.
> 
> How does one define what the pg_size will be before calling '/usr/bin/mkcephfs
> -c /etc/ceph/ceph.conf -a --mkbtrfs'?

I pushed a fix to the master branch.  The initial pool sizes were 
hard-coded to 2.  You can adjust things after the cluster is up and 
running with

	ceph osd pool set data size 3
	ceph osd pool set metadata size 3
	ceph osd pool set rbd size 3

sage
