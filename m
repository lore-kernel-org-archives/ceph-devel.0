From: Sage Weil <sweil@redhat.com>
Subject: Re: OSD suicide after being down/in for one day as it needs to search
 large amount of objects
Date: Wed, 20 Aug 2014 08:19:46 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1408200816210.28244@cobra.newdream.net>
References: <BLU436-SMTP1407B6BAC746323A36B7947DFD50@phx.gbl> <CAPYLRzh5eNVqPVWGgDKSOsQ6MaDVgxnki=1dzf9Nnw5UOO6HXw@mail.gmail.com> <BLU436-SMTP149AEBB380BB925D15D777ADFD20@phx.gbl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40771 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751316AbaHTPTq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Aug 2014 11:19:46 -0400
In-Reply-To: <BLU436-SMTP149AEBB380BB925D15D777ADFD20@phx.gbl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guang Yang <yguang11@outlook.com>
Cc: Gregory Farnum <greg@inktank.com>, Ceph-devel <ceph-devel@vger.kernel.org>, david.z1003@yahoo.com

On Wed, 20 Aug 2014, Guang Yang wrote:
> Thanks Greg.
> On Aug 20, 2014, at 6:09 AM, Gregory Farnum <greg@inktank.com> wrote:
> 
> > On Mon, Aug 18, 2014 at 11:30 PM, Guang Yang <yguang11@outlook.com> wrote:
> >> Hi ceph-devel,
> >> David (cc?ed) reported a bug (http://tracker.ceph.com/issues/9128) which we came across in our test cluster during our failure testing, basically the way to reproduce it was to leave one OSD daemon down and in for a day, at the same time, keep giving write traffic. When the OSD daemon was started again, it hit suicide timeout and kill itself.
> >> 
> >> After some analysis (details in the bug), David found that the op thread was busy searching for missing objects and once the volume to search increase, the thread is expected to work that long time, please refer to the bug for detailed logs.
> > 
> > Can you talk a little more about what's going on here? At a quick
> > naive glance, I'm not seeing why leaving an OSD down and in should
> > require work based on the amount of write traffic. Perhaps if the rest
> > of the cluster was changing mappings??
> We increased the down to out time interval from 5 minutes to 2 days to 
> avoid migrating data back and forth which could increase latency, so 
> that we target to mark OSD out manually. To achieve such, we are testing 
> against some boundary cases to let the OSD down and in for like 1 day, 
> however, when we try to bring it up again, it always failed due to hit 
> the suicide timeout.

Looking at the log snippet I see the PG had log range

	5481'28667,5646'34066

Which is ~5500 log events.  The default max is 10k.  search_for_missing is 
basically going to iterate over this list and check if the object is 
present locally.

If that's slow enough to trigger a suicide (which it seems to be), teh 
fix is simple: as Greg says we just need to make it probe the internel 
heartbeat code to indicate progress.  In most contexts this is done by 
passing a ThreadPool::TPHandle &handle into each method and then 
calling handle.reset_tp_timeout() on each iteration.  The same needs to be 
done for search_for_missing...

sage

