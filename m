From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: passing secrets to block devices
Date: Thu, 20 Oct 2011 11:30:42 -0700
Message-ID: <4EA068D2.4030101@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:40544 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042Ab1JTSan (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Oct 2011 14:30:43 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: libvir-list@redhat.com, qemu-devel@nongnu.org
Cc: ceph-devel@vger.kernel.org, "Daniel P. Berrange" <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>

We're working on libvirt support for block device authentication [1]. To
authenticate, rbd needs a username and a secret. Normally, to
avoid putting the secret on the command line, you can store the secret
in a file and pass the file to qemu, but when this is automated,
there's no good way to know when the file can be removed. There are
a few ways to pass the secret to qemu that avoid this problem:

1) pass an fd to an unlinked file containing the secret

This is the simplest method, but it sounds like qemu developers don't
like fd passing from libvirt. [2]

2) start guests paused, without disks requiring authentication, then
    use the drive_add monitor command to attach them

This would make disks with authentication somewhat of a special case
in libvirt, but would be simple to implement, and require no qemu changes.

3) start guests paused, then send the secret via a new QMP/HMP
    command (block_set_conf <key> <value>?)

This is a larger change, but it would be more generally useful for
changing configuration at runtime.

What do you think is the best approach?

[1] http://permalink.gmane.org/gmane.comp.file-systems.ceph.devel/4129
[2] http://lists.gnu.org/archive/html/qemu-devel/2011-08/msg02494.html

