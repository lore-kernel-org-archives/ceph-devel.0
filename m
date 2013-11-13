From: Alfredo Deza <alfredo.deza@inktank.com>
Subject: [ANN] ceph-deploy 1.3.2 released!
Date: Wed, 13 Nov 2013 08:29:41 -0500
Message-ID: <CANtztVzZV9ZmHhDa0DnCDQgZCVZ+BRbZo-EMdhhJgaG5D-h+4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:41355 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490Ab3KMN3m (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Nov 2013 08:29:42 -0500
Received: by mail-ob0-f178.google.com with SMTP id va2so412180obc.23
        for <ceph-devel@vger.kernel.org>; Wed, 13 Nov 2013 05:29:41 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

Hi All,

I'm happy to announce a new release of ceph-deploy, the easy
deployment tool for Ceph.

The only two (very important) changes made for this release are:

* Automatic SSH key copying/generation for hosts that do not have keys
setup when using `ceph-deploy new`

* All installs will now use the latest stable release of Ceph:
Emperor, unless otherwise specified.

With this release we are now also building documentation (and
publishing it!) with every change landing in master. Docs were not a
high priority in the past few months because we wanted to make
ceph-deploy more robust and easier to use, but we are now in a better
place and so docs will get better as we make changes.

The new documentation home is at:  http://ceph.com/ceph-deploy/docs/

And the changelog for this release is:
http://ceph.com/ceph-deploy/docs/changelog.html#id1

The new SSH magic was also documented as part of the release and can
be found here: http://ceph.com/ceph-deploy/docs/index.html#ssh-keys


Thanks!


Alfredo
