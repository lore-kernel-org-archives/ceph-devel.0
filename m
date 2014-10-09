From: Alfredo Deza <adeza@redhat.com>
Subject: [ANN] ceph-deploy 1.5.18 released
Date: Thu, 9 Oct 2014 14:21:28 -0400
Message-ID: <CANtztVxLZPf2vd+J+K2P-EujiX=adAU1pv+BiAVAV3YZ1AECZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yk0-f177.google.com ([209.85.160.177]:34173 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096AbaJISV3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Oct 2014 14:21:29 -0400
Received: by mail-yk0-f177.google.com with SMTP id q200so952323ykb.36
        for <ceph-devel@vger.kernel.org>; Thu, 09 Oct 2014 11:21:29 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

Hi All,

There is a new release of ceph-deploy that includes a fix where
enabling the OSD service would
fail on certain distros.

There is also a new improvement for creating a monitor keyring if not
found when deploying
monitors.

The full changelog can be seen here:
http://ceph.com/ceph-deploy/docs/changelog.html#id1

Make sure you upgrade!


-Alfredo
