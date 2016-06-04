From: Jianjian Huo <samuel.huo@gmail.com>
Subject: Re: Bluestore crash in mkfs
Date: Fri, 3 Jun 2016 21:29:08 -0700
Message-ID: <CAB=cV2Tp9ASRHxLSw5H3K=4PbrxrFkF4sARsfDRxDVqJpQ8ZHg@mail.gmail.com>
References: <BL2PR02MB21151DAE1DAF64B6CC74D01FF45A0@BL2PR02MB2115.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:35334 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711AbcFDE33 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 4 Jun 2016 00:29:29 -0400
Received: by mail-io0-f182.google.com with SMTP id o189so88249071ioe.2
        for <ceph-devel@vger.kernel.org>; Fri, 03 Jun 2016 21:29:29 -0700 (PDT)
In-Reply-To: <BL2PR02MB21151DAE1DAF64B6CC74D01FF45A0@BL2PR02MB2115.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: "Sage Weil (sage@newdream.net)" <sage@newdream.net>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Jun 3, 2016 at 7:16 PM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
> Sage,
> Latest code in Bluestore is crashing on me during mkfs. Here is the dump.
>
> ceph version 10.2.0-1809-gac8c40f (ac8c40f3e3257517f71d2af8bd26dcd264887b7f)
>  1: (()+0x99e65e) [0x55cf5263565e]
>  2: (()+0x113d0) [0x7f323526f3d0]
>  3: (rocksdb::ColumnFamilyOptions::ColumnFamilyOptions(rocksdb::Options const&)+0x59) [0x55cf525d4ce9]
>  4: (rocksdb::GetOptionsFromString(rocksdb::Options const&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&, rocksdb::Options*)+0x15a) [0x55cf525dc74a]
>  5: (RocksDBStore::ParseOptionsFromString(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >, rocksdb::Options&)+0x22e) [0x55cf524f58be]
>  6: (RocksDBStore::init(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >)+0x77) [0x55cf524f5f17]
>  7: (BlueStore::_open_db(bool)+0x274) [0x55cf5234b9e4]
>  8: (BlueStore::mkfs()+0x899) [0x55cf52361ad9]
>  9: (OSD::mkfs(CephContext*, ObjectStore*, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&, uuid_d, int)+0x117) [0x55cf52001427]
>  10: (main()+0x1003) [0x55cf51f9f2e3]
>  11: (__libc_start_main()+0xf0) [0x7f32331fa830]
>  12: (_start()+0x29) [0x55cf51fe2719]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.
>
>
> I am using the following option :
>
>        devs = /dev/sdb1
>        bluestore_block_path = /dev/sdb2
>
> Am I missing anything ?

This is what Mark posted last time, you forgot db path?
https://github.com/ceph/cbt/blob/master/example/bluestore/ceph.conf.bluestore_example
>
> Thanks & Regards
> Somnath
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
