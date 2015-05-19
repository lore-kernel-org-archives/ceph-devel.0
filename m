From: Andrey Korolyov <andrey@xdel.ru>
Subject: Snap operation throttling (again)
Date: Tue, 19 May 2015 18:06:08 +0300
Message-ID: <CABYiri-V7rmF=WdTek5V8TopG8gOR_H+3XC+cV6B+OUQ5er4cA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:34438 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290AbbESPGb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 May 2015 11:06:31 -0400
Received: by laat2 with SMTP id t2so28701073laa.1
        for <ceph-devel@vger.kernel.org>; Tue, 19 May 2015 08:06:29 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-users <ceph-users@ceph.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hello,

this question was brought many times before, and also solved in a
various ways - snap trimmer, scheduler` priorities and persistent fix
(for a ReplicatedPG issue), but it seems that the current Ceph
versions may suffer as well during the rollback operations on large
images and on large scale. Given CFQ scheduler for rotating media and
~10 percentage of an utilization as an initial preconditions, the
rollback operation of an one-fourth terabyte image over 100 OSDs may
result in a significant latency impact and, for such configuration,
breakage of a 30s request completion barrier. Although recent
improvements did very well in means of the congestion control for a
slow media for many kind of non-client ops, this exact issue remains.
I think it can be solved by another sleeper knob but unsure where its
proper place should be.

Thanks for suggestions!
