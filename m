From: =?UTF-8?B?6JSh5qyK5pix?= <chuanyu@cs.nctu.edu.tw>
Subject: Re: About deleting container/bucket from radosgw
Date: Sun, 15 Jul 2012 10:47:26 +0800
Message-ID: <CAKG+gh-SdU1W4gbe0Th+tciJp6kDn=Zt8aMG3SBguk9D94cBLQ@mail.gmail.com>
References: <CAKG+gh-25-9PgjPBpXx4PoGSinjudVtk8xXit-LBuqXDhPyUvA@mail.gmail.com>
	<CAC-hyiE7aQ50jJHR4CMcfxv2rsBvONj6z5MFJsg=gfyWVr=w-w@mail.gmail.com>
	<CAKG+gh--UPGuwqXbSKvJtq2DJG5Z2NCr7E7fJR0nGbTqhwcpHg@mail.gmail.com>
	<CAC-hyiFpLi-boNQeRxDzw65WejB_mXzw4HqqCFs8VcV9Ry4mPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:54323 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583Ab2GOCr2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 14 Jul 2012 22:47:28 -0400
Received: by eaak11 with SMTP id k11so1375547eaa.19
        for <ceph-devel@vger.kernel.org>; Sat, 14 Jul 2012 19:47:26 -0700 (PDT)
In-Reply-To: <CAC-hyiFpLi-boNQeRxDzw65WejB_mXzw4HqqCFs8VcV9Ry4mPw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: ceph-devel@vger.kernel.org

2012/7/15 Yehuda Sadeh <yehuda@inktank.com>:
> On Sat, Jul 14, 2012 at 8:04 AM, =E8=94=A1=E6=AC=8A=E6=98=B1 <chuanyu=
@cs.nctu.edu.tw> wrote:
> ...
>>
>> On the other hand, why radosgw-admin doesn't supply "bucket rm" call=
?
>> When I want to "user rm" a user, it seems like I need to "bucket unl=
ink"
>> all buckets belongs to the user, but the buckets are still in there!
>> Then, the other users can not create the same name of bucket
>> anymore(by s3/swift).
>
> Yeah, currently radosgw-admin doesn't provide a way to remove the
> entire content of the bucket. I opened an issue for that (#2786), and
> it ties into another issue also (#2499: the ability to remove user
> without removing its data first). I think we can provide tools for
> manual data removal, but we may also want to explore doing that as
> part of a bigger garbage collection scheme that we'll soon be working
> on.
It sounds good that rgw will have garbage collection!
>>
>> So, Is this the only way I can do by using s3/swift client to delete=
 buckets
>> which belongs to that user before "radosgw-admin user rm" ?
>>
>> Can I "rm" all buckets, and "rm" the user only by radosgw-admin?
>
> You can unlink the buckets and link them to a different user (so that
> you don't just leak the data), and then remove the user.
OK, it's a good approach now, thanks for your advice :)

Chuanyu
>
> Yehuda



--=20
=E8=94=A1=E6=AC=8A=E6=98=B1 Tsai Chuanyu
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
