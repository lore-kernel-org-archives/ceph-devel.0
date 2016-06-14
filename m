From: kefu chai <tchaikov@gmail.com>
Subject: Re: master build failing
Date: Tue, 14 Jun 2016 16:30:06 +0800
Message-ID: <CAJE9aOP9ZF5NMHchpTy_dzwLTaTjjxbpdU0MSGJ_iKfNdX+PQg@mail.gmail.com>
References: <CY1PR0201MB18209702FEAD607B802AC66985530@CY1PR0201MB1820.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f179.google.com ([209.85.161.179]:36444 "EHLO
	mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735AbcFNIaH convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Jun 2016 04:30:07 -0400
Received: by mail-yw0-f179.google.com with SMTP id v137so46531301ywa.3
        for <ceph-devel@vger.kernel.org>; Tue, 14 Jun 2016 01:30:07 -0700 (PDT)
In-Reply-To: <CY1PR0201MB18209702FEAD607B802AC66985530@CY1PR0201MB1820.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ramesh Chander <Ramesh.Chander@sandisk.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, "Mark Nelson (mnelson@redhat.com)" <mnelson@redhat.com>, dl-storm-dev <dl-storm-dev@sandisk.com>

On Tue, Jun 14, 2016 at 2:09 AM, Ramesh Chander
<Ramesh.Chander@sandisk.com> wrote:
> Getting these linker errors:
>
> /root/ram/ram_bkp/ceph/ceph-latest/ceph_unit_issue/src/rocksdb/db/db_impl.cc:583: undefined reference to `malloc_stats_print'
> collect2: error: ld returned 1 exit status
> make[3]: *** [ceph_test_objectstore_workloadgen] Error 1
> rocksdb/librocksdb.a(db_impl.o): In function `DumpMallocStats':
> /root/ram/ram_bkp/ceph/ceph-latest/ceph_unit_issue/src/rocksdb/db/db_impl.cc:583: undefined reference to `malloc_stats_print'
> collect2: error: ld returned 1 exit status
> make[3]: *** [ceph_test_objectstore] Error 1
> rocksdb/librocksdb.a(db_impl.o): In function `DumpMallocStats':
> /root/ram/ram_bkp/ceph/ceph-latest/ceph_unit_issue/src/rocksdb/db/db_impl.cc:583: undefined reference to `malloc_stats_print'
> collect2: error: ld returned 1 exit status
> make[3]: *** [ceph_xattr_bench] Error 1
> rocksdb/librocksdb.a(db_impl.o): In function `DumpMallocStats':
> /root/ram/ram_bkp/ceph/ceph-latest/ceph_unit_issue/src/rocksdb/db/db_impl.cc:583: undefined reference to `malloc_stats_print'
> collect2: error: ld returned 1 exit status
> make[3]: *** [ceph_test_filejournal] Error 1
>
> last time Mark did something to fix it.
>
> I tried make clean in rocksdb directory as well, still same error.

did you uninstall jemalloc after configure or cmake? maybe you can
check the make_config.mk under rocksdb directory? are you using cmake
or automake?


>
> -Ramesh Chander
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards
Kefu Chai
