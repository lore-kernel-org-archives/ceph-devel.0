From: Alfredo Deza <alfredo.deza@inktank.com>
Subject: [ANN] ceph-deploy 1.3.4 released!
Date: Fri, 3 Jan 2014 09:26:17 -0500
Message-ID: <CANtztVzbo5H3AMyFCEwLbPLhsGccq4DgzpLoSo9uF=8WnCDJ1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f52.google.com ([209.85.219.52]:38028 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698AbaACO0U (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Jan 2014 09:26:20 -0500
Received: by mail-oa0-f52.google.com with SMTP id h16so16066783oag.39
        for <ceph-devel@vger.kernel.org>; Fri, 03 Jan 2014 06:26:17 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

Hi All,

There is a new release of ceph-deploy, the easy deployment tool for Ceph.

This is mostly a bug-fix release, although one minor feature was
added: the ability to
install/remove packages from remote hosts with a new sub-command: `pkg`

As we continue to add features (or improve old ones) we are also
making sure proper
documentation goes hand in hand with those changes too. For `pkg` this
is now documented
in the ceph-deploy docs page: http://ceph.com/ceph-deploy/docs/pkg.html

The complete changelog, including 1.3.4 changes can be found here:
http://ceph.com/ceph-deploy/docs/changelog.html#id1


Make sure you update!


Thanks,


Alfredo
