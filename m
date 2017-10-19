From: Jason Dillaman <jdillama@redhat.com>
Subject: "debug ms = 0/5" logging ...
Date: Thu, 19 Oct 2017 07:47:28 -0400
Message-ID: <1508413648.27011.5.camel@redhat.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f174.google.com ([209.85.216.174]:48145 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753269AbdJSLrb (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Oct 2017 07:47:31 -0400
Received: by mail-qt0-f174.google.com with SMTP id f8so14002058qta.5
        for <ceph-devel@vger.kernel.org>; Thu, 19 Oct 2017 04:47:30 -0700 (PDT)
Received: from cube-1 (pool-173-73-60-87.washdc.fios.verizon.net. [173.73.60.87])
        by smtp.gmail.com with ESMTPSA id s6sm8855331qkd.55.2017.10.19.04.47.28
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Oct 2017 04:47:28 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

While the default messenger logging setting has always been an
impediment to high queue-depth, high IOPS workloads, in Luminous it
appears to have slowed down librbd small block IOPS by an additional 10-
15%. When compared against cases where the messenger logs are disabled,
it's more than a 40% IOPS degradation to have the messenger logs
enabled.

From some quick "perf" runs, the Luminous delta seems to be from from a
few places: (1) hobject_t is now used in the OSD messages, and it's more
expensive to construct[2] and print; (2) log messages are longer in
length; and (3) async messenger is more verbose per message at log level
1 compared to simple messenger.

I'd hate to advocate the sledge-hammer approach to say everyone should
deploy librbd with "debug ms = 0" -- especially since I've relied on
decoding the in-memory log messages from core dumps as a pseudo-librbd
flight recorder in the past.

This seems like an area that could use some team discussion and thought.
Perhaps it would be possible to re-use tracepoint hooks where we keep
the last X traces in-memory so that they can be dumped and/or are
available in the core file. In theory that would at least reduce the
expense of converting these trace-like log messages to expensive human
readable strings.

Thoughts?

[1] http://tracker.ceph.com/issues/21846
[2] http://tracker.ceph.com/issues/21845

--
Jason
