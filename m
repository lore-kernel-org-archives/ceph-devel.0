From: Wei Jin <wjin.cn@gmail.com>
Subject: Osd failure detection
Date: Thu, 9 Nov 2017 17:43:04 +0800
Message-ID: <A80E9066-6266-49E2-9BD7-137E8136D6B9@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pg0-f51.google.com ([74.125.83.51]:45088 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753100AbdKIJnJ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Nov 2017 04:43:09 -0500
Received: by mail-pg0-f51.google.com with SMTP id l19so1681986pgo.2
        for <ceph-devel@vger.kernel.org>; Thu, 09 Nov 2017 01:43:09 -0800 (PST)
Received: from [10.2.9.173] ([103.48.142.82])
        by smtp.gmail.com with ESMTPSA id t80sm3117234pfi.98.2017.11.09.01.43.06
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Nov 2017 01:43:07 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi, List,

=46rom Luminous release, I noticed following information:

 "Some OSD failures are now detected almost immediately, whereas =
previously the heartbeat timeout (which defaults to 20 seconds) had to =
expire.  This prevents IO from blocking for an extended period for =
failures where the host remains up but the ceph-osd process is no longer =
running."

This is critical and we have no plan to upgrade to Luminous so far.
Is there any plan to back port it Jewel? Or anybody know the related pr =
or patches? Maybe I could do it by myself.
Thanks.=
