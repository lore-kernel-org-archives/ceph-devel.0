From: Henry C Chang <henry.cy.chang@gmail.com>
Subject: rados import/export
Date: Mon, 30 Apr 2012 11:31:39 +0800
Message-ID: <CANExM-MCR7wZMyn-gEw7Mx6j-eq2-nw_jLHMYOaK2v+5JRS3Yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52742 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755086Ab2D3Dbk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 29 Apr 2012 23:31:40 -0400
Received: by iadi9 with SMTP id i9so3584768iad.19
        for <ceph-devel@vger.kernel.org>; Sun, 29 Apr 2012 20:31:39 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi all,

I found one issue when I played around the "rados import/export"
commands. I tried:

1. Export the pool ".users.uid" to a local directory.
2. Delete the pool.
3. Import the pool ".user.uid" from the local directory.

After the pool is restored, the rgw's user info are correct. However,
I failed to list the user's buckets.
Then, I traced the codes a little bit. It seems the problem is that we
do not export/import the omaps (stored in leveldb) of the objects.
Since v0.44, we employed leveldb to store the key/value maps. I think
we need to take care of the omaps as well during backup and restore.

Henry
