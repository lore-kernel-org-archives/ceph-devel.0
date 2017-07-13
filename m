From: Alfredo Deza <adeza@redhat.com>
Subject: build issues today
Date: Thu, 13 Jul 2017 08:58:03 -0400
Message-ID: <CAC-Np1wSahSXTNhFmPWf15iL8c9ttUkCJgowEVAzgBYGuG53Kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f178.google.com ([209.85.128.178]:35480 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751165AbdGMM6H (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Jul 2017 08:58:07 -0400
Received: by mail-wr0-f178.google.com with SMTP id k67so52558249wrc.2
        for <ceph-devel@vger.kernel.org>; Thu, 13 Jul 2017 05:58:06 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

We had OutOfMemory errors in the master Jenkins instance, and we had
to bounce the service to be able to get back online.

As a result, most builds in the past 6-8 hours may have been affected
with failures.

The system is now back online.

To further prevent this will require some serious re-work of the
master instance, but in the meantime we can improve this further by
restarting the Jenkins process. We will start scheduling these
restarts on Sunday's at 5am UTC to prevent impact.
