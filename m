From: kefu chai <tchaikov@gmail.com>
Subject: Re: adding "{mds,mon} metadata" asok command
Date: Sat, 21 Mar 2015 00:04:25 +0800
Message-ID: <CAJE9aOPcHS4nfbQ-QqLCHNmSO4MYn_4uBTmt=FWNgZ=ybp0F7A@mail.gmail.com>
References: <CAJE9aOP2g4=Pw-oGY4m90aXayc=Kx_GP8yLC+tTkSE62V6ObuQ@mail.gmail.com>
	<alpine.DEB.2.00.1503200628150.7043@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:37521 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750990AbbCTQE0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Mar 2015 12:04:26 -0400
Received: by igcqo1 with SMTP id qo1so22118328igc.0
        for <ceph-devel@vger.kernel.org>; Fri, 20 Mar 2015 09:04:25 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1503200628150.7043@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Mar 20, 2015 at 9:30 PM, Sage Weil <sage@newdream.net> wrote:
> On Fri, 20 Mar 2015, kefu chai wrote:
>> on the mon side, i will apply the same approach to MMonJoin and
>> MonmapMonitor, but with another prefix when putting encoding metadata
>> into transaction.
>
> The MMonJoin is only used when expanding the cluster, i.e. when first
> adding the new monitor during cluster configuration time.
>
>> @joao, IIRC, you were suggesting me to add another paxos service for
>> this purpose but is it feasible to put this data into MMonJoin and
>> persist it into the paxos service's storage?
>>
>> any suggestion or comments would be appreciated. if no objections, i
>> will be on it.
>
> Instead, I suggest having each mon generate the metadata during startup.
> Then, somewhere during bootstrap(), compare the stored metadata (they all
> have a copy of the mon data set) with the actual metadata, and if it
> varies send a new message (MMonUpdateMetadata?) to the leader requesting a
> change.

thanks sage =) will go this way once i have joao's blessing.

>
> Joao, what do you think?
>
> sage
>



-- 
Regards
Kefu Chai
