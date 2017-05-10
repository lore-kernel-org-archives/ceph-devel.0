From: Myna V <mynaramana@gmail.com>
Subject: Coupled Layer MSR (Array Codes) in Ceph
Date: Wed, 10 May 2017 16:08:18 +0530
Message-ID: <CAGvpcHZ6PWQXC4bcm7GT5D=uCAyO1PVcc4x1NPJM3jmbMsj0bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pg0-f51.google.com ([74.125.83.51]:35636 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752267AbdEJKi7 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 10 May 2017 06:38:59 -0400
Received: by mail-pg0-f51.google.com with SMTP id o3so14620051pgn.2
        for <ceph-devel@vger.kernel.org>; Wed, 10 May 2017 03:38:59 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi Sage,

We have updated the pull request with the changes suggested during CDM
April meeting.

1. Removing the new filestore:read
2. Having a single function (given by decode2) that can carry out both
decode and repair cases.

We would like to know your comments on the current code.

Pull request link: https://github.com/ceph/ceph/pull/14300

Link with commits in order: https://github.com/mynaramana/ceph/tree/fix2

Thanks,
Myna.
