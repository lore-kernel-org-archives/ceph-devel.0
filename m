From: Gregory Meno <gmeno@redhat.com>
Subject: Are we ready to move from Trusty to Xenial in the lab?
Date: Tue, 13 Sep 2016 12:05:27 -0700
Message-ID: <CABq-AyRr-tKgtm9dOF4g2fxL7aR4jPfYtLppBc_12Uh39xJL8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f181.google.com ([209.85.216.181]:33861 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755539AbcIMTF2 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Sep 2016 15:05:28 -0400
Received: by mail-qt0-f181.google.com with SMTP id 38so94304435qte.1
        for <ceph-devel@vger.kernel.org>; Tue, 13 Sep 2016 12:05:28 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hello readers,

I am aware that our nightly tests are running on centos7 and trusty in
the sepia lab. xenial has been the lastest LTS release of Ubuntu for
some time now. It seems like we should move the nightly testing on to
xenial

Here are some benefits to moving the nightlies up to xenial:

* Quicker feedback of issues before we release
* Easier access to reproduce issues that are reported after release
* provide an easy way to judge readiness for a Python3 world

Some things that might prevent us from going there this week.

* we should wait till we have a mechanism to re-image bare metal lab
machines on the fly before each test (edeploy --
https://github.com/redhat-cip/edeploy)
* python3 isn't quite ready and we'll feel a lot of pain in the short term

Is there something I'm missing here?
Should we just go ahead and see how it goes?

cheers,
Gregory
