From: Yuri Weinstein <yweinste@redhat.com>
Subject: Jewel 10.2.6 ready for release
Date: Thu, 2 Mar 2017 07:40:25 -0800
Message-ID: <CAMMFjmECRzE3WNK=dQtOhuo_+6s2xHFuZvx-dkzFBHjCPSetPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35927 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751149AbdCBWwb (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Mar 2017 17:52:31 -0500
Received: by mail-wm0-f53.google.com with SMTP id n11so2980913wma.1
        for <ceph-devel@vger.kernel.org>; Thu, 02 Mar 2017 14:51:17 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Development, Ceph" <ceph-devel@vger.kernel.org>, Nathan Cutler <ncutler@suse.cz>, "Weil, Sage" <sweil@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Gregory Farnum <gfarnum@redhat.com>, John Spray <jspray@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>, "gmeno@redhat.com" <gmeno@redhat.com>, "Schoen, Andrew" <andrew.schoen@gmail.com>, Abhishek Lekshmanan <abhishek@suse.com>

QE validation is completed and Jewel 10.2.6 is ready for release.

Detailed summary of the QE Validation can be found here
http://tracker.ceph.com/issues/17851#note-92

The following suites were in scope of this point release validation:

rados (subset 35/50 228 jobs)
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

Thx
YuriW
