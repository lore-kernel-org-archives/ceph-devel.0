From: Haodong Tang <tanghaodong25@gmail.com>
Subject: Re: Bluestore :Which side is wal submit code
Date: Sat, 1 Apr 2017 15:59:41 +0800
Message-ID: <CACYTDmhCskb++uppo_Bz46wL+3jCjK5BjbS+hSRBKs8NLO_gbQ@mail.gmail.com>
References: <CAN=xyVUKELMkKnFtkmf7k8PSUBR1981bBkbZoj4cssMTZ_BMWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:36003 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750828AbdDAH7n (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 1 Apr 2017 03:59:43 -0400
Received: by mail-wm0-f41.google.com with SMTP id o81so13087614wmb.1
        for <ceph-devel@vger.kernel.org>; Sat, 01 Apr 2017 00:59:43 -0700 (PDT)
In-Reply-To: <CAN=xyVUKELMkKnFtkmf7k8PSUBR1981bBkbZoj4cssMTZ_BMWg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: qi Shi <m13913886148@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Qi,

We don't write wal directly into wal device. wal is put into rocksdb
to ensure consistency, and is submitted in
"kv_sync_thread"(https://github.com/ceph/ceph/blob/master/src/os/bluestore/BlueStore.cc#L7582).

We can configure a separated device/partition for rocksdb
here(https://github.com/ceph/ceph/blob/master/src/common/config_opts.h#L1044)
to store rocksdb wal. That is the wal device you mentioned.

Thanks,
Haodong

On 1 April 2017 at 15:20, qi Shi <m13913886148@gmail.com> wrote:
> hello everyone!
>           when bluestore is overwrite ,it will use wal.
>           and i think it is like journal. IO divided into submit and apply.
>           When i look at the code, i find _wal_apply().
>           But i can not find wal submit.
>           I only found the following code :
> ---------------------------------------------------------------------------------------------------------------------
>  // chunk-aligned wal overwrite?
>     if (b->get_blob().get_ondisk_length() >= b_off + b_len &&
> b_off % chunk_size == 0 &&
> b_len % chunk_size == 0 &&
> b->get_blob().is_allocated(b_off, b_len)) {
>       bluestore_wal_op_t *op = _get_wal_op(txc, o);
>       op->op = bluestore_wal_op_t::OP_WRITE;
>       _buffer_cache_write(txc, b, b_off, padded,
>   wctx->buffered ? 0 : Buffer::FLAG_NOCACHE);
>
>       int r = b->get_blob().map(
> b_off, b_len,
> [&](uint64_t offset, uint64_t length) {
>   op->extents.emplace_back(bluestore_pextent_t(offset, length));
>           return 0;
> });
>       assert(r == 0);
>       if (b->get_blob().csum_type) {
> b->dirty_blob().calc_csum(b_off, padded);
>       }
>       op->data.claim(padded);
>       dout(20) << __func__ << "  wal write 0x" << std::hex << b_off << "~"
>        << b_len << std::dec << " of mutable " << *b
>        << " at " << op->extents << dendl;
>       Extent *le = o->extent_map.set_lextent(offset, offset - bstart, length,
>                                      b, &wctx->old_extents);
>       b->dirty_blob().mark_used(le->blob_offset, le->length);
>       txc->statfs_delta.stored() += le->length;
>       dout(20) << __func__ << "  lex " << *le << dendl;
>       logger->inc(l_bluestore_write_small_wal);
>       return;
> -------------------------------------------------------------------------------------------------------------------
>
> but these code does not write Block device partition of wal.
> how does Bluestore submit IO to Block device partition of wal ?
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
