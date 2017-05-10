From: Loic Dachary <loic@dachary.org>
Subject: Re: crush problem in EC environment
Date: Wed, 10 May 2017 14:37:34 +0200
Message-ID: <9e788f9f-cdfa-be00-c2a6-d1dffefaaa97@dachary.org>
References: <CALi+v19s-0XZpteLX_6_HNjUTzsKLiFbvtaZFkjjm80yuuUk=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:40912 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751955AbdEJMhi (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 10 May 2017 08:37:38 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by relay7-d.mail.gandi.net (Postfix) with ESMTPS id 346831155
        for <ceph-devel@vger.kernel.org>; Wed, 10 May 2017 14:37:37 +0200 (CEST)
In-Reply-To: <CALi+v19s-0XZpteLX_6_HNjUTzsKLiFbvtaZFkjjm80yuuUk=Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: zengran zhang <z13121369189@gmail.com>, ceph-devel@vger.kernel.org

Hi,

On 05/10/2017 12:29 PM, zengran zhang wrote:
> hi cephers:
>     recently,we found some pgs incomplete in our bluestore+ec
> overwrite environment, we think it
> is because the pg's acting set size below the min_size when some osd
> failure out. we wonder know how to reslove the crush problem in EC
> environment. thanks!
> 
> PG_STAT OBJECTS MISSING_ON_PRIMARY DEGRADED MISPLACED UNFOUND BYTES
> LOG  DISK_LOG STATE      STATE_STAMP                VERSION   REPORTED
> UP                      UP_PRIMARY ACTING
> ACTING_PRIMARY LAST_SCRUB SCRUB_STAMP                LAST_DEEP_SCRUB
> DEEP_SCRUB_STAMP
> 4.4c          0                  0        0         0       0     0
> 0        0 incomplete 2017-05-10 15:51:16.592083       0'0    966:3
> [2147483647,6,8,2147483647,1,9]          5
> [2147483647,6,8,2147483647,1,9]              5   829'6744 2017-05-10
> 04:50:07.114874        725'4190 2017-05-06 05:47:25.286826
> 4.67          0                  0        0         0       0     0
> 3000     3000 incomplete 2017-05-10 15:51:16.512486  831'5439    966:4
>  [6,2147483647,2147483647,5,8,4]          6
> [6,2147483647,2147483647,5,8,4]              6   825'5292 2017-05-09
> 16:53:26.029346        696'5082 2017-05-04 00:28:50.459986
> 

It is indeed likely because there are not enough OSDs or hosts (depending on the crush rule you're using) to provide the required (6) OSDs for each PG.

Cheers

> regards!
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Loïc Dachary, Artisan Logiciel Libre
