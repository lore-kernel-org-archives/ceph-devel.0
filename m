From: Jesse Williamson <jwilliamson@suse.de>
Subject: Re: OSDMap / osd_state questions
Date: Tue, 4 Apr 2017 05:18:26 -0700 (PDT)
Message-ID: <alpine.LSU.2.20.1704040511310.19913@ancalagon.suse.de>
References: <alpine.LSU.2.20.1704030511540.12566@ancalagon.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:51546 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751156AbdDDMSd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 4 Apr 2017 08:18:33 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4CB69AB45
        for <ceph-devel@vger.kernel.org>; Tue,  4 Apr 2017 12:18:27 +0000 (UTC)
In-Reply-To: <alpine.LSU.2.20.1704030511540.12566@ancalagon.suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Squid Cybernetic <ceph-devel@vger.kernel.org>

On Tue, 4 Apr 2017, Jesse Williamson wrote:

Ok, sorry to add extra traffic, but a partial answer to my own question leads to more questions:

> ...is there some condition where an osd id will appear in osd_state and yet 
> CEPH_OSD_EXISTS be false? It looks like the other two conditions, UP and 
> OUT[1] depend on that being true.

OSDMonitor::get_health() appears to circumvent the is_up()/is_down() 
methods from OSDMap, instead checking manually-- and slightly 
differently[1].

One of the checks is:
       if (!osdmap.exists(i)) {
         if (osdmap.crush->item_exists(i)) {
           down_osds.insert(i);
         }

...so, to be "down", something must NOT exist in the osd_state AND must 
exist in the CRUSH map. Looking at definition of OSDMap::exists() and 
OSDMap::is_down(), they differ in that get_health() is checking the CRUSH 
map. Who's right..?

It also looks like in get_health() when something's added to down_osds, 
num_down_in_osds isn't incremented. Is this intentional?

Thanks again,

-Jesse

1. From OSDMonitor::get_health():

     int num_in_osds = 0;
     set<int> down_osds;
     for (int i = 0; i < osdmap.get_max_osd(); i++) {
       if (!osdmap.exists(i)) {
         if (osdmap.crush->item_exists(i)) {
           down_osds.insert(i);
         }
      continue;
       }
       if (osdmap.is_out(i))
         continue;
       ++num_in_osds;
       if (!osdmap.is_up(i)) {
     ++num_down_in_osds;

2. exists(), etc.:

   bool exists(int osd) const {
     //assert(osd >= 0);
     return osd >= 0 && osd < max_osd && (osd_state[osd] & 
CEPH_OSD_EXISTS);
   }

   bool is_up(int osd) const {
     return exists(osd) && (osd_state[osd] & CEPH_OSD_UP);
   }

   bool has_been_up_since(int osd, epoch_t epoch) const {
     return is_up(osd) && get_up_from(osd) <= epoch;
   }

   bool is_down(int osd) const {
     return !is_up(osd);
   }

