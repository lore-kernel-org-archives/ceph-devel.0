From: Gregory Farnum <greg@inktank.com>
Subject: Re: SimpleMessenger dispatching: cause of performance problems?
Date: Thu, 16 Aug 2012 09:24:10 -0700
Message-ID: <CAPYLRziFxHfXb0y+-cwap-tjF-_OHmu6vLd+TcFeMgVEXCnAHA@mail.gmail.com>
References: <502D1B07.3030101@itxperts.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:47207 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932897Ab2HPQYL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Thu, 16 Aug 2012 12:24:11 -0400
Received: by lagy9 with SMTP id y9so1567270lag.19
        for <ceph-devel@vger.kernel.org>; Thu, 16 Aug 2012 09:24:10 -0700 (PDT)
In-Reply-To: <502D1B07.3030101@itxperts.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Bluemle <andreas.bluemle@itxperts.de>
Cc: ceph-devel@vger.kernel.org

Can you provide more details about where you pulled this measurement
data from? There are already a number of timestamps saved to track
stuff like this and in our own (admittedly still incomplete) work on
this subject we haven't seen any delays from the SimpleMessenger.
We've had several guys doing a lot of performance work this week, and
they've been narrowing in on problems with the commit to disk (rather
than the journal) taking long enough that client data starts getting
(deliberately) throttled as it comes in. This could be some of the
gaps you're seeing and attributing to the SimpleMessenger.
-Greg

On Thu, Aug 16, 2012 at 9:08 AM, Andreas Bluemle
<andreas.bluemle@itxperts.de> wrote:
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
>
> What I believe is happening: dispatching requests from SimpleMessenger to
> OSD worker threads seems to consume a fair amount of time. This ends
> up in a widening gap between subsequent receipts of requests and the start
> of OSD processing them.
>
> A primary write suffers twice from this problem: first because
> the delay happens on the primary OSD and second because the replicating
> OSD also suffers from the same problem - and hence causes additional delays
> at the primary OSD when it waits for the commit from the replicating OSD.
>
> In the attached graphics, the x-axis shows the time (in seconds)
> The y-axis shows the offset where a request to write happened.
>
> The red bar represents the SimpleMessenger receive, i.e. from reading
> the message header until enqueuing the completely decoded message into
> the SImpleMessenger dispatch queue.
>
> The green bar represents the time required for local processing, i.e.
> dispatching the the OSD worker, writing to filesystem and journal, send
> out the replication operation to the replicating OSD. It right
> end of the green bar is the time when locally everything has finished
> and a commit could happen.
>
> The blue bar represents the time until the replicating OSD has sent a commit
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
> enqueue time at the OSD worker queue of the previous write request: the left
> end of a black bar relates nicely to the beginning of a green bar above it.
>
>
>
> --
> Andreas Bluemle                     mailto:Andreas.Bluemle@itxperts.de
> ITXperts GmbH                       http://www.itxperts.de
> Balanstrasse 73, Geb. 08            Phone: (+49) 89 89044917
> D-81541 Muenchen (Germany)          Fax:   (+49) 89 89044910
>
> Company details: http://www.itxperts.de/imprint.htm
>
