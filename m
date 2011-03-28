From: Sage Weil <sage@newdream.net>
Subject: Re: Creating the filesystem and tweaking configurations
Date: Mon, 28 Mar 2011 13:52:59 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1103281340050.20362@cobra.newdream.net>
References: <loom.20110328T213028-664@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35258 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754077Ab1C1UuE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Mar 2011 16:50:04 -0400
In-Reply-To: <loom.20110328T213028-664@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Steena Monteiro <steena.m@aggiemail.usu.edu>
Cc: ceph-devel@vger.kernel.org

On Mon, 28 Mar 2011, Steena Monteiro wrote:
> 1) I used apt-get to procure and install Ceph excluding the standalone 
> client on
> Lucid Lynx. I obtained built the  client using instructions 
> on the Ceph wiki and
> it worked fine after I reverted certain commits. However, mkcephfs (from: $
> /usr/sbin/mkcephfs -c /etc/ceph/ceph.conf --allhosts -v) has been breaking:
> 
> 2011-03-28 13:23:23.596948 b77b16d0 OSD::mkfs: 
> couldn't mount FileStore: error -95
> 2011-03-28 13:23:23.597008 b77b16d0  ** ERROR: 
> error creating empty object store
> in /data/osd0: error 95: Operation not supported
> failed: '/usr/bin/cosd -c /etc/ceph/ceph.conf --monmap
> /tmp/mkcephfs.DZdhzxPY5k/monmap.24380 -i 0 --mkfs --osd-data /data/osd0'
> 
> Additionally, I checked and /data/osd0 does exist...

That usually means that /data/osd0 is on ext3 and you didn't mount with 
user_xattr.  The osd log should have a detailed error.

> 2) I want to be able to tune Ceph's configuration 
> parameters (located in
> config.cc within the Ceph source) and see how each 
> configuration change impacts Ceph's performance.
> However, I am not certain how changes in the ceph source
> code will be reflected in the standalone-client in terms of 
> Ceph's performance.
> Is there a suggested way I could work to accomplish changing parameters in the
> source in order to have the file system impacted by these changes?

Everything in config.cc can be set via ceph.conf, so that should save you 
some compile time.

Which tunables affect what will depend pretty heavily on the workload 
you're testing.  The things I would look at first would probably be with 
the OSD thread counts,r kernel client readahead, or some of the cache 
tunables.  IIRC I sent an annotated list of the config options with 
comments on which would be good candidates for testing.  I suspect 
focusing on something specific (say, OSD) would help get the process 
sorted out without too many variables.

sage
