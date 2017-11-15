From: Yuri Weinstein <yweinste@redhat.com>
Subject: 12.2.2 Luminous validation status
Date: Wed, 15 Nov 2017 14:02:59 -0800
Message-ID: <CAMMFjmGPWHxtGMVsAp2bR1k6tD0BAnwoXCF=d5zr2BYWpkgn9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:50513 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758363AbdKOWDA (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Nov 2017 17:03:00 -0500
Received: by mail-oi0-f42.google.com with SMTP id l138so6998361oib.7
        for <ceph-devel@vger.kernel.org>; Wed, 15 Nov 2017 14:03:00 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>, John Spray <jspray@redhat.com>, Karol Mroz <KMroz@suse.com>, Patrick Donnelly <pdonnell@redhat.com>, "Development, Ceph" <ceph-devel@vger.kernel.org>, "Lekshmanan, Abhishek" <abhishek.lekshmanan@gmail.com>, Nathan Cutler <ncutler@suse.cz>, Ilya Dryomov <idryomov@gmail.com>

Details of this release summarized here
http://tracker.ceph.com/issues/21830#note-26

The following suites included:

rados
rgw
rbd
fs
krbd
kcephfs
knfs
rest
hadoop - EXCLUDED
samba - EXCLUDED
ceph-deploy
ceph-disk
upgrade/client-upgrade-hammer (luminous)
upgrade/client-upgrade-kraken (luminous)
upgrade/client-upgrade-jewel (luminous)
upgrade/jewel-x (luminous)
upgrade/kraken-x (luminous)
upgrade/luminous-x (master) - not ran yet
powercycle
ceph-ansible
(please speak up if something is missing)

Please see all details in the ticket and add comments in the tracker.

Issue http://tracker.ceph.com/issues/22134 failed kcephfs and knfs
suite, needs Sage, Ilya help!

Abhishek, Nathan - I think we need to reopen backpoting for this
release, so we can get suites to "green" state as much as possible as
it will help us save lots of time and energy for future luminous point
releases.

I also suggest to make sure we do limited runs on *all* suites for
future point releases, so we can discover issues earlier (I will be
happy to help running them during integration stage).

Thx
YuriW
