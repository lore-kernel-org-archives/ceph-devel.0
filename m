From: Sage Weil <sage@inktank.com>
Subject: Re: Client can't reboot when rbd volume is mounted.
Date: Sun, 10 Feb 2013 21:36:56 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1302102133260.5429@cobra.newdream.net>
References: <511880D8.1000306@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60878 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750880Ab3BKFg4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Feb 2013 00:36:56 -0500
In-Reply-To: <511880D8.1000306@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Roman Alekseev <rs.alekseev@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Mon, 11 Feb 2013, Roman Alekseev wrote:
> Hi,
> 
> When I try to reboot a client server  without unmounting of rbd volume
> manually
> its services stop working but server doesn't reboot completely and show the
> following logs in KVM console:
> 
> [235618.0202207] libceph: connect 192.168.0.19:6789 error -101

That is 

#define        ENETUNREACH     101     /* Network is unreachable */

Note that that (or any other) socket error is not necessarily fatal; the 
kernel client will retry and eventually connect to that or another OSD 
to complete the IO.  Are you observing that the RBD image hangs or 
something?

You can peek at in-flight IO (and other state) with

 cat /sys/kernel/debug/ceph/*/osdc

unmount/unmap should not be necessarily in any case unless there is a bug.  
We backported a bunch of stuff to 3.6.6, so 3.6.10 ought to be okay.  You 
might try a newer 3.6.x kernel too; I forget if there was a second batch 
of fixes..

sage
