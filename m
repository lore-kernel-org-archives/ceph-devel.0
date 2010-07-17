From: Takuya ASADA <syuu@dokukino.com>
Subject: Re: undefined reference to librados::Rados::read
Date: Sat, 17 Jul 2010 23:20:56 +0900
Message-ID: <AANLkTiku27Ef-Zk6s1VSAEKmlJaX88KoR3uHrGntNNZ-@mail.gmail.com>
References: <AANLkTinjpOysFXSJ8vvcuNxCzJ7JTLv9R6qRcIGG2d1Y@mail.gmail.com>
	<AANLkTilMYS-GLEUpKDRHfCGZQSI-6qi4KnPOcSYgv6Ze@mail.gmail.com>
	<AANLkTiknkFdBi1pWHocCg8zNKljRN5_eOb6odyUhPBL7@mail.gmail.com>
	<AANLkTinEUg17m7I6QsIX8rcaF0nu5n83NQqL1Ab2xCI1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:46011 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755811Ab0GQOVR convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 17 Jul 2010 10:21:17 -0400
Received: by pvc7 with SMTP id 7so1174128pvc.19
        for <ceph-devel@vger.kernel.org>; Sat, 17 Jul 2010 07:21:16 -0700 (PDT)
In-Reply-To: <AANLkTinEUg17m7I6QsIX8rcaF0nu5n83NQqL1Ab2xCI1@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: ceph-devel@vger.kernel.org

Ah! I understood. You are right. Thanks!

syuu

2010/7/17 Yehuda Sadeh Weinraub <yehudasa@gmail.com>:
> On Thu, Jul 15, 2010 at 10:06 PM, Takuya ASADA <syuu@dokukino.com> wr=
ote:
>> Hi,
>>
>> Oh sorry I didn't describe the environment.
>> The distribution is CentOS 5.5 x86, gcc is 4.1.2.
>> I tried both current source code from git and version 0.20.2 source =
code.
>>
>> I also tried to implement the other operations, these codes are coul=
d
>> compiled successfully.
>> ex) http://github.com/syuu1228/radoscmds/blob/master/put_obj.cc
>> This uses rados->write_full().
>>
>
> I bet it's some inconsistency in the way size_t is defined. You can
> try casting the last parameter to unsigned long and see whether it
> fixes it. You can also try adding _FILE_OFFSET_BITS=3D64 when compili=
ng
> it, like this:
>
> # g++ =C2=A0-D_FILE_OFFSET_BITS=3D64 -lcrypto -lrados -lcrush get_obj=
=2Ecc
>
> Thanks,
> Yehuda
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
