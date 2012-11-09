From: Travis Rhoden <trhoden@gmail.com>
Subject: cephx auth issue
Date: Fri, 9 Nov 2012 12:54:35 -0500
Message-ID: <CACkq2mp21AdjQCpEzynbVht81Y-xzD0UXT16zt_EBEcy3ND92Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:52529 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754363Ab2KIRy4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Nov 2012 12:54:56 -0500
Received: by mail-vb0-f46.google.com with SMTP id ff1so4128253vbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 09 Nov 2012 09:54:55 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I'm not sure what I've done wrong here:

Things are okay as client.admin:

# rbd -p images --id admin ls
test

But not as client.images:

# rbd -p images --id images ls
error: (1) Operation not permitted

The privs/caps seem okay in ceph auth:

# ceph auth list
<snip>
client.admin
	key: <snip>
	caps: [mds] allow
	caps: [mon] allow *
	caps: [osd] allow *
client.images
	key: <snip>
	caps: [mon] allow r
	caps: [osd] allow rwx pool=images
client.volumes
	key: <snip>
	caps: [mon] allow r
	caps: [osd] allow rwx pool=volumes, allow rx pool=images


And the keyrings are present as:

# ls -al /etc/ceph
total 36
drwxr-xr-x   2 root   root    4096 Nov  9 17:48 .
drwxr-xr-x 108 root   root    4096 Nov  9 17:27 ..
-rw-r-----   1 root   root      63 Nov  8 22:37 ceph.client.admin.keyring
-rw-r-----   1 glance glance    64 Nov  9 17:48 ceph.client.images.keyring
-rw-r-----   1 cinder cinder    65 Nov  9 17:48 ceph.client.volumes.keyring
-rw-r--r--   1 root   root    2095 Nov  9 17:42 ceph.conf

Ad the keyring seems readable just fine:
# strace rbd -p images --id images ls
<snip>
open("/etc/ceph/ceph.client.images.keyring", O_RDONLY) = 3
close(3)                                = 0
open("/etc/ceph/ceph.client.images.keyring", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0640, st_size=64, ...}) = 0
read(3, "[client.images]\n\tkey = AQBC85tQK"..., 64) = 64
<snip>


What am I missing?

Same thing happens for volumes pool/user:
# rbd ls -p volumes --id volumes
error: (1) Operation not permitted
# rbd ls -p images --id volumes
error: (1) Operation not permitted


Thanks in advance,

Travis
