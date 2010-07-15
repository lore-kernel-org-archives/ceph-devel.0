From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: undefined reference to librados::Rados::read
Date: Thu, 15 Jul 2010 10:19:14 -0700
Message-ID: <AANLkTilMYS-GLEUpKDRHfCGZQSI-6qi4KnPOcSYgv6Ze@mail.gmail.com>
References: <AANLkTinjpOysFXSJ8vvcuNxCzJ7JTLv9R6qRcIGG2d1Y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:35356 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934Ab0GORTQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Jul 2010 13:19:16 -0400
Received: by vws5 with SMTP id 5so1416054vws.19
        for <ceph-devel@vger.kernel.org>; Thu, 15 Jul 2010 10:19:15 -0700 (PDT)
In-Reply-To: <AANLkTinjpOysFXSJ8vvcuNxCzJ7JTLv9R6qRcIGG2d1Y@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Takuya ASADA <syuu@dokukino.com>
Cc: ceph-devel@vger.kernel.org

On Thu, Jul 15, 2010 at 7:52 AM, Takuya ASADA <syuu@dokukino.com> wrote:
>
> Hi,
>
> I'm writing sample code of RADOS client to learn RADOS API, and I'm
> stacking on librados::Rados::read().
> It could compile, but cannot link due to this error:
> get_obj.cc:(.text+0x315): undefined reference to
> `librados::Rados::read(void*, std::basic_string<char,
> std::char_traits<char>, std::allocator<char> > const&, long,
> ceph::buffer::list&, unsigned int)'
>
...
>
> Then, compile & link following command:
> # g++ -lcrypto -lrados -lcrush get_obj.cc
> /tmp/cctA2uA8.o: In function `main':
> get_obj.cc:(.text+0x315): undefined reference to
> `librados::Rados::read(void*, std::basic_string<char,
> std::char_traits<char>, std::allocator<char> > const&, long,
> ceph::buffer::list&, unsigned int)'
> collect2: ld returned 1 exit status
>
> Do you have any idea with this?
>

What librados version is installed? Are you compiling from source?

Thanks,
Yehuda
