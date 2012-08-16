From: Andreas Bluemle <andreas.bluemle@itxperts.de>
Subject: SimpleMessenger dispatching: cause of performance problems?
Date: Thu, 16 Aug 2012 18:08:39 +0200
Message-ID: <502D1B07.3030101@itxperts.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080607020409060901050102"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.itxperts.de ([212.202.108.166]:42634 "EHLO
	mail.itxperts.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932739Ab2HPQIn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Aug 2012 12:08:43 -0400
Received: from itxmail.itxperts.de (itxmail.itxperts.de [192.168.140.192])
	by mail.itxperts.de (8.14.0/8.14.0) with ESMTP id q7GG8dhc010957
	for <ceph-devel@vger.kernel.org>; Thu, 16 Aug 2012 18:08:40 +0200
Received: from [192.168.140.7] (doppio.itxperts.de [192.168.140.7])
	by itxmail.itxperts.de (Postfix) with ESMTP id E971B13F02
	for <ceph-devel@vger.kernel.org>; Thu, 16 Aug 2012 18:03:56 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080607020409060901050102
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I have been trying to migrate a ceph cluster (ceph-0.48argonaut)
to a high speed cluster network and encounter scalability problems:
the overall performance of the ceph cluster does not scale well
with an increase in the underlying networking speed.

In short:

I believe that the dispatching from SimpleMessenger to
OSD worker queues causes that scalability issue.

Question: is it possible that this dispatching is causing performance 
problems?


In detail:

In order to find out more about this problem, I have added profiling to
the ceph code in various place; for write operations to the primary or the
secondary, timestamps are recorded for OSD object, offset and length of
the such a write request.

Timestamps record:
  - receipt time at SimpleMessenger
  - processing time at osd
  - for primary write operations: wait time until replication operation
    is acknowledged.

What I believe is happening: dispatching requests from SimpleMessenger to
OSD worker threads seems to consume a fair amount of time. This ends
up in a widening gap between subsequent receipts of requests and the start
of OSD processing them.

A primary write suffers twice from this problem: first because
the delay happens on the primary OSD and second because the replicating
OSD also suffers from the same problem - and hence causes additional delays
at the primary OSD when it waits for the commit from the replicating OSD.

In the attached graphics, the x-axis shows the time (in seconds)
The y-axis shows the offset where a request to write happened.

The red bar represents the SimpleMessenger receive, i.e. from reading
the message header until enqueuing the completely decoded message into
the SImpleMessenger dispatch queue.

The green bar represents the time required for local processing, i.e.
dispatching the the OSD worker, writing to filesystem and journal, send
out the replication operation to the replicating OSD. It right
end of the green bar is the time when locally everything has finished
and a commit could happen.

The blue bar represents the time until the replicating OSD has sent a commit
back to the primary OSD and the original write request can be committed to
the client.

The green bar is interrupted by a black bar: the left end represents
the time when the request has been enqueued on the OSD worker queue. The
right end gives the time when the request is taken off the OSD worker
queue and actual OSD processing starts.

The test was a simple sequential write to a rados block device.

Receiption of the write requests at the OSD is also sequential in the
graphics: the bar to the bottom of the graphics shows an earlier write 
request.

Note that the dispatching of a later request in all cases relates to the
enqueue time at the OSD worker queue of the previous write request: the left
end of a black bar relates nicely to the beginning of a green bar above it.



-- 
Andreas Bluemle                     mailto:Andreas.Bluemle@itxperts.de
ITXperts GmbH                       http://www.itxperts.de
Balanstrasse 73, Geb. 08            Phone: (+49) 89 89044917
D-81541 Muenchen (Germany)          Fax:   (+49) 89 89044910

Company details: http://www.itxperts.de/imprint.htm


--------------080607020409060901050102
Content-Type: image/png;
 name="dispatch-detail.png"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="dispatch-detail.png"

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
AAAAAACwlP8B7YkvyIUMU4AAAAAASUVORK5CYII=
--------------080607020409060901050102--
