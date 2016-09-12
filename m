From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Mismatching nonce for 'ceph osd.0 tell'
Date: Tue, 13 Sep 2016 00:59:18 +0200
Message-ID: <f54dda71-dabf-cab2-948c-83b9f2007aff@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:13176 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757554AbcILW7d (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 12 Sep 2016 18:59:33 -0400
Received: from [192.168.10.67] (opteron [192.168.10.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id 8B5072934F
        for <ceph-devel@vger.kernel.org>; Tue, 13 Sep 2016 00:59:28 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi

When running  cephtool-test-mon.sh, part of it executes:
  ceph tell osd.0 version
I see reports on the commandline, I guess that this is the OSD
complaining that things are wrong:

2016-09-12 23:50:39.239037 814e50e00  0 -- 127.0.0.1:0/1925715881 >>
127.0.0.1:6800/26384 conn(0x814fde800 sd=18 :-1
s=STATE_CONNECTING_WAIT_BANNER_AND_IDENTIFY pgs=0 cs=0
l=1)._process_connection connect claims to be 127.0.0.1:6800/1026384 not
127.0.0.1:6800/26384 - wrong node!

Which it will run until it is shot down.... after 3600 secs.

the nonce is incremented with 1000000 on every rebind.

But what I do not understand is how this mismatch has occurred.
I would expect port 6800 to be the port on which the OSD is connected
too, so the connecting party (ceph in this case) thinks the nonce to be
1026384. Did the MON have this information? And where did the MON then
get it from....

Somewhere one of the parts did not receive the new nonce, or did not
also increment it?

Any suggestions welcomed on directions where to look,

Thanx,
--WjW
