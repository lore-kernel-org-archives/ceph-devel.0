From: Two Spirit <twospirit6905@gmail.com>
Subject: Write to Secondary Zone?
Date: Fri, 29 Sep 2017 08:41:21 -0700
Message-ID: <CAKRxpuv1CtoEJHhsp3tk3Az1PrWZ3bP9kOT_fiAOmXutzPsXrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:51499 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751349AbdI2PlW (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Sep 2017 11:41:22 -0400
Received: by mail-io0-f178.google.com with SMTP id l15so145185iol.8
        for <ceph-devel@vger.kernel.org>; Fri, 29 Sep 2017 08:41:22 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Is it now supported to be able to write to a secondary zone without problems?

If not supported, is there a timeframe that this (being able to write
to secondary zones) would be supported?

It also looks like the federated solution does not scale well with
multi region all in sync.

Is there support in Ceph for region-to-region syncing. Based on the
figure in the documentation, it appears that zone to zone syncing does
not happen across a slow wan link (as there are 3 MONs in the backend,
and unified Ceph cluster is not recommended across a WAN)
