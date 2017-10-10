From: kefu chai <tchaikov@gmail.com>
Subject: Re: OSD crashes
Date: Tue, 10 Oct 2017 22:54:59 +0800
Message-ID: <CAJE9aOPkVSjGvDzArVr6ZMyNvAws=CcyWemVj16OJn-E0BJPaQ@mail.gmail.com>
References: <CAGbvivKhwJcLtLGqOovkLazkH-gPwzUPYkbqP+atGPPdL_0_kA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:46787 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751385AbdJJOzA (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Oct 2017 10:55:00 -0400
Received: by mail-oi0-f49.google.com with SMTP id n82so38364878oig.3
        for <ceph-devel@vger.kernel.org>; Tue, 10 Oct 2017 07:55:00 -0700 (PDT)
In-Reply-To: <CAGbvivKhwJcLtLGqOovkLazkH-gPwzUPYkbqP+atGPPdL_0_kA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Oct 10, 2017 at 10:36 PM, Wyllys Ingersoll
<wyllys.ingersoll@keepertech.com> wrote:
> Im seeing the following OSD crashes on my system that is in a heavy
> recovery state.
>
> Ceph 10.2.9
> Ubuntu 16.04.2
> XFS disks with both journal and data on the same dmcrypt protected devices.
>
>
>    -13> 2017-10-10 10:33:44.202555 7f49da1158c0  5 osd.78 pg_epoch:
> 288706 pg[23.3bc(unlocked)] enter Initial
>    -12> 2017-10-10 10:33:44.204120 7f49da1158c0  5 osd.78 pg_epoch:
> 288706 pg[23.3bc( v 29854'429 (0'0,29854'429] local-les=285261 n=4
> ec=19254 les/c/f 285261/285281/0 285343/285343/285343) [101,39,100]
> r=-1 lpr=0 pi=203138-285342/152 crt=29854'429 lcod 0'0 inactive NOTIFY
> NIBBLEWISE] exit Initial 0.001559 0 0.000000
>    -11> 2017-10-10 10:33:44.204139 7f49da1158c0  5 osd.78 pg_epoch:
> 288706 pg[23.3bc( v 29854'429 (0'0,29854'429] local-les=285261 n=4
> ec=19254 les/c/f 285261/285281/0 285343/285343/285343) [101,39,100]
> r=-1 lpr=0 pi=203138-285342/152 crt=29854'429 lcod 0'0 inactive NOTIFY
> NIBBLEWISE] enter Reset
>    -10> 2017-10-10 10:33:44.233836 7f49da1158c0  5 osd.78 pg_epoch:
> 288730 pg[9.8(unlocked)] enter Initial
>     -9> 2017-10-10 10:33:44.245781 7f49da1158c0  5 osd.78 pg_epoch:
> 288730 pg[9.8( v 113941'62509 (35637'59509,113941'62509]
> local-les=288727 n=26 ec=1076 les/c/f 288727/288730/0
> 288719/288725/279537) [78,81,100] r=0 lpr=0 crt=113941'62509 lcod 0'0
> mlcod 0'0 inactive NIBBLEWISE] exit Initial 0.011945 0 0.000000
>     -8> 2017-10-10 10:33:44.245803 7f49da1158c0  5 osd.78 pg_epoch:
> 288730 pg[9.8( v 113941'62509 (35637'59509,113941'62509]
> local-les=288727 n=26 ec=1076 les/c/f 288727/288730/0
> 288719/288725/279537) [78,81,100] r=0 lpr=0 crt=113941'62509 lcod 0'0
> mlcod 0'0 inactive NIBBLEWISE] enter Reset
>     -7> 2017-10-10 10:33:44.509240 7f49da1158c0  5 osd.78 pg_epoch:
> 288753 pg[1.5e7(unlocked)] enter Initial
>     -6> 2017-10-10 10:33:47.185265 7f49da1158c0  5 osd.78 pg_epoch:
> 288753 pg[1.5e7( v 286018'307337 (208416'292664,286018'307337]
> local-les=279555 n=8426 ec=23117 les/c/f 279555/279564/0
> 279532/279544/279544) [78,34,30] r=0 lpr=0 crt=286018'307337 lcod 0'0
> mlcod 0'0 inactive NIBBLEWISE] exit Initial 2.676025 0 0.000000
>     -5> 2017-10-10 10:33:47.185302 7f49da1158c0  5 osd.78 pg_epoch:
> 288753 pg[1.5e7( v 286018'307337 (208416'292664,286018'307337]
> local-les=279555 n=8426 ec=23117 les/c/f 279555/279564/0
> 279532/279544/279544) [78,34,30] r=0 lpr=0 crt=286018'307337 lcod 0'0
> mlcod 0'0 inactive NIBBLEWISE] enter Reset
>     -4> 2017-10-10 10:33:47.345265 7f49da1158c0  5 osd.78 pg_epoch:
> 288706 pg[2.36a(unlocked)] enter Initial
>     -3> 2017-10-10 10:33:47.360864 7f49da1158c0  5 osd.78 pg_epoch:
> 288706 pg[2.36a( v 279380'86262 (36401'83241,279380'86262]
> local-les=285038 n=56 ec=23131 les/c/f 285038/285160/0
> 284933/284985/284985) [2,78,59] r=1 lpr=0 pi=284823-284984/2
> crt=279380'86262 lcod 0'0 inactive NOTIFY NIBBLEWISE] exit Initial
> 0.015599 0 0.000000
>     -2> 2017-10-10 10:33:47.360893 7f49da1158c0  5 osd.78 pg_epoch:
> 288706 pg[2.36a( v 279380'86262 (36401'83241,279380'86262]
> local-les=285038 n=56 ec=23131 les/c/f 285038/285160/0
> 284933/284985/284985) [2,78,59] r=1 lpr=0 pi=284823-284984/2
> crt=279380'86262 lcod 0'0 inactive NOTIFY NIBBLEWISE] enter Reset
>     -1> 2017-10-10 10:33:47.589722 7f49da1158c0  5 osd.78 pg_epoch:
> 288663 pg[1.2ad(unlocked)] enter Initial
>      0> 2017-10-10 10:33:48.931168 7f49da1158c0 -1 *** Caught signal
> (Aborted) **
>  in thread 7f49da1158c0 thread_name:ceph-osd
>
>  ceph version 10.2.9 (2ee413f77150c0f375ff6f10edd6c8f9c7d060d0)
>  1: (()+0x984c4e) [0x5597b21e7c4e]
>  2: (()+0x11390) [0x7f49d8fd3390]
>  3: (gsignal()+0x38) [0x7f49d6f71428]
>  4: (abort()+0x16a) [0x7f49d6f7302a]
>  5: (__gnu_cxx::__verbose_terminate_handler()+0x16d) [0x7f49d78b384d]

looks like an uncaught bad_alloc() exception when we are reading the
pg log from the underlying omap backed by leveldb. it would be weird
if the leveldb returns a HUGE slice that fails the allocator.  Wyllys,
how did the memory usage look like when the ceph-osd crashes?

>  6: (()+0x8d6b6) [0x7f49d78b16b6]
>  7: (()+0x8d701) [0x7f49d78b1701]
>  8: (()+0x8d919) [0x7f49d78b1919]
>  9: (ceph::buffer::create_aligned(unsigned int, unsigned int)+0x146)
> [0x5597b22f0f86]
>  10: (ceph::buffer::copy(char const*, unsigned int)+0x15) [0x5597b22f10f5]
>  11: (ceph::buffer::ptr::ptr(char const*, unsigned int)+0x18) [0x5597b22f1128]
>  12: (LevelDBStore::to_bufferlist(leveldb::Slice)+0x75) [0x5597b20a09b5]
>  13: (LevelDBStore::LevelDBWholeSpaceIteratorImpl::value()+0x32)
> [0x5597b20a4232]
>  14: (KeyValueDB::IteratorImpl::value()+0x22) [0x5597b1c843f2]
>  15: (DBObjectMap::DBObjectMapIteratorImpl::value()+0x25) [0x5597b204cbd5]
>  16: (PGLog::read_log(ObjectStore*, coll_t, coll_t, ghobject_t,
> pg_info_t const&, std::map<eversion_t, hobject_t,
> std::less<eversion_t>, std::allocator<std::pair<eversion_t const,
> hobject_t> > >&, PGLog::IndexedLog&, pg_missing_t&,
> std::__cxx11::basic_ostringstream<char, std::char_traits<char>,
> std::allocator<char> >&, bool, DoutPrefixProvider const*,
> std::set<std::__cxx11::basic_string<char, std::char_traits<char>,
> std::allocator<char> >, std::less<std::__cxx11::basic_string<char,
> std::char_traits<char>, std::allocator<char> > >,
> std::allocator<std::__cxx11::basic_string<char,
> std::char_traits<char>, std::allocator<char> > > >*)+0xb99)
> [0x5597b1e92a19]
>  17: (PG::read_state(ObjectStore*, ceph::buffer::list&)+0x313) [0x5597b1cc0fb3]
>  18: (OSD::load_pgs()+0x87a) [0x5597b1bfb96a]
>  19: (OSD::init()+0x2026) [0x5597b1c06c56]
>  20: (main()+0x2ef1) [0x5597b1b78391]
>  21: (__libc_start_main()+0xf0) [0x7f49d6f5c830]
>  22: (_start()+0x29) [0x5597b1bb9b99]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> needed to interpret this.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards
Kefu Chai
