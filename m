From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: compiling stops at od compare
Date: Sun, 31 Jan 2016 00:13:08 +0100
Message-ID: <56AD4384.2030705@digiware.nl>
References: <56ACB8FF.5000605@digiware.nl>
 <959618990.28815879.1454194644164.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:49491 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756463AbcA3XNg (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 30 Jan 2016 18:13:36 -0500
In-Reply-To: <959618990.28815879.1454194644164.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Benjamin <mbenjamin@redhat.com>
Cc: ceph-devel@vger.kernel.org

On 30-1-2016 23:57, Matt Benjamin wrote:
> Should we use std::min here (that might require a cast, iirc)?

Well the most important issue I have:
	while(len>0)
where len is of type size_t has only exactly one chance to be true, aka
len =3D 0. negative numbers do not exist.

So casting it to int is a bad(tm) thing.

But as I haven't designed the code, i can only react to the compiler
error and analyze it. And then my conclusion is that the cast can only
increase the chance on an error. And thus the compiler is correct in
triggering.

--WjW

>=20
> Matt
>=20
> ----- Original Message -----
>> From: "Willem Jan Withagen" <wjw@digiware.nl>
>> To: ceph-devel@vger.kernel.org
>> Sent: Saturday, January 30, 2016 8:22:07 AM
>> Subject: compiling stops at od compare
>>
>> When trying to compile on CentOS 7, gcc =3D 4.8.3
>>
>> os/bluestore/BlueFS.cc: In member function =E2=80=98int
>> BlueFS::_read(BlueFS::FileReader*, BlueFS::FileReaderBuffer*, uint64=
_t,
>> size_t, ceph::bufferlist*, char*)=E2=80=99:
>> os/bluestore/BlueFS.cc:731:31: warning: comparison between signed an=
d
>> unsigned integer expressions [-Wsign-compare]
>>      int r =3D MIN((int)len, left);
>>
>> This MIN is used to determine the amount of buffer that is still lef=
t
>> to be filed.
>> And here len and left are both size_t..., suggesting that both canno=
t be
>> negative. So either both need to be promoted/cast, or neither.
>>
>> The cast (int)len suggests that len could be negative.
>> The part where that could happen is at line 750:
>>
>>    off +=3D r;
>>     len -=3D r;
>>     ret +=3D r;
>>
>> So there the loop exit needs len to be exactly equal to r. Even if t=
he
>> loop specifies while(len>0). if len gets "negative" it grows into
>> something rather big.
>>
>> Now if len never gets negative then it also does not need to get cas=
t to
>> int. If it does, then in the unsigned case it will always be larger =
than
>> left.
>>
>> So bottomline is that the cast serves no purpose?
>> Removing it fixes compilation.
>>
>> --WjW
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
