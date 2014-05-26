From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: Questions of KeyValueStore (leveldb) backend
Date: Mon, 26 May 2014 12:55:46 +0800
Message-ID: <CACJqLyZYe6+CBrB49B5TnyahsT6387-bWDXCQ6JCYcJGP8iyJA@mail.gmail.com>
References: <BLU436-SMTP4071B1A51539EAA2F9D7ECDF3B0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:65311 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429AbaEZEzr convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 May 2014 00:55:47 -0400
Received: by mail-we0-f182.google.com with SMTP id t60so7541807wes.27
        for <ceph-devel@vger.kernel.org>; Sun, 25 May 2014 21:55:46 -0700 (PDT)
In-Reply-To: <BLU436-SMTP4071B1A51539EAA2F9D7ECDF3B0@phx.gbl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guang Yang <yguang11@outlook.com>
Cc: Ceph-devel <ceph-devel@vger.kernel.org>

On Mon, May 26, 2014 at 9:46 AM, Guang Yang <yguang11@outlook.com> wrot=
e:
> Hello Haomai,
> We are evaluating the key-value store backend which comes along with =
=46irefly release (thanks for implementing it in Ceph), it is very prom=
ising for a couple of our use cases, after going through the related co=
de change, I have a couple of questions which needs your help:
>   1. One observation is that, for object larger than 1KB, it will be =
striped to multiple chunks (k-v in the leveldb table), with one strip a=
s 1KB size. Is there any particular reason we choose 1KB as the strip s=
ize (and I didn=E2=80=99t find a configuration to tune this value)?

1KB is not a serious value, this value can be configured in the near fu=
ture.

>
>   2. This is properly a leveldb question, do we expect performance de=
gradation as the leveldb instance keeps increasing (e.g. several TB)?

Ceph OSD is expected to own a physical disk, normally is several
TB(1-4TB). LevelDB can take it easy. Especially we use it to store
large value(compared to normal application usage).

>
> Thanks,
> Guang



--=20
Best Regards,

Wheat
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
