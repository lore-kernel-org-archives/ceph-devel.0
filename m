From: Andrey Korolyov <andrey@xdel.ru>
Subject: Multiple issues with glibc heap management
Date: Mon, 13 Oct 2014 23:33:14 +0400
Message-ID: <CABYiri-csNmgHgaD4QxwaJwQE8qLEjStscZbzwd5Z2oBTFpyLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:45106 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752681AbaJMTdh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Oct 2014 15:33:37 -0400
Received: by mail-qc0-f172.google.com with SMTP id o8so5659923qcw.3
        for <ceph-devel@vger.kernel.org>; Mon, 13 Oct 2014 12:33:36 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>
Cc: Sergey Fionov <fionov@gmail.com>

Hello,

since very long period (at least from cuttlefish) many users,
including me, experiences rare but still very disturbing client
crashes (#8385, #6480, and couple of other same-looking traces for
different code pieces, I may start the corresponding separate bugs if
necessary). The main problem is that the issues are very hard to
reproduce in a deterministic way, although they are *primarily*
correlate with disk workload.

Despite fixing all reported separately is a definitely a working way,
the issue can be also caused be simularly-behaving single piece of
code belonging to one of shared libraries. As issue touches more or
less all existing deployments on stable release, may be it is worthy
(and possible) to fix it not by cleaning up particular issues one by
one.

Thanks!
