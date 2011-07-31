From: Sage Weil <sage@newdream.net>
Subject: Re: Kernel 3.0.0 + ext4 + ceph == ...
Date: Sun, 31 Jul 2011 13:42:55 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1107311339530.23447@cobra.newdream.net>
References: <4E33D101.1050504@ufm.su> <9BF9E529-C532-4A94-8362-93C2D1B778DB@mit.edu>
 <4E3432FC.9030204@ufm.su> <20110730165001.GI7361@thunk.org>
 <Pine.LNX.4.64.1107301016120.23447@cobra.newdream.net> <20110730221900.GK7361@thunk.org>
 <Pine.LNX.4.64.1107302149430.23447@cobra.newdream.net> <4E353D9E.5080802@ufm.su>
 <Pine.LNX.4.64.1107310951550.2348@cobra.newdream.net> <4E35B833.6070304@ufm.su>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46025 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940Ab1GaUiv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 31 Jul 2011 16:38:51 -0400
In-Reply-To: <4E35B833.6070304@ufm.su>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: Ted Ts'o <tytso@mit.edu>, ceph-devel@vger.kernel.org

On Sun, 31 Jul 2011, Fyodor Ustinov wrote:
> On 07/31/2011 08:04 PM, Sage Weil wrote:
> > dout(10)<<  "setattrs "<<  cid<<  "/"<<  oid<<  " '"<<  p->first<<  "' len
> > "<<  p->second.length()<<  " = "<<  r<<  dendl;
> Well.

Thanks!  Just to clarify a few things:
 
> root@osd0:~# grep "10000000483\.000005d6" /var/log/ceph/osd.0.log
> 2011-07-31 23:06:49.172838 7f23c048c700 filestore(/osd.0) remove
> temp/10000000483.000005d6/head = -1
       ^ The actual filename is a 10000000483.000005d6_head, ignore that 
last /.

> 2011-07-31 23:06:49.173941 7f23c048c700 filestore(/osd.0) write
> temp/10000000483.000005d6/head 0~1048576 = 1048576
> 2011-07-31 23:06:49.900837 7f23c048c700 filestore(/osd.0) write
> temp/10000000483.000005d6/head 1048576~1048576 = 1048576
> 2011-07-31 23:06:49.985600 7f23c048c700 filestore(/osd.0) write
> temp/10000000483.000005d6/head 2097152~1048576 = 1048576
> 2011-07-31 23:06:50.114185 7f23c048c700 filestore(/osd.0) write
> temp/10000000483.000005d6/head 3145728~1048576 = 1048576
> 2011-07-31 23:06:50.114239 7f23c048c700 filestore(/osd.0) remove
> 0.69_head/10000000483.000005d6/head = -1
> 2011-07-31 23:06:50.114287 7f23c048c700 filestore(/osd.0) collection_add
> 0.69_head/10000000483.000005d6/head temp/10000000483.000005d6/head = 0

This is link(2)

> 2011-07-31 23:06:50.114316 7f23c048c700 filestore(/osd.0) collection_remove
> temp/10000000483.000005d6/head = 0

This is unlink(2)

> 2011-07-31 23:06:50.114384 7f23c048c700 filestore(/osd.0) setattrs
> 0.69_head/10000000483.000005d6/head '_' len 161 = 161

The xattr names are prefixed with 'user.ceph.'

> 2011-07-31 23:06:50.114406 7f23c048c700 filestore(/osd.0) setattrs
> 0.69_head/10000000483.000005d6/head 'snapset' len 26 = 26
> 2011-07-31 23:06:50.114413 7f23c048c700 filestore(/osd.0) setattrs
> 0.69_head/10000000483.000005d6/head = 26

Does that tell you what to need, Ted?

Thanks!
sage
