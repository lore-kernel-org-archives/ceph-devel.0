From: Sage Weil <sage@newdream.net>
Subject: Re: FW: Ceph dmClock
Date: Tue, 1 Aug 2017 03:01:41 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1708010259440.20435@piezo.novalocal>
References: <116d5b63f1dc428998675dbe6e8c56eb@skt-tnetpmx1.SKT.AD> <e3321edabb3d42f2881c3e1ca30ad5b2@skt-tnetpmx1.SKT.AD> <CAKk8r1BnqHJt-EtP+9xBUE=oA8taO9ak+CdJk6BrjdhzHT3Ukw@mail.gmail.com> <d3e52b41-47b9-c660-1c96-6383609719ca@redhat.com>
 <CAKk8r1BadDo7KCVL0eA09TBxYLTXmtHLqzH=Tc6m8zZAVebFfw@mail.gmail.com> <CAKk8r1Dw1MACKhOUfyhzv5dQX5Ae+9S1B9T99qXUOGmQ4HyzWA@mail.gmail.com> <e2b99c22-ad7c-d0ae-6f9d-63c8d0322f20@redhat.com> <CAANLjFpyperAkB62s5G7bYMm2J8Z-SOu1S8imT2-QHq+AiVKaQ@mail.gmail.com>
 <CAKk8r1BH4FDBLgsVc5q8bmoWeiDXgUnaKNqNbBQCLyUWweFkrw@mail.gmail.com> <CANiZRW=NsZX45WieoLc6dPxiw5oSkGH2yM13aNqa42LobVniVA@mail.gmail.com> <CAKk8r1BFL+uaDEs7GeaybHHZLOfoka0T7Vs229tkGfZd5jjUnA@mail.gmail.com> <alpine.DEB.2.11.1703171420180.10776@piezo.novalocal>
 <CAKk8r1DF_LUVP=t1s8C5XsC1iOhu=yr7-LO8eKN6LP0QAs=14Q@mail.gmail.com> <CAKk8r1B6HM7HHQYcUWtFTjSFxOt7Ze9UvkEFhRG0xh-J8xiveQ@mail.gmail.com> <241e12a0-eb97-8957-f7e8-804ab447a492@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39043 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751725AbdHADBp (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 31 Jul 2017 23:01:45 -0400
In-Reply-To: <241e12a0-eb97-8957-f7e8-804ab447a492@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "J. Eric Ivancich" <ivancich@redhat.com>
Cc: Byung Su Park <pbs1108@gmail.com>, Mark Nelson <mnelson@redhat.com>, =?EUC-KR?B?udq6tLz2?= <bspark8@sk.com>, =?EUC-KR?Q?=B1=E8=C5=C2=BF=F5=2FSDS_Tech=2E_Lab?= <taewoong.kim@sk.com>, =?EUC-KR?Q?=BE=F6=C1=D6=B0=FC=2FSDS_Tech=2E_Lab?= <jugwan.eom@sk.com>, Matt Benjamin <mbenjamin@redhat.com>, Josh Durgin <jdurgin@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

> On 07/31/2017 09:39 AM, Byung Su Park wrote:
> >   - When using BlueStore Adaptive Throttle, about 57% reduction from
> > original performance is required to achieve 1:1:10:10:10 weight.
...
> >   - When using OIO Adaptive Throttle, about 80% reduction from original
> > performance is required to achieve 1:1:10:10:10 weight.
...
> >   - When OIO Adaptive Throttle is used, it almost guarantees a reserve
> > of 40K and 30K of target value with 89% reduction in original performance.

When you say 57% reduction, do you mean performance goes from (say) 1000 
IOPS to 430 IOPS, or that you get 57% of the peak performance (1000 IOPS 
-> 570 IOPS)?

Because if it's the former 80% reduction (i.e., 20%) sounds bad.  But I'm 
guessing you mean you get 80% of the original performance?

Thanks!
sage
