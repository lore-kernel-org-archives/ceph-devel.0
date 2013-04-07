From: Andrey Korolyov <andrey@xdel.ru>
Subject: Accidental image deletion
Date: Mon, 8 Apr 2013 00:31:42 +0400
Message-ID: <CABYiri8Y4yK+H_fb9Pm_GNrfCJbzEeFyhT8WEwawc0MBMUBB2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f47.google.com ([209.85.212.47]:50074 "EHLO
	mail-vb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933523Ab3DGUcE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 7 Apr 2013 16:32:04 -0400
Received: by mail-vb0-f47.google.com with SMTP id x13so3251026vbb.6
        for <ceph-devel@vger.kernel.org>; Sun, 07 Apr 2013 13:32:02 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hello,

Is there an existing or planned way to save an image from such thing,
except protected snapshot? Since ``rbd snap protect'' is good enough
for a small or inactive images, large ones may add significant overhead
by space or by I/O when 'locking' snapshot is present, so it would be nice
to see same functionality by the flag of ``rbd lock'' command.

Thanks!
