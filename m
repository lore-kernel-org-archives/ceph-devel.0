From: Yue Li <xyly781@gmail.com>
Subject: some questions about ceph
Date: Wed, 23 Jan 2013 17:35:45 -0600
Message-ID: <CAFKnYyQbZcsCH_DwsQC-2eagU+A1a0g7PRS_L769_FC8QVJTxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f169.google.com ([209.85.220.169]:50406 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752621Ab3AWXlR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Jan 2013 18:41:17 -0500
Received: by mail-vc0-f169.google.com with SMTP id n10so1671266vcn.14
        for <ceph-devel@vger.kernel.org>; Wed, 23 Jan 2013 15:41:16 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sheng Qiu <herbert1984106@gmail.com>

Hi,

i have some questions about ceph.

ceph provide a POSIX client for users.
for aio-read/write, it still use page cache on client side (seems to
me). How long will the page cache expire (in case the data on server
side has changed)?
if we miss the page cache, we need to fetch data from server side for
read accesses, what's the minimum transfer unit between client and
OSDs?
for write accesses, will the client batch the write request data into
units of obj size then transferring to OSDs?
generally what's the minimum transfer unit between client and OSDs?

How to ensure the consistency for multi-write from clients on the same
piece of data or parallel read and write on the same data?

Thanks,
Sheng
