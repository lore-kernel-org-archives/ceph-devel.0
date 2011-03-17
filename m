From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: vstart -d -n not working in 0.25.1
Date: Thu, 17 Mar 2011 16:54:56 -0700
Message-ID: <20110317235456.GA23005@dreamer>
References: <24DF3893-B686-4B01-AA71-BB249BBF5625@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:32866 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755723Ab1CQXzA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Mar 2011 19:55:00 -0400
Content-Disposition: inline
In-Reply-To: <24DF3893-B686-4B01-AA71-BB249BBF5625@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: ceph-devel@vger.kernel.org

On Thu, Mar 17, 2011 at 04:01:13PM -0700, Noah Watkins wrote:
> I am having difficulties getting the standalone "test setup" working
> with 0.25.1, which was working with 0.24. Here is the following
> output from "./vstart -d -n".
> 
> The logs don't seem to have anything interesting, and no cmon,cmds,
> or cosd is running after this startup script runs.
...
> ./monmaptool --create --clobber --add a ::1 127.0.1.1 128.114.52.36:6789 --add b ::1 127.0.1.1 128.114.52.36:6790 --add c ::1 127.0.1.1 128.114.52.36:6791 --print /tmp/ceph_monmap.13428

vstart.sh can't handle hosts with IPv6 right now -- in fact, it can't
even handle some IPv4 configurations of /etc/resolv.conf. A simple
test is to run: hostname --ip-address

If it outputs more than one IP address, vstart.sh won't work for you
right now. On this Ubuntu 10.04 box, I get "::1 127.0.1.1 10.0.1.102".
My /etc/hosts is

10.0.1.102	dreamer	# Added by NetworkManager
127.0.0.1	localhost.localdomain	localhost
::1	dreamer	localhost6.localdomain6	localhost6
127.0.1.1	dreamer

# The following lines are desirable for IPv6 capable hosts
::1     localhost ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
ff02::3 ip6-allhosts

I don't have a good solution right now.

I'd file a ticket, but the tracker is down currently :(

-- 
:(){ :|:&};:
