From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Anybody else hitting this panic in latest master with bluestore?
Date: Tue, 7 Jun 2016 06:33:05 -0500
Message-ID: <8dd167e2-89c2-84dc-fee1-216be0dc6392@redhat.com>
References: <CY1PR0201MB1820F45DA0E891966F2CBC42855D0@CY1PR0201MB1820.namprd02.prod.outlook.com>
 <BL2PR02MB2115D774BB2D4CFC43F8C847F45D0@BL2PR02MB2115.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60676 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753909AbcFGLdJ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 7 Jun 2016 07:33:09 -0400
In-Reply-To: <BL2PR02MB2115D774BB2D4CFC43F8C847F45D0@BL2PR02MB2115.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>, Ramesh Chander <Ramesh.Chander@sandisk.com>, ceph-devel <ceph-devel@vger.kernel.org>

I believe this is due to the rocksdb submodule update in PR #9466.  I'm 
working on tracking down the commit in rocksdb that's causing it.

Mark

On 06/07/2016 01:37 AM, Somnath Roy wrote:
> Yes, me and Mark is getting this. See my old post..
>
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Ramesh Chander
> Sent: Monday, June 06, 2016 10:00 PM
> To: ceph-devel
> Subject: Anybody else hitting this panic in latest master with bluestore?
>
> Please be aware that this feature is experimental, untested, unsupported, and may result in data corruption, data loss, and/or irreparable damage to your cluster.  Do not use feature with important data.
>
>     -1> 2016-06-06 21:58:50.008174 7fbd0a313500  1 using id 15
>      0> 2016-06-06 21:58:50.010667 7fbd0a313500 -1 *** Caught signal (Segmentation fault) **  in thread 7fbd0a313500 thread_name:ceph_test_objec
>
>  ceph version 10.2.0-1899-ged6dc92 (ed6dc9291628a8b1f488cc8b06f46c2815b64c04)
>  1: (()+0x5b75fa) [0x7fbd0a8f35fa]
>  2: (()+0x10340) [0x7fbd087fb340]
>  3: (()+0x152686) [0x7fbd071bb686]
>  4: (rocksdb::ColumnFamilyOptions::ColumnFamilyOptions(rocksdb::Options const&)+0x12a) [0x7fbd0a87594a]
>  5: (rocksdb::GetOptionsFromString(rocksdb::Options const&, std::string const&, rocksdb::Options*)+0x18a) [0x7fbd0a87db1a]
>  6: (RocksDBStore::ParseOptionsFromString(std::string, rocksdb::Options&)+0x10c) [0x7fbd0a7acfc4]
>  7: (RocksDBStore::init(std::string)+0x74) [0x7fbd0a7ad6ec]
>  8: (BlueStore::_open_db(bool)+0x261a) [0x7fbd0a62f24a]
>  9: (BlueStore::mkfs()+0xdb5) [0x7fbd0a647705]
>  10: (StoreTest::SetUp()+0x34b) [0x7fbd0a5e6edd]
>  11: (void testing::internal::HandleExceptionsInMethodIfSupported<testing::Test, void>(testing::Test*, void (testing::Test::*)(), char const*)+0x33) [0x7fbd0a8ecb73]
>  12: (testing::Test::Run()+0x50) [0x7fbd0a8e2860]
>  13: (testing::TestInfo::Run()+0x9e) [0x7fbd0a8e296e]
>  14: (testing::TestCase::Run()+0xa5) [0x7fbd0a8e2a75]
>  15: (testing::internal::UnitTestImpl::RunAllTests()+0x248) [0x7fbd0a8e44e8]
>  16: (testing::UnitTest::Run()+0x54) [0x7fbd0a8e47a4]
>  17: (main()+0x522) [0x7fbd0a585156]
>  18: (__libc_start_main()+0xf5) [0x7fbd0708aec5]
>  19: (()+0x248107) [0x7fbd0a584107]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.
>
>
> -Regards,
>  Ramesh Chander
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
