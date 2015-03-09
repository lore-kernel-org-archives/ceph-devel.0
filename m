From: Travis Rhoden <trhoden@gmail.com>
Subject: [ANN] ceph-deploy 1.5.22 released
Date: Mon, 9 Mar 2015 13:32:07 -0400
Message-ID: <CACkq2mpd9V0a87e7ucR-z-PhdEZgMT236pinE1ArL4epsZ_csA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:39741 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751702AbbCIRc3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Mar 2015 13:32:29 -0400
Received: by lbiw7 with SMTP id w7so25910642lbi.6
        for <ceph-devel@vger.kernel.org>; Mon, 09 Mar 2015 10:32:28 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, ceph-announce@lists.ceph.com

Hi All,

This is a new release of ceph-deploy that changes a couple of behaviors.

On RPM-based distros, ceph-deploy will now automatically enable
check_obsoletes in the Yum priorities plugin. This resolves an issue
many community members hit where package dependency resolution was
breaking due to conflicts between upstream packaging (hosted on
ceph.com) and downstream (i.e., Fedora or EPEL).

The other important change is that when using ceph-deploy to install
Ceph packages on a RHEL machine, the --release flag *must* be used if
you want to install upstream packages. In other words, if you want to
install Giant on a RHEL machine, you would need to use "ceph-deploy
install --release giant". If the --release flag is not used,
ceph-deploy will expect to use downstream package on RHEL. This is
documented at [1].

The full changelog can be seen at [2].

Please update!

 - Travis


[1] http://ceph.com/ceph-deploy/docs/install.html#distribution-notes
[2] http://ceph.com/ceph-deploy/docs/changelog.html#id1
