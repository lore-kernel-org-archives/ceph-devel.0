From: Sage Weil <sage@newdream.net>
Subject: Re: Which function is mon ping osd?
Date: Sun, 21 May 2017 19:06:37 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1705211904530.3646@piezo.novalocal>
References: <CAN=xyVX9S2g6RW-PMjhR8Xhch2Kd8UofZRDwHV=yrEbt7EFyFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46242 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752119AbdEUTGk (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 21 May 2017 15:06:40 -0400
In-Reply-To: <CAN=xyVX9S2g6RW-PMjhR8Xhch2Kd8UofZRDwHV=yrEbt7EFyFA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: qi Shi <m13913886148@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Sun, 21 May 2017, qi Shi wrote:
> When i read the official documents,I found that mon would ping osds.
> 
> The following is a description of the official documentation:
> ---------------------------------------------------------------------------------------------------------------------
> 
> OSD Membership and Status: Ceph OSD Daemons join a cluster and report
> on their status. At the lowest level, the Ceph OSD Daemon status is up
> or down reflecting whether or not it is running and able to service
> Ceph Client requests. If a Ceph OSD Daemon is down and inthe Ceph
> Storage Cluster, this status may indicate the failure of the Ceph OSD
> Daemon. If a Ceph OSD Daemon is not running (e.g., it crashes), the
> Ceph OSD Daemon cannot notify the Ceph Monitor that it is down. The
> Ceph Monitor can ping a Ceph OSD Daemon periodically to ensure that it
> is running. However, Ceph also empowers Ceph OSD Daemons to determine

This isn't accurate.  The OSDs periodically send messages to the mon (pg 
stats pre-luminous, and a new MOSDBeacon in luminous).  If the mon doesn't 
see that message after a configurable period of time then it marks the OSD 
down.  See OSDMonitor::prepare_beacon() in master.

sage

> if a neighboring OSD is down, to update the cluster map and to report
> it to the Ceph monitor(s). This means that Ceph monitors can remain
> light weight processes. SeeMonitoring OSDs and Heartbeats for
> additional details.
> -----------------------------------------------------------------------------------------------------------------------
> 
> Who can tell me which file in the source code, and which function,
> which function to do mon ping osd?
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
