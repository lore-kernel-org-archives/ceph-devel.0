From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: undefined reference to librados::Rados::read
Date: Fri, 16 Jul 2010 10:25:16 -0700
Message-ID: <AANLkTinEUg17m7I6QsIX8rcaF0nu5n83NQqL1Ab2xCI1@mail.gmail.com>
References: <AANLkTinjpOysFXSJ8vvcuNxCzJ7JTLv9R6qRcIGG2d1Y@mail.gmail.com>
	<AANLkTilMYS-GLEUpKDRHfCGZQSI-6qi4KnPOcSYgv6Ze@mail.gmail.com>
	<AANLkTiknkFdBi1pWHocCg8zNKljRN5_eOb6odyUhPBL7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:47172 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755005Ab0GPRZQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Jul 2010 13:25:16 -0400
Received: by vws5 with SMTP id 5so2776338vws.19
        for <ceph-devel@vger.kernel.org>; Fri, 16 Jul 2010 10:25:16 -0700 (PDT)
In-Reply-To: <AANLkTiknkFdBi1pWHocCg8zNKljRN5_eOb6odyUhPBL7@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Takuya ASADA <syuu@dokukino.com>
Cc: ceph-devel@vger.kernel.org

On Thu, Jul 15, 2010 at 10:06 PM, Takuya ASADA <syuu@dokukino.com> wrote:
> Hi,
>
> Oh sorry I didn't describe the environment.
> The distribution is CentOS 5.5 x86, gcc is 4.1.2.
> I tried both current source code from git and version 0.20.2 source code.
>
> I also tried to implement the other operations, these codes are could
> compiled successfully.
> ex) http://github.com/syuu1228/radoscmds/blob/master/put_obj.cc
> This uses rados->write_full().
>

I bet it's some inconsistency in the way size_t is defined. You can
try casting the last parameter to unsigned long and see whether it
fixes it. You can also try adding _FILE_OFFSET_BITS=64 when compiling
it, like this:

# g++  -D_FILE_OFFSET_BITS=64 -lcrypto -lrados -lcrush get_obj.cc

Thanks,
Yehuda
