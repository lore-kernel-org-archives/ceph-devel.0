From: Brad Hubbard <bhubbard@redhat.com>
Subject: Static analysis
Date: Wed, 23 Nov 2016 17:06:37 +1000
Message-ID: <20161123070637.GF26846@rskikr.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pg0-f41.google.com ([74.125.83.41]:35814 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752138AbcKWHNT (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Nov 2016 02:13:19 -0500
Received: by mail-pg0-f41.google.com with SMTP id p66so2897154pga.2
        for <ceph-devel@vger.kernel.org>; Tue, 22 Nov 2016 23:13:19 -0800 (PST)
Received: from rskikr.localdomain ([66.187.239.11])
        by smtp.gmail.com with ESMTPSA id g22sm31883005pgn.20.2016.11.22.23.06.42
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Nov 2016 23:06:44 -0800 (PST)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I did a run of the Clang Static Analyzer and it turned up multiple issues which
Kefu gobbled up :) The reports are quite detailed and walk you through how the
issue can present.

See https://github.com/ceph/ceph/pull/12145 and
https://github.com/ceph/ceph/pull/12148

Given how easy it is to run [1] (although slow) would it be a good idea to be
running this regulary, perhaps in addition to coverity scans?

[1] mkdir build && cd build && scan-build cmake .. && scan-build make -jX

-- 
Cheers,
Brad
