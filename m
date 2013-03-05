From: Dieter Kasper <d.kasper@kabelmail.de>
Subject: Re: When ceph synchronizes journal to disk? / read request
Date: Tue, 5 Mar 2013 09:37:02 +0100
Message-ID: <20130305083702.GA12118@oder>
References: <513343D8.8050402@cs.utah.edu>
 <CAPYLRzhAfvXfnCi4qRtdPEnV+v1qUy+DVED2Z0eep7eTvG__BA@mail.gmail.com>
 <51357589.6080202@cs.utah.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtpa1.mediabeam.com ([194.25.41.13]:48518 "EHLO
	smtpa1.mediabeam.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754878Ab3CEIte (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Mar 2013 03:49:34 -0500
Content-Disposition: inline
In-Reply-To: <51357589.6080202@cs.utah.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Xing Lin <xinglin@cs.utah.edu>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "Dieter Kasper (KD)" <d.kasper@kabelmail.de>

Hi Gregory,

another interesting aspect for me is:
How will a read-request for this block/sub-block (pending between journal and OSD)
be satisfied (assuming the client will not cache) ?
Will this read go to the journal or to the OSD ?

Best Regards,
-Dieter

On Tue, Mar 05, 2013 at 05:33:13AM +0100, Xing Lin wrote:
> Hi Gregory,
> 
> Thanks for your reply.
> 
> On 03/04/2013 09:55 AM, Gregory Farnum wrote:
> > The "journal [min|max] sync interval" values specify how frequently
> > the OSD's "FileStore" sends a sync to the disk. However, data is still
> > written into the normal filesystem as it comes in, and the normal
> > filesystem continues to schedule normal dirty data writeouts. This is
> > good ? it means that when we do send a sync down you don't need to
> > wait for all (30 seconds * 100MB/s) 3GB or whatever of data to go to
> > disk before it's completed.
> 
> I do not think I understand this well. When the writeahead journal mode 
> is in use, would you please explain what happens to a single 4M write 
> request? I assume that an entry in the journal will be created for this 
> write request and after this entry is flushed to the journal disk, Ceph 
> returns successful. There should be no IO to the osd's disk. All IOs are 
> supposed to go to the journal disk. At a later time, Ceph will start to 
> apply these changes to the normal filesystem by reading from the first 
> entry at which its previous synchronization stops. Finally, it will read 
> this entry and apply this write change to the normal file system. Could 
> you please point out where is wrong in my understanding? Thanks,
> 
> >> >I am running 0.48.2. The related configuration is as follows.
> > If you're starting up a new cluster I recommend upgrading to the
> > bobtail series (.56.3) instead of using Argonaut ? it's got a number
> > of enhancements you'll appreciate!
> 
> Yeah, I would like to use bobtail series. However, I started to make 
> small changes with Argonaut (0.48) and had ported my changes once to 
> 0.48.2 when it was released. I think I am good to continue with it for 
> the moment. I may consider to port my changes to bobtail series at a 
> later time. Thanks,
> 
> Xing
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

