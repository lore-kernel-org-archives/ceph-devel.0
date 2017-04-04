From: Sage Weil <sage@newdream.net>
Subject: Re: OSDMap / osd_state questions
Date: Tue, 4 Apr 2017 14:16:00 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1704041412130.2999@piezo.novalocal>
References: <alpine.LSU.2.20.1704030511540.12566@ancalagon.suse.de> <alpine.LSU.2.20.1704040511310.19913@ancalagon.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55626 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753239AbdDDOQD (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Apr 2017 10:16:03 -0400
In-Reply-To: <alpine.LSU.2.20.1704040511310.19913@ancalagon.suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jesse Williamson <jwilliamson@suse.de>
Cc: Squid Cybernetic <ceph-devel@vger.kernel.org>

On Tue, 4 Apr 2017, Jesse Williamson wrote:
> On Tue, 4 Apr 2017, Jesse Williamson wrote:
> 
> Ok, sorry to add extra traffic, but a partial answer to my own question leads
> to more questions:
> 
> > ...is there some condition where an osd id will appear in osd_state and yet
> > CEPH_OSD_EXISTS be false? It looks like the other two conditions, UP and
> > OUT[1] depend on that being true.
> 
> OSDMonitor::get_health() appears to circumvent the is_up()/is_down() methods
> from OSDMap, instead checking manually-- and slightly differently[1].
> 
> One of the checks is:
>       if (!osdmap.exists(i)) {
>         if (osdmap.crush->item_exists(i)) {
>           down_osds.insert(i);
>         }
> 
> ...so, to be "down", something must NOT exist in the osd_state AND must exist
> in the CRUSH map. Looking at definition of OSDMap::exists() and
> OSDMap::is_down(), they differ in that get_health() is checking the CRUSH map.
> Who's right..?

Not sure what eversion of the code you're looking at.  On master, it's

    set<int> osds;
    for (int i = 0; i < osdmap.get_max_osd(); i++) {
      if (!osdmap.exists(i)) {
        if (osdmap.crush->item_exists(i)) {
          osds.insert(i);
        }
	continue;
      } 
      ...
    }
    ...
    if (!osds.empty()) {
      ostringstream ss;
      ss << "osds were removed from osdmap, but still kept in crushmap";
      summary.push_back(make_pair(HEALTH_WARN, ss.str()));
      if (detail) {
        ss << " osds: [" << osds << "]";
        detail->push_back(make_pair(HEALTH_WARN, ss.str()));
      }
    }

> It also looks like in get_health() when something's added to down_osds,
> num_down_in_osds isn't incremented. Is this intentional?

The code in master makes sense there too.  What are you looking at?

Thanks!
sage



> 
> Thanks again,
> 
> -Jesse
> 
> 1. From OSDMonitor::get_health():
> 
>     int num_in_osds = 0;
>     set<int> down_osds;
>     for (int i = 0; i < osdmap.get_max_osd(); i++) {
>       if (!osdmap.exists(i)) {
>         if (osdmap.crush->item_exists(i)) {
>           down_osds.insert(i);
>         }
>      continue;
>       }
>       if (osdmap.is_out(i))
>         continue;
>       ++num_in_osds;
>       if (!osdmap.is_up(i)) {
>     ++num_down_in_osds;
> 
> 2. exists(), etc.:
> 
>   bool exists(int osd) const {
>     //assert(osd >= 0);
>     return osd >= 0 && osd < max_osd && (osd_state[osd] & CEPH_OSD_EXISTS);
>   }
> 
>   bool is_up(int osd) const {
>     return exists(osd) && (osd_state[osd] & CEPH_OSD_UP);
>   }
> 
>   bool has_been_up_since(int osd, epoch_t epoch) const {
>     return is_up(osd) && get_up_from(osd) <= epoch;
>   }
> 
>   bool is_down(int osd) const {
>     return !is_up(osd);
>   }
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
