From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: master build failing
Date: Thu, 30 Jun 2016 22:04:15 +0000
Message-ID: <BL2PR02MB2115AFA6B239598DA2EE8980F4240@BL2PR02MB2115.namprd02.prod.outlook.com>
References: <CY1PR0201MB18209702FEAD607B802AC66985530@CY1PR0201MB1820.namprd02.prod.outlook.com>
 <CAJE9aOP9ZF5NMHchpTy_dzwLTaTjjxbpdU0MSGJ_iKfNdX+PQg@mail.gmail.com>
 <D39AD750.FBEB%evgeniy.firsov@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-cys01nam02on0055.outbound.protection.outlook.com ([104.47.37.55]:65038
	"EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752057AbcF3Xi0 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Jun 2016 19:38:26 -0400
In-Reply-To: <D39AD750.FBEB%evgeniy.firsov@sandisk.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Evgeniy Firsov <Evgeniy.Firsov@sandisk.com>, kefu chai <tchaikov@gmail.com>, Ramesh Chander <Ramesh.Chander@sandisk.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, "Mark Nelson (mnelson@redhat.com)" <mnelson@redhat.com>, dl-storm-dev <dl-storm-dev@sandisk.com>

This is happening with jemalloc enabled build and not with tcmalloc. Wondering the jemalloc version we are using supports malloc_stats_print , Ubuntu still ships jemalloc version 3.6..

Thanks & Regards
Somnath

-----Original Message-----
From: Evgeniy Firsov
Sent: Thursday, June 30, 2016 2:05 PM
To: kefu chai; Ramesh Chander
Cc: ceph-devel; Mark Nelson (mnelson@redhat.com); dl-storm-dev
Subject: Re: master build failing

Same error for me.
This is automake, jemalloc is installed.

On 6/14/16, 1:30 AM, "ceph-devel-owner@vger.kernel.org on behalf of kefu chai" <ceph-devel-owner@vger.kernel.org on behalf of tchaikov@gmail.com>
wrote:

>On Tue, Jun 14, 2016 at 2:09 AM, Ramesh Chander
><Ramesh.Chander@sandisk.com> wrote:
>> Getting these linker errors:
>>
>>
>>/root/ram/ram_bkp/ceph/ceph-latest/ceph_unit_issue/src/rocksdb/db/db_i
>>mpl
>>.cc:583: undefined reference to `malloc_stats_print'
>> collect2: error: ld returned 1 exit status
>> make[3]: *** [ceph_test_objectstore_workloadgen] Error 1
>> rocksdb/librocksdb.a(db_impl.o): In function `DumpMallocStats':
>>
>>/root/ram/ram_bkp/ceph/ceph-latest/ceph_unit_issue/src/rocksdb/db/db_i
>>mpl
>>.cc:583: undefined reference to `malloc_stats_print'
>> collect2: error: ld returned 1 exit status
>> make[3]: *** [ceph_test_objectstore] Error 1
>> rocksdb/librocksdb.a(db_impl.o): In function `DumpMallocStats':
>>
>>/root/ram/ram_bkp/ceph/ceph-latest/ceph_unit_issue/src/rocksdb/db/db_i
>>mpl
>>.cc:583: undefined reference to `malloc_stats_print'
>> collect2: error: ld returned 1 exit status
>> make[3]: *** [ceph_xattr_bench] Error 1
>> rocksdb/librocksdb.a(db_impl.o): In function `DumpMallocStats':
>>
>>/root/ram/ram_bkp/ceph/ceph-latest/ceph_unit_issue/src/rocksdb/db/db_i
>>mpl
>>.cc:583: undefined reference to `malloc_stats_print'
>> collect2: error: ld returned 1 exit status
>> make[3]: *** [ceph_test_filejournal] Error 1
>>
>> last time Mark did something to fix it.
>>
>> I tried make clean in rocksdb directory as well, still same error.
>
>did you uninstall jemalloc after configure or cmake? maybe you can
>check the make_config.mk under rocksdb directory? are you using cmake
>or automake?
>
>
>>
>> -Ramesh Chander
>> PLEASE NOTE: The information contained in this electronic mail
>>message is intended only for the use of the designated recipient(s) named above.
>>If the reader of this message is not the intended recipient, you are
>>hereby notified that you have received this message in error and that
>>any review, dissemination, distribution, or copying of this message is
>>strictly prohibited. If you have received this communication in error,
>>please notify the sender by telephone or e-mail (as shown above)
>>immediately and destroy any and all copies of this message in your
>>possession (whether hard copies or electronically stored copies).
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>in  the body of a message to majordomo@vger.kernel.org  More majordomo
>>info at  http://vger.kernel.org/majordomo-info.html
>
>
>
>--
>Regards
>Kefu Chai
>--
>To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>in the body of a message to majordomo@vger.kernel.org More majordomo
>info at  http://vger.kernel.org/majordomo-info.html

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
