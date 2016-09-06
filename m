From: Yuri Weinstein <yweinste@redhat.com>
Subject: ceph v10.2.3 QE validation status
Date: Tue, 6 Sep 2016 10:12:10 -0700
Message-ID: <CAMMFjmHb=m_WJg8TMaVBOdXB37=viYOBSOYEXL_Bo3kET=hyoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:38577 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936599AbcIFRMN (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Sep 2016 13:12:13 -0400
Received: by mail-wm0-f52.google.com with SMTP id 1so202117471wmz.1
        for <ceph-devel@vger.kernel.org>; Tue, 06 Sep 2016 10:12:12 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>, Abhishek Varshney <abhishek.varshney@flipkart.com>, "Dachary, Loic" <ldachary@redhat.com>, "Dachary, Loic" <loic@dachary.org>, "Weil, Sage" <sage@redhat.com>, "Just, Samuel" <sjust@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, David Zafman <dzafman@redhat.com>

Detailed summary of the QE Validation can be found here
http://tracker.ceph.com/issues/16344#note-46

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
upgrade/infernalis-x (jewel)
powercycle
(please let me know if any suites are missing from this ^ list)

==============================
Issues requiring approval/decision:

rados:
   http://tracker.ceph.com/issues/16516 (approved by DavidZ)

rbd:
   multiple issues (Jason pls rview/approve, see notes
http://tracker.ceph.com/issues/16344#note-46)

krbd:
   http://tracker.ceph.com/issues/17223
   http://tracker.ceph.com/issues/17221
   http://tracker.ceph.com/issues/17222
   (Jason pls rview/approve)

knfs
   http://tracker.ceph.com/issues/17192
   (Greg pls rview/approve, note: it's similar we saw in hammer point release)

samba:
   http://tracker.ceph.com/issues/17184
   (Greg pls rview/approve)

upgrade/client-upgrade:about:startpage
   http://tracker.ceph.com/issues/16506
   (Sage, Sam, Jason pls rview/approve)

upgrade/infernalis-x (jewel):
   http://tracker.ceph.com/issues/17176
   (Sam, David  pls rview/approve)

powercycle:
   http://tracker.ceph.com/issues/17177
   (Sage  pls rview/approve)

Loic, given that we have high number of issues in this release, if you
and dev leads find that we need to add more backports we may consider
validating a new point RC (sha1).

Thx
YuriW
