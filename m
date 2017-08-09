From: Dan van der Ster <dan@vanderster.com>
Subject: default debug_client level is too high
Date: Wed, 9 Aug 2017 18:32:02 +0200
Message-ID: <CABZ+qq=cNRn+18bLM6_T_weeEAweg9jKe2n8jjitsDz7bgtpNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:34716 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752413AbdHIQcp (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Aug 2017 12:32:45 -0400
Received: by mail-oi0-f48.google.com with SMTP id x3so66470808oia.1
        for <ceph-devel@vger.kernel.org>; Wed, 09 Aug 2017 09:32:45 -0700 (PDT)
Received: from mail-oi0-f52.google.com (mail-oi0-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id h11sm4104353oif.34.2017.08.09.09.32.43
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Aug 2017 09:32:43 -0700 (PDT)
Received: by mail-oi0-f52.google.com with SMTP id x3so66469975oia.1
        for <ceph-devel@vger.kernel.org>; Wed, 09 Aug 2017 09:32:43 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi all,

During some ceph-fuse perf testing I've noticed that small buffered
write throughput is slowed down by the debug_client ldout logs.
At the default 0/5, the in mem log is filled with, e.g.:

 -9760> 2017-08-09 18:16:10.487511 7f848c1a5700  3 client.407554315
xattr_permission 0x7f84a52c8a00 = 0
 -9759> 2017-08-09 18:16:10.487515 7f848c1a5700  3 client.407554315
_getxattr(10003284f73, "security.capability", 0) = -61
 -9758> 2017-08-09 18:16:10.487525 7f848c1a5700  3 client.407554315
ll_forget 10003284f73 1
 -9757> 2017-08-09 18:16:10.487542 7f848b9a4700  3 client.407554315
ll_write 0x7f84a5147680 10003284f73 71824~1
 -9756> 2017-08-09 18:16:10.487566 7f848b9a4700  3 client.407554315
ll_write 0x7f84a5147680 71824~1 = 1
 -9755> 2017-08-09 18:16:10.487599 7f848c9a6700  3 client.407554315
ll_getxattr 10003284f73.head security.capability size 0
 -9754> 2017-08-09 18:16:10.487609 7f848c9a6700  3 client.407554315
xattr_permission 0x7f84a52c8a00 = 0
 -9753> 2017-08-09 18:16:10.487612 7f848c9a6700  3 client.407554315
_getxattr(10003284f73, "security.capability", 0) = -61

(so even tiny 1 byte buffered writes result in huge amounts of logging work).

In a simple test [1], I found that 100000 one byte writes takes
~10-11s with the default client log level, and ~5 to 6s with
debug_client=0/2.

I would therefore propose either increasing the ldout level for these
ll_* client ops to 6, or decreasing the default debug_client level to
0/2.

Any opinions?

Cheers, Dan

[1]
for i in xrange(100000):
  f.write('x')
  f.flush()
f.close()
