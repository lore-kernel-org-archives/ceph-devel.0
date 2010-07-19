From: Sage Weil <sage@newdream.net>
Subject: Re: kclient IPv4 vs IPv6 problem
Date: Mon, 19 Jul 2010 09:56:10 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1007190951110.996@cobra.newdream.net>
References: <i21mdf$fma$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36275 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751760Ab0GSQyB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Jul 2010 12:54:01 -0400
In-Reply-To: <i21mdf$fma$1@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: ceph-devel@vger.kernel.org

Hi Thomas,

On Mon, 19 Jul 2010, Thomas Mueller wrote:
> hi
> 
> if I mount ceph with localhost, 
> 
> > mount -t ceph localhost:/ /mnt
> 
> it fails with:
> 
> mount error 22 = Invalid argument
> 
> 
> dmesg shows:
> [  813.704419] ceph: parse_ips bad ip '[::1],[127.0.0.1]:/'

This is fixed in the 'master' branch (i.e. queued for 2.6.35).  You should 
be able to 'git merge origin/master' to get the fix.

> on my machine ipv6 and ipv4 are enabled (standard debian installation). 
> Seems like "localhost" resolves to ipv4 and ipv6 what confuses ceph 
> kclient.
> 
> As I only have ipv6 on the machine I can't test it in a real network. But 
> maybe this also applies to DNS hostnames with both A and AAAA entries.

There may still be a problem with using 'localhost' in this case because 
the monitor binds to a specific address in a specific address family.. 
whatever you specify for 'mon addr' in ceph.conf during mkcephfs.  If 
that's the IPv4 address, and localhost resolves to both v4 and v6 
addresses, then randomly half the time it will (I assume) fail to connect.

You can either specify the ip explicitly, or use a hostname that resolves 
to only that ip.

We could make the monitor bind to multiple addresses as well, but that 
requires extending the protocol.

sage
