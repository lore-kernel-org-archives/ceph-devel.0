From: Yuri Weinstein <yweinste@redhat.com>
Subject: QE validation hammer v0.94.6 finished
Date: Fri, 19 Feb 2016 11:53:16 -0800
Message-ID: <CAMMFjmHB6-dBJ2eHDPTTMiyi4+e5RLj4jaYbnHQZYzSiAemtBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:34927 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166AbcBSTxR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Feb 2016 14:53:17 -0500
Received: by mail-io0-f171.google.com with SMTP id g203so120660215iof.2
        for <ceph-devel@vger.kernel.org>; Fri, 19 Feb 2016 11:53:16 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-qa <ceph-qa@ceph.com>, "Development, Ceph" <ceph-devel@vger.kernel.org>, "Weil, Sage" <sage@redhat.com>, "Deza, Alfredo" <adeza@redhat.com>, "Dachary, Loic" <ldachary@redhat.com>, Abhishek Varshney <abhishek.varshney@flipkart.com>, Gregory Farnum <gfarnum@redhat.com>, "Just, Samuel" <sjust@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>, Tamilarasi Muthamizhan <tmuthami@redhat.com>, Gregory Meno <gmeno@redhat.com>

Hello

Abhishek, Loic, Alfredo - QE validation finished and v0.94.6 is ready
for publishing.

Detailed summary of the QE Validation can be found here
http://tracker.ceph.com/issues/13356#note-61

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
http://tracker.ceph.com/issues/14716 - approved by Greg, Josh

samba:
http://tracker.ceph.com/issues/14714 - approved by Greg

krbd:
http://tracker.ceph.com/issues/14715
http://tracker.ceph.com/issues/14717
- approved by Josh

ceph-deploy:
http://tracker.ceph.com/issues/14223
- approved by Sage

Thx
YuriW
