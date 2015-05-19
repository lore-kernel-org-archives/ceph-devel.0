From: Sage Weil <sage@newdream.net>
Subject: Re: [EMG]incomplete pgs make RGW unusable
Date: Tue, 19 May 2015 07:42:11 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1505190741450.9510@cobra.newdream.net>
References: <mjdupr$jtu$1@ger.gmane.org> <mjettq$dj6$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45914 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753116AbbESOmM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 May 2015 10:42:12 -0400
In-Reply-To: <mjettq$dj6$1@ger.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: flisky <yinjifeng@lianjia.com>
Cc: ceph-devel@vger.kernel.org

On Tue, 19 May 2015, flisky wrote:
> I follow the instruction from http://tracker.ceph.com/issues/10411#note-4, and
> finally get force_create_pg work.
> 
> Thanks, Brian Rak. It helps a lot.
> 
> And, it would be great if the [feature](http://tracker.ceph.com/issues/10098)
> is implemented.

I've bumped this up toward the top of the backlog.. it shouldn't be 
terribly difficult to implement!

sage


> 
> BR,
> 
> On 2015?05?19? 08:06, flisky wrote:
> > Hi core developers,
> > 
> > Sorry, I have to raise this from user list because there is no response.
> > 
> > I reformat the disks to increase osd journal size. During the process, I
> > lost 9 pgs.
> > 
> > The incomplete pgs belong to the pool .rgw.buckets, which causes slow
> > requests and make RGW unusable.
> > I have to restart the OSDs and RGWs time to time, to make RGW responsible.
> > 
> > The most scary things happen. I cannot recovery the incomplete pgs.
> > 
> > [force_create_pg](http://tracker.ceph.com/issues/10098) marks it a
> > feature to handle this.
> > 
> > The [blog](https://ceph.com/community/incomplete-pgs-oh-my/) is not
> > working, either.
> > 
> > And finally I give up the recovery, and use 'rados cppool' to copy our
> > huge pool, it's STUCK...
> > 
> > I'm very frustrated, and very surprised that Ceph doesn't offer a way to
> > just let the lost data lost.
> > 
> > Could anyone give any advise on this? Thanks!
> > 
> > Sincerely,
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
