From: Sage Weil <sage@newdream.net>
Subject: Re: different osds
Date: Sun, 22 May 2011 16:29:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1105221615550.9483@cobra.newdream.net>
References: <4DD96922.2080409@ufm.su>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58622 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753853Ab1EVX2A (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 22 May 2011 19:28:00 -0400
In-Reply-To: <4DD96922.2080409@ufm.su>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: ceph-devel@vger.kernel.org

On Sun, 22 May 2011, Fyodor Ustinov wrote:
> Hi!
> 
> Let's say I have 6 osd. 5 of them are the same, 6 - has twice the amount of
> disk size.
> 
> Should I somehow specifically describe it in CRUSH mapor seph will understand
> without it?

Right, you just need to weight it 2x that of the other nodes, and it'll 
get twice the data (and IO traffic).  I just pushed a patch to master that 
will let you do it with something like

 ceph osd getcrushmap -o orig
 crushtool -i orig --reweight-item <name> <weight> -o new
 ceph osd setcrushmap -i new

I usually set the weights in terms of some real units, like TB, so that 
the map dumps make sense.  You probably want to 

 crushtool -d orig > orig.txt
 crushtool -d new > new.txt
 diff orig.txt new.txt

to verify all is well before reinserting the updated map into the cluster.

sage
