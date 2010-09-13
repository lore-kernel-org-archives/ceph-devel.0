From: Takuya ASADA <syuu@dokukino.com>
Subject: read/write on RADOS using external buffer
Date: Mon, 13 Sep 2010 20:57:02 +0900
Message-ID: <AANLkTikRnvWbsD5OD7a88hpHsm5N3hJteaisYkfjdY2H@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59643 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755109Ab0IML5Y (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Sep 2010 07:57:24 -0400
Received: by wyf22 with SMTP id 22so6088061wyf.19
        for <ceph-devel@vger.kernel.org>; Mon, 13 Sep 2010 04:57:22 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I want to use external buffer in Rados::write() and Rados::read() in
my application, I figure out the way on write() but I couldn't on
read().

I have "char *buf" as buffer, and it's length "int len".
On write(), I could do it like this:
  rados.initialize(0, NULL);
  rados.open_pool(bucket, &pool);
  bl.push_front(ceph::buffer::create_static(len, buf));
  rados.write_full(pool, oid, bl);

But on read(), I tried slimier code but fails:
  r = rados.initialize(0, NULL);
  r = rados.open_pool(bucket, &pool);
  bl.push_front(ceph::buffer::create_static(len, buf));
  rados.read(pool, oid, 0, bl, 0);

It seems new buffer allocated inside of read() operation, and the data
wrote on new buffer instead of "buf".
Where that new buffer allocated?
And is there a way to use external buffer instead of new buffer?
