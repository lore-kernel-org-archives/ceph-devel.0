From: Sage Weil <sage@inktank.com>
Subject: Re: master branch issue in ceph.git
Date: Thu, 17 Jan 2013 21:30:36 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301172129210.14337@cobra.newdream.net>
References: <FA14C3D4-D9E7-4F74-A39A-C05B68F9294D@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41180 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750880Ab3ARFah (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Jan 2013 00:30:37 -0500
In-Reply-To: <FA14C3D4-D9E7-4F74-A39A-C05B68F9294D@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Zafman <david.zafman@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, 17 Jan 2013, David Zafman wrote:
> 
> The latest code is hanging trying to start teuthology.  I used teuthology-nuke to clear old state and reboot the machines.  I was using my branch rebased to latest master and when that started failing I switched to the default config.  It still keeps hanging here:
> 
> INFO:teuthology.task.ceph:Waiting until ceph is healthy...
> 
> $ ceph -s
>    health HEALTH_WARN 5 pgs degraded; 108 pgs stuck unclean
>    monmap e1: 3 mons at {0=10.214.131.23:6789/0,1=10.214.131.21:6789/0,2=10.214.131.20:6789/0}, election epoch 6, quorum 0,1,2 0,1,2
>    osdmap e7: 9 osds: 9 up, 9 in
>     pgmap v25: 108 pgs: 103 active+remapped, 5 active+degraded; 0 bytes data, 798 GB used, 3050 GB / 4055 GB avail
>    mdsmap e2: 0/0/0 up

git pull the latest teuthology.git master.  By default the crush map 
separates replicas across hosts now, and teuthology needed to be updated 
to do it by osd instead.

Sorry!

sage
