From: Two Spirit <twospirit6905@gmail.com>
Subject: Geographic disperse Ceph
Date: Fri, 15 Sep 2017 10:00:49 -0700
Message-ID: <CAKRxpuvCRxMGgdaPJP4n_oOF1EiCpzSd5OfEuj43Lh=v6jCPDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f48.google.com ([209.85.214.48]:57146 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750865AbdIORAw (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Sep 2017 13:00:52 -0400
Received: by mail-it0-f48.google.com with SMTP id g18so4187628itg.5
        for <ceph-devel@vger.kernel.org>; Fri, 15 Sep 2017 10:00:52 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

>> I have a requirement to run multiple geographically diverse locations
>> through "slow" wan links and evaluating if Ceph would be right for
>> that or how that is best handled with Ceph.
>
>It can be done but you ned ot be careful.  Anyway, dicuss it on
>ceph-develso others can benefit please!


Hi Sage, "careful" and "can be done" are the words I'm interested in.

can you shed some light here. I've got to deal with multiple sites
that are spread across geographic locations via "slow" link WANs. I
originally thought ceph was designed to handle this, but now have
concerns due to the limited MONs. They would become points of failures
if I had too few, and it doesn't sound like Ceph supports a lot of
MONs.

Here is an overview of some of the stuff. I've got a couple new
campuses that are in the process of being built. I think 2-5 buildings
each campus. I've also got remote sites that are limited to satellite
WAN connections which has significantly less bandwidth and one site
that has significantly large volumes of data that need multiple high
speed WANs links. I'm currently exchanging larger data sets using
trucknet (FedEx) and for the managers that are regularly travelmulti
sites who need full access to all their data at whichever site they
are at as well as dealing with an acquisition(another topic). The data
location is prioritized to the geographic region the data is
originated with replicas going outward to the remote regions.
Originally someone set this to replicate in a round robin fashion, but
that had problems. The multi site projects I have to pick a master. I
currently manage this through large link graphs to keep everything
straight, and unison/rsync/torrent, but I'd be glad when the file
system will do more of this. Add more metal, connect them together,
and everything should be done.

I think I need absolutely minimum 2-3 mons per cluster of computers,
for failure redundancy and each site would need a minimum of 2-3 MONs.
I'd like way more MONs than 3. And with one region being expanded to
multiple campus, I think each campus needs 3 mons. It sounds like ceph
is not a wide area distributed parallel file system, but more 3
independent local ceph clusters -- one per region. And as one region
is expanding to multiple campus, each campus needs their own
independent cluster. Maybe I'll find the solution using CRUSH, but
there is still the problem of maximum number of MONs and the split
brain condition is high concern. I've run across split brain, and
every time it happens, I have procedures and tools to deal with it,
but there is a data mess initially. As data gets larger, diff
comparison of full sets is more difficult and need to move to a
journal approach.

I'm thinking a tiered MON approach is necessary. focusing on building,
campus, and wan with different priorities to converge. And possibly
another with acquisitions where non technical political boundaries
exist.

Can you talk about the which aspects need to be "careful".
