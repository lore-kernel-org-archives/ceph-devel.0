From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: SimpleMessenger dispatching: cause of performance problems?
Date: Thu, 16 Aug 2012 09:44:23 -0700
Message-ID: <CAC-hyiFgdD8EcF1uonkdbAwshDh87aP3NjXBvCPv3gbW7XpazQ@mail.gmail.com>
References: <502D1B07.3030101@itxperts.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:52414 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753562Ab2HPQoY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Aug 2012 12:44:24 -0400
Received: by bkwj10 with SMTP id j10so995084bkw.19
        for <ceph-devel@vger.kernel.org>; Thu, 16 Aug 2012 09:44:23 -0700 (PDT)
In-Reply-To: <502D1B07.3030101@itxperts.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Bluemle <andreas.bluemle@itxperts.de>
Cc: ceph-devel@vger.kernel.org

On Thu, Aug 16, 2012 at 9:08 AM, Andreas Bluemle
<andreas.bluemle@itxperts.de> wrote:
>
> Hi,
>
> I have been trying to migrate a ceph cluster (ceph-0.48argonaut)
> to a high speed cluster network and encounter scalability problems:
> the overall performance of the ceph cluster does not scale well
> with an increase in the underlying networking speed.
>
> In short:
>
> I believe that the dispatching from SimpleMessenger to
> OSD worker queues causes that scalability issue.
>
> Question: is it possible that this dispatching is causing performance
> problems?
>
>
> In detail:
>
> In order to find out more about this problem, I have added profiling to
> the ceph code in various place; for write operations to the primary or the
> secondary, timestamps are recorded for OSD object, offset and length of
> the such a write request.
>
> Timestamps record:
>  - receipt time at SimpleMessenger
>  - processing time at osd
>  - for primary write operations: wait time until replication operation
>    is acknowledged.

Did you make any code changes? We'd love to see those.

>
> What I believe is happening: dispatching requests from SimpleMessenger to
> OSD worker threads seems to consume a fair amount of time. This ends
> up in a widening gap between subsequent receipts of requests and the start
> of OSD processing them.
>
> A primary write suffers twice from this problem: first because
> the delay happens on the primary OSD and second because the replicating
> OSD also suffers from the same problem - and hence causes additional
> delays
> at the primary OSD when it waits for the commit from the replicating OSD.
>
> In the attached graphics, the x-axis shows the time (in seconds)
> The y-axis shows the offset where a request to write happened.
>
> The red bar represents the SimpleMessenger receive, i.e. from reading
> the message header until enqueuing the completely decoded message into
> the SImpleMessenger dispatch queue.

Could it be that messages were throttled here?
There's a configurable that can be set (ms dispatch throttle bytes), might
affect that.

>
> The green bar represents the time required for local processing, i.e.
> dispatching the the OSD worker, writing to filesystem and journal, send
> out the replication operation to the replicating OSD. It right
> end of the green bar is the time when locally everything has finished
> and a commit could happen.
>
> The blue bar represents the time until the replicating OSD has sent a
> commit
> back to the primary OSD and the original write request can be committed to
> the client.
>
> The green bar is interrupted by a black bar: the left end represents
> the time when the request has been enqueued on the OSD worker queue. The
> right end gives the time when the request is taken off the OSD worker
> queue and actual OSD processing starts.
>
> The test was a simple sequential write to a rados block device.
>
> Receiption of the write requests at the OSD is also sequential in the
> graphics: the bar to the bottom of the graphics shows an earlier write
> request.
>
> Note that the dispatching of a later request in all cases relates to the
> enqueue time at the OSD worker queue of the previous write request: the
> left
> end of a black bar relates nicely to the beginning of a green bar above
> it.
>
>

Thanks,
Yehuda
