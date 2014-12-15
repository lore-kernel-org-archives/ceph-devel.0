From: Pavan Rallabhandi <Pavan.Rallabhandi@sandisk.com>
Subject: RE: Improving latency and ordering of the backfilling workload
Date: Mon, 15 Dec 2014 17:01:43 +0000
Message-ID: <68A06213B74F1742A2C48216AE1BB6B807D09A41@SACMBXIP01.sdcorp.global.sandisk.com>
References: <548EEF2C.1010703@dachary.org>
 <alpine.DEB.2.00.1412150841220.5263@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2on0079.outbound.protection.outlook.com ([65.55.169.79]:53914
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750712AbaLORfm convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Dec 2014 12:35:42 -0500
In-Reply-To: <alpine.DEB.2.00.1412150841220.5263@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Loic Dachary <loic@dachary.org>
Cc: Samuel Just <sam.just@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>



-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Sage Weil
Sent: Monday, December 15, 2014 10:15 PM
To: Loic Dachary
Cc: Samuel Just; Ceph Development
Subject: Re: Improving latency and ordering of the backfilling workload

On Mon, 15 Dec 2014, Loic Dachary wrote:
> Hi Sam,
>
> Here is what could be done (in the context of
> http://tracker.ceph.com/issues/9566
> ), please let me know if that makes sense:
>
> * ordering:
>
>   * when dequeuing a pending local reservation, chose one that
> contains a PG that belongs to the busiest OSD (i.e. the OSD for which
> there are more PGs waiting for a local reservation than any other)

I'm worried the reservation count won't be an accurate enough proxy for the amount of work the remote OSD has to do.  It would be very easy to piggyback some load information on the heartbeat messages which we should already be exchanging with anyone we would backfill with.

If we go down that path, there are a bunch of patches in the wip-read-hole series that lay useful groundwork.  Getting that branch into shape is the next big item after I finish the current batch of pull requests.

>   * when sending a remote reservation request, set the priority to
> reflect the total number of pending PG (absolute workload) and the
> number local pending PG for the destination OSD (workload queued
> locally for the remote OSD)
>   * on the receiving side, the priority of the remote reservation
> request makes sure the busiest OSD gets a remote reservation before
> the others
>
> * reducing latency:
>
>   * if there are N pending remote reservations, reject a remote
> reservation request instead of queuing it so that the local
> reservation can be used instead of waiting.
>
> Cheers
>
> --
> Lo?c Dachary, Artisan Logiciel Libre
>
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html

________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

