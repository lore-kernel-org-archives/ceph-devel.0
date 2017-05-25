From: Sage Weil <sage@newdream.net>
Subject: Re: Why not to change primary read to random read in any
 replication
Date: Thu, 25 May 2017 14:46:56 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1705251443480.3646@piezo.novalocal>
References: <CAN=xyVV+9aWt=g4SS3MMbPQU4RHTDUfBMTetez5-3DLq7e-c2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40154 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966585AbdEYOrA (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 25 May 2017 10:47:00 -0400
In-Reply-To: <CAN=xyVV+9aWt=g4SS3MMbPQU4RHTDUfBMTetez5-3DLq7e-c2g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: qi Shi <m13913886148@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Thu, 25 May 2017, qi Shi wrote:
> When the ceph client reads a very hot little file (less than 4M). The
> application scenario is live video. A single disk may have a
> bottleneck. The ceph client only reads the primary pg of osd. But this
> is the implementation of the serial. My suggestion is to change the
> primary read to random read three replication, or change to read 3
> replications at the same time, so to improve the reading efficiency.

In the general case, reading from the primary is the best policy because 
it localizes the caches (for example, for a given object A, it will only 
be cached in 1 place instead of 3, thereby allowing 3x as much data to be 
fit into cache).  The exception, of course, is very hot objects that 
saturate a single OSD's CPU or network (not disk--they're generally 
cached!), but these are rare.

There is code in librados that allows a client to send a (read) request to 
a random replica, but the client has to know when to do that.  More 
importantly, there is not test coverage for it, so we don't know if it is 
reliable/stable (particularly with recovery).  There were known bugs that 
Sam was looking at a year or so ago but I don't recall if he thought he 
fixed them (I think no).  But either way, it's not tested, so should not 
be considered reliable.

sage

