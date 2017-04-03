From: Myna V <mynaramana@gmail.com>
Subject: Coupled Layer MSR: PR 14300, ECSubRead decode fail.
Date: Mon, 3 Apr 2017 23:32:11 +0530
Message-ID: <CAGvpcHbbY2wU+vMxooxg=JC41c1DRaAKj86fw3ybGvFcNfWhLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50]:34374 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751757AbdDCSCw (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Apr 2017 14:02:52 -0400
Received: by mail-pg0-f50.google.com with SMTP id 21so127743425pgg.1
        for <ceph-devel@vger.kernel.org>; Mon, 03 Apr 2017 11:02:52 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Elita Lobo <loboelita@gmail.com>, Bhagyashree Puranik <bhagya.puranik@gmail.com>, Birenjith Sasidharan <birenjith@gmail.com>, Ganesh Kini <kiniganesh94@gmail.com>, Vinayak Ramkumar <vinram93@gmail.com>

Hello All,

This is regarding the make check error in readable.sh

https://jenkins.ceph.com/job/ceph-pull-requests/21319/

We have added additional fields to the ECSubRead message type and
updated the encode, decode of ECSubRead message to incorporate the
newly added fields. The failure seems to happen when the object (older
ECSubRead) is being decoded with the new decode function as it is
expecting a larger buffer length.

How do we update the test objects in ceph-object-corpus with these
added fields ?

Thanks,
Myna.
