From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Creating the filesystem and tweaking configurations
Date: Mon, 28 Mar 2011 13:46:56 -0700
Message-ID: <20110328204656.GB10768@dreamer>
References: <loom.20110328T213028-664@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:42945 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432Ab1C1Uq7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Mar 2011 16:46:59 -0400
Content-Disposition: inline
In-Reply-To: <loom.20110328T213028-664@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Steena Monteiro <steena.m@aggiemail.usu.edu>
Cc: ceph-devel@vger.kernel.org

On Mon, Mar 28, 2011 at 07:54:13PM +0000, Steena Monteiro wrote:
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

Just to eliminate possible causes, can you please list the kernel
version and the ceph version you are using?

Can you show us your config file, and any logs that were written?

> 2) I want to be able to tune Ceph's configuration 
> parameters (located in
> config.cc within the Ceph source) and see how each 
> configuration change impacts Ceph's performance.
> However, I am not certain how changes in the ceph source
> code will be reflected in the standalone-client in terms of 
> Ceph's performance.
> Is there a suggested way I could work to accomplish changing parameters in the
> source in order to have the file system impacted by these changes?

Anything you see in src/common/config.cc as OPTION(...) is editable
via the config file, you don't need to change the source.

If you change the config file (across all nodes), unmount the client,
restart the whole cluster (maybe even reboot for even more predictable
benchmark results), and then mount the client again, changes will have
very definitely been forced into effect; that should give you good,
benchmarkable, numbers.

-- 
:(){ :|:&};:
