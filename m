From: Sage Weil <sage@newdream.net>
Subject: Re: Kernel 3.0.0 + ext4 + ceph == ...
Date: Mon, 1 Aug 2011 09:20:39 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1108010918580.6290@cobra.newdream.net>
References: <4E33D101.1050504@ufm.su> <9BF9E529-C532-4A94-8362-93C2D1B778DB@mit.edu>
 <4E3432FC.9030204@ufm.su> <20110730165001.GI7361@thunk.org>
 <Pine.LNX.4.64.1107301016120.23447@cobra.newdream.net> <20110730221900.GK7361@thunk.org>
 <Pine.LNX.4.64.1107302149430.23447@cobra.newdream.net> <4E353D9E.5080802@ufm.su>
 <Pine.LNX.4.64.1107310951550.2348@cobra.newdream.net> <4E35B833.6070304@ufm.su>
 <Pine.LNX.4.64.1107311339530.23447@cobra.newdream.net>
 <80E3795B-C981-492F-9312-DC91D57E4017@mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47193 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753257Ab1HAQQd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Aug 2011 12:16:33 -0400
In-Reply-To: <80E3795B-C981-492F-9312-DC91D57E4017@mit.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Theodore Tso <tytso@MIT.EDU>
Cc: Fyodor Ustinov <ufm@ufm.su>, ceph-devel@vger.kernel.org

On Mon, 1 Aug 2011, Theodore Tso wrote:
> On Jul 31, 2011, at 4:42 PM, Sage Weil wrote:
> 
> > This is link(2)
> > 
> >> 2011-07-31 23:06:50.114316 7f23c048c700 filestore(/osd.0) collection_remove
> >> temp/10000000483.000005d6/head = 0
> > 
> > This is unlink(2)
> > 
> >> 2011-07-31 23:06:50.114384 7f23c048c700 filestore(/osd.0) setattrs
> >> 0.69_head/10000000483.000005d6/head '_' len 161 = 161
> > 
> > The xattr names are prefixed with 'user.ceph.'
> > 
> >> 2011-07-31 23:06:50.114406 7f23c048c700 filestore(/osd.0) setattrs
> >> 0.69_head/10000000483.000005d6/head 'snapset' len 26 = 26
> >> 2011-07-31 23:06:50.114413 7f23c048c700 filestore(/osd.0) setattrs
> >> 0.69_head/10000000483.000005d6/head = 26
> > 
> > Does that tell you what to need, Ted?
> 
> So let me make sure I understand what happened.  Ceph made sure no file existed with this name, and created with the first write log entry:
> 
> 2011-07-31 23:06:49.173941 7f23c048c700 filestore(/osd.0) write temp/10000000483.000005d6/head 0~1048576 = 1048576

The fd was actually closed here.

> It then linked it into this directory:
> 
> 2011-07-31 23:06:50.114287 7f23c048c700 filestore(/osd.0) collection_add 0.69_head/10000000483.000005d6/head temp/10000000483.000005d6/head = 0
> 
> ? and removed it from the temp directory:
> 
> 2011-07-31 23:06:50.114316 7f23c048c700 filestore(/osd.0) collection_remove temp/10000000483.000005d6/head = 0
> 
> and then created three inodes that totaled approximately 240 bytes in length or so (including the name and headers)
                         xattrs
> 
> 2011-07-31 23:06:50.114384 7f23c048c700 filestore(/osd.0) setattrs 0.69_head/10000000483.000005d6/head '_' len 161 = 161
> 2011-07-31 23:06:50.114406 7f23c048c700 filestore(/osd.0) setattrs 0.69_head/10000000483.000005d6/head 'snapset' len 26 = 26
> 2011-07-31 23:06:50.114413 7f23c048c700 filestore(/osd.0) setattrs 0.69_head/10000000483.000005d6/head = 26
> 
> ? and then presumably the file was closed and that would have been the 
> end of this file being touched by ceph, correct?

Yep!

sage
