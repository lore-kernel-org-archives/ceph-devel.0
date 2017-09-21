From: Yuri Weinstein <yweinste@redhat.com>
Subject: ceph v10.2.10 QE validation status
Date: Thu, 21 Sep 2017 14:11:15 -0700
Message-ID: <CAMMFjmHRF8AA3h0Sta==y5XMXNqZBMtwz-nno4hEpVP24EBMcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:44016 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751793AbdIUVLR (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Sep 2017 17:11:17 -0400
Received: by mail-io0-f182.google.com with SMTP id k101so13915516iod.0
        for <ceph-devel@vger.kernel.org>; Thu, 21 Sep 2017 14:11:16 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>, Abhishek Varshney <abhishek.varshney@flipkart.com>, "Dachary, Loic" <ldachary@redhat.com>, "Dachary, Loic" <loic@dachary.org>, "Weil, Sage" <sage@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, Nathan Cutler <ncutler@suse.cz>, Ilya Dryomov <idryomov@gmail.com>, John Spray <jspray@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>

Detailed summary of the QE Validation can be found here
http://tracker.ceph.com/issues/20613#note-65

rados (subset 227 jobs)
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
upgrade/jewel-x/point-to-point-x
powercycle
ceph-ansible
(please let me know if any suites are missing from this ^ list)


==============================
Issues requiring approval/decision:

rados - needs Josh review/approval
fs - needs Patrick review/approval
krbd - approved by Ilya
hadoop - EXCLUDED FROM THIS RELEASE
samba - EXCLUDED FROM THIS RELEASE
upgrade/jewel-x/point-to-point-x Nathan is fixing one issue
ceph-ansible -
needs Sebastian, Vasu, Andrew review/approval

I am not clear on our validation approach for ceph-ansible suite and
added a ticket to address it
https://github.com/ceph/ceph-ansible/issues/1938

Nathan, over after we do minor clean up it feels we will be ready to
publish v10.2.10.

Thx
YuriW
