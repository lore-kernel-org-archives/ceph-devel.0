From: Evgeniy Firsov <Evgeniy.Firsov@sandisk.com>
Subject: Re: AddressSanitizer
Date: Sat, 2 Apr 2016 02:43:43 +0000
Message-ID: <D3247E10.C746%evgeniy.firsov@sandisk.com>
References: <56FE89BC.5040808@digiware.nl>
 <CAJ4mKGZkq0hZObxQ1+ZOrbi8TaKrciqsAFoXuzS5JQ_qGb9N9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2on0073.outbound.protection.outlook.com ([207.46.100.73]:7591
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751183AbcDBC6q convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Apr 2016 22:58:46 -0400
In-Reply-To: <CAJ4mKGZkq0hZObxQ1+ZOrbi8TaKrciqsAFoXuzS5JQ_qGb9N9A@mail.gmail.com>
Content-Language: en-US
Content-ID: <78833A717A5DA84886F961CF5A0EDC35@namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>, Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Actually GCC has it too(>=4.8) and its very good tool with MUCH lower
overhead then Valgrind.

On 4/1/16, 3:19 PM, "ceph-devel-owner@vger.kernel.org on behalf of Gregory
Farnum" <ceph-devel-owner@vger.kernel.org on behalf of gfarnum@redhat.com>
wrote:

>On Fri, Apr 1, 2016 at 7:46 AM, Willem Jan Withagen <wjw@digiware.nl>
>wrote:
>> Hi
>>
>> In my search for reasons why I have crashes I started using
>> AddressSanitizer with Clang (since that is native included)
>> https://github.com/google/sanitizers/wiki/AddressSanitizer,
>>
>> Below the results which might indicate locations of possible trouble.
>> Would there be interest into looking into these further?
>> I know that some unitests under valgrind also complain about memory
>> leaks just because items are not properly free/deleted since they are
>> just tests.
>>
>> But the ceph-mon container-overflow and the .libs/ceph-dencoder double
>> free are parts of the tree that are used outside the tests.
>>
>> But I still have to find the flags to actually get the translation to
>> file codelines for this to be really useful.
>>
>> --WjW
>>
>>
>> SUMMARY: AddressSanitizer: alloc-dealloc-mismatch
>> (/usr/srcs/Ceph/work/ceph/src/unittest_erasure_code_isa+0x7fea8b)
>> SUMMARY: AddressSanitizer: alloc-dealloc-mismatch
>> (/usr/srcs/Ceph/work/ceph/src/unittest_erasure_code_plugin_isa+0x7e9d0b)
>> SUMMARY: AddressSanitizer: alloc-dealloc-mismatch
>> (/usr/srcs/Ceph/work/ceph/src/unittest_erasure_code_shec+0x8144cb)
>> SUMMARY: AddressSanitizer: alloc-dealloc-mismatch
>> (/usr/srcs/Ceph/work/ceph/src/unittest_erasure_code_shec_all+0x8021ab)
>> SUMMARY: AddressSanitizer: alloc-dealloc-mismatch
>>
>>(/usr/srcs/Ceph/work/ceph/src/unittest_erasure_code_shec_thread+0x7fb78b)
>> SUMMARY: AddressSanitizer: alloc-dealloc-mismatch
>>
>>(/usr/srcs/Ceph/work/ceph/src/unittest_erasure_code_shec_arguments+0x7fd7
>>4b)
>> SUMMARY: AddressSanitizer: alloc-dealloc-mismatch
>>
>>(/usr/srcs/Ceph/work/ceph/src/unittest_erasure_code_plugin_shec+0x7e98db)
>> SUMMARY: AddressSanitizer: heap-use-after-free
>> (/usr/srcs/Ceph/work/ceph/src/unittest_pglog+0x92722f)
>> SUMMARY: AddressSanitizer: dynamic-stack-buffer-overflow
>> (/usr/srcs/Ceph/work/ceph/src/unittest_lfnindex+0x8ee69f)
>> SUMMARY: AddressSanitizer: stack-buffer-overflow
>> (/usr/srcs/Ceph/work/ceph/src/unittest_utf8+0x5ff392)
>> SUMMARY: AddressSanitizer: container-overflow
>> (/usr/srcs/Ceph/work/ceph/src/ceph-mon+0xb591b1)
>> SUMMARY: AddressSanitizer: double-free
>> (/usr/srcs/Ceph/work/ceph/src/.libs/ceph-dencoder+0x8b1fcb)
>
>This is interesting but I wouldn't spend much time on it without
>seeing the actual call paths. We get a lot of memory warnings in
>libraries that turn out to be issues only with shutdown, often because
>the memory checking tool doesn't understand or handle certain
>features.
>
>If it turns out to be real, there have been various efforts to enable
>more clang/llvm checking against the Ceph code base and this is
>another thing that could go in there. Or perhaps it could replace our
>valgrind runs in teuthology or something?
>-Greg
>--
>To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
