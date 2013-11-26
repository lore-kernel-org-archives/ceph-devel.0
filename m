From: Alfredo Deza <alfredo.deza@inktank.com>
Subject: [ANN] ceph-deploy 1.3.3 released!
Date: Tue, 26 Nov 2013 14:50:51 -0600
Message-ID: <CANtztVznWS7oZ6g+3iZKcbfzVhZOm_C2cb42PyP9Lnt3AjVXKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f50.google.com ([209.85.219.50]:43793 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752492Ab3KZUuw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Nov 2013 15:50:52 -0500
Received: by mail-oa0-f50.google.com with SMTP id n16so6729598oag.9
        for <ceph-devel@vger.kernel.org>; Tue, 26 Nov 2013 12:50:51 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

Hi All,

There is a new release of ceph-deploy, the easy deployment tool for Ceph.

The most important (non-bug) change for this release is the ability to
specify repository mirrors when installing ceph. This can be done with
environment variables or flags in the `install` subcommand.

Full documentation on that feature can be found in the new location for docs:

http://ceph.com/ceph-deploy/docs/install.html#behind-firewall

The complete changelog can be found here:
http://ceph.com/ceph-deploy/docs/changelog.html#id1

Make sure you update!

Thanks,


Alfredo
