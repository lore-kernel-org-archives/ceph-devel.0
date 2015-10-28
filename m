From: Yuri Weinstein <yweinste@redhat.com>
Subject: v0.80.11 QE validation status
Date: Wed, 28 Oct 2015 09:04:33 -0700
Message-ID: <CAMMFjmFP88goDtrMCmrwpkNOR6R45aOaJaa2t0cCKR+Lb_jTBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:33556 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751598AbbJ1QEf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Oct 2015 12:04:35 -0400
Received: by wijp11 with SMTP id p11so261274813wij.0
        for <ceph-devel@vger.kernel.org>; Wed, 28 Oct 2015 09:04:33 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-qa <ceph-qa@ceph.com>, "Development, Ceph" <ceph-devel@vger.kernel.org>, "Weil, Sage" <sage@redhat.com>, "Dachary, Loic" <ldachary@redhat.com>

Summary of suites executed for this release can be found in
http://tracker.ceph.com/issues/11644

rados - 1/7th passed

rbd - http://tracker.ceph.com/issues/11104

rgw - http://tracker.ceph.com/issues/11104

fs - http://tracker.ceph.com/issues/11104, http://tracker.ceph.com/issues/13630

krbd - http://tracker.ceph.com/issues/13631

kcephfs - http://tracker.ceph.com/issues/13631,
http://tracker.ceph.com/issues/13630

samba - http://tracker.ceph.com/issues/6613 sama as in v0.80.10 was
aprroved for release

ceph-deploy(ubuntu_) - almost passed, 1 job is still running

ceph-deploy(distros) - http://tracker.ceph.com/issues/13367

upgrade/dumpling-x (to firefly)(distros) - passed

upgrade/firefly(distros) - passed

upgrades to giant - deprecated

upgrade/firefly-x (to hammer)(distros) -
http://tracker.ceph.com/issues/11104,
http://tracker.ceph.com/issues/13632

powercycle - http://tracker.ceph.com/issues/11104,
http://tracker.ceph.com/issues/13631

All found problems seem unrelated to the product, however they
prevented some tests from running.  In particular #11104 is widespread
and has to be fixed (see also http://tracker.ceph.com/issues/13622 as
proposed workaround)

I suggest we rerunning failed tests after addressing the issues above.

Thx
YuriW
