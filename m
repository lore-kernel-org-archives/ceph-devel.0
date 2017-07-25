From: Alfredo Deza <adeza@redhat.com>
Subject: unable to build Debian Stretch for 12.1.2
Date: Tue, 25 Jul 2017 15:02:14 -0400
Message-ID: <CAC-Np1y2RLRHTgbjNF7uM6-+nho1tz2PUxDE6pdef1y-bMtZxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:36533 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750732AbdGYTCQ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Jul 2017 15:02:16 -0400
Received: by mail-wm0-f43.google.com with SMTP id t201so53912228wmt.1
        for <ceph-devel@vger.kernel.org>; Tue, 25 Jul 2017 12:02:15 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

We are (consistently) hitting this Segmentation Fault:

/build/ceph-12.1.2/src/test/librbd/object_map/test_mock_LockRequest.cc:61:3:
internal compiler error: Segmentation fault
   }
   ^

https://jenkins.ceph.com/job/ceph-build/ARCH=x86_64,AVAILABLE_ARCH=x86_64,AVAILABLE_DIST=stretch,DIST=stretch,MACHINE_SIZE=huge/237/consoleFull#-1443688772a811ea2-3e7b-466b-84b4-d13df7e35809

The builds for Debian distros are all produced from Xenial hosts that
use pbuilder to accommodate any Deb distro. On the same host, Xenial
and Trusty works fine for example.

GCC version on the box that failed:

gcc (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609

The scripts we use for building are here:
https://github.com/ceph/ceph-build/tree/master/ceph-build/build

Unless someone can help out identify why this happens and how to fix
it, it means that we will not be able to have Stretch packages.

-Alfredo
