From: Casey Bodley <cbodley@redhat.com>
Subject: Re: RGW zones and admin ops
Date: Wed, 29 Mar 2017 09:49:03 -0400
Message-ID: <58c1dd40-f8a6-a909-65d5-11d788aab530@redhat.com>
References: <CAN1NP8h0h8Vo-EpjbmWSYg_L3G3KpCGfFUPBMJ=Crno3CgUW6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f180.google.com ([209.85.216.180]:34523 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754438AbdC2NtG (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Mar 2017 09:49:06 -0400
Received: by mail-qt0-f180.google.com with SMTP id n21so12789556qta.1
        for <ceph-devel@vger.kernel.org>; Wed, 29 Mar 2017 06:49:05 -0700 (PDT)
In-Reply-To: <CAN1NP8h0h8Vo-EpjbmWSYg_L3G3KpCGfFUPBMJ=Crno3CgUW6w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Forumulator V <forumulator@gmail.com>, ceph-devel@vger.kernel.org


On 03/29/2017 12:03 AM, Forumulator V wrote:
> Hi,
>
> I was going through the RGW code, and couldn't understand a few parts.
>
> i.) Where is zones and zonegroup information stored(on the backend)?
> Also do all RGW instances in a zone store objects on the same object
> storage cluster?

The multisite configuration (zone/zonegroup/period/realm) is stored as 
rados objects in the rgw.root pool (see RGW_DEFAULT_ZONE_ROOT_POOL and 
friends in rgw_rados.cc).

Generally, each zone will run in a separate ceph cluster. RGW instances 
within a zone will share the same storage.

But the zone itself contains the list of pool names used for its 
storage, so it's also possible to run multiple zones on the same ceph 
cluster without clobbering each others data - each zone will use 
separate pools by default.

> ii.) What do zones and zonegroups really correspond to? Are they like
> regions in S3?

It's a similar concept to regions, but mostly within the context of 
replication. The first draft of rgw multisite actually used the term 
'region' instead of zonegroup. You can think of a zonegroup as a 
replicated dataset - zones within a single zonegroup will replicate each 
others object data.

> iii.) Where are the users and their metadata stored? Is it also on the backend?
>

Following up on point ii., users and buckets are considered 'metadata' 
by rgw multisite, and are replicated across all zonegroups. Users are 
stored as rados objects across several of the zone's pools (see the 
RGWZoneParams::user_*_pool fields in rgw_rados.h).

> I'm sure the answers are there in the code, I understood some of it
> but not these parts.
>
> Thanks,
> Pranjal
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

I'm happy to answer more questions, if you have them. I also welcome 
suggestions for improving our existing documentation at 
http://docs.ceph.com/docs/master/radosgw/multisite/.

Casey
