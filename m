From: Wido den Hollander <wido@42on.com>
Subject: Re: auto stop of scrubbing and deep scrubbing while backfilling or
 recovering
Date: Tue, 8 Nov 2016 12:35:45 +0100 (CET)
Message-ID: <1789831527.1558.1478604945320@ox.pcextreme.nl>
References: <bcfd3f34-dcd2-9d6d-52ef-1d39e9f54593@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.139]:40571 "EHLO
        smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932675AbcKHLft (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Nov 2016 06:35:49 -0500
In-Reply-To: <bcfd3f34-dcd2-9d6d-52ef-1d39e9f54593@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>, ceph-devel@vger.kernel.org


> Op 8 november 2016 om 9:35 schreef Stefan Priebe - Profihost AG <s.priebe@profihost.ag>:
> 
> 
> Hello,
> 
> i'm wondering if anybody has already thought about automatically
> stopping srub and deep-scrub in case of backfilling or recovering. I've
> seen several situations where scrubbing massivly raises the latency
> while doing backfilling or recovering.
> 

Seems like a sane change to me, but maybe a dev has a better option. I don't think a stop is easy, but a 'noscrub' flag could be set inside the OSD.

Maybe a config option: osd_scrub_during_recovery

Defaults to true, but can be set to false by the admin.

Before a scrub starts the OSD will check if there is recovery / backfilling active on the OSD and if so it will not initiate the scrub.

Wido

> Greets,
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
