From: Amit <amitkuma@redhat.com>
Subject: jenkins failing smoke.sh
Date: Fri, 10 Nov 2017 17:54:15 +0530
Message-ID: <5a059a72.96c9620a.e1286.e05f@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pg0-f51.google.com ([74.125.83.51]:44064 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750850AbdKJMYU (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Nov 2017 07:24:20 -0500
Received: by mail-pg0-f51.google.com with SMTP id j3so7285085pga.1
        for <ceph-devel@vger.kernel.org>; Fri, 10 Nov 2017 04:24:20 -0800 (PST)
Received: from amitkuma.pnq.csb ([125.16.97.119])
        by smtp.gmail.com with ESMTPSA id l22sm20176370pfk.45.2017.11.10.04.24.17
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Nov 2017 04:24:18 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

The following tests FAILED: 	  5 - smoke.sh (Timeout)
Errors while running CTest
rm: cannot remove ‘/tmp/ceph-asok.13134’: Is a directory
Build step 'Execute shell' marked build as failure
[BFA] Scanning build for known causes...
..[BFA] Found failure cause(s):
[BFA] No such file or directory from category Development
[BFA] Test failure
[BFA] Done. 2s
Setting status of 12b6e29c0a70bbca50f7738d123f210f29e5e6ac to FAILURE with url https://jenkins.ceph.com/job/ceph-pull-requests-arm64/8663/ and message: 'make check failed
 '
Using context: make check (arm64)
Finished: FAILURE


