From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Fw:Re:Re:Re: Question about write op processing of OSD
Date: Tue, 3 Jan 2017 15:30:16 -0800
Message-ID: <CAJ4mKGZ=MzK84QGkzMntRLmy_WSHkNeqOPOq3kEcMCAVxNxnWg@mail.gmail.com>
References: <56ec2444.5ac4.15905e49671.Coremail.xxhdx1985126@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f42.google.com ([209.85.214.42]:38311 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759330AbdACXaR (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Jan 2017 18:30:17 -0500
Received: by mail-it0-f42.google.com with SMTP id x2so309739200itf.1
        for <ceph-devel@vger.kernel.org>; Tue, 03 Jan 2017 15:30:17 -0800 (PST)
In-Reply-To: <56ec2444.5ac4.15905e49671.Coremail.xxhdx1985126@163.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: xxhdx1985126 <xxhdx1985126@163.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Dec 15, 2016 at 8:29 PM, xxhdx1985126 <xxhdx1985126@163.com> wrote:
>
> Sorry, I correct my question.
>
> I read the "already_complete" method. It returns true if it all op ealier than M is "all_committed" in repop_queue, so in our scenario, it will always return true, since OSD.X was not acting primary of the target pg. Then, what if when the resubmitted M arrives when the previous M has not been committed? If we ack the client not considering if the req has already been committed, wouldn't there be a possibility that things go wrong? For example, what if after OSD.X ack the client, the actual commit of M fails?
>
> Thank you:-)

You'll need to be more specific about what pieces you're looking at. I
don't think anything referencing OSD operation IDs will always return
true just because OSD.X wasn't acting primary in a previous interval,
for instance, but I dunno which bits you're referring to. In general
during the peering process the OSDs will agree on which set of
operations were logically "completed" (regardless of local state) and
either throw out everything outside that set or else block any
subsequent operations until it can see their results.
-Greg

>
>
>
> At 2016-12-16 10:09:56, "xxhdx1985126" <xxhdx1985126@163.com> wrote:
>>
>>Thanks for the quick reply:-)
>>
>>Is it possible that the client resubmit M after the new "Peering" process completes but before the processing of M is completed on OSD.X? I'm asking this because as far as I understand, if the "dup" req is not already completed, the OSD will put it in the "waitingg_for_ondisk" and "waiting_for_ack" queue which are only accessed when the previous repop completes "commit" and "apply" process and are not accessed in this scenario since there is no such "previous repop".
>>
>>Thanks:-)
>>
>>At 2016-12-16 08:35:15, "Gregory Farnum" <gfarnum@redhat.com> wrote:
>>>On Thu, Dec 15, 2016 at 4:17 PM, xxhdx1985126 <xxhdx1985126@163.com> wrote:
>>>>
>>>> Hi, everyone.
>>>>
>>>>
>>>> What will the OSD do in the following scenario?
>>>>
>>>>        Say, a MOSDRepop M that is initiated at client A is being processed on an OSD.X, during which the acting primary turn "down" due to some error and OSD.X is chosen to be the new acting primary. Since OSD.X is a replica OSD for MOSDRepOp M, how can client A be acked after OSD.X finished the processing of M? Or does A be acked at all in this kind of circumstances?
>>>
>>>The client is not acked by OSD.X, but when the client sees the OSDMap
>>>marking down the previous primary, it will resubmit MOSDOpM to OSD.X
>>>(and increment the retry counter). OSD.X will notice that MOSDOpM has
>>>already been completed and reply with the same answer it gave
>>>previously.[1]
>>>-Greg
>>>[1]: Barring protocol or implementation bugs. There have historically
>>>been some issues with things like (successful) deletes returning
>>>ENOENT instead of 0; I don't remember if all the known ones have been
>>>squashed or not.
