From: Sage Weil <sage@inktank.com>
Subject: Re: slow requests, hunting for new mon
Date: Thu, 14 Feb 2013 17:35:51 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1302141728430.11259@cobra.newdream.net>
References: <20130212072815.GA17655@onthe.net.au> <slrnkhr316.ntb.chris@chris.onthe.net.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45694 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759142Ab3BOBfv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Feb 2013 20:35:51 -0500
In-Reply-To: <slrnkhr316.ntb.chris@chris.onthe.net.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chris Dunlop <chris@onthe.net.au>
Cc: ceph-devel@vger.kernel.org

On Fri, 15 Feb 2013, Chris Dunlop wrote:
> On 2013-02-12, Chris Dunlop <chris@onthe.net.au> wrote:
> > Hi,
> >
> > What are likely causes for "slow requests" and "monclient: hunting for new
> > mon" messages? E.g.:
> >
> > 2013-02-12 16:27:07.318943 7f9c0bc16700  0 monclient: hunting for new mon
> > ...
> > 2013-02-12 16:27:45.892314 7f9c13c26700  0 log [WRN] : 6 slow requests, 6 included below; oldest blocked for > 30.383883 secs
> > 2013-02-12 16:27:45.892323 7f9c13c26700  0 log [WRN] : slow request 30.383883 seconds old, received at 2013-02-12 16:27:15.508374: osd_op(client.9821.0:122242 rb.0.209f.74b0dc51.000000000120 [write 921600~4096] 2.981cf6bc) v4 currently no flag points reached
> > 2013-02-12 16:27:45.892328 7f9c13c26700  0 log [WRN] : slow request 30.383782 seconds old, received at 2013-02-12 16:27:15.508475: osd_op(client.9821.0:122243 rb.0.209f.74b0dc51.000000000120 [write 987136~4096] 2.981cf6bc) v4 currently no flag points reached
> > 2013-02-12 16:27:45.892334 7f9c13c26700  0 log [WRN] : slow request 30.383720 seconds old, received at 2013-02-12 16:27:15.508537: osd_op(client.9821.0:122244 rb.0.209f.74b0dc51.000000000120 [write 1036288~8192] 2.981cf6bc) v4 currently no flag points reached
> > 2013-02-12 16:27:45.892338 7f9c13c26700  0 log [WRN] : slow request 30.383684 seconds old, received at 2013-02-12 16:27:15.508573: osd_op(client.9821.0:122245 rb.0.209f.74b0dc51.000000000122 [write 1454080~4096] 2.fff29a9a) v4 currently no flag points reached
> > 2013-02-12 16:27:45.892341 7f9c13c26700  0 log [WRN] : slow request 30.328986 seconds old, received at 2013-02-12 16:27:15.563271: osd_op(client.9821.0:122246 rb.0.209f.74b0dc51.000000000122 [write 1482752~4096] 2.fff29a9a) v4 currently no flag points reached
> 
> OK, for the sake of anyone who might come across this thread when
> searching for similar issues...
> 
> http://ceph.com/docs/master/rados/operations/troubleshooting-osd/#slow-or-unresponsive-osd
> 
> ...unfortunately the error message in the link above says "old request"
> rather than "slow request" (old code?), so that page doesn't come up
> when googling for the "slow request" message. The page needs
> updating.

Updated, thanks!

> The underlying problem in our case seems to have been spikes in the
> number of IOPS going to the disks (e.g. watch 'iostat -x' output). Whilst
> the disks were coping with steady state load, occasionally something (in
> this case, activity in a vm running on rbd) would cause a spike in
> activity and the disks couldn't cope. I'd initially looked at the amount
> of data going to the disks and thought it was well with the disks'
> capabilities, however I hadn't considered the IOPS.
> 
> The (partial?) solution was to move the journals onto a separate device,
> halving the IOPS going to the data disk (write journal, write data) as
> well as avoiding having the heads slamming back and forth between the
> data and journal. We're continuing to watch the IOPS and will add more
> OSDs to spread the load further if necessary.
> 
> I still don't know what the "hunting" messages actually indicate, but
> they've also disappeared since fixing the "slow request" messages.

This usually means the monitor was responding and we (the OSD or client) 
is trying to reconnect (to a random monitor).

> Incidentally, it strikes me that there is a significant amount of write
> amplification going on when running vms with a file system such as xfs
> or ext4 (with journal) on top of rbd/rados (with journal) on top of xfs
> (with journal). I.e. a single write from a vm can turn into up to 8
> separate writes by the time it hits the underlying xfs filesystem. I
> think this is why our ceph setup is struggling at far less load on the
> same hardware compared to the drbd setup we're wanting to replace.

Currently, yes.  There is always going to be some additional overhead 
because the object data is stored in a file system.  We were/are doing 
several other non-optimal things too, however, that is being improved in 
the current master branch (moving some metadata into leveldb which does a 
better job of managing the IO pattern).  Stay tuned!

sage

