From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: about memory alignment
Date: Sun, 19 Nov 2017 21:33:57 +1100
Message-ID: <CAJ4mKGbVOr+yT4b=1Po70TkF4vr02Wc+=hha=GHrTd30_vsYSw@mail.gmail.com>
References: <7DF47FD5BC069E4BBD28890C798EC7BC8C8D2E79@H3CMLB14-EX.srv.huawei-3com.com>
 <7DF47FD5BC069E4BBD28890C798EC7BC8C8D2EB5@H3CMLB14-EX.srv.huawei-3com.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:33344 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751059AbdKSKd6 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 19 Nov 2017 05:33:58 -0500
Received: by mail-io0-f171.google.com with SMTP id i184so5547089ioa.0
        for <ceph-devel@vger.kernel.org>; Sun, 19 Nov 2017 02:33:58 -0800 (PST)
In-Reply-To: <7DF47FD5BC069E4BBD28890C798EC7BC8C8D2EB5@H3CMLB14-EX.srv.huawei-3com.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Liuhao <liu.haoA@h3c.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Nov 14, 2017 at 12:12 AM Liuhao <liu.haoA@h3c.com> wrote:
>
> HI, developers:
>
> data.largest_data_off_in_data_bl = orig_len + sizeof(__u32);  // we are about to
> What 's mean of sizeof(__u32)?  Why add sizeof(__u32)?


We're recording here the total size of the buffer used to transmit the
data. Since the buffer includes a prefix of its own length, and that
prefix is a __u32, we add that to the actual data size.
-Greg

>
>
> Detail:
> oid write(const coll_t& cid, const ghobject_t& oid, uint64_t off, uint64_t len,
>                 const bufferlist& write_data, uint32_t flags = 0) {
>       uint32_t orig_len = data_bl.length();
>       Op* _op = _get_next_op();
>       _op->op = OP_WRITE;
>       _op->cid = _get_coll_id(cid);
>       _op->oid = _get_object_id(oid);
>       _op->off = off;
>       _op->len = len;
>       ::encode(write_data, data_bl);
>
>       assert(len == write_data.length());
>       data.fadvise_flags = data.fadvise_flags | flags;
>       if (write_data.length() > data.largest_data_len) {
>          data.largest_data_len = write_data.length();
>          data.largest_data_off = off;
>          data.largest_data_off_in_data_bl = orig_len + sizeof(__u32);  // we are about to
>       }
>       data.ops++;
> }
>
> Thanks
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
