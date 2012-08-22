From: Florian Haas <florian@hastexo.com>
Subject: Re: wip-crush
Date: Wed, 22 Aug 2012 16:46:12 +0200
Message-ID: <5034F0B4.3060107@hastexo.com>
References: <alpine.DEB.2.00.1208211807330.12167@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:48231 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757357Ab2HVOqQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Aug 2012 10:46:16 -0400
Received: by bkwj10 with SMTP id j10so352033bkw.19
        for <ceph-devel@vger.kernel.org>; Wed, 22 Aug 2012 07:46:15 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1208211807330.12167@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 08/22/2012 03:10 AM, Sage Weil wrote:
> I pushed a branch that changes some of the crush terminology.  Instead of 
> having a crush type called "pool" that requires you to say things like 
> "pool=default" in the "ceph osd crush set ..." command, it uses "root" 
> instead.  That hopefully reinforces that it is a tree/hierarchy.
> 
> There is also a patch that changes "bucket" to "node" throughout, since 
> bucket is a term also used by radosgw.
> 
> Thoughts?  I think the main pain in making this transition is that old 
> clusters have maps that have a type 'pool' and new ones won't, and the 
> docs will need to walk people through both...

"pool" in a crushmap being completely unrelated to a RADOS pool is
something that I've heard customers/users report as confusing, as well.
So changing that is probably a good thing. Naming it "root" is probably
a good choice as well, as it happens to match
http://ceph.com/wiki/Custom_data_placement_with_CRUSH.

As for changing "bucket" to node... a "node" is normally simply a
physical server (at least in HA terminology, which many potential Ceph
users will be familiar with), and CRUSH uses "host" for that. So that's
another recipe for confusion. How about using something super-generic,
like "element" or "item"?

Cheers,
Florian

