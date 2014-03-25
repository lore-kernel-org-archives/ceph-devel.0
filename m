From: Shinji Matsumoto <shinji.matsumoto@us.sios.com>
Subject: Question about librados notification
Date: Tue, 25 Mar 2014 21:50:57 +0900
Message-ID: <CAJ58763WbS3dhnu572w7pwSVY2iywXmVwstu_bpRY=cR5K-+iQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:44979 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475AbaCYMu6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Mar 2014 08:50:58 -0400
Received: by mail-ie0-f170.google.com with SMTP id rd18so337268iec.1
        for <ceph-devel@vger.kernel.org>; Tue, 25 Mar 2014 05:50:57 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hello all,

I have a question about Ceph notification mechanism.
http://ceph.com/docs/master/architecture/#object-watch-notify

Scenario:

(1) 3 clients (client1, client2, client3) have interests on a Ceph
object (object A). Each client calls rados_watch() to register
notification callback on the object..

(2) Client1 calls rados_notify()  on object A. On client1 and client2,
the notification is delivered and processed successfully within a
timeout period.

(3) However on client3, the notification is delivered, but it doesn't
complete within a timeout period for a temporary reason, such as
temporarily busy process for instance.

(4) On client1, rados_notify() returns a status of timeout.

(5) On client3, the temporary reason goes away and the notification is
processed.

(6) Then, client3 attempts to read from object A by a call to rados_read().

Question:

Will the call to rados_read() attempted at step (6) always succeed,
always fail or is the behavior unpredictable, which is, it's affected
by the factors that are not defined in this scenario?

Thank you.

Shinji Matsumoto
SIOS technology, Inc.
