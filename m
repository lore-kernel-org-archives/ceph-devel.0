From: Greg Farnum <gregory.farnum@dreamhost.com>
Subject: Re: osd shutdown notification
Date: Mon, 26 Mar 2012 12:45:14 -0700
Message-ID: <C788F32E4D0A4AD490FED360DCB75D11@dreamhost.com>
References: <Pine.LNX.4.64.1203261228050.19530@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:42815 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754914Ab2CZTpR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Mar 2012 15:45:17 -0400
Received: by obbeh20 with SMTP id eh20so5524850obb.19
        for <ceph-devel@vger.kernel.org>; Mon, 26 Mar 2012 12:45:16 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1203261228050.19530@cobra.newdream.net>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On Monday, March 26, 2012 at 12:36 PM, Sage Weil wrote:
> Currently when you shutdown/kill a ceph-osd it is no different from it 
> crashing: you have to wait N seconds for its peers to conclude the process 
> is down before the OSD is deemed 'failed' and the osd map is updated.
> 
> This would be pretty easy to improve on:
> 
> - on a clean shutdown (e.g., due to SIGTERM), we could execv a call to 
> the ceph tool to tell the monitors the osd stopped (maybe with a 
> 'reason' and nice log message).
> 
> - on an unclean shutdown (e.g., failed assert, segfault) we can
> do the same, with an appropriate message in the system log
> 
> Basically it means that is ceph-osd crashes or shuts down then it 
> will normally get instantly marked down without waiting for the normal osd 
> timeout to expire.
> 
> execv() is kind of ugly, but seems safer in the failure cases, where you 
> can't trust the existing MonClient to be operational. 
> 
> Alternatively, some external wrapper could watch for the process to 
> terminate and notify the cluster, but this would be a bit more difficult 
> to implement, because that notification needs to uniquely identify the 
> process instance (e.g., via the cluster addr), and we'd need some way for 
> it to wait for the osd to join and then extract that id, etc.
> 
> Thoughts?
execve to an external binary seems like the wrong tool for this job. On clean shutdown the OSD can send off a notification itself; somehow handling failures seems like a job for the monitoring service, not Ceph itself.
Doing it this way would also complicate cephx key management, since you either need an extra "osd-notifier" key added to each OSD node, or to give each OSD key modification privileges on the monitor.


