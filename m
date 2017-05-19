From: Xiaoxi Chen <superdebuger@gmail.com>
Subject: [Rgw][Swift API] Swift Midlleware compability
Date: Fri, 19 May 2017 15:48:23 +0800
Message-ID: <CAEYCsV+S6CJWo-4Zx7XU+s5vyRkpZifROgvHUsc5=AYpzLWUbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yb0-f180.google.com ([209.85.213.180]:33296 "EHLO
        mail-yb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750755AbdESHsY (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 19 May 2017 03:48:24 -0400
Received: by mail-yb0-f180.google.com with SMTP id 187so9539865ybg.0
        for <ceph-devel@vger.kernel.org>; Fri, 19 May 2017 00:48:24 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@lists.ceph.com>

Hi,

    When we are evaluating migrating object storage cluster from swift
to ceph, all technical stuff goes fine except swift middleware.  To be
honest swift middleware (and WSGI Pipeline) provide lots of
flexibility and easy customization to enterprise user, we have some
home made middleware together with some from community. Now the
challenge for me is how to migrate such customization into ceph.

     One straightforward approach is re-implement such middleware
directly inside RGW code, but this is the least desire approach as we
need to maintain and build our own RGW package every new ceph release,
including own QA infrastructure.

     Second approach is having a swift-to-rgw WSGI-proxy for RGW, it
was discussed in ML 2 years ago
(http://permalink.gmane.org/gmane.comp.file-systems.ceph.devel/24320)
and POC code implementation on (https://github.com/rzarzynski/rgwift).
It doesn't attract too much attention but I would like to reraise it,
see if it is the way we want to go.  Pros on this approach is
simplicity , user doesn't need to re-write existing logical in swift
middleware, and the swift API is not changing actively so it is not
too burden for community to maintain such WSGI proxy. Cons including
deployment complexity.


      Third one, could we have similar extension mechanism for RGW?
Would be nice if we can have customizable pipeline but some hook on
certain stage (pre-access, core-rgw, post-access) could also be a good
start ?

Xiaoxi
