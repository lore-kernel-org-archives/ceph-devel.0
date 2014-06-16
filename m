From: Haomai Wang <haomaiwang@gmail.com>
Subject: About set_alloc_hint op
Date: Mon, 16 Jun 2014 14:46:36 +0800
Message-ID: <CACJqLybDiwwhSKCsG=J_4qXXVkkNYcJy2WoP2UR1WdaM=gTSew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:56480 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753868AbaFPGqi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Jun 2014 02:46:38 -0400
Received: by mail-wi0-f182.google.com with SMTP id bs8so3428700wib.3
        for <ceph-devel@vger.kernel.org>; Sun, 15 Jun 2014 23:46:36 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

Now librbd is the only user for set_alloc_hint op.

  void AioWrite::add_write_ops(librados::ObjectWriteOperation &wr) {
    wr.set_alloc_hint(m_ictx->get_object_size(), m_ictx->get_object_size());
    wr.write(m_object_off, m_write_data);
  }

According above, the arguments for set_alloc_hint both are the size of
a object. It looks like there exist a misleading of the argument name
called "expected_write_size". And I would like to think
"expected_write_size" as the write size for most write ops.

KeyValueStore in recent commits use "expected_write_size" as strip
size, unfortunately librbd will issue set_alloc_hint(4MB, 4MB) but
each write op's size is serval KB.

I'm not sure "expected_object_size" and "expected_write_size" for
set_alloc_hint are properly used by librbd or maybe I misunderdstand
the op.

As for FileStore, if use XFS, set_alloc_hint will let FS allocate in
multiples of the hint size for this file. And some users may use 16MB
as the order of librbd image(like me :-| ), so it seemed a little
space ineffective.

I pushed a fix for keyvaluestore to avoid using
set_alloc_op(https://github.com/ceph/ceph/pull/1967).

-- 
Best Regards,

Wheat
