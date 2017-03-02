From: Brett Niver <bniver@redhat.com>
Subject: Testing with Bluestore and Filestore
Date: Thu, 2 Mar 2017 11:36:34 -0500
Message-ID: <CAMdDSN2xU=eRCxEDrq3qP0zmXxxTLAZrSboHcB8N4EH2ZhU8PQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot0-f171.google.com ([74.125.82.171]:35091 "EHLO
        mail-ot0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751141AbdCBQhz (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Mar 2017 11:37:55 -0500
Received: by mail-ot0-f171.google.com with SMTP id x37so11206130ota.2
        for <ceph-devel@vger.kernel.org>; Thu, 02 Mar 2017 08:36:35 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Jason Dillaman <jdillama@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Sage,

Perhaps this has already been discussed, but Jason had a good idea,
that perhaps instead of testing both BS and FS upstream independently,
 and doubling our testing, we might have teuthology randomly pick
which to use.

That would potentially reduce TCs and also give us the testing that
would help prepare for working thru the migration/transition once BS
is ready.

Brett
