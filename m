From: Christian Brunner <chb@muc.de>
Subject: Re: [Qemu-devel] [PATCH] ceph/rbd block driver for qemu-kvm (v8)
Date: Mon, 6 Dec 2010 21:15:28 +0100
Message-ID: <AANLkTimrzcjLTLrioN+HpPEXUqeCaVs_ut=h5+-tHy4N@mail.gmail.com>
References: <20101117214223.GA31321@sir.home>
	<4CFCDBB1.5000800@redhat.com>
Reply-To: chb@muc.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33989 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752580Ab0LFUP2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Dec 2010 15:15:28 -0500
In-Reply-To: <4CFCDBB1.5000800@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, ceph-devel@vger.kernel.org, kvm@vger.kernel.org

2010/12/6 Kevin Wolf <kwolf@redhat.com>:

Hi Kevin,

> This lacks a Signed-off-by. Please merge Yehuda's fix for configure when
> you resend the patch.

I've sent an updated patch.

> What's the easiest way to try it out? I tried to use vstart.sh and copy
> the generated ceph.conf to /etc/ceph/ceph.conf so that qemu-img etc.
> find the monitor address. However, that leads to a hang when I try "rbd
> list" or "./qemu-img create -f rbd rbd:data/test.img 4G", so I seem to
> be missing something.

The most simple ceph.conf I can think about, is the following:

[global]
        auth supported = none

[mon]
        mon data = /ceph/mon$id

[mon0]
        host = {hostname}
        mon addr = 127.0.0.1:6789

[osd]
        osd data = /ceph/osd\$id

[osd0]
        host = {hostname}
        btrfs devs = {devicename}


Replace {hostname} with your `hostname -s` and {devicename} with the
name of an empty volume. Create a directory for the monitor and a
mountpoint for the osd volume:

# mkdir -p /ceph/mon0
# mkdir -p /ceph/osd0

After you have created the ceph.conf file, you can create your
ceph-filesystem with the following command (attention - this will
format the configured volume):

# mkcephfs -c /etc/ceph/ceph.conf --mkbtrfs -a

Now you should be able to start ceph (assuming you are using the redhat rpm):

# service ceph start

Check if ceph is running with `ceph -w` or `rados df`. `qemu-img
create -f rbd rbd:data/test.img 4G` should work now, too.

Regards
Christian
