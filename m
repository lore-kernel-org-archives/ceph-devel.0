From: kefu chai <tchaikov@gmail.com>
Subject: master / mimic-dev1 deb build broken on ceph/ceph-ci
Date: Thu, 4 Jan 2018 21:37:21 +0800
Message-ID: <CAJE9aOPsGdqDEZFFxwYJ2SRgqOPSkYmC5px5yKyMkvYw0GsP3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f182.google.com ([209.85.216.182]:46582 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752699AbeADNhX (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Jan 2018 08:37:23 -0500
Received: by mail-qt0-f182.google.com with SMTP id r39so1840285qtr.13
        for <ceph-devel@vger.kernel.org>; Thu, 04 Jan 2018 05:37:23 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: The Esoteric Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

hi guys,

as you may notice that we recently switched our toolchain on xenial to
gcc-7. to enable the built executables to run on old systems without
the new libstdc++ runtime, they should be linked against libstdc++
statically. but the master and mimic-dev1 branches fail to do so.
that's why the built packages will refuse to install with error
messages like:

ceph-test : Depends: libradosstriper1 but it is not going to be installed
             Depends: libstdc++6 (>= 6) but 5.4.0-6ubuntu1~16.04.5 is
to be installed


https://github.com/ceph/ceph/pull/19763 is posted to address this
issue. but before it is merged, please include it for testing your
debian packages in sepia.

the centos-7 build is not impacted by this issue, as it use DTS-7, and
DTS-7's ld script links the stdc++_nonshared.a for us by default.

sorry for the inconvenience =(

-- 
Regards
Kefu Chai
