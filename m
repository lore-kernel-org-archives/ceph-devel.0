From: Sage Weil <sage@inktank.com>
Subject: Re: BUG: mount failed with IP and hostname mixed
Date: Sun, 25 Nov 2012 09:37:39 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1211250937070.23552@cobra.newdream.net>
References: <CAJiejCQqjStwZi1Tgei-AsKrkrbo876mWziP1FoPVhDBm8Yjqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41166 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753232Ab2KYRhj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 25 Nov 2012 12:37:39 -0500
In-Reply-To: <CAJiejCQqjStwZi1Tgei-AsKrkrbo876mWziP1FoPVhDBm8Yjqw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Drunkard Zhang <gongfan193@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Thanks!  Fix is pushed to next branch.

Trigger is when the hostname resolves to the same IP listed.

sage

On Mon, 26 Nov 2012, Drunkard Zhang wrote:

> It's ceph-0.51, easy to reproduce, just mix IP and hostname and put IP
> before hostnames when mount use ceph-fuse or mount.ceph, like:
> 
> ceph-fuse -m 150.164.100.218,log21,log3 /mnt/bc
> mount -t ceph 150.164.100.218,log21,log3 /mnt/bc
> mount.ceph 150.164.100.218,log21,log3 /mnt/bc
> 
> Here's failed message using ceph-fuse:
> log2 /tmp # ceph-fuse -m 150.164.100.218,log21,log3 /mnt/bc
> 2012-11-26 01:23:38.712704 7f4a4bfc6780 -1 did not load config file,
> using default settings.
> mon/MonMap.h: In function 'void MonMap::add(const std::string&, const
> entity_addr_t&)' thread 7f4a4bfc6780 time 2012-11-26 01:23:38.713625
> mon/MonMap.h: 97: FAILED assert(addr_name.count(addr) == 0)
>  ceph version 0.51 (commit:c03ca95d235c9a072dcd8a77ad5274a52e93ae30)
>  1: (MonMap::build_from_host_list(std::string, std::string)+0xb13) [0x55cf03]
>  2: (MonMap::build_initial(CephContext*, std::ostream&)+0xe7) [0x55e827]
>  3: (MonClient::build_initial_monmap()+0x6c) [0x54debc]
>  4: (main()+0x1bd) [0x482cad]
>  5: (__libc_start_main()+0xfd) [0x7f4a49fcb4bd]
>  6: ceph-fuse() [0x4829b9]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> needed to interpret this.
> 2012-11-26 01:23:38.715137 7f4a4bfc6780 -1 mon/MonMap.h: In function
> 'void MonMap::add(const std::string&, const entity_addr_t&)' thread
> 7f4a4bfc6780 time 2012-11-26 01:23:38.713625
> mon/MonMap.h: 97: FAILED assert(addr_name.count(addr) == 0)
> 
>  ceph version 0.51 (commit:c03ca95d235c9a072dcd8a77ad5274a52e93ae30)
>  1: (MonMap::build_from_host_list(std::string, std::string)+0xb13) [0x55cf03]
>  2: (MonMap::build_initial(CephContext*, std::ostream&)+0xe7) [0x55e827]
>  3: (MonClient::build_initial_monmap()+0x6c) [0x54debc]
>  4: (main()+0x1bd) [0x482cad]
>  5: (__libc_start_main()+0xfd) [0x7f4a49fcb4bd]
>  6: ceph-fuse() [0x4829b9]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> needed to interpret this.
> 
>     -1> 2012-11-26 01:23:38.712704 7f4a4bfc6780 -1 did not load config
> file, using default settings.
>      0> 2012-11-26 01:23:38.715137 7f4a4bfc6780 -1 mon/MonMap.h: In
> function 'void MonMap::add(const std::string&, const entity_addr_t&)'
> thread 7f4a4bfc6780 time 2012-11-26 01:23:38.713625
> mon/MonMap.h: 97: FAILED assert(addr_name.count(addr) == 0)
> 
>  ceph version 0.51 (commit:c03ca95d235c9a072dcd8a77ad5274a52e93ae30)
>  1: (MonMap::build_from_host_list(std::string, std::string)+0xb13) [0x55cf03]
>  2: (MonMap::build_initial(CephContext*, std::ostream&)+0xe7) [0x55e827]
>  3: (MonClient::build_initial_monmap()+0x6c) [0x54debc]
>  4: (main()+0x1bd) [0x482cad]
>  5: (__libc_start_main()+0xfd) [0x7f4a49fcb4bd]
>  6: ceph-fuse() [0x4829b9]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> needed to interpret this.
> 
> terminate called after throwing an instance of 'ceph::FailedAssertion'
> *** Caught signal (Aborted) **
>  in thread 7f4a4bfc6780
>  ceph version 0.51 (commit:c03ca95d235c9a072dcd8a77ad5274a52e93ae30)
>  1: ceph-fuse() [0x67a904]
>  2: (()+0x10410) [0x7f4a4b972410]
>  3: (gsignal()+0x35) [0x7f4a49fdea85]
>  4: (abort()+0x185) [0x7f4a49fdfd85]
>  5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f4a4a9197cd]
>  6: (()+0xb8976) [0x7f4a4a917976]
>  7: (()+0xb89a3) [0x7f4a4a9179a3]
>  8: (()+0xb8a9e) [0x7f4a4a917a9e]
>  9: (ceph::__ceph_assert_fail(char const*, char const*, int, char
> const*)+0x7a2) [0x59f1d2]
>  10: (MonMap::build_from_host_list(std::string, std::string)+0xb13) [0x55cf03]
>  11: (MonMap::build_initial(CephContext*, std::ostream&)+0xe7) [0x55e827]
>  12: (MonClient::build_initial_monmap()+0x6c) [0x54debc]
>  13: (main()+0x1bd) [0x482cad]
>  14: (__libc_start_main()+0xfd) [0x7f4a49fcb4bd]
>  15: ceph-fuse() [0x4829b9]
> 2012-11-26 01:23:38.716314 7f4a4bfc6780 -1 *** Caught signal (Aborted) **
>  in thread 7f4a4bfc6780
> 
>  ceph version 0.51 (commit:c03ca95d235c9a072dcd8a77ad5274a52e93ae30)
>  1: ceph-fuse() [0x67a904]
>  2: (()+0x10410) [0x7f4a4b972410]
>  3: (gsignal()+0x35) [0x7f4a49fdea85]
>  4: (abort()+0x185) [0x7f4a49fdfd85]
>  5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f4a4a9197cd]
>  6: (()+0xb8976) [0x7f4a4a917976]
>  7: (()+0xb89a3) [0x7f4a4a9179a3]
>  8: (()+0xb8a9e) [0x7f4a4a917a9e]
>  9: (ceph::__ceph_assert_fail(char const*, char const*, int, char
> const*)+0x7a2) [0x59f1d2]
>  10: (MonMap::build_from_host_list(std::string, std::string)+0xb13) [0x55cf03]
>  11: (MonMap::build_initial(CephContext*, std::ostream&)+0xe7) [0x55e827]
>  12: (MonClient::build_initial_monmap()+0x6c) [0x54debc]
>  13: (main()+0x1bd) [0x482cad]
>  14: (__libc_start_main()+0xfd) [0x7f4a49fcb4bd]
>  15: ceph-fuse() [0x4829b9]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> needed to interpret this.
> 
>      0> 2012-11-26 01:23:38.716314 7f4a4bfc6780 -1 *** Caught signal
> (Aborted) **
>  in thread 7f4a4bfc6780
> 
>  ceph version 0.51 (commit:c03ca95d235c9a072dcd8a77ad5274a52e93ae30)
>  1: ceph-fuse() [0x67a904]
>  2: (()+0x10410) [0x7f4a4b972410]
>  3: (gsignal()+0x35) [0x7f4a49fdea85]
>  4: (abort()+0x185) [0x7f4a49fdfd85]
>  5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f4a4a9197cd]
>  6: (()+0xb8976) [0x7f4a4a917976]
>  7: (()+0xb89a3) [0x7f4a4a9179a3]
>  8: (()+0xb8a9e) [0x7f4a4a917a9e]
>  9: (ceph::__ceph_assert_fail(char const*, char const*, int, char
> const*)+0x7a2) [0x59f1d2]
>  10: (MonMap::build_from_host_list(std::string, std::string)+0xb13) [0x55cf03]
>  11: (MonMap::build_initial(CephContext*, std::ostream&)+0xe7) [0x55e827]
>  12: (MonClient::build_initial_monmap()+0x6c) [0x54debc]
>  13: (main()+0x1bd) [0x482cad]
>  14: (__libc_start_main()+0xfd) [0x7f4a49fcb4bd]
>  15: ceph-fuse() [0x4829b9]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> needed to interpret this.
> Aborted
> 
> Here's direct mount message:
> log2 /tmp # mount.ceph 150.164.100.218,log21,log3 /mnt/bc
> source mount path was not specified
> failed to resolve source
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
