From: David Butterfield <dab21774@gmail.com>
Subject: Re: global backfill reservation?
Date: Tue, 16 May 2017 01:21:30 -0600
Message-ID: <CALiN7rynLdFkYV+VmnmqOy8_8ghvLDSwNfXQfTkugw3C60iheA@mail.gmail.com>
References: <alpine.DEB.2.11.1705112237290.18953@piezo.novalocal>
 <99194e05-6bb9-29db-a85b-bf13da36fcf4@brockmann-consult.de> <CAJ4mKGag26AdYAOU_A96tRKvSqjNt2NpA2nbeZN+xBXL+rw-iQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f179.google.com ([209.85.217.179]:36729 "EHLO
        mail-ua0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751338AbdEPHVc (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 16 May 2017 03:21:32 -0400
Received: by mail-ua0-f179.google.com with SMTP id j17so94009257uag.3
        for <ceph-devel@vger.kernel.org>; Tue, 16 May 2017 00:21:32 -0700 (PDT)
In-Reply-To: <CAJ4mKGag26AdYAOU_A96tRKvSqjNt2NpA2nbeZN+xBXL+rw-iQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Peter Maloney <peter.maloney@brockmann-consult.de>, Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, May 15, 2017 at 4:02 PM, Gregory Farnum <gfarnum@redhat.com> wrote:
> On Fri, May 12, 2017 at 1:49 PM, Peter Maloney wrote:
>> I think the biggest problem is not how many OSDs are busy, but that any
>> single osd is overloaded long enough for a human user to call it laggy
>> (eg. "ls" takes 5s because of blocked requests). A setting to say you
>> want all osds 30% busy would be better than saying you want 30% of your
>> osds overloaded and 70% idle (where another word for idle is wasted).
>
> That said, global backfill scheduling has other uses (...and might be
> faster to implement than proper prioritization). It lets us restrict
> network bandwidth devoted to backfill, not just local disk ops.

I worked on the performance of resynchronization (after node recovery)
and restripe (after node add/remove) of a distributed SAN that already
had an adjustable bandwidth limit when I started on it (leaky bucket
sort of thing).  It limited bandwidth, but the restripe after adding a new
node could take a week (it was cruder with its fixed geometry than
newer techniques).

I found it worked better to disable the bandwidth limiter and instead
control the resync load by adjusting the number of network I/O ops
a recovering node will issue and have outstanding to other nodes for
resync I/O at any given time.  Queue Depths like 2 or 3 or 4 finished
sooner and with less impact on client I/O than using the B/W limiter.

It still wasn't wonderful, but it was better, so it might be an approach
to consider.  Note that in this system all nodes would do recovery
concurrently.  The QD limit can be set independently by each node
without resort to a central or distributed algorithm.  If necessary each
node could dynamically control its own pull rate by adjusting its
recovery QD based on its current load or whatever.
