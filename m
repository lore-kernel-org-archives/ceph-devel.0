From: Peter Maloney <peter.maloney@brockmann-consult.de>
Subject: Re: another scrub bug? blocked for > 10240.948831 secs
Date: Fri, 28 Apr 2017 09:24:38 +0200
Message-ID: <27bfebcd-6a91-bd00-82c5-e56af6775d52@brockmann-consult.de>
References: <94127293-3ba3-8bb8-db43-604b6a54eb55@brockmann-consult.de>
 <alpine.DEB.2.11.1704171316150.10661@piezo.novalocal>
 <456cafe7-ecaa-5c62-ca82-6c09a2b06ae7@brockmann-consult.de>
 <alpine.DEB.2.11.1704201421120.6575@piezo.novalocal>
 <d0b1c505-8ccd-dfbf-2dd8-c44fc3f7b96e@brockmann-consult.de>
 <alpine.DEB.2.11.1704201617120.6575@piezo.novalocal>
 <b8e72ba6-919b-e9f2-9fd3-577cb7ab6389@brockmann-consult.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.74]:60810 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756057AbdD1HXv (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Apr 2017 03:23:51 -0400
In-Reply-To: <b8e72ba6-919b-e9f2-9fd3-577cb7ab6389@brockmann-consult.de>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 04/20/17 20:58, Peter Maloney wrote:
> On 04/20/17 18:19, Sage Weil wrote:
>>  but I guess the 
>> underlying first question is whether any snap deletion happened anywhere 
>> around this period (2560+ sec before the warning, or around the time the 
>> op was sent in epoch 83264).  
> A snapshot based backup thing ran at 12:00 CEST and took until 18:25
> CEST to finish, which overlaps that, and creates and removes 120
> snapshots spread throughout the process.
>> (And yeah, removed_snaps is the field that 
>> matters here!)
>>
>> Thanks!
>> sage
This still happens in 10.2.7

> 2017-04-28 04:41:59.343443 osd.9 10.3.0.132:6808/2704 18 : cluster
> [WRN] slow request 10.040822 seconds old, received at 2017-04-28
> 04:41:49.302552: replica scrub(pg:
> 4.145,from:0'0,to:93267'6832180,epoch:93267,start:4:a2d2c99e:::rbd_data.4bf687238e1f29.000000000000f7a3:0,end:4:a2d2dcd6:::rbd_data.46820b238e1f29.000000000000bfbc:f25e,chunky:1,deep:0,seed:4294967295,version:6)
> currently reached_pg
> ...
> 2017-04-28 06:07:09.975902 osd.9 10.3.0.132:6808/2704 36 : cluster
> [WRN] slow request 5120.673291 seconds old, received at 2017-04-28
> 04:41:49.302552: replica scrub(pg: 4.145,from:0'0,to:93
> 267'6832180,epoch:93267,start:4:a2d2c99e:::rbd_data.4bf687238e1f29.000000000000f7a3:0,end:4:a2d2dcd6:::rbd_data.46820b238e1f29.000000000000bfbc:f25e,chunky:1,deep:0,seed:4294967295,version:
and there are snaps created and removed around that time.
