From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: About set_alloc_hint op
Date: Mon, 16 Jun 2014 13:04:20 +0400
Message-ID: <CALFYKtCQZ1UM9xTZN_79cVECn8=pjFDESjSfg06ec1Ab5+XeuA@mail.gmail.com>
References: <CACJqLybDiwwhSKCsG=J_4qXXVkkNYcJy2WoP2UR1WdaM=gTSew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f173.google.com ([209.85.216.173]:50813 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754285AbaFPJEV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Jun 2014 05:04:21 -0400
Received: by mail-qc0-f173.google.com with SMTP id l6so7311909qcy.18
        for <ceph-devel@vger.kernel.org>; Mon, 16 Jun 2014 02:04:20 -0700 (PDT)
In-Reply-To: <CACJqLybDiwwhSKCsG=J_4qXXVkkNYcJy2WoP2UR1WdaM=gTSew@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Jun 16, 2014 at 10:46 AM, Haomai Wang <haomaiwang@gmail.com> wrote:
> Hi,
>
> Now librbd is the only user for set_alloc_hint op.
>
>   void AioWrite::add_write_ops(librados::ObjectWriteOperation &wr) {
>     wr.set_alloc_hint(m_ictx->get_object_size(), m_ictx->get_object_size());
>     wr.write(m_object_off, m_write_data);
>   }
>
> According above, the arguments for set_alloc_hint both are the size of
> a object. It looks like there exist a misleading of the argument name
> called "expected_write_size". And I would like to think
> "expected_write_size" as the write size for most write ops.
>
> KeyValueStore in recent commits use "expected_write_size" as strip
> size, unfortunately librbd will issue set_alloc_hint(4MB, 4MB) but
> each write op's size is serval KB.
>
> I'm not sure "expected_object_size" and "expected_write_size" for
> set_alloc_hint are properly used by librbd or maybe I misunderdstand
> the op.

The idea was to have set_alloc_hint to be a one-shot op, but for rbd
this turned out to be impossible due to the fact that rbd does not
maintain any sort of object map.  (I'm hoping this will change after
the upcoming CDS ;)  Now, expected_write_size is indeed supposed to be
something close to the average or expected size of rbd writes, but,
currently there is no interface for the user to convey that information
and we don't do any tracking ourselves.  Given that, and in combination
with filestore_max_alloc_hint_size, setting both expected_object_size
and expected_write_size to object_size seemed like a good idea.

>
> As for FileStore, if use XFS, set_alloc_hint will let FS allocate in
> multiples of the hint size for this file. And some users may use 16MB
> as the order of librbd image(like me :-| ), so it seemed a little
> space ineffective.

You can cap the hint with with filestore_max_alloc_hint_size config
option.

Thanks,

                Ilya
