From: Jens Rosenboom <j.rosenboom@x-ion.de>
Subject: OSD crashing on startup (hammer)
Date: Tue, 13 Dec 2016 06:32:21 +0100
Message-ID: <CADr68Wayt7JNGDUa8-=gbh0HOiqLFJwQcTOPT5O3QBUHcgCSJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36918 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750703AbcLMFcX (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Dec 2016 00:32:23 -0500
Received: by mail-wm0-f51.google.com with SMTP id t79so101956125wmt.0
        for <ceph-devel@vger.kernel.org>; Mon, 12 Dec 2016 21:32:22 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

We have seen an issue similar to http://tracker.ceph.com/issues/13594
on a cluster running 0.94.7, where the OSD fails to start after we
needed the powercycle the server. Can the issue be reopened as
affecting hammer or shall I open a new issue?

ceph version 0.94.7 (d56bdf93ced6b80b07397d57e3fa68fe68304432)
 1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
const*)+0x8b) [0xbb1fab]
 2: (PG::peek_map_epoch(ObjectStore*, spg_t, unsigned int*,
ceph::buffer::list*)+0x885) [0x7c19b5]
 3: (OSD::load_pgs()+0x9b7) [0x6b9cd7]
 4: (OSD::init()+0x17c7) [0x6bd777]
 5: (main()+0x2a31) [0x6480e1]
 6: (__libc_start_main()+0xf5) [0x7f9711c9cf45]
 7: /usr/bin/ceph-osd() [0x661147]

Updating to 0.94.9 has not helped.
