From: Alfredo Deza <alfredo.deza@inktank.com>
Subject: 0.79 dependency issue on RPM packages
Date: Wed, 9 Apr 2014 10:21:18 -0400
Message-ID: <CANtztVyMzL_gpDYrYq0=y4CDsUsbof7qxShZmpCtSpvKOYzqPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yk0-f174.google.com ([209.85.160.174]:46420 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933279AbaDIOVT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Apr 2014 10:21:19 -0400
Received: by mail-yk0-f174.google.com with SMTP id 20so2214499yks.19
        for <ceph-devel@vger.kernel.org>; Wed, 09 Apr 2014 07:21:19 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

Yesterday we found out that there was a dependency issue for the init
script on CentOS/RHEL
distros where we depend on some functions that are available through
redhat-lsb-core but were
not declared in the ceph.spec file.

This will cause daemons not to start at all since the init script will
attempt to source a file that is not
there (if that package is not installed).

The workaround for this issue is to just install that one package:

    sudo yum install redhat-lsb-core

And make sure that `/lib/lsb/init-functions` is present.

This should not affect Debian (and Debian based) distros.

Ticket reference: http://tracker.ceph.com/issues/8028
