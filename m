From: Yehuda Sadeh <yehuda@inktank.com>
Subject: keystone and libnss
Date: Tue, 13 Nov 2012 19:37:16 -0800
Message-ID: <CAC-hyiE1oMB7EE0iD2_QoGgAjZO+z6T90Q5c6Zww=Nud+p5NVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:55753 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932457Ab2KNDhR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Nov 2012 22:37:17 -0500
Received: by mail-vc0-f174.google.com with SMTP id fk26so8164491vcb.19
        for <ceph-devel@vger.kernel.org>; Tue, 13 Nov 2012 19:37:16 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>

One issue to keep in mind with Keystone is that it requires nss to
work efficiently. With nss both presigned (pki) tokens and token
revocation work. Without it, the following happens:

 - we go to the keystone server for every non-cached token, even if
it's presigned
 - when we fail to decode the revocation list we clear the tokens cache

So essentially it affects performance. Not sure whether it's that big
of a deal, as there's still the cache window, but we should keep it in
mind.

Yehuda
