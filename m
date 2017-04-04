From: Sage Weil <sage@newdream.net>
Subject: Re: OSDMap / osd_state questions
Date: Tue, 4 Apr 2017 14:12:07 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1704041408290.2999@piezo.novalocal>
References: <alpine.LSU.2.20.1704030511540.12566@ancalagon.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55611 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754167AbdDDOML (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Apr 2017 10:12:11 -0400
In-Reply-To: <alpine.LSU.2.20.1704030511540.12566@ancalagon.suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jesse Williamson <jwilliamson@suse.de>
Cc: Squid Cybernetic <ceph-devel@vger.kernel.org>

On Tue, 4 Apr 2017, Jesse Williamson wrote:
> Hello,
> 
> I have a couple of questions about OSDMap.
> 
> OSDMap has:
>   int num_osd;         // not saved; see calc_num_osds
>   int num_up_osd;      // not saved; see calc_num_osds
>   int num_in_osd;      // not saved; see calc_num_osds
> 
>   int32_t max_osd;
>   vector<uint8_t> osd_state;
> 
>   int calc_num_osds();
> 
> calc_num_osds() does this:
> int OSDMap::calc_num_osds()
> {
>   num_osd = 0;
>   num_up_osd = 0;
>   num_in_osd = 0;
>   for (int i=0; i<max_osd; i++) {
>     if (osd_state[i] & CEPH_OSD_EXISTS) {
>       ++num_osd;
>       if (osd_state[i] & CEPH_OSD_UP) {
>     ++num_up_osd;
>       }
>       if (get_weight(i) != CEPH_OSD_OUT) {
>     ++num_in_osd;
>       }
>     }
>   }
>   return num_osd;
> }
> 
> ...is there some condition where an osd id will appear in osd_state and yet
> CEPH_OSD_EXISTS be false? 

Yes

> It looks like the other two conditions, UP and OUT[1] depend on that 
> being true.

Those bits are ignored if the OSD doesn't exist.

> First question: Can we get away with returning osd_state.size()?

Nope!
 
> Second, should the cached/memoized member variables set as a side-effect of
> calc_num_osds() /ever/ be trusted if we don't call the method first?

Nope!  We're careful to call it after decode() and apply_incremental(), 
which are basically the only two paths that modify OSDMap.

> Finally, if we have to go through this loop anyway, perhaps in addition to the
> size we'll want to know the OSD ids as well? I see several places where we
> wind up looping through osd_state /again/ to get extra information (for
> example, OSDMonitor::get_health()).
> 
> Perhaps a method basically doing this would be useful, along these lines?
> 
> partition_copy(begin(osd_state), end(osd_state),
>                begin(up_osds), begin(down_osds),
>                [&osdmap](const int32_t osd_id) { return osdmap.is_up(osd_id);
> });

Maybe!  Since osd_state is a vector its all very fast.  Not sure that we 
are bulding a set<int> of up or down often enough to justify 
prebuilding it.  (It also consumes memory, and on big clusters 
we have lots of big OSDMaps in a cache that can't consume too much 
memory.)

sage

