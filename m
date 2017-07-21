From: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Subject: external key mgr for ceph-mon?
Date: Fri, 21 Jul 2017 14:30:00 -0400
Message-ID: <CAGbviv+mBMnDo_R81btpw-1jM_5m0ihW5GGJ_uYB7DksT1xKjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:36453 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754621AbdGUSaC (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 21 Jul 2017 14:30:02 -0400
Received: by mail-it0-f41.google.com with SMTP id a62so11506152itd.1
        for <ceph-devel@vger.kernel.org>; Fri, 21 Jul 2017 11:30:01 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Has anyone considered making the ceph-mon process fetch an external
"master" wrapping key from an external server (preferably using KMIP
protocol) to wrap/unwrap the ceph keys used for OSD encryption (or
possibly other keys as well)?

In certain environments, there are strict requirements to have
external key management for disk-encryption keys. Now that keys for
OSD encryption are stored in the monitor, it should be possible to
wrap those keys in the monitor persistent storage with an external key
so that they system could not be started without fetching the master
wrapping key from an external source.

I just wanted to check and see if anyone has done any work in this area.

Wyllys Ingersoll
Keeper Technology, LLC
