From: Alfredo Deza <adeza@redhat.com>
Subject: dev build issues
Date: Fri, 30 Jun 2017 16:39:13 -0400
Message-ID: <CAC-Np1wO-S1B2O_a+HvY=-TqO4oOkq-pVpaZ9DqGy5HcYBW74g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f179.google.com ([209.85.128.179]:35825 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751982AbdF3UjP (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Jun 2017 16:39:15 -0400
Received: by mail-wr0-f179.google.com with SMTP id k67so208847527wrc.2
        for <ceph-devel@vger.kernel.org>; Fri, 30 Jun 2017 13:39:14 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

We are experiencing DNS issues where some of our build nodes can't
resolve other services in the system.

This means that some builds will just not complete and will appear as
'started' (yellow) in shaman.

We are going to try to get these build nodes to resolve more robustly,
in the meantime you can trigger another build with an amend to your
last commit and pushing, or rebasing and pushing to your branch in
ceph-ci.git

The reason why it is not immediately apparent that the build has
failed is because the build node is in charge of updating the status,
but since it can't resolve shaman.ceph.com the build in shaman appears
to stay in 'building' state (yellow)

These fail fairly quickly, so for now, please check after a few
minutes to re-trigger if the build didn't go through.

-Alfredo
