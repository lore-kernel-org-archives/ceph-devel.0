From: Alfredo Deza <alfredo.deza@inktank.com>
Subject: [ANN] ceph-deploy 1.2.2 released!
Date: Fri, 23 Aug 2013 08:36:20 -0400
Message-ID: <CANtztVzbVVJg93QOuAutpgMAp3H3frbHaYivBhqO4nF4X2y0dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:35465 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754902Ab3HWMgV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Aug 2013 08:36:21 -0400
Received: by mail-oa0-f46.google.com with SMTP id j10so653254oah.5
        for <ceph-devel@vger.kernel.org>; Fri, 23 Aug 2013 05:36:20 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, ceph-devel@vger.kernel.org

Hi all,

There is a new bug-fix release of ceph-deploy, the easy ceph deployment tool.

Installation instructions: https://github.com/ceph/ceph-deploy#installation

This is the list of all fixes that went into this release which can
also be found in the CHANGELOG.rst file in ceph-deploy's git repo:

* Do not force usage of lsb_release, fallback to
  ``platform.linux_distribution()``
* Ease installation in CentOS/Scientific by adding the EPEL repo
  before attempting to install Ceph.
* Graceful handling of pushy connection issues due to host
  address resolution
* Honor the usage of ``--cluster`` when calling osd prepare.


Make sure you update!

Thanks,


Alfredo
