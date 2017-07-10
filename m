From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: peering process
Date: Mon, 10 Jul 2017 18:07:12 +1000
Message-ID: <CAF-wwdGLL4f7YeH4cqGyvq-+gtJJgdpNBGfWmQh-M-N7mg-epQ@mail.gmail.com>
References: <CAB7xdikjRLknjy5pac08zUbcN=r8N0+cJ4ZOL3tPMZkNSiiYLA@mail.gmail.com>
 <CAJ4mKGaepvKs9SMZv+G=soSL44sS_KdZkWt-+P0KypObqcNH2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:34501 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753435AbdGJIHU (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Jul 2017 04:07:20 -0400
Received: by mail-pf0-f170.google.com with SMTP id q85so46068358pfq.1
        for <ceph-devel@vger.kernel.org>; Mon, 10 Jul 2017 01:07:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJ4mKGaepvKs9SMZv+G=soSL44sS_KdZkWt-+P0KypObqcNH2g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: sheng qiu <herbert1984106@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>



On Sat, Jul 8, 2017 at 6:15 AM, Gregory Farnum <gfarnum@redhat.com> wrote:
> On Fri, Jun 30, 2017 at 3:25 PM, sheng qiu <herbert1984106@gmail.com> wrote:
>> Hi,
>>
>> We are trying to reduce the peering processing latency, since it may
>> block front io.
>>
>> in our experiment, we kill certain osd and bring it back after a very
>> short time. We checked performance counters as below:
>>
>>  "peering_latency": {
>>
>>             "avgcount": 52,
>>
>>             "sum": 52.435308773,
>>
>>             "avglat": 1008.371323
>>
>>         },
>>
>>      "getinfo_latency": {
>>
>>             "avgcount": 52,
>>
>>             "sum": 3.525831625,
>>
>>             "avglat": 67.804454
>>
>>         },
>>
>>         "getlog_latency": {
>>
>>             "avgcount": 46,
>>
>>             "sum": 0.255325943,
>>
>>             "avglat": 5.550564
>>
>>         },
>>
>>  "getmissing_latency": {
>>
>>             "avgcount": 46,
>>
>>             "sum": 0.000877735,
>>
>>             "avglat": 0.019081
>>
>>         },
>>
>>         "waitupthru_latency": {
>>
>>             "avgcount": 46,
>>
>>             "sum": 48.652836368,
>>
>>             "avglat": 1057.670356
>>
>>         }
>>
>> as shown, average peering latency is 1008ms, most of them are consumed
>> by "waitupthru_latency".  By looking at the codes, i am not quite
>> understand this part. Can anyone explain this part especially why it
>> takes such long time in this stage?
>
> I think it's described in documentation somewhere, but in brief:
> 1) In order to go active, an OSD must talk to *all* previous OSDs
> which might have modified the PG in question.
> 2) That means it has to go talk to everybody who owned it for an OSDMap interval
> 3) ...except that could be pointlessly expensive if the cluster was
> thrashing or something and the OSDs weren't actually running during
> that epoch.
> 4) So we introduce an "up_thru" mapping from OSD->epoch of the OSDMap,
> which tracks when an OSD was alive.
> 5) And before we can go active with a PG, we have to have committed
> (to the OSDMap, via monitors) that we were up_thru during an interval
> where we own it.
> 5) Then, subsequent OSDs can do some comparisons between old OSDMaps
> and the PG mappings to figure out if an OSD *might* have gone active
> with the PG.
>
> So that waitupthru_latency is measuring how much time the OSD has to
> spend waiting to get a sufficiently-new up_thru value to actually go
> active on the PG. It's not a measure of local work.
>
>
>>
>> I also noticed there's some description regarding "fast peering" on
>> http://tracker.ceph.com/projects/ceph/wiki/Osd_-_Faster_Peering
>>
>> is this still ongoing or stale?
>
> I don't think any serious work was done on it, no.

Before Sam left we looked into whether it was feasible to retain peer_{info,
missing} when the interval changed to try and avoid the getlog/getmissing steps.
It's not clear to me this is the same work as that URL since it mentions
"preemptively requesting" the log+missing which was not discussed as far as I
remember. Shortly before Sam left we determined that it was only feasible to
retain peer_info and peer_missing if the OSD determines it is still primary and
did not go active in the last interval. Due to this limitation the work was
given a much lower priority but I hope to revisit it soon anyway. We did not
really discuss waitupthru_latency.

> -Greg
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Cheers,
Brad
