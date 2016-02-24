From: Yuri Weinstein <yweinste@redhat.com>
Subject: QE validation infernalis v9.2.1 status
Date: Wed, 24 Feb 2016 08:24:04 -0800
Message-ID: <CAMMFjmG3ukLQQiw6=R8z4PaR=MxVBvME4Qh3e-RsqFvrgdpqug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:36057 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751837AbcBXQYG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Feb 2016 11:24:06 -0500
Received: by mail-io0-f179.google.com with SMTP id l127so49470604iof.3
        for <ceph-devel@vger.kernel.org>; Wed, 24 Feb 2016 08:24:05 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-qa <ceph-qa@ceph.com>, "Development, Ceph" <ceph-devel@vger.kernel.org>, "Weil, Sage" <sage@redhat.com>, "Deza, Alfredo" <adeza@redhat.com>, "Dachary, Loic" <ldachary@redhat.com>, Abhishek Varshney <abhishek.varshney@flipkart.com>, Gregory Farnum <gfarnum@redhat.com>, "Just, Samuel" <sjust@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>, Tamilarasi Muthamizhan <tmuthami@redhat.com>, Gregory Meno <gmeno@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>

Detailed summary of the QE Validation can be found here
http://tracker.ceph.com/issues/13750#note-32

The following suites were in scope of this point release testing:

rados (subset 1/7)
rbd
rgw
fs
krbd
kcephfs
knfs
hadoop
samba
rest
ceph-deploy
upgrade/client-upgrade
upgrade/hammer-x (infernalis)
upgrade/firefly-x (infernalis)
upgrade/firefly-hammer-x (infernalis)
upgrade/infernalis
powercycle

Known issues (approved for release):

krbd:
http://tracker.ceph.com/issues/14848 - approved by Jason

ceph-deploy:
http://tracker.ceph.com/issues/14223 - assumed approved by Sage (?)

powercycle:
http://tracker.ceph.com/issues/14810 - needs Sage approval

Thx
YuriW
