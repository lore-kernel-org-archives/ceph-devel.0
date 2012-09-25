From: Sage Weil <sage@inktank.com>
Subject: Re: Ho to identify location of Primary Copy Of Obj ?
Date: Tue, 25 Sep 2012 14:29:25 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1209251428570.6215@cobra.newdream.net>
References: <CAGfy=6mvjOUh8jV8EaSZXK=o-6+a5fdFTvNF6WrXcqmF4mwRog@mail.gmail.com> <50621552.2050900@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52872 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753479Ab2IYV3Z (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Sep 2012 17:29:25 -0400
In-Reply-To: <50621552.2050900@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Mick <dan.mick@inktank.com>
Cc: hemant surale <hemant.surale@gmail.com>, ceph-devel@vger.kernel.org

On Tue, 25 Sep 2012, Dan Mick wrote:
> Hemant:
> 
> Yes, you can.  Use ceph osd getmap -o <file> to get the OSD map, and then use
> osdmaptool --find-object-map <objectname> <file> to output the
> PG the object hashes to and the list of OSDs that PG maps to (primary first):
> 
> $ ceph osd getmap -o osdmap
> got osdmap epoch 59
> $ osdmaptool --test-map-object dmick.rbd osdmap
> osdmaptool: osdmap file 'osdmap'
>  object 'dmick.rbd' -> 0.69c8 -> [3,1]
> 
> shows dmick.rbd mapping to pg 0.69c8, which in turn maps to OSDs 3 and 1, 3
> being the primary.

You can do this more simply with:

 ceph osd map <poolname> <objectname>

sage

> 
> On 09/25/2012 02:30 AM, hemant surale wrote:
> > Hi Community,
> >            Is it possible to identify where exactly primary copy of obj
> > is stored ? I am using crushmaps to use specific osds for data
> > placement but i want to knw the primary capoy location. Or I need to
> > replace pseudo random function by some deterministic function to guide
> > ceph to utilize specific osd?
> > 
> > 
> > Regards,
> > Hemant Surale.
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
