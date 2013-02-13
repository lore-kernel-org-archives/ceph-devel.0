From: Mandell Degerness <mandell@pistoncloud.com>
Subject: OSD failure on start
Date: Wed, 13 Feb 2013 11:57:31 -0800
Message-ID: <CA+jddaPFHhwvyA73BA=58b=MMkF8me5WeSm0LcThp9XLho=k7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:54457 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756947Ab3BMT5d (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Feb 2013 14:57:33 -0500
Received: by mail-wg0-f52.google.com with SMTP id 12so1262515wgh.31
        for <ceph-devel@vger.kernel.org>; Wed, 13 Feb 2013 11:57:32 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I'm getting this error on one of my OSD's when I try to start it.

I can gather more complete log data if no-one recognizes the error from this:

Feb 13 19:30:04 node-192-168-8-14 ceph-osd: 2013-02-13 19:30:04.612847
7f4f607e7780  0 filestore(/mnt/osd96) mount found snaps <>
Feb 13 19:30:04 node-192-168-8-14 ceph-osd: 2013-02-13 19:30:04.615147
7f4f607e7780  0 filestore(/mnt/osd96) mount: enabling WRITEAHEAD
journal mode: btrfs not detected
Feb 13 19:30:04 node-192-168-8-14 ceph-osd: 2013-02-13 19:30:04.658965
7f4f607e7780  1 journal _open /mnt/osd96/journal fd 30: 8589934592
bytes, block size 4096 bytes, directio = 1, aio = 0
Feb 13 19:30:04 node-192-168-8-14 ceph-osd: 2013-02-13 19:30:04.720091
7f4f607e7780  1 journal _open /mnt/osd96/journal fd 30: 8589934592
bytes, block size 4096 bytes, directio = 1, aio = 0
Feb 13 19:30:04 node-192-168-8-14 ceph-osd: 2013-02-13 19:30:04.721871
7f4f607e7780 -1 osd/OSD.cc: In function 'OSDMapRef
OSD::get_map(epoch_t)' thread 7f4f607e7780 time 2013-02-13
19:30:04.721278
osd/OSD.cc: 4029: FAILED assert(_get_map_bl(epoch, bl))

 ceph version 0.48.1argonaut (commit:a7ad701b9bd479f20429f19e6fea7373ca6bba7c)
 1: (OSD::get_map(unsigned int)+0x560) [0x7f4f60a411e0]
 2: (OSD::init()+0x5a3) [0x7f4f60a53ce3]
 3: (main()+0x4462) [0x7f4f6096d182]
 4: (__libc_start_main()+0xfd) [0x7f4f5e64b26d]
 5: (()+0x16e829) [0x7f4f60968829]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.
Feb 13 19:30:04 node-192-168-8-14 ceph-osd: --- begin dump of recent events ---
