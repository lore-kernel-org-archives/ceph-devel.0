From: Henrique Fingler <hfingler@cs.utexas.edu>
Subject: How do I "install" from source? Service binaries (and /etc/ceph) are
 missing after make install
Date: Fri, 15 Sep 2017 19:18:32 -0400
Message-ID: <CACG+mBVY==QPieFqgP1Qf1tcibRJZS5LhU02Wsca+4q=o2EkFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from newman.cs.utexas.edu ([128.83.139.110]:55814 "EHLO
        newman.cs.utexas.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751164AbdIOX0D (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Sep 2017 19:26:03 -0400
Received: from mail-oi0-f41.google.com (mail-oi0-f41.google.com [209.85.218.41])
        (authenticated bits=0)
        by newman.cs.utexas.edu (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id v8FNIc0p016868
        (version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
        for <ceph-devel@vger.kernel.org>; Fri, 15 Sep 2017 18:18:38 -0500
Received: by mail-oi0-f41.google.com with SMTP id p126so246153oih.9
        for <ceph-devel@vger.kernel.org>; Fri, 15 Sep 2017 16:18:38 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I made some modifications to the source code and I'm trying to deploy it.

 The ceph-deploy fails because I dont want to do "ceph-deploy
install", and even if I run "sudo make install" some service binaries
are not found,  /etc/ceph and the dir on /var/ are not created.

 So now I'm just trying to do a manual deploy and I can't do the
monitor part. I run everything, but when I try to actually launch the
monitor, I can't. The manual says to run "sudo start ceph-mon
id=node1" if I have ubuntu. Well, AWS's ubuntu doesn't use upstart so
that doesn't work. I then tried "sudo /etc/init.d/ceph start
mon.node1", but ceph doesn't exist in init.d.

 How is it created and who does it? Is it a symlink to the binary? Why
doesn't "make install" do this automatically? Is there a script to do
the delta between installing from a package manager and installing
from source?

 My modified version was based on Jewel if that's important.

 Thanks.
