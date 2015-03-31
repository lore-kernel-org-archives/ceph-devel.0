From: Sage Weil <sweil@redhat.com>
Subject: Re: Release pg.lock in build scrub map for primary
Date: Tue, 31 Mar 2015 06:44:39 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1503310643220.15540@cobra.newdream.net>
References: <6AA21C22F0A5DA478922644AD2EC308C9623A3@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55054 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753888AbbCaNom (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 31 Mar 2015 09:44:42 -0400
In-Reply-To: <6AA21C22F0A5DA478922644AD2EC308C9623A3@SHSMSX101.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Ma, Jianpeng" <jianpeng.ma@intel.com>
Cc: sjust@redhat.com, ceph-devel@vger.kernel.org

On Tue, 31 Mar 2015, Ma, Jianpeng wrote:
> Hi Sage,
>     We know scrub & handle normal osd ops is serial. Especially for deep-scrub, it need read all data, so it can block normal osd op for more time..
> >From the code, the most consume time function is PGBackend::be_scan_list. If for this section, we can release pg.lock and get the main aim.
> 
> My analysis
> 1: at this point, we already set scrub.start/end, so the normal write-order op about those objects will blocked. For PGBackend::be_scan_list, it's safe to release pg.lock.
> 2:for _scan_rollback_obs, it need last_rollback_info_trimmed_to_applied.  To be carefully, we can move  _scan_rollback_obs before be_scan_list avoid some rollback objects removed.
> 3:becasuse I don't familiar with snap. I don't sure is it safe for _scan_snaps which release and reget pg.lock?
> 
> The fininal code like in build_scrub_map_chunk:
>   _scan_rollback_obs(rollback_obs, handle);
>    Pg.unlock()
>    get_pgbackend()->be_scan_list(map, ls, deep, seed, handle);
>    pg.lock()
>    _scan_snaps(map); 

I actually thought that scrub was doing the object listing without the 
lock... I think that was the case and perhaps the locking was added to 
avoid some race?  Sam, do you remember?

sage

