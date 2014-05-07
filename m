From: Alfredo Deza <alfredo.deza@inktank.com>
Subject: [ANN] ceph-deploy 1.5.2 released
Date: Wed, 7 May 2014 15:46:45 -0400
Message-ID: <CANtztVywvrYmJ5w_kMMK96ZyDVOEnxH96nufACF+ct_J3m04XA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yk0-f172.google.com ([209.85.160.172]:53761 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750866AbaEGTqp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 May 2014 15:46:45 -0400
Received: by mail-yk0-f172.google.com with SMTP id 79so1268475ykr.3
        for <ceph-devel@vger.kernel.org>; Wed, 07 May 2014 12:46:45 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

Hi All,

There is a new bug-fix release of ceph-deploy, the easy deployment
tool for Ceph.

This release comes with two important changes:

* fix usage of `--` when removing packages in Debian/Ubuntu
* Default to Firefly when installing Ceph.

Make sure you upgrade!


-Alfredo
