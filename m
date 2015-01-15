From: Cheng Cheng <ccheng.leo@gmail.com>
Subject: QoS Control for RBD I/Os?
Date: Thu, 15 Jan 2015 12:53:05 -0500
Message-ID: <E5173F87-4790-4151-9B2A-3FE6E8F11E96@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:57808 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751994AbbAORxJ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Jan 2015 12:53:09 -0500
Received: by mail-ie0-f175.google.com with SMTP id x19so16241274ier.6
        for <ceph-devel@vger.kernel.org>; Thu, 15 Jan 2015 09:53:08 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: =?utf-8?B?56iL6K+a?= <ccheng.leo@gmail.com>

Hi Ceph,

I am wondering is there a mechanism to prioritize the rbd_aio_write/rbd=
_aio_read I/Os? Currently all RBD I/Os are issued in FIFO to rados laye=
r, and there is NO QoS mechanism to control the priority of these I/Os.

A QoS mechanism will be beneficial when performing certain management o=
perations, such as flatten. When flatten a image, the outstanding I/Os =
do get throttled by =E2=80=9Crbd_concurrent_management_ops=E2=80=9D. Ho=
wever this won't guarantee normal I/Os are not affected, as outstanding=
 normal I/Os are still competing with concurrent management ops.

Anyone know how/where to implement this QoS mechanism?

Thanks!
Cheng  =20


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
