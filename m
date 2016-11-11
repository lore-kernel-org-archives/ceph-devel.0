From: Yuri Weinstein <yweinste@redhat.com>
Subject: ceph v10.2.4 QE validation status
Date: Fri, 11 Nov 2016 08:47:50 -0800
Message-ID: <CAMMFjmEkMUBCnZFqMr_kcfZgB5jm3CjVNfXpSAXT7ZCwMLQEfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:36122 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756128AbcKKQ6g (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Nov 2016 11:58:36 -0500
Received: by mail-wm0-f44.google.com with SMTP id g23so108886619wme.1
        for <ceph-devel@vger.kernel.org>; Fri, 11 Nov 2016 08:57:05 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>, Abhishek Varshney <abhishek.varshney@flipkart.com>, "Dachary, Loic" <ldachary@redhat.com>, "Dachary, Loic" <loic@dachary.org>, "Weil, Sage" <sage@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, Nathan Cutler <ncutler@suse.cz>, Ilya Dryomov <idryomov@gmail.com>, John Spray <jspray@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>

Detailed summary of the QE Validation can be found here
http://tracker.ceph.com/issues/17487#note-32

The following suites were in scope of this point release validation:

rados (subset 35/50 297 jobs)
rbd
rgw
fs
krbd
kcephfs
knfs
rest
hadoop
samba
ceph-deploy
ceph-disk
upgrade/client-upgrade
upgrade/hammer-x (jewel)
upgrade/infernalis-x (jewel) - deprecated
powercycle
(please let me know if any suites are missing from this ^ list)

==============================
Issues requiring approval/decision:

fs - http://tracker.ceph.com/issues/17832 (Greg pls review/approve)

krbd - http://tracker.ceph.com/issues/17221 (Jason, Ilya pls review/approve)

knfs - http://tracker.ceph.com/issues/16397 (same as in v10.2.3, Greg
pls review/approve)

upgrade/hammer-x (jewel) - http://tracker.ceph.com/issues/17847 ((Sage
pls review/approve)

upgrade/infernalis-x (jewel) - deprecated, but Nathan is still working
to make it pass (Sage pls review/approve)

powercycle - in progress

Thx
YuriW
