From: Yuri Weinstein <yweinste@redhat.com>
Subject: kraken v11.2.1 QE status
Date: Sat, 5 Aug 2017 09:04:30 -0700
Message-ID: <CAMMFjmHRoBZP5YbrJEXUDd5F7JUbB5_r2CubuD_j6pL8J0SP3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f172.google.com ([209.85.128.172]:36904 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751226AbdHEQEc (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 5 Aug 2017 12:04:32 -0400
Received: by mail-wr0-f172.google.com with SMTP id 33so25887873wrz.4
        for <ceph-devel@vger.kernel.org>; Sat, 05 Aug 2017 09:04:32 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Development, Ceph" <ceph-devel@vger.kernel.org>, Nathan Cutler <ncutler@suse.cz>, "Weil, Sage" <sage@redhat.com>, "Deza, Alfredo" <adeza@redhat.com>, Ilya Dryomov <idryomov@redhat.com>

Detailed summary of the QE Validation can be found here
http://tracker.ceph.com/issues/19009#note-91

The following suites were in scope of this point release validation:

rados (subset 35/50 245 jobs)
rbd  (subset 35/50 100 jobs)
rgw
fs
krbd
kcephfs
knfs
rest
hadoop - EXCLUDED
samba - EXCLUDED
ceph-deploy
ceph-disk
upgrade/client-upgrade
upgrade/jewel-x (kraken)
upgrade/hammer-jewel-x - EXCLUDED
powercycle
ceph-ansible

(please let me know if any suites are missing from this ^ list)

Outstanding issues:

krbd - Ilya, pls review and approve/comment for release as appropriate

upgrade/client-upgrade - failed as expected, pls confirm approval, exclusion

upgrade/jewel-x (kraken) - one job failed, I suspect it's the same we
saw for jewel release (https://github.com/ceph/ceph/pull/16089),
confirm approval

ceph-ansible - failed, https://github.com/ceph/ceph-ansible/issues/1737

Thx
YuriW
