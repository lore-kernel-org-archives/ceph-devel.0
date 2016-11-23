From: Alfredo Deza <adeza@redhat.com>
Subject: repository build process change
Date: Wed, 23 Nov 2016 15:15:49 -0500
Message-ID: <CAC-Np1zuviMENxn-4ZWMbC78b7J2x1asxg-i3ks+7uTkfuyaRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:33356 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934653AbcKWUPu (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Nov 2016 15:15:50 -0500
Received: by mail-qk0-f181.google.com with SMTP id x190so27974531qkb.0
        for <ceph-devel@vger.kernel.org>; Wed, 23 Nov 2016 12:15:50 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Starting next week we will start building binaries and repositories
from the ceph-ci.git repo (https://github.com/ceph/ceph-ci).

The current build process, which uses ceph.git will also continue at
the same time, so there is
enough time to transition over.

This doesn't change anything for a developer except where it needs to
push to get a repository
with binaries for a given branch.

After a week of correctly building from both repositories I will send
a follow up email to warn of the change.

Let me know if you have any questions,


Thanks!
