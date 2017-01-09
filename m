From: Samuel Just <sjust@redhat.com>
Subject: Re: Failure to repair an omap digest
Date: Mon, 9 Jan 2017 13:09:58 -0800
Message-ID: <CAN=+7FW3KpaCfQKjkH71EKfOamyqwvnWuXp4KUfTFssfLpWNgw@mail.gmail.com>
References: <85235bfc-34da-4e31-1eb3-259477445967@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:33336 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932505AbdAIVKA (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Jan 2017 16:10:00 -0500
Received: by mail-qk0-f173.google.com with SMTP id s140so131676433qke.0
        for <ceph-devel@vger.kernel.org>; Mon, 09 Jan 2017 13:09:59 -0800 (PST)
In-Reply-To: <85235bfc-34da-4e31-1eb3-259477445967@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Zafman <dzafman@redhat.com>
Cc: Dan Mick <dmick@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Sounds like this should be added to the docs!
-Sam

On Mon, Jan 9, 2017 at 1:05 PM, David Zafman <dzafman@redhat.com> wrote:
> ceph version 11.1.0-6147-g12706d7 (12706d76225fa1491d00362d3bc04e0541dead73)
>
> A failure to repair occurred because without a digest in the object info the
> code doesn't attempt to decide which omap is wrong.   Here we only have an
> omap_digest_mismatch error.  Had the "selected_object_info" included "od"
> presuambly of 1fff04c0 then "omap_digest_mismatch_oi" would have been set on
> osd.47 and it would be repaired.
>
> The way to fix this particular case is to stop osd.47, remove the object
> with ceph-objectstore-tool, then restart osd.47 and the repair should then
> re-create a correct object and omap there.  As you can see the object name
> is 100011cf577.00000000 in pool 1 (metadata).
>
> $  sudo rados list-inconsistent-pg metadata
> ["1.25"]
>
> $ sudo rados list-inconsistent-obj 1.25 --format=json-pretty
> {
>     "epoch": 767566,
>     "inconsistents": [
>         {
>             "object": {
>                 "name": "100011cf577.00000000",
>                 "nspace": "",
>                 "locator": "",
>                 "snap": "head",
>                 "version": 9023143
>             },
>             "errors": [
>                 "omap_digest_mismatch"
>             ],
>             "union_shard_errors": [],
>             "selected_object_info":
> "1:a7f0f16e:::100011cf577.00000000:head(768083'9023143 mds.0.94887:9732381
> dirty|omap|data_digest s 0 uv 9023143 dd ffffffff alloc_hint [0 0 0])",
>             "shards": [
>                 {
>                     "osd": 7,
>                     "errors": [],
>                     "size": 0,
>                     "omap_digest": "0x1fff04c0",
>                     "data_digest": "0xffffffff"
>                 },
>                 {
>                     "osd": 47,
>                     "errors": [],
>                     "size": 0,
>                     "omap_digest": "0xc2c5ddcd",
>                     "data_digest": "0xffffffff"
>                 },
>                 {
>                     "osd": 60,
>                     "errors": [],
>                     "size": 0,
>                     "omap_digest": "0x1fff04c0",
>                     "data_digest": "0xffffffff"
>                 },
>                 {
>                     "osd": 72,
>                     "errors": [],
>                     "size": 0,
>                     "omap_digest": "0x1fff04c0",
>                     "data_digest": "0xffffffff"
>                 }
>             ]
>         }
>     ]
> }
>
>
> David
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
