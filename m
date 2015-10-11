From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: lltng enabled by default and qemu apparmor|selinux problems
Date: Sun, 11 Oct 2015 19:06:54 +0200 (CEST)
Message-ID: <370906433.54234352.1444583214983.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:45015 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102AbbJKRG5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 11 Oct 2015 13:06:57 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>
Cc: Sage Weil <sweil@redhat.com>

Hi,

it seem that since this commit

https://github.com/ceph/ceph/pull/4261/files

lltng is enabled by default.

But this give error with qemu when apparmor|selinux is enabled.

That's why ubuntu && redhat now disable it for their own packages.

https://bugzilla.redhat.com/show_bug.cgi?id=1223319
https://bugs.launchpad.net/ubuntu/+source/libvirt/+bug/1432644

In the ubuntu launchpad, Sage has made a reply

"
Sage Weil (sage-newdream) wrote on 2015-04-02:	#21
FWIW, we are disabling the lttng support in the final hammer release to avoid this issue (until we come up with a better solution)."


It seem that it's still enabled by default in ceph git and ceph.com packages.

Is it still planned to disable by default ?



