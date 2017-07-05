From: Yuri Weinstein <yweinste@redhat.com>
Subject: Jewel 10.2.8 QE status
Date: Wed, 5 Jul 2017 08:39:04 -0700
Message-ID: <CAMMFjmFCkkwKij64f-04gksGOxC0qSSHvhvd0_KEq_BiKiZDuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f175.google.com ([209.85.128.175]:35721 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751681AbdGEPjG (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Jul 2017 11:39:06 -0400
Received: by mail-wr0-f175.google.com with SMTP id k67so264589700wrc.2
        for <ceph-devel@vger.kernel.org>; Wed, 05 Jul 2017 08:39:05 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Development, Ceph" <ceph-devel@vger.kernel.org>, Nathan Cutler <ncutler@suse.cz>, "Weil, Sage" <sage@redhat.com>, "Deza, Alfredo" <adeza@redhat.com>

Detailed summary of the QE Validation can be found here
http://tracker.ceph.com/issues/19538#note-89
The following suites were in scope of this point release validation:

rados (subset 35/50 227 jobs)
rbd
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
upgrade/hammer-x (jewel)
upgrade/jewel-x/point-to-point-x
powercycle
ceph-ansible

(please let me know if any suites are missing from this ^ list)

Three PRs were merged to fix minor issues:

https://github.com/ceph/ceph/pull/16089
https://github.com/ceph/ceph/pull/16088
https://github.com/ceph/ceph/pull/14710

The SHA1 is 66dbf9beef04988dbd3653591e51afa6d84e3990 (tip of "jewel"
branch) - Nathan pls double check.

Jewel 10.2.8 QE - is ready for publishing.
Alfredo FYI

Thx
YuriW
