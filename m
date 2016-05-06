From: Yuri Weinstein <yweinste@redhat.com>
Subject: QE validation hammer v0.94.7 finished (needs approval)
Date: Fri, 6 May 2016 09:26:25 -0700
Message-ID: <CAMMFjmFE6NTPA-DkTRubYPeyy+Qk0gHU_da3g97+zK9=Xm+DJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35682 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755528AbcEFQ01 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 May 2016 12:26:27 -0400
Received: by mail-wm0-f47.google.com with SMTP id e201so64035024wme.0
        for <ceph-devel@vger.kernel.org>; Fri, 06 May 2016 09:26:26 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-qa <ceph-qa@ceph.com>, "Development, Ceph" <ceph-devel@vger.kernel.org>, "Weil, Sage" <sage@redhat.com>, "Deza, Alfredo" <adeza@redhat.com>, "Dachary, Loic" <ldachary@redhat.com>, Abhishek Varshney <abhishek.varshney@flipkart.com>, Gregory Farnum <gfarnum@redhat.com>, "Just, Samuel" <sjust@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>, Tamilarasi Muthamizhan <tmuthami@redhat.com>, Gregory Meno <gmeno@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>

Hello

Detailed summary of the QE Validation can be found here
http://tracker.ceph.com/issues/14692#note-61

The following suites were in scope of this point release testing:

rados (subset 1/7)
rbd
rgw
fs
krbd
kcephfs
hadoop
samba
rest
ceph-deploy
upgrade/client-upgrade
upgrade/dumpling-firefly-x (hammer)
upgrade/firefly-x (hammer)
upgrade/hammer
upgrade/hammer-x (infernalis)
powercycle

Known issues (approved for release):

fs:
http://tracker.ceph.com/issues/14716 - (same as in v0.94.6 was
approved by Greg, Josh)

samba:
http://tracker.ceph.com/issues/14714 - (same as in v0.94.6 was approved by Greg)

krbd:
see failed runs, Jason/Josh pls review and approve or suggest next steps.

ceph-deploy:
http://tracker.ceph.com/issues/14223 (same as in v0.94.6 was approved by Sage)

Thx
YuriW
