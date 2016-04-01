From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: AddressSanitizer
Date: Fri, 1 Apr 2016 15:19:44 -0700
Message-ID: <CAJ4mKGZkq0hZObxQ1+ZOrbi8TaKrciqsAFoXuzS5JQ_qGb9N9A@mail.gmail.com>
References: <56FE89BC.5040808@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f52.google.com ([209.85.213.52]:35670 "EHLO
	mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752708AbcDAWTp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Apr 2016 18:19:45 -0400
Received: by mail-vk0-f52.google.com with SMTP id e6so120343210vkh.2
        for <ceph-devel@vger.kernel.org>; Fri, 01 Apr 2016 15:19:45 -0700 (PDT)
In-Reply-To: <56FE89BC.5040808@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Apr 1, 2016 at 7:46 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> Hi
>
> In my search for reasons why I have crashes I started using
> AddressSanitizer with Clang (since that is native included)
> https://github.com/google/sanitizers/wiki/AddressSanitizer,
>
> Below the results which might indicate locations of possible trouble.
> Would there be interest into looking into these further?
> I know that some unitests under valgrind also complain about memory
> leaks just because items are not properly free/deleted since they are
> just tests.
>
> But the ceph-mon container-overflow and the .libs/ceph-dencoder double
> free are parts of the tree that are used outside the tests.
>
> But I still have to find the flags to actually get the translation to
> file codelines for this to be really useful.
>
> --WjW
>
>
> SUMMARY: AddressSanitizer: alloc-dealloc-mismatch
> (/usr/srcs/Ceph/work/ceph/src/unittest_erasure_code_isa+0x7fea8b)
> SUMMARY: AddressSanitizer: alloc-dealloc-mismatch
> (/usr/srcs/Ceph/work/ceph/src/unittest_erasure_code_plugin_isa+0x7e9d0b)
> SUMMARY: AddressSanitizer: alloc-dealloc-mismatch
> (/usr/srcs/Ceph/work/ceph/src/unittest_erasure_code_shec+0x8144cb)
> SUMMARY: AddressSanitizer: alloc-dealloc-mismatch
> (/usr/srcs/Ceph/work/ceph/src/unittest_erasure_code_shec_all+0x8021ab)
> SUMMARY: AddressSanitizer: alloc-dealloc-mismatch
> (/usr/srcs/Ceph/work/ceph/src/unittest_erasure_code_shec_thread+0x7fb78b)
> SUMMARY: AddressSanitizer: alloc-dealloc-mismatch
> (/usr/srcs/Ceph/work/ceph/src/unittest_erasure_code_shec_arguments+0x7fd74b)
> SUMMARY: AddressSanitizer: alloc-dealloc-mismatch
> (/usr/srcs/Ceph/work/ceph/src/unittest_erasure_code_plugin_shec+0x7e98db)
> SUMMARY: AddressSanitizer: heap-use-after-free
> (/usr/srcs/Ceph/work/ceph/src/unittest_pglog+0x92722f)
> SUMMARY: AddressSanitizer: dynamic-stack-buffer-overflow
> (/usr/srcs/Ceph/work/ceph/src/unittest_lfnindex+0x8ee69f)
> SUMMARY: AddressSanitizer: stack-buffer-overflow
> (/usr/srcs/Ceph/work/ceph/src/unittest_utf8+0x5ff392)
> SUMMARY: AddressSanitizer: container-overflow
> (/usr/srcs/Ceph/work/ceph/src/ceph-mon+0xb591b1)
> SUMMARY: AddressSanitizer: double-free
> (/usr/srcs/Ceph/work/ceph/src/.libs/ceph-dencoder+0x8b1fcb)

This is interesting but I wouldn't spend much time on it without
seeing the actual call paths. We get a lot of memory warnings in
libraries that turn out to be issues only with shutdown, often because
the memory checking tool doesn't understand or handle certain
features.

If it turns out to be real, there have been various efforts to enable
more clang/llvm checking against the Ceph code base and this is
another thing that could go in there. Or perhaps it could replace our
valgrind runs in teuthology or something?
-Greg
