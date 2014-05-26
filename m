From: Wido den Hollander <wido@42on.com>
Subject: Re: Questions of KeyValueStore (leveldb) backend
Date: Mon, 26 May 2014 11:23:00 +0200
Message-ID: <538307F4.8090101@42on.com>
References: <BLU436-SMTP4071B1A51539EAA2F9D7ECDF3B0@phx.gbl> <CACJqLyZYe6+CBrB49B5TnyahsT6387-bWDXCQ6JCYcJGP8iyJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:51254 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751515AbaEZJXD (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 26 May 2014 05:23:03 -0400
In-Reply-To: <CACJqLyZYe6+CBrB49B5TnyahsT6387-bWDXCQ6JCYcJGP8iyJA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>, Guang Yang <yguang11@outlook.com>
Cc: Ceph-devel <ceph-devel@vger.kernel.org>

On 05/26/2014 06:55 AM, Haomai Wang wrote:
> On Mon, May 26, 2014 at 9:46 AM, Guang Yang <yguang11@outlook.com> wr=
ote:
>> Hello Haomai,
>> We are evaluating the key-value store backend which comes along with=
 Firefly release (thanks for implementing it in Ceph), it is very promi=
sing for a couple of our use cases, after going through the related cod=
e change, I have a couple of questions which needs your help:
>>    1. One observation is that, for object larger than 1KB, it will b=
e striped to multiple chunks (k-v in the leveldb table), with one strip=
 as 1KB size. Is there any particular reason we choose 1KB as the strip=
 size (and I didn=E2=80=99t find a configuration to tune this value)?
>
> 1KB is not a serious value, this value can be configured in the near =
future.
>

So that is currently hardcoded? I can't find any reference to it in=20
config_opts.h

>>
>>    2. This is properly a leveldb question, do we expect performance =
degradation as the leveldb instance keeps increasing (e.g. several TB)?
>
> Ceph OSD is expected to own a physical disk, normally is several
> TB(1-4TB). LevelDB can take it easy. Especially we use it to store
> large value(compared to normal application usage).
>

With a large value you mean something like 4MB? The regular strip-size=20
for RBD, CephFS and such?

>>
>> Thanks,
>> Guang
>
>
>


--=20
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
