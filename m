From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: peering process
Date: Fri, 7 Jul 2017 13:15:26 -0700
Message-ID: <CAJ4mKGaepvKs9SMZv+G=soSL44sS_KdZkWt-+P0KypObqcNH2g@mail.gmail.com>
References: <CAB7xdikjRLknjy5pac08zUbcN=r8N0+cJ4ZOL3tPMZkNSiiYLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:37762 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751034AbdGGUP2 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Jul 2017 16:15:28 -0400
Received: by mail-it0-f41.google.com with SMTP id m84so2878963ita.0
        for <ceph-devel@vger.kernel.org>; Fri, 07 Jul 2017 13:15:28 -0700 (PDT)
In-Reply-To: <CAB7xdikjRLknjy5pac08zUbcN=r8N0+cJ4ZOL3tPMZkNSiiYLA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sheng qiu <herbert1984106@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Jun 30, 2017 at 3:25 PM, sheng qiu <herbert1984106@gmail.com> wrote:
> Hi,
>
> We are trying to reduce the peering processing latency, since it may
> block front io.
>
> in our experiment, we kill certain osd and bring it back after a very
> short time. We checked performance counters as below:
>
>  "peering_latency": {
>
>             "avgcount": 52,
>
>             "sum": 52.435308773,
>
>             "avglat": 1008.371323
>
>         },
>
>      "getinfo_latency": {
>
>             "avgcount": 52,
>
>             "sum": 3.525831625,
>
>             "avglat": 67.804454
>
>         },
>
>         "getlog_latency": {
>
>             "avgcount": 46,
>
>             "sum": 0.255325943,
>
>             "avglat": 5.550564
>
>         },
>
>  "getmissing_latency": {
>
>             "avgcount": 46,
>
>             "sum": 0.000877735,
>
>             "avglat": 0.019081
>
>         },
>
>         "waitupthru_latency": {
>
>             "avgcount": 46,
>
>             "sum": 48.652836368,
>
>             "avglat": 1057.670356
>
>         }
>
> as shown, average peering latency is 1008ms, most of them are consumed
> by "waitupthru_latency".  By looking at the codes, i am not quite
> understand this part. Can anyone explain this part especially why it
> takes such long time in this stage?

I think it's described in documentation somewhere, but in brief:
1) In order to go active, an OSD must talk to *all* previous OSDs
which might have modified the PG in question.
2) That means it has to go talk to everybody who owned it for an OSDMap interval
3) ...except that could be pointlessly expensive if the cluster was
thrashing or something and the OSDs weren't actually running during
that epoch.
4) So we introduce an "up_thru" mapping from OSD->epoch of the OSDMap,
which tracks when an OSD was alive.
5) And before we can go active with a PG, we have to have committed
(to the OSDMap, via monitors) that we were up_thru during an interval
where we own it.
5) Then, subsequent OSDs can do some comparisons between old OSDMaps
and the PG mappings to figure out if an OSD *might* have gone active
with the PG.

So that waitupthru_latency is measuring how much time the OSD has to
spend waiting to get a sufficiently-new up_thru value to actually go
active on the PG. It's not a measure of local work.


>
> I also noticed there's some description regarding "fast peering" on
> http://tracker.ceph.com/projects/ceph/wiki/Osd_-_Faster_Peering
>
> is this still ongoing or stale?

I don't think any serious work was done on it, no.
-Greg
