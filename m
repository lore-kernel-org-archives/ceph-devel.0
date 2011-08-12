From: Colin Patrick McCabe <colin.mccabe@dreamhost.com>
Subject: Proposed changes to librados API for version 0.34
Date: Fri, 12 Aug 2011 09:57:57 -0700
Message-ID: <CA+qbEUNTpaar+-_h_9mGV1c8otgT+iijZBwb6eEFS_x3fvD0Xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:47013 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066Ab1HLQ57 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Aug 2011 12:57:59 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id DC1F3C064
	for <ceph-devel@vger.kernel.org>; Fri, 12 Aug 2011 09:59:57 -0700 (PDT)
Received: from mail-fx0-f46.google.com (mail-fx0-f46.google.com [209.85.161.46])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 8C531C063
	for <ceph-devel@vger.kernel.org>; Fri, 12 Aug 2011 09:59:57 -0700 (PDT)
Received: by fxh19 with SMTP id 19so2422480fxh.19
        for <ceph-devel@vger.kernel.org>; Fri, 12 Aug 2011 09:57:57 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Proposed changes to librados API:

rados_write_full: get rid of the uint64_t off parameter. It looks like
a copy-paste error left over from rados_write.
It is unused by the actual implementation. The C++ API doesn't have an
offset parameter, and it's not clear what one would do for write_full.

rados_setxattr / Rados::set_xattr: Return 0 on success, rather than
the length of the xattr that was set.
The user knows how many bytes are in the xattr he asked us to set, and
it's not like we can set a partial one.
POSIX returns 0 or negative, and we should too.

selfmanaged snap API: we use uint64_t for the snap id in some places,
and rados_snap_t in others. We should pick one or the other and use it
consistently.

sincerely,
Colin
