From: Guang Yang <yguang11@outlook.com>
Subject: Re: Questions of KeyValueStore (leveldb) backend
Date: Mon, 26 May 2014 13:09:32 +0800
Message-ID: <BLU436-SMTP759AB8A87875AE2FBBD0E8DF3B0@phx.gbl>
References: <BLU436-SMTP4071B1A51539EAA2F9D7ECDF3B0@phx.gbl> <CACJqLyZYe6+CBrB49B5TnyahsT6387-bWDXCQ6JCYcJGP8iyJA@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from blu0-omc4-s34.blu0.hotmail.com ([65.55.111.173]:6821 "EHLO
	blu0-omc4-s34.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751710AbaEZFJk convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 26 May 2014 01:09:40 -0400
In-Reply-To: <CACJqLyZYe6+CBrB49B5TnyahsT6387-bWDXCQ6JCYcJGP8iyJA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>
Cc: Ceph-devel <ceph-devel@vger.kernel.org>

Thanks!
On May 26, 2014, at 12:55 PM, Haomai Wang <haomaiwang@gmail.com> wrote:

> On Mon, May 26, 2014 at 9:46 AM, Guang Yang <yguang11@outlook.com> wr=
ote:
>> Hello Haomai,
>> We are evaluating the key-value store backend which comes along with=
 Firefly release (thanks for implementing it in Ceph), it is very promi=
sing for a couple of our use cases, after going through the related cod=
e change, I have a couple of questions which needs your help:
>>  1. One observation is that, for object larger than 1KB, it will be =
striped to multiple chunks (k-v in the leveldb table), with one strip a=
s 1KB size. Is there any particular reason we choose 1KB as the strip s=
ize (and I didn=92t find a configuration to tune this value)?
>=20
> 1KB is not a serious value, this value can be configured in the near =
future.
>=20
>>=20
>>  2. This is properly a leveldb question, do we expect performance de=
gradation as the leveldb instance keeps increasing (e.g. several TB)?
>=20
> Ceph OSD is expected to own a physical disk, normally is several
> TB(1-4TB). LevelDB can take it easy. Especially we use it to store
> large value(compared to normal application usage).
>=20
>>=20
>> Thanks,
>> Guang
>=20
>=20
>=20
> --=20
> Best Regards,
>=20
> Wheat
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
