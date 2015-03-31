From: Samuel Just <sjust@redhat.com>
Subject: Re: Release pg.lock in build scrub map for primary
Date: Tue, 31 Mar 2015 13:12:01 -0400 (EDT)
Message-ID: <1709924711.8566703.1427821921193.JavaMail.zimbra@redhat.com>
References: <6AA21C22F0A5DA478922644AD2EC308C9623A3@SHSMSX101.ccr.corp.intel.com> <alpine.DEB.2.00.1503310643220.15540@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:46400 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753995AbbCaRMD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 31 Mar 2015 13:12:03 -0400
In-Reply-To: <alpine.DEB.2.00.1503310643220.15540@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Jianpeng Ma <jianpeng.ma@intel.com>, ceph-devel@vger.kernel.org

We stopped dropping the lock when chunky scrub was added.  I would prefer to not drop the lock.
-Sam

----- Original Message -----
From: "Sage Weil" <sweil@redhat.com>
To: "Jianpeng Ma" <jianpeng.ma@intel.com>
Cc: sjust@redhat.com, ceph-devel@vger.kernel.org
Sent: Tuesday, March 31, 2015 6:44:39 AM
Subject: Re: Release pg.lock in build scrub map for primary

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

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


