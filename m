From: Jens Harbott <j.rosenboom@x-ion.de>
Subject: Re: Issue on RGW 500 error: flush_read_list(): d->client_c->handle_data()
 returned -5
Date: Wed, 19 Jul 2017 15:48:33 +0000
Message-ID: <CADr68WakoPGs21PDk3fXfZ2czJ2YRiQv0usQhPKHZW-BDzNyMg@mail.gmail.com>
References: <06681238D8946F44A60AA400760A1CBF12393956@SHSMSX103.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35229 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755409AbdGSPsf (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Jul 2017 11:48:35 -0400
Received: by mail-wm0-f46.google.com with SMTP id w126so2743026wme.0
        for <ceph-devel@vger.kernel.org>; Wed, 19 Jul 2017 08:48:35 -0700 (PDT)
In-Reply-To: <06681238D8946F44A60AA400760A1CBF12393956@SHSMSX103.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Zhou, Yuan" <yuan.zhou@intel.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

2017-07-19 14:45 GMT+00:00 Zhou, Yuan <yuan.zhou@intel.com>:
> Hello,
>
> Trying to do some tests with bigdata + S3a + RGW here and ran into a weird 500 error. I checked the log and find the error was due to:
>
> ERROR: flush_read_list(): d->client_c->handle_data() returned -5
>
> After checking the code this function seems trying to send data back to client but something wrong happen. Was this because the connection between client and RGW was closed before the data transferring finish?
>
> Is there a way to do some debug on this?
>
> I'm testing with Ceph 10.2.7, the data pool was using EC(3 + 2). Any comments would be appreciated!

Error 5 is EIO, so it seems like your OSDs couldn't read some of the
data properly. You could either check all of your OSD logs at that
time or add "debug ms=1" to your RGW config and rerun your test, where
you will have more information about the OSD transactions in your
radosgw.log then.

In addition, radosgw is known bad at giving feedback to the client
about such errors, see http://tracker.ceph.com/issues/20166.
