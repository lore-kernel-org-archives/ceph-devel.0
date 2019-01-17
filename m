From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 6/9] ceph: quota: Cleanup license mess
Date: Fri, 18 Jan 2019 00:14:22 +0100
Message-ID: <20190117231501.346447710@linutronix.de>
References: <20190117231416.111952141@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart <kstewart@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, Luis Henriques <lhenriques@suse.com>, Jiri Kosina <jkosina@suse.cz>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Precise and non-ambiguous license information is important. The recently
added aegis header file has a SPDX license identifier, which is nice, but
at the same time it has a contradictionary license boiler plate text.

  SPDX-License-Identifier: GPL-2.0

versus 

  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
  * as published by the Free Software Foundation; either version 2
  * of the License, or (at your option) any later version.

Oh well.

As the other ceph related files are licensed under the GPL v2 only, it's
assumed that the SPDX id is correct and the boiler plate was randomly
copied into that patch.

Remove the boiler plate as it is wrong and even if correct it is redundant.

Fixes: fb18a57568c2 ("ceph: quota: add initial infrastructure to support cephfs quotas")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Luis Henriques <lhenriques@suse.com>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: "Yan, Zheng" <zyan@redhat.com>
Cc: Sage Weil <sage@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
---

P.S.: This patch is part of a larger cleanup, but independent of other
      patches and is intended to be picked up by the maintainer directly.

---
 fs/ceph/quota.c |   13 -------------
 1 file changed, 13 deletions(-)

--- a/fs/ceph/quota.c
+++ b/fs/ceph/quota.c
@@ -3,19 +3,6 @@
  * quota.c - CephFS quota
  *
  * Copyright (C) 2017-2018 SUSE
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <linux/statfs.h>
