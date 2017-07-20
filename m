From: Kyle Bader <kyle.bader@gmail.com>
Subject: Re: Issue on RGW 500 error: flush_read_list(): d->client_c->handle_data()
 returned -5
Date: Thu, 20 Jul 2017 10:34:31 +0300
Message-ID: <CAFMfnwrcH0E_TJjLFBaoWUPB6oDKSj3_+dHDk_3XUoQB2NLchg@mail.gmail.com>
References: <06681238D8946F44A60AA400760A1CBF12393956@SHSMSX103.ccr.corp.intel.com>
 <CADr68WakoPGs21PDk3fXfZ2czJ2YRiQv0usQhPKHZW-BDzNyMg@mail.gmail.com> <CAOi4hNfPb=rsJgcDD+V3qghpz7cZO1mhSV2FH1A-PJghqpaqAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yb0-f172.google.com ([209.85.213.172]:36857 "EHLO
        mail-yb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934298AbdGTHec (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Jul 2017 03:34:32 -0400
Received: by mail-yb0-f172.google.com with SMTP id 74so4886272ybf.3
        for <ceph-devel@vger.kernel.org>; Thu, 20 Jul 2017 00:34:32 -0700 (PDT)
In-Reply-To: <CAOi4hNfPb=rsJgcDD+V3qghpz7cZO1mhSV2FH1A-PJghqpaqAw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: yuxiang fang <abcdeffyx@gmail.com>
Cc: Jens Harbott <j.rosenboom@x-ion.de>, "Zhou, Yuan" <yuan.zhou@intel.com>, Ceph Development <ceph-devel@vger.kernel.org>

Check your nginx/haproxy logs if that is in place, that can be a spice
of timeouts as was previously mentioned.

If the transfer is large, you may want to check kernel tcp timeouts at
the kernel level on both ends?

Are your OSDs spinning or SSD, and if the former do you have your
index pools on SSD by way of a custom crush rule pointing to an all
SSD root?

On Wed, Jul 19, 2017 at 7:39 PM, yuxiang fang <abcdeffyx@gmail.com> wrote:
> Hi zhou yuan
>
> Get large object with high compression rate will cause EIO in jewel,
> but it seems that you didn't enable compression.
>
> You are right, there is something wrong with the connection between
> rgw and the client, is there any middleware between the real client
> and rgw? (e.g nginx, which may cause such kind of error when download
> big object)
>
> thanks
> ivan from eisoo
>
>
> On Wed, Jul 19, 2017 at 11:48 PM, Jens Harbott <j.rosenboom@x-ion.de> wrote:
>> 2017-07-19 14:45 GMT+00:00 Zhou, Yuan <yuan.zhou@intel.com>:
>>> Hello,
>>>
>>> Trying to do some tests with bigdata + S3a + RGW here and ran into a weird 500 error. I checked the log and find the error was due to:
>>>
>>> ERROR: flush_read_list(): d->client_c->handle_data() returned -5
>>>
>>> After checking the code this function seems trying to send data back to client but something wrong happen. Was this because the connection between client and RGW was closed before the data transferring finish?
>>>
>>> Is there a way to do some debug on this?
>>>
>>> I'm testing with Ceph 10.2.7, the data pool was using EC(3 + 2). Any comments would be appreciated!
>>
>> Error 5 is EIO, so it seems like your OSDs couldn't read some of the
>> data properly. You could either check all of your OSD logs at that
>> time or add "debug ms=1" to your RGW config and rerun your test, where
>> you will have more information about the OSD transactions in your
>> radosgw.log then.
>>
>> In addition, radosgw is known bad at giving feedback to the client
>> about such errors, see http://tracker.ceph.com/issues/20166.
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 

Kyle Bader
