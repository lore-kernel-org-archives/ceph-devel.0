From: Oleg Kolosov <olekol@gmail.com>
Subject: Re: LRC has slower recovery than Jerasure
Date: Tue, 12 Sep 2017 00:08:32 +0300
Message-ID: <CAODUPsGGcUk9zKUEnRYBPzEQicvpeM6M6nUHg+sk7v20SP9okg@mail.gmail.com>
References: <CAODUPsGPdZ7AL1nYpTP5OE8iqWpcgj=Durm_f_4C=y12tbmnYA@mail.gmail.com>
 <alpine.DEB.2.11.1709112048200.24068@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:35185 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750957AbdIKVId (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Sep 2017 17:08:33 -0400
Received: by mail-io0-f179.google.com with SMTP id g32so17442205ioj.2
        for <ceph-devel@vger.kernel.org>; Mon, 11 Sep 2017 14:08:33 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1709112048200.24068@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Hi Sage,
Yes, this might be an issue, I wonder if in any way I can minimize the
effect of recovery at the primary, otherwise LRC plugin misses its
purpose in such a configuration.
I'll explain my experiment in detail:

The code was defined the following:
 plugin=lrc \
 mapping=DD_DD____ \
 layers='[
 [ "DD_DD_ccc", "" ],
[ "DDc______", "" ],
[ "___DDc___", "" ],
 ]' \
 ruleset-steps='[
 [ "choose", "host",  3  ],
 [ "chooseleaf", "osd",  3  ],
 ]'


osd tree is the following:

ID  WEIGHT   TYPE NAME      UP/DOWN REWEIGHT PRIMARY-AFFINITY
 -1 40.00000 root default
-22  8.00000     host host0
  0  1.00000         osd.0       up  1.00000          1.00000
  1  1.00000         osd.1       up  1.00000          1.00000
  2  1.00000         osd.2       up  1.00000          1.00000
  3  1.00000         osd.3       up  1.00000          1.00000
  4  1.00000         osd.4       up  1.00000          1.00000
  5  1.00000         osd.5       up  1.00000          1.00000
  6  1.00000         osd.6       up  1.00000          1.00000
  7  1.00000         osd.7       up  1.00000          1.00000
-23  8.00000     host host1
  8  1.00000         osd.8       up  1.00000          1.00000
  9  1.00000         osd.9       up  1.00000          1.00000
 10  1.00000         osd.10      up  1.00000          1.00000
 11  1.00000         osd.11      up  1.00000          1.00000
 12  1.00000         osd.12      up  1.00000          1.00000
 13  1.00000         osd.13      up  1.00000          1.00000
 14  1.00000         osd.14      up  1.00000          1.00000
 15  1.00000         osd.15      up  1.00000          1.00000
-24  8.00000     host host2
 16  1.00000         osd.16      up  1.00000          1.00000
 17  1.00000         osd.17      up  1.00000          1.00000
 18  1.00000         osd.18      up  1.00000          1.00000
 19  1.00000         osd.19      up  1.00000          1.00000
 20  1.00000         osd.20      up  1.00000          1.00000
 21  1.00000         osd.21      up  1.00000          1.00000
 22  1.00000         osd.22      up  1.00000          1.00000
 23  1.00000         osd.23      up  1.00000          1.00000
-25  8.00000     host host3
 24  1.00000         osd.24      up  1.00000          1.00000
 25  1.00000         osd.25      up  1.00000          1.00000
 26  1.00000         osd.26      up  1.00000          1.00000
 27  1.00000         osd.27      up  1.00000          1.00000
 28  1.00000         osd.28      up  1.00000          1.00000
 29  1.00000         osd.29      up  1.00000          1.00000
 30  1.00000         osd.30      up  1.00000          1.00000
 31  1.00000         osd.31      up  1.00000          1.00000
-26  8.00000     host host4
 32  1.00000         osd.32      up  1.00000          1.00000
 33  1.00000         osd.33      up  1.00000          1.00000
 34  1.00000         osd.34      up  1.00000          1.00000
 35  1.00000         osd.35      up  1.00000          1.00000
 36  1.00000         osd.36      up  1.00000          1.00000
 37  1.00000         osd.37      up  1.00000          1.00000
 38  1.00000         osd.38      up  1.00000          1.00000
 39  1.00000         osd.39      up  1.00000          1.00000


In my experiment I write a certain amount of data, next I kill an osd
and take measurements during recovery (until cluster is HEALTH_OK
again). I measure cpu and reads done in every second.
What I see for the reads is that it reaches some sort of a constant
value per sec, like there is a threshold for reads during recovery.
CPU behaved the same, but following the throttling  change the
threshold became less obvious.

When performing the same experiment with only 'chooseleaf osd'
defined, I get normal behaviour.

Thanks,
Oleg
