From: sheng qiu <herbert1984106@gmail.com>
Subject: peering process
Date: Fri, 30 Jun 2017 15:25:37 -0700
Message-ID: <CAB7xdikjRLknjy5pac08zUbcN=r8N0+cJ4ZOL3tPMZkNSiiYLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f180.google.com ([209.85.216.180]:34629 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753234AbdF3WZi (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Jun 2017 18:25:38 -0400
Received: by mail-qt0-f180.google.com with SMTP id 32so109879884qtv.1
        for <ceph-devel@vger.kernel.org>; Fri, 30 Jun 2017 15:25:38 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

We are trying to reduce the peering processing latency, since it may
block front io.

in our experiment, we kill certain osd and bring it back after a very
short time. We checked performance counters as below:

 "peering_latency": {

            "avgcount": 52,

            "sum": 52.435308773,

            "avglat": 1008.371323

        },

     "getinfo_latency": {

            "avgcount": 52,

            "sum": 3.525831625,

            "avglat": 67.804454

        },

        "getlog_latency": {

            "avgcount": 46,

            "sum": 0.255325943,

            "avglat": 5.550564

        },

 "getmissing_latency": {

            "avgcount": 46,

            "sum": 0.000877735,

            "avglat": 0.019081

        },

        "waitupthru_latency": {

            "avgcount": 46,

            "sum": 48.652836368,

            "avglat": 1057.670356

        }

as shown, average peering latency is 1008ms, most of them are consumed
by "waitupthru_latency".  By looking at the codes, i am not quite
understand this part. Can anyone explain this part especially why it
takes such long time in this stage?

I also noticed there's some description regarding "fast peering" on
http://tracker.ceph.com/projects/ceph/wiki/Osd_-_Faster_Peering

is this still ongoing or stale?

I am appreciated for any kind reply.

Thanks,
Sheng
