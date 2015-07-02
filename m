From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: Transaction struct Op
Date: Fri, 3 Jul 2015 01:26:24 +0800
Message-ID: <CACJqLyYweQX3hR6gowr_jy3v20OHjmLe+ORpzF7UdV1qH9ASSw@mail.gmail.com>
References: <90559C83A9C7FA45B5846C975DFA612DDB4DD4E133@ABGEX73E.FSC.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yk0-f182.google.com ([209.85.160.182]:34747 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753059AbbGBR0Z convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Jul 2015 13:26:25 -0400
Received: by ykfy125 with SMTP id y125so74638819ykf.1
        for <ceph-devel@vger.kernel.org>; Thu, 02 Jul 2015 10:26:24 -0700 (PDT)
In-Reply-To: <90559C83A9C7FA45B5846C975DFA612DDB4DD4E133@ABGEX73E.FSC.NET>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?Da=C5=82ek=2C_Piotr?= <Piotr.Dalek@ts.fujitsu.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Yes, some fields only used for special ops. But union may increase the
complexity of stuct.

And the extra memory may not a problem because "Ops"  in one
transaction should be within ten.

On Thu, Jul 2, 2015 at 10:05 PM, Da=C5=82ek, Piotr
<Piotr.Dalek@ts.fujitsu.com> wrote:
> Hello,
>
> In ObjectStore.h we have the following stuct:
>
>     struct Op {
>       __le32 op;
>       __le32 cid;
>       __le32 oid;
>       __le64 off;
>       __le64 len;
>       __le32 dest_cid;
>       __le32 dest_oid;                  //OP_CLONE, OP_CLONERANGE
>       __le64 dest_off;                  //OP_CLONERANGE
>       __le32 hint_type;                 //OP_COLL_HINT
>       __le64 expected_object_size;      //OP_SETALLOCHINT
>       __le64 expected_write_size;       //OP_SETALLOCHINT
>       __le32 split_bits;                //OP_SPLIT_COLLECTION2
>       __le32 split_rem;                 //OP_SPLIT_COLLECTION2
>     } __attribute__ ((packed)) ;
>
> Some of the fields (like hint_type and split_rem) are totally unused =
in certain ops, and they eat up space anyway. Maybe we should use union=
s here, and re-use some of the fields for other purposes? Right now the=
 structure is 72 bytes in size, and for most ops, at least 32 bytes are=
 always wasted.
>
>
> With best regards / Pozdrawiam
> Piotr Da=C5=82ek
>
>



--=20
Best Regards,

Wheat
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
