From: Sage Weil <sage@inktank.com>
Subject: Re: Ignore O_SYNC for rbd cache
Date: Wed, 10 Oct 2012 09:23:35 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1210100919020.8499@cobra.newdream.net>
References: <CABYiri87Kni9+XkS2JWymxocJF9bCYpPswYFiBkeEOk6CSeMQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37216 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753969Ab2JJQXg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Oct 2012 12:23:36 -0400
In-Reply-To: <CABYiri87Kni9+XkS2JWymxocJF9bCYpPswYFiBkeEOk6CSeMQw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 10 Oct 2012, Andrey Korolyov wrote:
> Hi,
> 
> Recent tests on my test rack with 20G IB(iboip, 64k mtu, default
> CUBIC, CFQ, LSI SAS 2108 w/ wb cache) interconnect shows a quite
> fantastic performance - on both reads and writes Ceph completely
> utilizing all disk bandwidth as high as 0.9 of theoretical limit of
> sum of all bandwidths bearing in mind replication level. The only
> thing that may bring down overall performance is a O_SYNC|O_DIRECT
> writes which will be issued by almost every database server in the
> default setup. Assuming that the database config may be untouchable
> and somehow I can build very reliable hardware setup which `ll never
> fail on power, should ceph have an option to ignore these flags? May
> be there is another real-world cases for including such or I am very
> wrong even thinking on fool client application in this way.

I certainly wouldn't recommend it, but there are probably use cases where 
it makes sense (i.e., the data isn't as important as the performance).  
Any such option would probably be called

 rbd async flush danger danger = true

and would trigger a flush but not wait for it, or perhaps

 rbd ignore flush danger danger = true

which would not honor flush at all. 

This would jeopoardize the integrity of the file system living on the RBD 
image; they rely on flush to order their commits, and playing fast and 
loose with that can lead to any number of corruptions.  The only silver 
lining is that in the not-so-distant future (3-4 years ago) this was 
poorly supported by the block layer and file systems alike and ext3 didn't 
crash and burn as quite often as you might have expected.

Anyway, not something I would recommend, certainly for a generic VM 
platform.  Maybe if you have a sepcific performance-sensitive application 
you can afford to let crash and burn...

sage
