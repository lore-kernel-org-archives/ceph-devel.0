From: Two Spirit <twospirit6905@gmail.com>
Subject: Re: clearing unfound objects
Date: Wed, 13 Sep 2017 14:34:39 -0700
Message-ID: <CAKRxpuuYuCkYVYwX5FcMHZ9m-MSu8tB2Qs7ZO5MJ7dex4X0VCA@mail.gmail.com>
References: <CAKRxpuu-P_Hp4F9KZTN_=OGaN_gHLUgLAosXE09716yAX9Wrag@mail.gmail.com>
 <alpine.DEB.2.11.1709122248360.24068@piezo.novalocal> <CAKRxpuuMbavH4V7zEDaOzJFzG=eLU0XH2KjgF6EJh1EWevxxQw@mail.gmail.com>
 <alpine.DEB.2.11.1709130154080.24068@piezo.novalocal> <CAKRxpuv0Fi_2YU_pCpcpQf2zcFRj4miu6-FVEhjiqHKb_=mJhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:49107 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751125AbdIMVel (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Sep 2017 17:34:41 -0400
Received: by mail-it0-f41.google.com with SMTP id c195so535371itb.1
        for <ceph-devel@vger.kernel.org>; Wed, 13 Sep 2017 14:34:40 -0700 (PDT)
In-Reply-To: <CAKRxpuv0Fi_2YU_pCpcpQf2zcFRj4miu6-FVEhjiqHKb_=mJhw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: John Spray <jspray@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

did not see that one coming. what to do?

# ceph health detail

FS_DEGRADED 1 filesystem is degraded
    fs cephfs is degraded
OBJECT_UNFOUND 1/731509 unfound (0.000%)
    pg 6.2 has 1 unfound objects

# ceph pg 6.2 query
    "recovery_state": [
        {
            "name": "Started/Primary/Active",
            "enter_time": "2017-09-13 14:22:26.384418",
            "might_have_unfound": [
                {
                    "osd": "0",
                    "status": "already probed"
                },
                {
                    "osd": "2",
                    "status": "already probed"
                },
                {
                    "osd": "3",
                    "status": "already probed"
                },
                {
                    "osd": "4",
                    "status": "already probed"
                },
                {
                    "osd": "5",
                    "status": "already probed"
                }

# ceph pg 6.2 mark_unfound_lost revert
pg has no unfound objects

I wasn't expecting that error message. I think that is not correct.
I am a little crazy, so I tried the same thing, expecting a different result

# ceph pg 6.2 mark_unfound_lost revert
pg has 1 objects unfound and apparently lost marking

and I got one, but my filesystem is still degraded. I was expecting
my filesystem to be good again. Do I have to wait for active+clean?
or what do I do now?
