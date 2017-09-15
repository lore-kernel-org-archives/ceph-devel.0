From: Two Spirit <twospirit6905@gmail.com>
Subject: Re: Geographic disperse Ceph
Date: Fri, 15 Sep 2017 10:52:14 -0700
Message-ID: <CAKRxput5TJtj5PJ=us2mmdJZE26mUEyQSpNx_9N7wrc1d27ZcA@mail.gmail.com>
References: <CAKRxpuvCRxMGgdaPJP4n_oOF1EiCpzSd5OfEuj43Lh=v6jCPDw@mail.gmail.com>
 <alpine.DEB.2.11.1709151729200.16664@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:46884 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751184AbdIORwQ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Sep 2017 13:52:16 -0400
Received: by mail-it0-f49.google.com with SMTP id 6so3542586itl.1
        for <ceph-devel@vger.kernel.org>; Fri, 15 Sep 2017 10:52:15 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1709151729200.16664@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

>Probably aim for 2 or 3 mons per site, unless you have a lot of
sites.

that would initial phase put me at 10-15 mons for a minimum config
with very little room to grow -- too close to 21 for comfort. Would
the sites be one unified ceph cluster? or is this independent clusters
federated together? Currently torrents do this very well, but would
like parallel transfers from multi site to multi site in the file
system.

>...but from this it sounds like RGW federation might be sufficient for
>your purposes.  Separate ceph clusters at each site, with a shared RGW (S3
>API) namespace.  You can set up zones and zongroups to replicate data
>across sites asynchronously.

Thanks. good info. more to look into.

On Fri, Sep 15, 2017 at 10:33 AM, Sage Weil <sweil@redhat.com> wrote:
> On Fri, 15 Sep 2017, Two Spirit wrote:
>> >> I have a requirement to run multiple geographically diverse locations
>> >> through "slow" wan links and evaluating if Ceph would be right for
>> >> that or how that is best handled with Ceph.
>> >
>> >It can be done but you ned ot be careful.  Anyway, dicuss it on
>> >ceph-develso others can benefit please!
>>
>>
>> Hi Sage, "careful" and "can be done" are the words I'm interested in.
>>
>> can you shed some light here. I've got to deal with multiple sites
>> that are spread across geographic locations via "slow" link WANs. I
>> originally thought ceph was designed to handle this, but now have
>> concerns due to the limited MONs. They would become points of failures
>> if I had too few, and it doesn't sound like Ceph supports a lot of
>> MONs.
>
> We test up to 21 or something, but I wouldn't deploy more than 7 or 9 in
> practice.  Probably aim for 2 or 3 mons per site, unless you have a lot of
> sites.
>
> Careful means enough mons, and making sure the links are reliable enough
> to stretch a rados cluster across it.  You also need to be careful that
> your CRUSH rules are set up to replicate across sites (if that's what you
> want), and that your workload tolerates the latencies involved.
>
>> Here is an overview of some of the stuff. I've got a couple new
>> campuses that are in the process of being built. I think 2-5 buildings
>> each campus. I've also got remote sites that are limited to satellite
>> WAN connections which has significantly less bandwidth and one site
>> that has significantly large volumes of data that need multiple high
>> speed WANs links. I'm currently exchanging larger data sets using
>> trucknet (FedEx) and for the managers that are regularly travelmulti
>> sites who need full access to all their data at whichever site they
>> are at as well as dealing with an acquisition(another topic). The data
>> location is prioritized to the geographic region the data is
>> originated with replicas going outward to the remote regions.
>> Originally someone set this to replicate in a round robin fashion, but
>> that had problems. The multi site projects I have to pick a master. I
>> currently manage this through large link graphs to keep everything
>> straight, and unison/rsync/torrent, but I'd be glad when the file
>> system will do more of this. Add more metal, connect them together,
>> and everything should be done.
>
> ...but from this it sounds like RGW federation might be sufficient for
> your purposes.  Separate ceph clusters at each site, with a shared RGW (S3
> API) namespace.  You can set up zones and zongroups to replicate data
> across sites asynchronously.
>
> sage
>
>>
>> I think I need absolutely minimum 2-3 mons per cluster of computers,
>> for failure redundancy and each site would need a minimum of 2-3 MONs.
>> I'd like way more MONs than 3. And with one region being expanded to
>> multiple campus, I think each campus needs 3 mons. It sounds like ceph
>> is not a wide area distributed parallel file system, but more 3
>> independent local ceph clusters -- one per region. And as one region
>> is expanding to multiple campus, each campus needs their own
>> independent cluster. Maybe I'll find the solution using CRUSH, but
>> there is still the problem of maximum number of MONs and the split
>> brain condition is high concern. I've run across split brain, and
>> every time it happens, I have procedures and tools to deal with it,
>> but there is a data mess initially. As data gets larger, diff
>> comparison of full sets is more difficult and need to move to a
>> journal approach.
>>
>> I'm thinking a tiered MON approach is necessary. focusing on building,
>> campus, and wan with different priorities to converge. And possibly
>> another with acquisitions where non technical political boundaries
>> exist.
>>
>> Can you talk about the which aspects need to be "careful".
>>
>>
