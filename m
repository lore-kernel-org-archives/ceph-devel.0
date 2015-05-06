From: Mark Nelson <mnelson@redhat.com>
Subject: Re: CRC algorithm selection
Date: Wed, 06 May 2015 13:43:01 -0500
Message-ID: <554A60B5.8050803@redhat.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD8773C@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54588 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751282AbbEFSnE (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 6 May 2015 14:43:04 -0400
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD8773C@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 05/06/2015 01:36 PM, Somnath Roy wrote:
> Sage,
> Based on the discussion of today's performance meeting, I ran the crc32 unittest and here is the result.
>
> root@emsserver2:/home/ceph-main/src# ./unittest_crc32c
> Running main() from gmock_main.cc
> [==========] Running 7 tests from 1 test case.
> [----------] Global test environment set-up.
> [----------] 7 tests from Crc32c
> [ RUN      ] Crc32c.Small
> [       OK ] Crc32c.Small (0 ms)
> [ RUN      ] Crc32c.PartialWord
> [       OK ] Crc32c.PartialWord (0 ms)
> [ RUN      ] Crc32c.Big
> [       OK ] Crc32c.Big (16 ms)
> [ RUN      ] Crc32c.Performance
> populating large buffer
> calculating crc
> best choice = 1193.86 MB/sec
> best choice 0xffffffff = 1193.56 MB/sec
> sctp = 1190.6 MB/sec
> intel baseline = 261.623 MB/sec
> [       OK ] Crc32c.Performance (7064 ms)
> [ RUN      ] Crc32c.Range
> [       OK ] Crc32c.Range (0 ms)
> [ RUN      ] Crc32c.RangeZero
> [       OK ] Crc32c.RangeZero (0 ms)
> [ RUN      ] Crc32c.RangeNull
> [       OK ] Crc32c.RangeNull (0 ms)
> [----------] 7 tests from Crc32c (7080 ms total)
>
> [----------] Global test environment tear-down
> [==========] 7 tests from 1 test case ran. (7080 ms total)
> [  PASSED  ] 7 tests.
>
>
> So, it seems 'sctp' is giving better performance and thus it is recommending this.
>
> So, it seems it is not picking up *_intel_fast method and going back to make file I saw 'configure' was skipping yasm check since in my setup yasm was not installed.
> I manually installed 'yasm' and rebuild everything. Now, here is the result..It is picking up *_intel_fast method and it is ~6 times faster !!!
>
>
> root@emsserver2:/home/ceph-main/src# ./unittest_crc32c
> Running main() from gmock_main.cc
> [==========] Running 7 tests from 1 test case.
> [----------] Global test environment set-up.
> [----------] 7 tests from Crc32c
> [ RUN      ] Crc32c.Small
> [       OK ] Crc32c.Small (0 ms)
> [ RUN      ] Crc32c.PartialWord
> [       OK ] Crc32c.PartialWord (0 ms)
> [ RUN      ] Crc32c.Big
> [       OK ] Crc32c.Big (4 ms)
> [ RUN      ] Crc32c.Performance
> populating large buffer
> calculating crc
> best choice = 6275.01 MB/sec
> best choice 0xffffffff = 6314.59 MB/sec
> sctp = 1187.1 MB/sec
> intel baseline = 261.652 MB/sec
> [       OK ] Crc32c.Performance (5709 ms)
> [ RUN      ] Crc32c.Range
> [       OK ] Crc32c.Range (0 ms)
> [ RUN      ] Crc32c.RangeZero
> [       OK ] Crc32c.RangeZero (0 ms)
> [ RUN      ] Crc32c.RangeNull
> [       OK ] Crc32c.RangeNull (0 ms)
> [----------] 7 tests from Crc32c (5713 ms total)
>
> [----------] Global test environment tear-down
> [==========] 7 tests from 1 test case ran. (5713 ms total)
> [  PASSED  ] 7 tests.
>
>
> Thanks for the pointer and I will enable my journal tests with crc enabled.
>
> BTW, I think we need to error out configure script (or at least document ) if build server is not having  'yasm' installed.

Excellent debugging Somnath!
