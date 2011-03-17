From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: vstart -d -n not working in 0.25.1
Date: Thu, 17 Mar 2011 16:57:00 -0700
Message-ID: <4EB6395D-5648-4C65-93F6-CA0A1E3F3774@cs.ucsc.edu>
References: <24DF3893-B686-4B01-AA71-BB249BBF5625@cs.ucsc.edu> <20110317235456.GA23005@dreamer>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:46743 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755967Ab1CQX5M convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Mar 2011 19:57:12 -0400
In-Reply-To: <20110317235456.GA23005@dreamer>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

Ahh,

I was just poking around in vstart. Looks like the IP is determined by `hostname --ip-address`, which for some reason my machine is returning IPv6. Solution is ./vstart --localhost which then selects the IP to be 127.0.0.1. Not sure why my machine was returning:

nwatkins@kyoto:~$ hostname --ip-address
::1 127.0.1.1 128.114.52.36

Thanks for the help!

-n

On Mar 17, 2011, at 4:54 PM, Tommi Virtanen wrote:

> On Thu, Mar 17, 2011 at 04:01:13PM -0700, Noah Watkins wrote:
>> I am having difficulties getting the standalone "test setup" working
>> with 0.25.1, which was working with 0.24. Here is the following
>> output from "./vstart -d -n".
>> 
>> The logs don't seem to have anything interesting, and no cmon,cmds,
>> or cosd is running after this startup script runs.
> ...
>> ./monmaptool --create --clobber --add a ::1 127.0.1.1 128.114.52.36:6789 --add b ::1 127.0.1.1 128.114.52.36:6790 --add c ::1 127.0.1.1 128.114.52.36:6791 --print /tmp/ceph_monmap.13428
> 
> vstart.sh can't handle hosts with IPv6 right now -- in fact, it can't
> even handle some IPv4 configurations of /etc/resolv.conf. A simple
> test is to run: hostname --ip-address
> 
> If it outputs more than one IP address, vstart.sh won't work for you
> right now. On this Ubuntu 10.04 box, I get "::1 127.0.1.1 10.0.1.102".
> My /etc/hosts is
> 
> 10.0.1.102	dreamer	# Added by NetworkManager
> 127.0.0.1	localhost.localdomain	localhost
> ::1	dreamer	localhost6.localdomain6	localhost6
> 127.0.1.1	dreamer
> 
> # The following lines are desirable for IPv6 capable hosts
> ::1     localhost ip6-localhost ip6-loopback
> fe00::0 ip6-localnet
> ff00::0 ip6-mcastprefix
> ff02::1 ip6-allnodes
> ff02::2 ip6-allrouters
> ff02::3 ip6-allhosts
> 
> I don't have a good solution right now.
> 
> I'd file a ticket, but the tracker is down currently :(
> 
> -- 
> :(){ :|:&};:

