From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Compiling for FreeBSD, Clang refuses to compile a test
Date: Tue, 8 Dec 2015 09:48:00 +0100
Message-ID: <56669940.4090504@digiware.nl>
References: <565B3999.3050302@digiware.nl>
 <CACJqLyaSTqKjAQf1Nb8UE00SrF0y1fskYhExmWd3vbCvNrFBkA@mail.gmail.com>
 <565B4A7F.60301@digiware.nl>
 <CAAM7YAmmOwfyiB1jFfGLz4fDxPxHRPQQNk80qEq2-RqFiHH-3g@mail.gmail.com>
 <20151130065812.GA20205@gmail.com>
 <alpine.DEB.2.00.1511300518210.19170@cobra.newdream.net>
 <565D7FA8.3010301@digiware.nl>
 <alpine.DEB.2.00.1512010529280.19170@cobra.newdream.net>
 <565DA3B5.1070608@digiware.nl>
 <alpine.DEB.2.00.1512010634510.19170@cobra.newdream.net>
 <565DC9D4.7060701@digiware.nl> <565DEC36.10102@digiware.nl>
 <565F5E28.8020706@digiware.nl> <5660106F.90202@digiware.nl>
 <5662DEEB.7060208@digiware.nl>
 <CANE=7sX5w36vhpN6TGNc4e_LBEsxcZokzEJX-Qs63zUbS4ynLA@mail.gmail.com>
 <5665FDD3.90000@digiware.nl>
 <CAEFDAA4T8VraUL90PvDEnkvOF9Q_6rinKfRgpG-CGMBeVz9pcQ@mail.gmail.com>
 <56662483.30101@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:18585 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755247AbbLHI6w (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 8 Dec 2015 03:58:52 -0500
In-Reply-To: <56662483.30101@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Michal Jarzabek <stiopa@gmail.com>
Cc: =?UTF-8?B?WGluemUgQ2hpICjkv6Hms70p?= <xmdxcxz@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 8-12-2015 01:29, Willem Jan Withagen wrote:
> On 7-12-2015 23:19, Michal Jarzabek wrote:
>> Hi Willem,
>>
>> If you look at line 411 and 412 you will have variables k and m
>> defined. They are not changed anywhere(I think), so the sizes must
>> be big enough. As Xinze mentioned just add const in front of it:
>> const int k = 12 const int m = 4 and it should fix the compile
>> error.
>>
>> buffer::ptr enc[k + m] works with gcc, because of the compiler
>> extension, but it's not standard
>> c++(https://gcc.gnu.org/onlinedocs/gcc/Variable-Length.html)
>>
>> I will submit patch to  change it.
>
> That is exactly what I have done to get things compiling. Have not
> yet gotten to the state that everything builds to start testing.

Testing has started....

Not everything goes well, but it is getting there.
Had to disable ebd testing as that still does not get build.
But I think I saw a patch passing by that it only got build for Linux.

And the tests below tooks to run for atleast 7 hours on a
CPU: AMD Phenom(tm) II X6 1075T Processor (3013.83-MHz K8-class CPU)
So what I gather from that is that that is too long.

Some tests (like: unittest_erasure_code_shec_thread)  got killed because
they ran out of swap, others (unittest_on_exit) got a signal 6...
But then again that could be because the gtest ASSERT_DEATH stuff is
not suppoorted under FreeBSD (as by words of Google)

--WjW



PASS: unittest_erasure_code_plugin
PASS: unittest_erasure_code
PASS: unittest_erasure_code_jerasure
PASS: unittest_erasure_code_plugin_jerasure
PASS: unittest_erasure_code_isa
PASS: unittest_erasure_code_plugin_isa
PASS: unittest_erasure_code_lrc
PASS: unittest_erasure_code_plugin_lrc
PASS: unittest_erasure_code_shec
PASS: unittest_erasure_code_shec_all
PASS: unittest_erasure_code_shec_thread
Killed
FAIL: unittest_erasure_code_shec_arguments
PASS: unittest_erasure_code_plugin_shec
PASS: unittest_erasure_code_example
PASS: unittest_librados
PASS: unittest_librados_config
PASS: unittest_journal
PASS: unittest_rbd_replay
PASS: unittest_encoding
PASS: unittest_base64
PASS: unittest_run_cmd
PASS: unittest_simple_spin
PASS: unittest_libcephfs_config
PASS: unittest_mon_moncap
PASS: unittest_mon_pgmap
PASS: unittest_ecbackend
PASS: unittest_osdscrub
PASS: unittest_pglog
PASS: unittest_hitset
PASS: unittest_osd_osdcap
PASS: unittest_pageset
PASS: unittest_chain_xattr
PASS: unittest_lfnindex
PASS: unittest_mds_authcap
PASS: unittest_addrs
PASS: unittest_bloom_filter
PASS: unittest_histogram
PASS: unittest_prioritized_queue
PASS: unittest_str_map
PASS: unittest_sharedptr_registry
PASS: unittest_shared_cache
PASS: unittest_sloppy_crc_map
PASS: unittest_util
PASS: unittest_crush_wrapper
PASS: unittest_crush
PASS: unittest_osdmap
PASS: unittest_workqueue
PASS: unittest_striper
PASS: unittest_prebufferedstreambuf
PASS: unittest_str_list
PASS: unittest_log
PASS: unittest_throttle
PASS: unittest_ceph_argparse
PASS: unittest_ceph_compatset
PASS: unittest_mds_types
PASS: unittest_osd_types
PASS: unittest_lru
PASS: unittest_io_priority
PASS: unittest_gather
PASS: unittest_signals
PASS: unittest_bufferlist
PASS: unittest_xlist
PASS: unittest_crc32c
PASS: unittest_arch
PASS: unittest_crypto
PASS: unittest_crypto_init
PASS: unittest_perf_counters
PASS: unittest_admin_socket
PASS: unittest_ceph_crypto
PASS: unittest_utf8
PASS: unittest_mime
PASS: unittest_escape
PASS: unittest_strtol
PASS: unittest_confutils
PASS: unittest_config
PASS: unittest_context
PASS: unittest_safe_io
PASS: unittest_heartbeatmap
PASS: unittest_formatter
PASS: unittest_daemon_config
PASS: unittest_ipaddr
PASS: unittest_texttable
Abort trap (core dumped)
FAIL: unittest_on_exit
PASS: unittest_readahead
PASS: unittest_tableformatter
PASS: unittest_bit_vector
FAIL: ceph-detect-init/run-tox.sh
FAIL: test/erasure-code/test-erasure-code.sh
FAIL: test/erasure-code/test-erasure-eio.sh
