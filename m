From: liuchang0812 <liuchang0812@gmail.com>
Subject: Re: question about default leveldb block_size
Date: Mon, 13 Feb 2017 16:05:58 +0800
Message-ID: <CACKY0b9_kzyL0s2WEsTkodR4czWfzdVnv75KMvwYTKei-7MxFw@mail.gmail.com>
References: <CACKY0b-5bnPp40mvx2TMfAwu6_-fVoqaxN-Uhxcfmqd0-ccknw@mail.gmail.com>
 <CAF7cUg3Df3DRvwBLug+-VSLrK0r7Ejb8P9xRBo=zfWXYjTnmEw@mail.gmail.com>
 <D928D641-8E76-43D9-BD0D-F6E1C70E60ED@gmail.com> <CAF7cUg2Vd+dmRhWwo5kzeq5jCzQ7A4Bc=n0GmcL9N1P0f27m8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f174.google.com ([209.85.161.174]:32862 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752208AbdBMIGA (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Feb 2017 03:06:00 -0500
Received: by mail-yw0-f174.google.com with SMTP id u68so46390313ywg.0
        for <ceph-devel@vger.kernel.org>; Mon, 13 Feb 2017 00:06:00 -0800 (PST)
In-Reply-To: <CAF7cUg2Vd+dmRhWwo5kzeq5jCzQ7A4Bc=n0GmcL9N1P0f27m8Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: xinxin shu <xinxin.shu5040@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

Thanks, Get it

2017-02-13 13:38 GMT+08:00 xinxin shu <xinxin.shu5040@gmail.com>:
> pls refer to https://github.com/ceph/ceph/blob/master/src/kv/LevelDBStore=
.cc#L71
>
> 2017-02-13 12:41 GMT+08:00 =E5=88=98=E7=95=85 <liuchang0812@gmail.com>:
>> Thanks  xinxin
>>
>> Where's the related code?
>>
>> =E5=8F=91=E8=87=AA=E6=88=91=E7=9A=84 iPhone
>>
>>> =E5=9C=A8 2017=E5=B9=B42=E6=9C=8813=E6=97=A5=EF=BC=8C11:58=EF=BC=8Cxinx=
in shu <xinxin.shu5040@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>>>
>>> leveldb is opened with default block size (4K) with setting
>>> leveldb_block_size to 0
>>>
>>> 2017-02-13 11:34 GMT+08:00 liuchang0812 <liuchang0812@gmail.com>:
>>>> I saw that we use 0 as leveldb_block_size [1] as following:
>>>>
>>>>     OPTION(leveldb_block_size, OPT_U64, 0) // leveldb block size
>>>>
>>>> It seems that leveldb don't process 0 as a special value.
>>>>
>>>> Any reasons for this configuration? why not 4KB or 32KB?
>>>>
>>>>
>>>>
>>>> [1] https://github.com/ceph/ceph/blob/master/src/common/config_opts.h#=
L887
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
