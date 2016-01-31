From: Willem Jan Withagen <wjw@digiware.nl>
Subject: [patch] Re: compiling stops at od compare
Date: Sun, 31 Jan 2016 13:25:55 +0100
Message-ID: <56ADFD53.4020401@digiware.nl>
References: <56ACB8FF.5000605@digiware.nl>
 <959618990.28815879.1454194644164.JavaMail.zimbra@redhat.com>
 <56AD4384.2030705@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:24417 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757278AbcAaM0Z (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 31 Jan 2016 07:26:25 -0500
In-Reply-To: <56AD4384.2030705@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Benjamin <mbenjamin@redhat.com>
Cc: ceph-devel@vger.kernel.org

On 31-1-2016 00:13, Willem Jan Withagen wrote:
> On 30-1-2016 23:57, Matt Benjamin wrote:
>> Should we use std::min here (that might require a cast, iirc)?
>=20
> Well the most important issue I have:
> 	while(len>0)
> where len is of type size_t has only exactly one chance to be true, a=
ka
> len =3D 0. negative numbers do not exist.
>=20
> So casting it to int is a bad(tm) thing.
>=20
> But as I haven't designed the code, i can only react to the compiler
> error and analyze it. And then my conclusion is that the cast can onl=
y
> increase the chance on an error. And thus the compiler is correct in
> triggering.

Sorry,

I did not answer your question.

If using std::min requires a cast, then it will fall in the same pitfal=
l
as the current code does. if there is a std::min version that does not
autocast/promote size_t to int it might work as well.
Using MIN does "the right thing", without the cast.

diff --git a/src/os/bluestore/BlueFS.cc b/src/os/bluestore/BlueFS.cc
index 1bad6a2..13555c9 100644
--- a/src/os/bluestore/BlueFS.cc
+++ b/src/os/bluestore/BlueFS.cc
@@ -728,7 +728,7 @@ int BlueFS::_read(
     left =3D buf->get_buf_remaining(off);
     dout(20) << __func__ << " left " << left << " len " << len << dend=
l;

-    int r =3D MIN((int)len, left);
+    int r =3D MIN(len, left);
     if (outbl) {
       bufferlist t;
       t.substr_of(buf->bl, off - buf->bl_off, r);

This does the job on Centos 7 for me....

--WjW

>> ----- Original Message -----
>>> From: "Willem Jan Withagen" <wjw@digiware.nl>
>>> To: ceph-devel@vger.kernel.org
>>> Sent: Saturday, January 30, 2016 8:22:07 AM
>>> Subject: compiling stops at od compare
>>>
>>> When trying to compile on CentOS 7, gcc =3D 4.8.3
>>>
>>> os/bluestore/BlueFS.cc: In member function =E2=80=98int
>>> BlueFS::_read(BlueFS::FileReader*, BlueFS::FileReaderBuffer*, uint6=
4_t,
>>> size_t, ceph::bufferlist*, char*)=E2=80=99:
>>> os/bluestore/BlueFS.cc:731:31: warning: comparison between signed a=
nd
>>> unsigned integer expressions [-Wsign-compare]
>>>      int r =3D MIN((int)len, left);
>>>
>>> This MIN is used to determine the amount of buffer that is still le=
ft
>>> to be filed.
>>> And here len and left are both size_t..., suggesting that both cann=
ot be
>>> negative. So either both need to be promoted/cast, or neither.
>>>
>>> The cast (int)len suggests that len could be negative.
>>> The part where that could happen is at line 750:
>>>
>>>    off +=3D r;
>>>     len -=3D r;
>>>     ret +=3D r;
>>>
>>> So there the loop exit needs len to be exactly equal to r. Even if =
the
>>> loop specifies while(len>0). if len gets "negative" it grows into
>>> something rather big.
>>>
>>> Now if len never gets negative then it also does not need to get ca=
st to
>>> int. If it does, then in the unsigned case it will always be larger=
 than
>>> left.
>>>
>>> So bottomline is that the cast serves no purpose?
>>> Removing it fixes compilation.
>>>
>>> --WjW
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
