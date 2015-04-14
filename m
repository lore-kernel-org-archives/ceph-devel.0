From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: how to test hammer rbd objectmap feature ?
Date: Tue, 14 Apr 2015 09:48:23 +0200 (CEST)
Message-ID: <2146461277.257952132.1428997703232.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:56822 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751465AbbDNHs0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Apr 2015 03:48:26 -0400
Received: from localhost (localhost [127.0.0.1])
	by mailpro.odiso.net (Postfix) with ESMTP id B251440755C36
	for <ceph-devel@vger.kernel.org>; Tue, 14 Apr 2015 09:48:23 +0200 (CEST)
Received: from mailpro.odiso.net ([127.0.0.1])
	by localhost (mailpro.odiso.net [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 5NmsYRNySut1 for <ceph-devel@vger.kernel.org>;
	Tue, 14 Apr 2015 09:48:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mailpro.odiso.net (Postfix) with ESMTP id 8B11940755C75
	for <ceph-devel@vger.kernel.org>; Tue, 14 Apr 2015 09:48:23 +0200 (CEST)
Received: from mailpro.odiso.net ([127.0.0.1])
	by localhost (mailpro.odiso.net [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 9Pe7eWMG-bbN for <ceph-devel@vger.kernel.org>;
	Tue, 14 Apr 2015 09:48:23 +0200 (CEST)
Received: from mailpro.odiso.net (mailpro.odiso.net [10.1.31.112])
	by mailpro.odiso.net (Postfix) with ESMTP id 6646540755C36
	for <ceph-devel@vger.kernel.org>; Tue, 14 Apr 2015 09:48:23 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

I would like to known how to enable object map on hammer ?

I found a post hammer commit here:

https://github.com/ceph/ceph/commit/3a7b28d9a2de365d515ea1380ee9e4f867504e10
"rbd: add feature enable/disable support"

-   Specifies which RBD format 2 features are to be enabled when creating
-   an image. The numbers from the desired features below should be added
-   to compute the parameter value:
+   Specifies which RBD format 2 feature should be enabled when creating
+   an image. Multiple features can be enabled by repeating this option
+   multiple times. The following features are supported:

-.. option:: --image-features features
+.. option:: --image-feature feature

-   +1: layering support
-   +2: striping v2 support
-   +4: exclusive locking support
-   +8: object map support
+   layering: layering support
+   striping: striping v2 support
+   exclusive-lock: exclusive locking support
+   object-map: object map support (requires exclusive-lock)


So, in current hammer release, we can only setup objectmap and other features on rbd volume creation ?

Do this patch allow to change features on the fly ?
If yes, is it planned to backport it to hammer soon ?


