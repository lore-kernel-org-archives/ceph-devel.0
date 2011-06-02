From: Sage Weil <sage@newdream.net>
Subject: Re: ceph_tool_common_init failed
Date: Thu, 2 Jun 2011 09:39:17 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1106020936580.19146@cobra.newdream.net>
References: <BANLkTinhA3T3F3+ocVrr9vzckJoWZRtXZg@mail.gmail.com>
 <BANLkTimK72kHioovQ=9Jaz0neiBzq+5LNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58370 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752316Ab1FBQhg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Jun 2011 12:37:36 -0400
In-Reply-To: <BANLkTimK72kHioovQ=9Jaz0neiBzq+5LNQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: biyan chen <riby.chen@gmail.com>, ceph-devel@vger.kernel.org

On Thu, 2 Jun 2011, Gregory Farnum wrote:
> 2011/6/2 biyan chen <riby.chen@gmail.com>:
> > 2011-06-02 16:27:35.010776 7f3f53940720 unable to authenticate as client.admin
> 
> That's your problem. You don't have your keys set up properly to
> authenticate as the admin on those nodes. :)
> 
> I suspect permissions problems are the cause of your other issues with
> file writing as well. How did you set up this cluster? Try recreating
> your cluster by carefully following the instructions at
> http://ceph.newdream.net/wiki/Creating_a_new_file_system

First you should probably verify that there is a keyring file (usually 
/etc/ceph/keyring) that has a client.admin key in it (it's plaintext; cat 
it to see) and that it is readable.  It's written to /etc/ceph/keyring by 
mkcephfs by default but that may have been on a different node, or the 
permissions might be off.  If the file is in a different location, you can 
explicitly specify that on the command line with '-k path/to/keyring'.

sage
