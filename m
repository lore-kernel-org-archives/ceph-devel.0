From: Alfredo Deza <adeza@redhat.com>
Subject: use ceph-ci.git to get repositories out of dev branches
Date: Wed, 7 Dec 2016 07:34:22 -0500
Message-ID: <CAC-Np1y=2DY7Rve+ao73i7EtKrFY1K_jnDR86Yhhgt9XF7gsQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:34941 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751212AbcLGMeX (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Dec 2016 07:34:23 -0500
Received: by mail-qk0-f176.google.com with SMTP id n204so411720498qke.2
        for <ceph-devel@vger.kernel.org>; Wed, 07 Dec 2016 04:34:23 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>
Cc: Andrew Schoen <aschoen@redhat.com>

As announced on November 23rd, please start pushing development
branches to ceph-ci.git (https://github.com/ceph/ceph-ci) to get
repositories.

This doesn't change reporting in https://shaman.ceph.com and it
shouldn't affect testing via teuthology.

The ceph.git repository will continue to build binaries and
repositories for another week to help transitioning.

If you have any issues, please mention them in the #sepia or
#ceph-devel channels to me (alfredodeza) or Andrew Schoen
(andrewschoen).

Thanks!


-Alfredo
