From: Sage Weil <sage@newdream.net>
Subject: Re: Nodown/Noout by OSD_ID?
Date: Wed, 20 Jan 2016 20:58:15 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1601202056370.21498@cpach.fuggernut.com>
References: <CAEYCsVLFUYAeKT_2bxyA1DpC5K5yzS6JHM=eJ=4WuGpjdypTnw@mail.gmail.com> <alpine.DEB.2.11.1601200813250.4600@cpach.fuggernut.com> <CALe9h7cqj+ck9-tKBgKuSx=4KcPSJnjO3O=eWSfV3yUT3J=QcQ@mail.gmail.com> <alpine.DEB.2.11.1601201025140.4600@cpach.fuggernut.com>
 <CAEYCsV+ELKWAGHD4qo5Lw3_=99zp1ubK2E0n=DsiVHhStzWqXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51895 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751957AbcAUB6H (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Jan 2016 20:58:07 -0500
In-Reply-To: <CAEYCsV+ELKWAGHD4qo5Lw3_=99zp1ubK2E0n=DsiVHhStzWqXA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xiaoxi Chen <superdebuger@gmail.com>
Cc: John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Thu, 21 Jan 2016, Xiaoxi Chen wrote:
> Yeah,  mark a whole tree is cool.
> 
> We can do that in API level but in implementation, seems we still need
> to set the flag on OSD level for simplicity. For example, say RackA
> and B are belongs to Row A in crush tree, then if we do:
>      ceph [osdmap? crush? ] set RowA noout
>      ceph [osdmap? crush? ] set RackA noup
>      ceph [osdmap? crush? ] unset RackB noout
> 
> As a result, OSDs in Rack A should be noup+noout, but OSDs in RackB
> should have no flag setted.  The easiest way in my mind might be
> traversal the crush subtree and mark the flag on  vector<uint8_t>
> osd_state for every OSD, uint8_t is just enough for now....but next
> time if we want to have more state will be struggle.

Oh right--that is much simpler!

> 
> #define CEPH_OSD_NOUP     (1<<4)  /* osd cannot be marked up */
> #define CEPH_OSD_NODOWN     (1<<5)  /* osd cannot be marked down */
> #define CEPH_OSD_NOIN     (1<<6)  /* osd cannot be marked in */
> #define CEPH_OSD_NOOUT     (1<<7)  /* osd cannot be marked out */

+1

> The APIs we would like to support are:
> 
> 1. ceph XXX set/unset {crush_subtree_name} {flag}

ceph osd [un]set-osd {osd} {flag}
ceph osd [un]set-subtree {osd} {flag}

(This way we look like 'ceph osd crush reweight-subtree ...'.)

> 2. ceph osd tree will show flag of each OSD (if it has)
> 3. ceph health should show the number of OSD with flags.
> 4. ceph health detail show OSDs with flgas.
> 
> 3) and 4) need to iterate the  vector<uint8_t> osd_state in OSDMap.

Sounds good!
sage


