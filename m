From: Yuri Weinstein <yweinste@redhat.com>
Subject: 12.2.3 QE Luminous validation status
Date: Tue, 13 Feb 2018 13:36:54 -0800
Message-ID: <CAMMFjmHppXYtqbUA7a6DE3g2fH_pF60BzMtKPhW6y1uVGru0Nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pg0-f45.google.com ([74.125.83.45]:39319 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965749AbeBMVg4 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Feb 2018 16:36:56 -0500
Received: by mail-pg0-f45.google.com with SMTP id w17so796552pgv.6
        for <ceph-devel@vger.kernel.org>; Tue, 13 Feb 2018 13:36:55 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>, John Spray <jspray@redhat.com>, Karol Mroz <KMroz@suse.com>, Patrick Donnelly <pdonnell@redhat.com>, "Development, Ceph" <ceph-devel@vger.kernel.org>, "Lekshmanan, Abhishek" <abhishek.lekshmanan@gmail.com>, Nathan Cutler <ncutler@suse.cz>, Ilya Dryomov <idryomov@gmail.com>, Jeff Layton <jlayton@redhat.com>, ceph-qe-team <ceph-qe-team@redhat.com>, "Deza, Alfredo" <adeza@redhat.com>, Andrew Schoen <aschoen@redhat.com>

Details of this release summarized here
http://tracker.ceph.com/issues/22665#note-4

The following suites included:

rados
rgw
rbd
krbd
fs
kcephfs
multimds
knfs
hadoop - EXCLUDED
samba - EXCLUDED
ceph-deploy
ceph-disk
upgrade/client-upgrade-hammer (luminous)
upgrade/client-upgrade-kraken (luminous)
upgrade/client-upgrade-jewel (luminous)
upgrade/jewel-x (luminous)
upgrade/kraken-x (luminous)
upgrade/luminous-x (master) - EXCLUDED
powercycle
ceph-ansible
ceph-volume
(please speak up if something is missing)

Please see all details in the ticket and add comments in the tracker.

Seeking approval from the dev leads.

Issues:

rados - passed, Josh pls confirm approval.

rgw - Casey, Abhishek - do we want to ad//merge
https://github.com/ceph/ceph/pull/20407 ?

rbd, krbd - approved by Jason

fs, kcephfs, multimds - approved by Patrick

knfs - pending review/approval from Jeff (http://tracker.ceph.com/issues/22995)

ceph-deploy - approved by Vasu

upgrade/client-upgrade-kraken - Nathan, do/can we include your fix
into this release ?

upgrade/kraken-x (luminous) - some jobs still rerunning

upgrade/luminous-x (master) - Sage you to exclude this suite for now?

ceph-volume - pending approval from  Alfredo, Andrew

Pls reply

Thx
YuriW
