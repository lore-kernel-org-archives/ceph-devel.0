From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: v0.56.2 released
Date: Thu, 31 Jan 2013 08:27:05 +0100
Message-ID: <510A1CC9.4030608@profihost.ag>
References: <alpine.DEB.2.00.1301301540030.6225@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:51851 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754637Ab3AaH1N (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Jan 2013 02:27:13 -0500
In-Reply-To: <alpine.DEB.2.00.1301301540030.6225@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hello,

is it correct that the actual upstream/bobtail branch does not match the
v0.56.2 tag? The upstream/bobtail branch has 6 more commits from 25.01.
and 28.01.

Greets,
Stefan

Am 31.01.2013 00:46, schrieb Sage Weil:
> The next bobtail point release is ready, and it's looking pretty good. 
> This is an important update for the 0.56.x backport series that fixes a 
> number of bugs and several performance issues. All v0.56.x users are 
> encouraged to upgrade. 
> 
> Notable changes since v0.56.1:
> 
>  * osd: snapshot trimming fixes
>  * osd: scrub snapshot metadata
>  * osd: fix osdmap trimming
>  * osd: misc peering fixes
>  * osd: stop heartbeating with peers if internal threads are stuck/hung
>  * osd: PG removal is friendlier to other workloads
>  * osd: fix recovery start delay (was causing very slow recovery)
>  * osd: fix scheduling of explicitly requested scrubs
>  * osd: fix scrub interval config options
>  * osd: improve recovery vs client io tuning
>  * osd: improve 'slow request' warning detail for better diagnosis
>  * osd: default CRUSH map now distributes across hosts, not OSDs
>  * osd: fix crash on 32-bit hosts triggered by librbd clients
>  * librbd: fix error handling when talking to older OSDs
>  * mon: fix a few rare crashes
>  * ceph command: ability to easily adjust CRUSH tunables
>  * radosgw: object copy does not copy source ACLs
>  * rados command: fix omap command usage
>  * sysvinit script: set ulimit -n properly on remote hosts
>  * msgr: fix narrow race with message queuing
>  * fixed compilation on some old distros (e.g., RHEL 5.x)
> 
> There are a small number of interface changes related to the default CRUSH 
> rule and scrub interval configuration options. Please see the full release 
> notes.
> 
> You can get v0.56.2 in the usual fashion:
> 
>  * Git at git://github.com/ceph/ceph.git
>  * Tarball at http://ceph.com/download/ceph-0.56.2.tar.gz
>  * For Debian/Ubuntu packages, see http://ceph.com/docs/master/install/debian
>  * For RPMs, see http://ceph.com/docs/master/install/rpm
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
