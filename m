From: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Subject: inconsistent pg will not repair
Date: Tue, 26 Sep 2017 10:03:13 -0400
Message-ID: <CAGbvivJWLXaGzZjAFLpqBFP9N7QHkYt8uZyo9z3qpSnrHz8YZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:55768 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937257AbdIZODQ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Sep 2017 10:03:16 -0400
Received: by mail-lf0-f49.google.com with SMTP id u21so4628325lfk.12
        for <ceph-devel@vger.kernel.org>; Tue, 26 Sep 2017 07:03:15 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

I have an inconsistent PG that I cannot seem to get to repair cleanly.
I can find the 3 objects in question and they all have the same size
and md5sum, but yet whenever I repair it, it is reported as an error
"failed to pick suitable auth object".

Any suggestions for fixing or workaround this issue to resolve the
inconsistency?

Ceph 10.2.9
Ubuntu 16.04.2


2017-09-26 09:54:03.123938 7fd31048e700 -1 log_channel(cluster) log
[ERR] : 1.5b8 shard 7: soid 1:1daab06b:::100004d6662.00000000:head
data_digest 0x923deb74 != data_digest 0x23f10be8 from auth oi
1:1daab06b:::100004d6662.00000000:head(204442'221517
client.5654254.1:2371279 dirty|data_digest|omap_digest s 1421644 uv
203993 dd 23f10be8 od ffffffff alloc_hint [0 0])
2017-09-26 09:54:03.123944 7fd31048e700  0 log_channel(cluster) do_log
log to syslog
2017-09-26 09:54:03.123999 7fd31048e700 -1 log_channel(cluster) log
[ERR] : 1.5b8 shard 26: soid 1:1daab06b:::100004d6662.00000000:head
data_digest 0x923deb74 != data_digest 0x23f10be8 from auth oi
1:1daab06b:::100004d6662.00000000:head(204442'221517
client.5654254.1:2371279 dirty|data_digest|omap_digest s 1421644 uv
203993 dd 23f10be8 od ffffffff alloc_hint [0 0])
2017-09-26 09:54:03.124005 7fd31048e700  0 log_channel(cluster) do_log
log to syslog
2017-09-26 09:54:03.124013 7fd31048e700 -1 log_channel(cluster) log
[ERR] : 1.5b8 shard 44: soid 1:1daab06b:::100004d6662.00000000:head
data_digest 0x923deb74 != data_digest 0x23f10be8 from auth oi
1:1daab06b:::100004d6662.00000000:head(204442'221517
client.5654254.1:2371279 dirty|data_digest|omap_digest s 1421644 uv
203993 dd 23f10be8 od ffffffff alloc_hint [0 0])
2017-09-26 09:54:03.124015 7fd31048e700  0 log_channel(cluster) do_log
log to syslog
2017-09-26 09:54:03.124022 7fd31048e700 -1 log_channel(cluster) log
[ERR] : 1.5b8 soid 1:1daab06b:::100004d6662.00000000:head: failed to
pick suitable auth object
2017-09-26 09:54:03.124023 7fd31048e700  0 log_channel(cluster) do_log
log to syslog
2017-09-26 09:56:14.461015 7fd31048e700 -1 log_channel(cluster) log
[ERR] : 1.5b8 deep-scrub 3 errors
2017-09-26 09:56:14.461021 7fd31048e700  0 log_channel(cluster) do_log
log to syslog
