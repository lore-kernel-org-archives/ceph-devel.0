From: Yuri Weinstein <yweinste@redhat.com>
Subject: Jewel 10.2.7 QE status
Date: Wed, 5 Apr 2017 13:16:12 -0700
Message-ID: <CAMMFjmH_DTdeQDB-C4+A7KsUyAF0jxsZRyGn-2drEOxFds7jsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f174.google.com ([209.85.128.174]:33704 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933851AbdDEUQU (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Apr 2017 16:16:20 -0400
Received: by mail-wr0-f174.google.com with SMTP id w43so29894488wrb.0
        for <ceph-devel@vger.kernel.org>; Wed, 05 Apr 2017 13:16:19 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Development, Ceph" <ceph-devel@vger.kernel.org>

Detailed summary of the QE Validation can be found here
http://tracker.ceph.com/issues/19055#note-13
The following suites were in scope of this point release validation:

rados (subset 35/50 227 jobceph-ansibles)
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

=====================
Outstanding issues

rados - two jobs failed, need Josh's approval
krbd - seems similar to previous release, need Ilya's approval

upgrade/client-upgrade
and
upgrade/hammer-x (jewel) - suspect
http://tracker.ceph.com/issues/19429, need Sage/Josh approve

Thx
YuriW
