From: Wido den Hollander <wido@42on.com>
Subject: Re: full_ratios - please explain?
Date: Wed, 18 Feb 2015 16:05:55 +0100
Message-ID: <54E4AA53.2020900@42on.com>
References: <CAGbvivJ89toPvbO8XOQ8ru_BDQJbJfZvbj2NhxFk1G5K=d-3Zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:47602 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752033AbbBRPF6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 18 Feb 2015 10:05:58 -0500
In-Reply-To: <CAGbvivJ89toPvbO8XOQ8ru_BDQJbJfZvbj2NhxFk1G5K=d-3Zw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>, ceph-devel@vger.kernel.org

On 18-02-15 15:39, Wyllys Ingersoll wrote:
> Can someone explain the interaction and effects of all of these
> "full_ratio" parameters?  I havent found any real good explanation of how
> they affect the distribution of data once the cluster gets above the
> "nearfull" and close to the "close" ratios.
> 

When only ONE (1) OSD goes over the mon_osd_nearfull_ratio the cluster
goes from HEALTH_OK into HEALTH_WARN state.

> 
> mon_osd_full_ratio
> mon_osd_nearfull_ratio
> 
> osd_backfill_full_ratio
> osd_failsafe_full_ratio
> osd_failsafe_nearfull_ratio
> 
> We have a cluster with about 144 OSDs (518 TB) and trying to get it to a
> 90% full rate for testing purposes.
> 
> We've found that when some of the OSDs get above the mon_osd_full_ratio
> value (.95 in our system), then it stops accepting any new data, even
> though there is plenty of space left on other OSDs that are not yet even up
> to 90%.  Tweaking the osd_failsafe ratios enabled data to move again for a
> bit, but eventually it becomes unbalanced and stops working again.
> 

Yes, that is because with Ceph safety goes first. When only one OSD goes
over the full ratio the whole cluster stops I/O.

CRUSH does not take OSD utilization into account when placing data, so
it's almost impossible to predict which I/O can continue.

Data safety and integrity is priority number 1. Full disks are a danger
to those priorities, so I/O is stopped.

> Is there a recommended combination of values to use that will allow the
> cluster to continue accepting data and rebalancing correctly above 90%.
> 

No, not with those values. Monitor your filesystems that they stay below
those values. If one OSD becomes to full you can weigh it down using
CRUSH to have some data move away from it.

> thanks,
>  Wyllys Ingersoll
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
