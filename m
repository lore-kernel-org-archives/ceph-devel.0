From: Takuya ASADA <syuu@dokukino.com>
Subject: Re: undefined reference to librados::Rados::read
Date: Fri, 16 Jul 2010 14:06:49 +0900
Message-ID: <AANLkTiknkFdBi1pWHocCg8zNKljRN5_eOb6odyUhPBL7@mail.gmail.com>
References: <AANLkTinjpOysFXSJ8vvcuNxCzJ7JTLv9R6qRcIGG2d1Y@mail.gmail.com>
	<AANLkTilMYS-GLEUpKDRHfCGZQSI-6qi4KnPOcSYgv6Ze@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:40408 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751405Ab0GPFHK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Jul 2010 01:07:10 -0400
Received: by gxk23 with SMTP id 23so1042417gxk.19
        for <ceph-devel@vger.kernel.org>; Thu, 15 Jul 2010 22:07:09 -0700 (PDT)
In-Reply-To: <AANLkTilMYS-GLEUpKDRHfCGZQSI-6qi4KnPOcSYgv6Ze@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi,

Oh sorry I didn't describe the environment.
The distribution is CentOS 5.5 x86, gcc is 4.1.2.
I tried both current source code from git and version 0.20.2 source code.

I also tried to implement the other operations, these codes are could
compiled successfully.
ex) http://github.com/syuu1228/radoscmds/blob/master/put_obj.cc
This uses rados->write_full().

And most of the codes are borrowed from rgw/rgw_rados.cc and rados.cc.

2010/7/16 Yehuda Sadeh Weinraub <yehudasa@gmail.com>:
> On Thu, Jul 15, 2010 at 7:52 AM, Takuya ASADA <syuu@dokukino.com> wrote:
>>
>> Hi,
>>
>> I'm writing sample code of RADOS client to learn RADOS API, and I'm
>> stacking on librados::Rados::read().
>> It could compile, but cannot link due to this error:
>> get_obj.cc:(.text+0x315): undefined reference to
>> `librados::Rados::read(void*, std::basic_string<char,
>> std::char_traits<char>, std::allocator<char> > const&, long,
>> ceph::buffer::list&, unsigned int)'
>>
> ...
>>
>> Then, compile & link following command:
>> # g++ -lcrypto -lrados -lcrush get_obj.cc
>> /tmp/cctA2uA8.o: In function `main':
>> get_obj.cc:(.text+0x315): undefined reference to
>> `librados::Rados::read(void*, std::basic_string<char,
>> std::char_traits<char>, std::allocator<char> > const&, long,
>> ceph::buffer::list&, unsigned int)'
>> collect2: ld returned 1 exit status
>>
>> Do you have any idea with this?
>>
>
> What librados version is installed? Are you compiling from source?
>
> Thanks,
> Yehuda
>
