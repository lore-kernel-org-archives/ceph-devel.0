From: yuxiang fang <abcdeffyx@gmail.com>
Subject: Re: Issue on RGW 500 error: flush_read_list(): d->client_c->handle_data()
 returned -5
Date: Thu, 20 Jul 2017 00:39:23 +0800
Message-ID: <CAOi4hNfPb=rsJgcDD+V3qghpz7cZO1mhSV2FH1A-PJghqpaqAw@mail.gmail.com>
References: <06681238D8946F44A60AA400760A1CBF12393956@SHSMSX103.ccr.corp.intel.com>
 <CADr68WakoPGs21PDk3fXfZ2czJ2YRiQv0usQhPKHZW-BDzNyMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pg0-f44.google.com ([74.125.83.44]:38287 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753709AbdGSQjy (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Jul 2017 12:39:54 -0400
Received: by mail-pg0-f44.google.com with SMTP id s4so2478644pgr.5
        for <ceph-devel@vger.kernel.org>; Wed, 19 Jul 2017 09:39:54 -0700 (PDT)
In-Reply-To: <CADr68WakoPGs21PDk3fXfZ2czJ2YRiQv0usQhPKHZW-BDzNyMg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jens Harbott <j.rosenboom@x-ion.de>
Cc: "Zhou, Yuan" <yuan.zhou@intel.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi zhou yuan

Get large object with high compression rate will cause EIO in jewel,
but it seems that you didn't enable compression.

You are right, there is something wrong with the connection between
rgw and the client, is there any middleware between the real client
and rgw? (e.g nginx, which may cause such kind of error when download
big object)

thanks
ivan from eisoo


On Wed, Jul 19, 2017 at 11:48 PM, Jens Harbott <j.rosenboom@x-ion.de> wrote:
> 2017-07-19 14:45 GMT+00:00 Zhou, Yuan <yuan.zhou@intel.com>:
>> Hello,
>>
>> Trying to do some tests with bigdata + S3a + RGW here and ran into a weird 500 error. I checked the log and find the error was due to:
>>
>> ERROR: flush_read_list(): d->client_c->handle_data() returned -5
>>
>> After checking the code this function seems trying to send data back to client but something wrong happen. Was this because the connection between client and RGW was closed before the data transferring finish?
>>
>> Is there a way to do some debug on this?
>>
>> I'm testing with Ceph 10.2.7, the data pool was using EC(3 + 2). Any comments would be appreciated!
>
> Error 5 is EIO, so it seems like your OSDs couldn't read some of the
> data properly. You could either check all of your OSD logs at that
> time or add "debug ms=1" to your RGW config and rerun your test, where
> you will have more information about the OSD transactions in your
> radosgw.log then.
>
> In addition, radosgw is known bad at giving feedback to the client
> about such errors, see http://tracker.ceph.com/issues/20166.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
