From: Abhishek Varshney <abhishek.varshney@flipkart.com>
Subject: Upgrading from debian7/hammer to debian8/jewel : rgw logrotate fails
 on the way
Date: Sat, 4 Mar 2017 22:21:19 +0530
Message-ID: <CAP3mxSx8+yuvz8=pt8h6=oNwqQ7fuTv66ZmnfjnQ8fJk0eU7JA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f180.google.com ([209.85.161.180]:35184 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752112AbdCDQvV (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 4 Mar 2017 11:51:21 -0500
Received: by mail-yw0-f180.google.com with SMTP id v198so12358004ywc.2
        for <ceph-devel@vger.kernel.org>; Sat, 04 Mar 2017 08:51:20 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

As part of upgrading from v0.94.2 on debian wheezy to v0.94.6 on
debian jessie and ultimately to jewel, it was found that logrotate for
radosgw fails on ceph v0.94.3 and later, for debian-based distros with
systemd. This probably happens because the radosgw service name has
been renamed to ceph-radosgw with this PR [1].
As far as I understand, systemd support for debian is not present in
hammer and was only introduced in infernalis [2]. But for RHEL-based
distros, hammer does seem to support systemd.

Are there any other gotchas that could be expected with debian jessie
(systemd) + hammer mix? I am aware that hammer is not supported on
debian jessie [3], but this is unavoidable for us to be able to
upgrade from (debian wheezy + hammer) to (debian jessie + jewel).

In case, PRs are still being accepted for hammer, here is the proposed
fix to this particular issue: https://github.com/ceph/ceph/pull/13793.

[1] https://github.com/ceph/ceph/pull/3953
[2] https://github.com/ceph/ceph/pull/5446
[3] http://docs.ceph.com/docs/master/start/os-recommendations/

Thanks
Abhishek
