From: Tommi Virtanen <tv@inktank.com>
Subject: Re: Problem creating osd.0 ??
Date: Mon, 1 Oct 2012 10:21:16 -0700
Message-ID: <CADvuQRHGsmv1fY9ZihxRvU_C7HyboOX9VaO5+mD_Rp6sf0x4Lw@mail.gmail.com>
References: <CAGfy=6k4wZxjcJEaWTdetXEw6_ZYzNiOaH+kqGR0S7VepPotHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:45198 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768Ab2JARVh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Oct 2012 13:21:37 -0400
Received: by mail-qa0-f46.google.com with SMTP id c26so45630qad.19
        for <ceph-devel@vger.kernel.org>; Mon, 01 Oct 2012 10:21:36 -0700 (PDT)
In-Reply-To: <CAGfy=6k4wZxjcJEaWTdetXEw6_ZYzNiOaH+kqGR0S7VepPotHQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: hemant surale <hemant.surale@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Sep 26, 2012 at 10:43 PM, hemant surale <hemant.surale@gmail.com> wrote:
> root@hemant-virtual-machine:/etc/ceph# mkcephfs -a -c
> /etc/ceph/ceph.conf -k ceph.keyring
> temp dir is /tmp/mkcephfs.E1M7ay6HBa
> preparing monmap in /tmp/mkcephfs.E1M7ay6HBa/monmap
> /usr/bin/monmaptool --create --clobber --add alpha 10.72.147.249:6789
> --print /tmp/mkcephfs.E1M7ay6HBa/monmap
> /usr/bin/monmaptool: monmap file /tmp/mkcephfs.E1M7ay6HBa/monmap
> /usr/bin/monmaptool: generated fsid 84d8b6ea-e062-45fe-8386-17ac7231ea13
> epoch 0
> fsid 84d8b6ea-e062-45fe-8386-17ac7231ea13
> last_changed 2012-09-27 11:11:33.447933
> created 2012-09-27 11:11:33.447933
> 0: 10.72.147.249:6789/0 mon.alpha
> /usr/bin/monmaptool: writing epoch 0 to
> /tmp/mkcephfs.E1M7ay6HBa/monmap (1 monitors)
> === osd.0 ===
> 2012-09-27 11:11:33.498019 7fde16353780 -1 filestore(/ceph_data/osd.0)
> limited size xattrs -- enable filestore_xattr_use_omap
> 2012-09-27 11:11:33.498031 7fde16353780 -1 OSD::mkfs: couldn't mount
> FileStore: error -95
> 2012-09-27 11:11:33.498057 7fde16353780 -1  ** ERROR: error creating
> empty object store in /ceph_data/osd.0: (95) Operation not supported
> failed: '/sbin/mkcephfs -d /tmp/mkcephfs.E1M7ay6HBa --init-daemon osd.0'
> -----------------------------------
>
> I created dir manually as well as assigned all permissions to root
> user still this problem persists. Please help me out .

That's on an ext4 filesystem, I guess?

In your ceph.conf, say

[global]
filestore_xattr_use_omap = true

and probably you'll need to also remount that partition with -o user_xattr


Better ext4 support is tracked in http://tracker.newdream.net/issues/3138
