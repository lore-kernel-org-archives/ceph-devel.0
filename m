From: Alfredo Deza <adeza@redhat.com>
Subject: on demand documentation builds on pull requests
Date: Mon, 14 Aug 2017 12:39:50 -0400
Message-ID: <CAC-Np1x7Q9KmbWJc3OmKiBh_w6EZeDK5soNGz9dzUFz3Pdzzfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35909 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751365AbdHNQjw (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Aug 2017 12:39:52 -0400
Received: by mail-wm0-f48.google.com with SMTP id t201so41480447wmt.1
        for <ceph-devel@vger.kernel.org>; Mon, 14 Aug 2017 09:39:52 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

We have added a check to build docs on pull requests.  This is handy
to catch rst->html rendering issues that might be tricky to spot.

The job is configured to include the url where the html build was
published so that it is easier to find
the right location.

This is an "on demand" build, so it only runs when the following
comment is added on a pull request:

    jenkins test docs

The convention for the build URL is:

    http://docs.ceph.com/ceph-prs/{pull request id}/

Thanks!


-Alfredo
