From: Willem Jan Withagen <wjw@digiware.nl>
Subject: FreeBSD is receiving traps on os/FileJournal.cc:1036
Date: Wed, 16 Dec 2015 00:56:25 +0100
Message-ID: <5670A8A9.3020708@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:11990 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751059AbbLPAJW (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 15 Dec 2015 19:09:22 -0500
Received: from rack1.digiware.nl (unknown [127.0.0.1])
	by smtp.digiware.nl (Postfix) with ESMTP id 04F3F153430
	for <ceph-devel@vger.kernel.org>; Wed, 16 Dec 2015 01:09:21 +0100 (CET)
Received: from [IPv6:2001:4cb8:3:1:3137:f73:6440:a2ed] (unknown [IPv6:2001:4cb8:3:1:3137:f73:6440:a2ed])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.digiware.nl (Postfix) with ESMTPSA id 3D038153408
	for <ceph-devel@vger.kernel.org>; Wed, 16 Dec 2015 00:56:27 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

I'm receiving traps when running the tests going with 'gmake check'
and on one of the tests it traps on:

os/FileJournal.cc:1036
void FileJournal::align_bl(off64_t pos, bufferlist& bl)
{
  // make sure list segments are page aligned
  if (directio && (!bl.is_aligned(block_size) ||
                   !bl.is_n_align_sized(CEPH_MINIMUM_BLOCK_SIZE))) {
    assert(0 == "bl should be align");
    if ((bl.length() & (CEPH_MINIMUM_BLOCK_SIZE - 1)) != 0 ||
        (pos & (CEPH_MINIMUM_BLOCK_SIZE - 1)) != 0)
      dout(0) << "rebuild_page_aligned failed, " << bl << dendl;
    assert((bl.length() & (CEPH_MINIMUM_BLOCK_SIZE - 1)) == 0);
    assert((pos & (CEPH_MINIMUM_BLOCK_SIZE - 1)) == 0);
  }
}

And then I get confused with the following commit in other tests:
commit 8ed724222651812c2ee8cc3804dc1f54c973897d
Author: Kefu Chai <kchai@redhat.com>
Date:   Fri Sep 4 01:23:31 2015 +0800

    test/bufferlist: do not expect !is_page_aligned() after unaligned
rebuild

    if the size of a bufferlist is page aligned we allocate page aligned
    memory chunk for it when rebuild() is called. otherwise we just call
    the plain new() to allocate new memory chunk for holding the continuous
    buffer. but we should not expect that `new` allocator always returns
    unaligned memory chunks. instead, it *could* return page aligned
    memory chunk as long as the allocator feels appropriate. so, the
    `EXPECT_FALSE(bl.is_page_aligned())` after the `rebuild()` call is
    removed.

    Signed-off-by: Kefu Chai <kchai@redhat.com>

Could these 2 be related, and do I have an alignment problem when
allocating buffers and bufferlists....

Note that I also have not solved the illegal writes to _len in
bufferlists when running unittest_erasure_code_shec_arguments.

So any suggestions as to where to look at for this, are welcome.

--WjW

