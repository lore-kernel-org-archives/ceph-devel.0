From: Jesse Williamson <jwilliamson@suse.de>
Subject: OSDMap / osd_state questions
Date: Tue, 4 Apr 2017 04:42:32 -0700 (PDT)
Message-ID: <alpine.LSU.2.20.1704030511540.12566@ancalagon.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:47493 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750988AbdDDLme (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 4 Apr 2017 07:42:34 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DAC7EAD73
        for <ceph-devel@vger.kernel.org>; Tue,  4 Apr 2017 11:42:32 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Squid Cybernetic <ceph-devel@vger.kernel.org>


Hello,

I have a couple of questions about OSDMap.

OSDMap has:
   int num_osd;         // not saved; see calc_num_osds
   int num_up_osd;      // not saved; see calc_num_osds
   int num_in_osd;      // not saved; see calc_num_osds

   int32_t max_osd;
   vector<uint8_t> osd_state;

   int calc_num_osds();

calc_num_osds() does this:
int OSDMap::calc_num_osds()
{
   num_osd = 0;
   num_up_osd = 0;
   num_in_osd = 0;
   for (int i=0; i<max_osd; i++) {
     if (osd_state[i] & CEPH_OSD_EXISTS) {
       ++num_osd;
       if (osd_state[i] & CEPH_OSD_UP) {
     ++num_up_osd;
       }
       if (get_weight(i) != CEPH_OSD_OUT) {
     ++num_in_osd;
       }
     }
   }
   return num_osd;
}

...is there some condition where an osd id will appear in osd_state and 
yet CEPH_OSD_EXISTS be false? It looks like the other two conditions, UP 
and OUT[1] depend on that being true.

First question: Can we get away with returning osd_state.size()?

Second, should the cached/memoized member variables set as a side-effect 
of calc_num_osds() /ever/ be trusted if we don't call the method first?

Finally, if we have to go through this loop anyway, perhaps in addition to 
the size we'll want to know the OSD ids as well? I see several places 
where we wind up looping through osd_state /again/ to get extra 
information (for example, OSDMonitor::get_health()).

Perhaps a method basically doing this would be useful, along these lines?

partition_copy(begin(osd_state), end(osd_state),
                begin(up_osds), begin(down_osds),
                [&osdmap](const int32_t osd_id) { return osdmap.is_up(osd_id); });

Thanks for reading,

-Jesse

1. It would be amusing to check for DOWN and OUT.;-)

