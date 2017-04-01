From: qi Shi <m13913886148@gmail.com>
Subject: Bluestore :Which side is wal submit code
Date: Sat, 1 Apr 2017 15:20:36 +0800
Message-ID: <CAN=xyVUKELMkKnFtkmf7k8PSUBR1981bBkbZoj4cssMTZ_BMWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f53.google.com ([209.85.214.53]:37723 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751155AbdDAHUm (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 1 Apr 2017 03:20:42 -0400
Received: by mail-it0-f53.google.com with SMTP id 190so22650293itm.0
        for <ceph-devel@vger.kernel.org>; Sat, 01 Apr 2017 00:20:37 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hello everyone!
          when bluestore is overwrite ,it will use wal.
          and i think it is like journal. IO divided into submit and apply.
          When i look at the code, i find _wal_apply().
          But i can not find wal submit.
          I only found the following code :
---------------------------------------------------------------------------------------------------------------------
 // chunk-aligned wal overwrite?
    if (b->get_blob().get_ondisk_length() >= b_off + b_len &&
b_off % chunk_size == 0 &&
b_len % chunk_size == 0 &&
b->get_blob().is_allocated(b_off, b_len)) {
      bluestore_wal_op_t *op = _get_wal_op(txc, o);
      op->op = bluestore_wal_op_t::OP_WRITE;
      _buffer_cache_write(txc, b, b_off, padded,
  wctx->buffered ? 0 : Buffer::FLAG_NOCACHE);

      int r = b->get_blob().map(
b_off, b_len,
[&](uint64_t offset, uint64_t length) {
  op->extents.emplace_back(bluestore_pextent_t(offset, length));
          return 0;
});
      assert(r == 0);
      if (b->get_blob().csum_type) {
b->dirty_blob().calc_csum(b_off, padded);
      }
      op->data.claim(padded);
      dout(20) << __func__ << "  wal write 0x" << std::hex << b_off << "~"
       << b_len << std::dec << " of mutable " << *b
       << " at " << op->extents << dendl;
      Extent *le = o->extent_map.set_lextent(offset, offset - bstart, length,
                                     b, &wctx->old_extents);
      b->dirty_blob().mark_used(le->blob_offset, le->length);
      txc->statfs_delta.stored() += le->length;
      dout(20) << __func__ << "  lex " << *le << dendl;
      logger->inc(l_bluestore_write_small_wal);
      return;
-------------------------------------------------------------------------------------------------------------------

but these code does not write Block device partition of wal.
how does Bluestore submit IO to Block device partition of wal ?
