From: sheng qiu <herbert1984106@gmail.com>
Subject: ceph write path
Date: Thu, 24 Jan 2013 21:41:22 -0500
Message-ID: <CAB7xdikxeLumDMJNYacoxiiijkx2vekAdc5ccDy0A+5isOJ-3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f178.google.com ([209.85.210.178]:42409 "EHLO
	mail-ia0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753389Ab3AYClW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jan 2013 21:41:22 -0500
Received: by mail-ia0-f178.google.com with SMTP id y26so5826953iab.23
        for <ceph-devel@vger.kernel.org>; Thu, 24 Jan 2013 18:41:22 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

i am trying to understand the ceph codes on client side.
for write path, if it's aio_write, the ceph_write_begin() allocate
pages in page cache to buffer the written data, however i did not see
it allocated any space on the remote OSDs (for local fs such as ext2,
the get_block() did this),
i suppose it's done later when invoke kernel flushing process to write
back the dirty pages.

i checked the ceph_writepages_start(), here it seems organize the
dirty data and prepare the requests to send to the OSDs.  For new
allocated written data, how it maps to the OSDs and where it is done?
is it done in ceph_osdc_new_request()?

If the transfer unit is not limited to sizes of obj, i supposed that
ceph needed to packed several pieces of data (smaller than one obj
size)  together so that there won't be internal fragmentation for an
object. who does this job and which part of source codes/files are
related with this?

I really want to get a deep understanding about the codes, so i raised
these questions. if my understanding is not correct, please figure
out. i will be very appreciated.

Thanks,
Sheng

--
Sheng Qiu
Texas A & M University
Room 332B Wisenbaker
email: herbert1984106@gmail.com
College Station, TX 77843-3259
