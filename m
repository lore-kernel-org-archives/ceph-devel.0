From: Joao Eduardo Luis <jecluis@gmail.com>
Subject: Re: adding "{mds,mon} metadata" asok command
Date: Mon, 23 Mar 2015 10:04:43 +0000
Message-ID: <550FE53B.9050407@gmail.com>
References: <CAJE9aOP2g4=Pw-oGY4m90aXayc=Kx_GP8yLC+tTkSE62V6ObuQ@mail.gmail.com> <alpine.DEB.2.00.1503200628150.7043@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:34871 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752138AbbCWKEn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Mar 2015 06:04:43 -0400
Received: by wibdy8 with SMTP id dy8so42715560wib.0
        for <ceph-devel@vger.kernel.org>; Mon, 23 Mar 2015 03:04:42 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1503200628150.7043@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, kefu chai <tchaikov@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Sorry for the latency.

On 03/20/2015 01:30 PM, Sage Weil wrote:
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

I agree.  And I don't think we need a new service for this, and I also 
don't think we need to write stuff to the store.  We can generate this 
information when the monitor hits 'bootstrap()' and share it with the 
rest of the quorum once an election finishes, and always keep it in 
memory (unless there's some information that needs to be persisted, but 
I was under the impression that was not the case).

This, btw, is what mon/DataHealthService.cc does, but you should be able 
to avoid stuffing this into a service or creating a new service.  The 
timecheck stuff in the monitor also works a bit like this -- take a look 
at those if you need a guideline.

Cheers!

   -Joao

>
> Joao, what do you think?
>
> sage
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Joao Eduardo Luis | github.com/jecluis
