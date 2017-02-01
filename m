From: Yuri Weinstein <yweinste@redhat.com>
Subject: hammer 0.94.10 QE status
Date: Wed, 1 Feb 2017 08:55:23 -0800
Message-ID: <CAMMFjmEwGeC5JT4WBe=+YFj=tC2NreQhQBhG7Au0vrvxzHZObQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35190 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752974AbdBAQzZ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Feb 2017 11:55:25 -0500
Received: by mail-wm0-f48.google.com with SMTP id b65so47807774wmf.0
        for <ceph-devel@vger.kernel.org>; Wed, 01 Feb 2017 08:55:24 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Development, Ceph" <ceph-devel@vger.kernel.org>, Nathan Cutler <ncutler@suse.cz>, "Weil, Sage" <sweil@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>, "Just, Samuel" <sjust@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Gregory Farnum <gfarnum@redhat.com>, John Spray <jspray@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>

Here is snapshot of hammer 0.94.10 point release testing status.

Suites were not tested on ubuntu 16.06 due to
http://tracker.ceph.com/issues/18382 and as a result were forced to
test on ubuntu 14.04 and centos 7.2 (note we don't have smithi with
centos 7.3).

There was an additional noise created by fact that since we tested
last hammer release in August 2016 we moved from gitbuilders to shaman
build system and it resulted in issues with some packages.

Details of tests can be found here http://tracker.ceph.com/issues/17151#note-61

======================
rados ubuntu - packaging issues, need approval - Josh
rados centos - packaging issues, need approval - Josh
======================
rbd - PASSED
======================
rgw ubuntu - PASSED
rgw centos - valgrind issues http://tracker.ceph.com/issues/18735,
need approval Yehuda, Sage
======================
fs ubuntu - looks similar to v0.94.8, need Greg, John approval
fs centos - noise? need Greg, John review/approval
======================
krbd ubuntu - looks like the same in v0.94.8
http://tracker.ceph.com/issues/15895#note-33 need approval Jason, Ilya
krbd centos -  looks like the same in v0.94.8
http://tracker.ceph.com/issues/15895#note-33 need approval Jason, Ilya
======================
kcephfs - PASSED
======================
knfs - PASSED
======================
hadoop - PASSED
======================
samba - packaging issues, need approval - Greg, Sage
======================
rest  - PASSED
======================
ceph-deploy - Vasu is fixing, need approval Sage
======================
upgrade/client-upgrade - PASSED
======================
upgrade/firefly-x (hammer) - need Sage approval. maybe deprecate?
======================
upgrade/hammer - PASSED
======================
upgrade/hammer-x (jewel) - FAILED, need Sage approval. maybe deprecate?
======================
powercycle - PASSED
======================

Thx
YuriW
