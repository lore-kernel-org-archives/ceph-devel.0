From: Willem Jan Withagen <wjw@digiware.nl>
Subject: man pages no longer compressing during install?
Date: Sat, 29 Apr 2017 14:16:09 +0200
Message-ID: <81511478-8a15-9cc7-73e5-84102231b1bc@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:22359 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1166713AbdD2MQQ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Sat, 29 Apr 2017 08:16:16 -0400
Received: from [192.168.10.67] (opteron [192.168.10.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id 152A232952
        for <ceph-devel@vger.kernel.org>; Sat, 29 Apr 2017 14:16:13 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

My FreeBSD port assumes that the manpages are installed compresses when
running `make install`.
That used to work, but that is no longer the case...

Now I can fix this in the package-building, but I was wondering why this
is an issue all of a sudden.

--WjW
