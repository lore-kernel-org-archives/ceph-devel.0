From: Yuri Weinstein <yweinste@redhat.com>
Subject: Status of luminous v12.2.1 QE validation
Date: Tue, 19 Sep 2017 13:10:31 -0700
Message-ID: <CAMMFjmF5OczC9Yg1F2S3EvPAZO4ZBefpuxNm-f70XG-dr6-31g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:53548 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751227AbdISUKc (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Sep 2017 16:10:32 -0400
Received: by mail-io0-f176.google.com with SMTP id q11so1820401ioe.10
        for <ceph-devel@vger.kernel.org>; Tue, 19 Sep 2017 13:10:32 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Patrick Donnelly <pdonnell@redhat.com>, Abhishek Lekshmanan <abhishek@suse.com>, "Development, Ceph" <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>, John Spray <jspray@redhat.com>, "gmeno@redhat.com" <gregory.meno@inktank.com>, "Durgin, Josh" <jdurgin@redhat.com>, Nathan Cutler <ncutler@suse.cz>, Zheng Yan <zyan@redhat.com>, Vasu Kulkarni <vakulkar@redhat.com>, "Dreyer, Ken" <kdreyer@redhat.com>, Ilya Dryomov <idryomov@redhat.com>

Details of this release summarized here
http://tracker.ceph.com/issues/21296#note-18

The following suites included:

rados
rgw
rbd
fs
krbd
kceph
knfs
rest
hadoop - EXCLUDED
samba - EXCLUDED
ceph-deploy
ceph-disk
upgrade/client-upgrade
upgrade/jewel-x (luminous)
upgrade/kraken-x (luminous)
upgrade/luminous-x (master)
powercycle
ceph-ansible
(please speak up if something is missing)

Issues:

rados.rbd
http://tracker.ceph.com/issues/21428 (assume is a `must` to be backported)

fs
http://tracker.ceph.com/issues/21381 - known
http://tracker.ceph.com/issues/20910 - known
http://tracker.ceph.com/issues/20736 - known

kcephfs - needs analysis - Patrick, Zheng FYI

knfs
http://tracker.ceph.com/issues/21424

rest
http://tracker.ceph.com/issues/21425

ceph-ansible related - per Vasu ceph-asible pass on master, PRs are to
be backported:
https://github.com/ceph/ceph/pull/17757
https://github.com/ceph/ceph-ansible/issues/1834

RHEL 7.4 related PRs need to backported:
https://github.com/ceph/ceph/pull/17776
https://github.com/ceph/ceph/pull/17796
https://github.com/ceph/ceph/pull/17777

Not all tests were completed yet.

I suggest to consider the list for fixing/backporting and then rerun
all suites on a new sha1.

Thx
YuriW
