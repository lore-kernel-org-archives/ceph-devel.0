From: Mohamad Gebai <mgebai@suse.de>
Subject: Unstable clock
Date: Tue, 17 Oct 2017 08:30:31 -0400
Message-ID: <085064b4-2e21-4e54-cdd8-dd8a4560aa92@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60054 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753116AbdJQMag (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 17 Oct 2017 08:30:36 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@lists.ceph.com>
Cc: Florian Haas <florian@hastexo.com>

Hi,

I am looking at the following issue: http://tracker.ceph.com/issues/21375

In summary, during a 'rados bench', impossible latency values (e.g.
9.00648e+07) are suddenly reported. I looked briefly at the code, it
seems CLOCK_REALTIME is used, which means that wall clock changes would
affect this output. This is a VM cluster, so the hypothesis was that the
system's clock was falling behind for some reason, then getting
readjusted (that's the only way I could reproduce the issue), which I
think is quite possible in a virtual environment.

A concern was raised: are there more critical parts of Ceph where a
clock jumping around might interfere with the behavior of the cluster?
It would be good to know if there are any, and maybe prepare for them?

Mohamad
