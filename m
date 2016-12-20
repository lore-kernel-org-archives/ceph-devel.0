From: Willem Jan Withagen <wjw@digiware.nl>
Subject: OSD rebind connects to ports of other OSDs
Date: Tue, 20 Dec 2016 11:21:19 +0100
Message-ID: <2b061067-e839-054e-5166-619deecfae5e@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:25946 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933621AbcLTKVX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 20 Dec 2016 05:21:23 -0500
Received: from [192.168.10.67] (opteron [192.168.10.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id 0628533CA8
        for <ceph-devel@vger.kernel.org>; Tue, 20 Dec 2016 11:21:21 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

I've been banging my head against the wall for some time now.
But rebinding OSD.0 (in cephtool-test-mon.sh) does not quite work.

When rebinding it connects to the ports of OSD.1 because those ports are
the first not in the avoid_list. That should be refused since these
sockets belong to a different process.
UNLESS SO_REUSEPORT is set:
 SO_REUSEPORT allows completely duplicate bindings by multiple processes
 if they all set SO_REUSEPORT before binding the port.  This option
 permits multiple instances of a program to each receive UDP/IP
 multicast or broadcast datagrams destined for the bound port.

Which seems that that happens.
Output from sockstat in this state:
wjw      ceph-osd-0   43305 14 tcp4   *:6800                *:*
wjw      ceph-osd-0   43305 15 tcp4   127.0.0.1:6804        *:*
wjw      ceph-osd-0   43305 16 tcp4   127.0.0.1:6805        *:*
wjw      ceph-osd-0   43305 45 tcp4   127.0.0.1:6806        *:*
wjw      ceph-osd-1   43318 14 tcp4   *:6804                *:*
wjw      ceph-osd-1   43318 15 tcp4   *:6805                *:*
wjw      ceph-osd-1   43318 16 tcp4   *:6806                *:*
wjw      ceph-osd-1   43318 17 tcp4   *:6807                *:*

Which clearly demonstrates the mess.
How ever that option is nowhere set in the ceph-code, neither is it a
setting that "just" gets set.

Any suggestions where to look for this option to get set in an
incidental/bug way would be much appreciated.
Or a suggestion on how to easily debug this.

Thanx,
--WjW
