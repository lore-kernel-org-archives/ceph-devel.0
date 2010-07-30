From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: writes-starving-reads problem
Date: Fri, 30 Jul 2010 10:14:52 -0700
Message-ID: <AANLkTik==iekRavs8iJzAHPpxX=qrfqkS_GtAp8gp_iV@mail.gmail.com>
References: <AANLkTimDmPzWMBHKmgkRoE5LHqWL3-6_=R+PxZokqxVN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:32901 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752240Ab0G3ROx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Jul 2010 13:14:53 -0400
Received: by wwj40 with SMTP id 40so1739044wwj.1
        for <ceph-devel@vger.kernel.org>; Fri, 30 Jul 2010 10:14:52 -0700 (PDT)
In-Reply-To: <AANLkTimDmPzWMBHKmgkRoE5LHqWL3-6_=R+PxZokqxVN@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry C Chang <henry_c_chang@tcloudcomputing.com>
Cc: ceph-devel@vger.kernel.org

On Fri, Jul 30, 2010 at 2:40 AM, Henry C Chang
<henry_c_chang@tcloudcomputing.com> wrote:
> Hi,
>
> I ran into "writes-starving-reads" problem on a machine with 48G RAM.
>
> I have two processes running concurrently:
> Process 1 copies an 8 GB file from local disk to CEPH.
> Process 2 copies an 8 GB file from CEPH to local disk.
>
> Process 1 finished quickly since the data were cached in memory first.
> Process 2 was blocked until all the cached data have been written to OSD.
> (Maybe not all the cached data, but I waited for a long time.)
>
> I don't have this problem on a machine with 8G RAM.
>
> Has anyone experienced this before or any idea why?
>
> Thanks,
> Henry
We haven't heard of anything like this ourselves, although locally
we're not using such beefy machines yet.
Can you give us more information on your cluster configuration and how
the problem presented itself? Did the processes have progress bars and
you watched the ceph->local have no progress until the local->ceph
completed, or did the ceph->local copy just take much longer?
-Greg
