From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: master build failing
Date: Fri, 1 Jul 2016 02:41:57 +0000
Message-ID: <CY1PR02MB21238A2303B50BDECC780C94F4250@CY1PR02MB2123.namprd02.prod.outlook.com>
References: <CY1PR0201MB18209702FEAD607B802AC66985530@CY1PR0201MB1820.namprd02.prod.outlook.com>
 <CAJE9aOP9ZF5NMHchpTy_dzwLTaTjjxbpdU0MSGJ_iKfNdX+PQg@mail.gmail.com>
 <D39AD750.FBEB%evgeniy.firsov@sandisk.com>
 <0b9ea189-c626-988d-3dd1-6af384b9ca16@redhat.com>
 <57759E2C.1050301@redhat.com>
 <BL2PR02MB211512FF3BC9C16180914D73F4250@BL2PR02MB2115.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn3nam01on0089.outbound.protection.outlook.com ([104.47.33.89]:52160
	"EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751036AbcGAEUE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Jul 2016 00:20:04 -0400
In-Reply-To: <BL2PR02MB211512FF3BC9C16180914D73F4250@BL2PR02MB2115.namprd02.prod.outlook.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Mick <dmick@redhat.com>, Mark Nelson <mnelson@redhat.com>, Evgeniy Firsov <Evgeniy.Firsov@sandisk.com>, kefu chai <tchaikov@gmail.com>, Ramesh Chander <Ramesh.Chander@sandisk.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Figured this out..
cmake -D ALLOCATOR=jemalloc ..

Thanks & Regards
Somnath

-----Original Message-----
From: Somnath Roy
Sent: Thursday, June 30, 2016 6:43 PM
To: Dan Mick; Mark Nelson; Evgeniy Firsov; kefu chai; Ramesh Chander
Cc: ceph-devel; dl-storm-dev
Subject: RE: master build failing

How do I build ceph now with cmake conditionally with tcmalloc/jemalloc/rocksdb etc. ?

-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Dan Mick
Sent: Thursday, June 30, 2016 3:33 PM
To: Mark Nelson; Evgeniy Firsov; kefu chai; Ramesh Chander
Cc: ceph-devel; dl-storm-dev
Subject: Re: master build failing

"do_cmake.sh" can automate some of that

On 06/30/2016 03:04 PM, Mark Nelson wrote:
> If you are inclined, it's probably worth switching over to cmake at
> this point.  I suspect the automake stuff is going to get crufty
> pretty fast now that folks are switching over en mass.  I switched a
> couple of days ago and after working out a couple of bugs it's working really well.
>
> git clean -fdx
> mkdir build; cd build
> cmake ..
> make -j $(nproc)
> sudo make install
>
> Mark
>
> On 06/30/2016 04:05 PM, Evgeniy Firsov wrote:
>> Same error for me.
>> This is automake, jemalloc is installed.
>>
>> On 6/14/16, 1:30 AM, "ceph-devel-owner@vger.kernel.org on behalf of
>> kefu chai" <ceph-devel-owner@vger.kernel.org on behalf of
>> tchaikov@gmail.com>
>> wrote:
>>
>>> On Tue, Jun 14, 2016 at 2:09 AM, Ramesh Chander
>>> <Ramesh.Chander@sandisk.com> wrote:
>>>> Getting these linker errors:
>>>>
>>>>
>>>> /root/ram/ram_bkp/ceph/ceph-latest/ceph_unit_issue/src/rocksdb/db/d
>>>> b_impl
>>>>
>>>> .cc:583: undefined reference to `malloc_stats_print'
>>>> collect2: error: ld returned 1 exit status
>>>> make[3]: *** [ceph_test_objectstore_workloadgen] Error 1
>>>> rocksdb/librocksdb.a(db_impl.o): In function `DumpMallocStats':
>>>>
>>>> /root/ram/ram_bkp/ceph/ceph-latest/ceph_unit_issue/src/rocksdb/db/d
>>>> b_impl
>>>>
>>>> .cc:583: undefined reference to `malloc_stats_print'
>>>> collect2: error: ld returned 1 exit status
>>>> make[3]: *** [ceph_test_objectstore] Error 1
>>>> rocksdb/librocksdb.a(db_impl.o): In function `DumpMallocStats':
>>>>
>>>> /root/ram/ram_bkp/ceph/ceph-latest/ceph_unit_issue/src/rocksdb/db/d
>>>> b_impl
>>>>
>>>> .cc:583: undefined reference to `malloc_stats_print'
>>>> collect2: error: ld returned 1 exit status
>>>> make[3]: *** [ceph_xattr_bench] Error 1
>>>> rocksdb/librocksdb.a(db_impl.o): In function `DumpMallocStats':
>>>>
>>>> /root/ram/ram_bkp/ceph/ceph-latest/ceph_unit_issue/src/rocksdb/db/d
>>>> b_impl
>>>>
>>>> .cc:583: undefined reference to `malloc_stats_print'
>>>> collect2: error: ld returned 1 exit status
>>>> make[3]: *** [ceph_test_filejournal] Error 1
>>>>
>>>> last time Mark did something to fix it.
>>>>
>>>> I tried make clean in rocksdb directory as well, still same error.
>>>
>>> did you uninstall jemalloc after configure or cmake? maybe you can
>>> check the make_config.mk under rocksdb directory? are you using
>>> cmake or automake?
>>>
>>>
>>>>
>>>> -Ramesh Chander
>>>> PLEASE NOTE: The information contained in this electronic mail
>>>> message is intended only for the use of the designated recipient(s)
>>>> named above.
>>>> If the reader of this message is not the intended recipient, you
>>>> are hereby notified that you have received this message in error
>>>> and that any review, dissemination, distribution, or copying of
>>>> this message is strictly prohibited. If you have received this
>>>> communication in error, please notify the sender by telephone or
>>>> e-mail (as shown above) immediately and destroy any and all copies
>>>> of this message in your possession (whether hard copies or electronically stored copies).
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe
>>>> ceph-devel" in the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>>
>>> --
>>> Regards
>>> Kefu Chai
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe
>>> ceph-devel" in the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>> PLEASE NOTE: The information contained in this electronic mail
>> message is intended only for the use of the designated recipient(s)
>> named above. If the reader of this message is not the intended
>> recipient, you are hereby notified that you have received this
>> message in error and that any review, dissemination, distribution, or
>> copying of this message is strictly prohibited. If you have received
>> this communication in error, please notify the sender by telephone or
>> e-mail (as shown above) immediately and destroy any and all copies of
>> this message in your possession (whether hard copies or
>> electronically stored copies).
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>> in the body of a message to majordomo@vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> in the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
