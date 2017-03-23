From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Sudden Bluestore includes
Date: Thu, 23 Mar 2017 09:45:37 +0100
Message-ID: <401a7fe8-7a04-9ab4-bdc3-dd2f4611f7a4@digiware.nl>
References: <49d0042f-350e-91a6-dedf-ee7abad98a2e@digiware.nl>
 <CAJE9aOMM3a4Gr7kUC-FqpJuu0eGjP_17pnknNa63ZVtBcb7phA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:46295 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753120AbdCWIpl (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 23 Mar 2017 04:45:41 -0400
In-Reply-To: <CAJE9aOMM3a4Gr7kUC-FqpJuu0eGjP_17pnknNa63ZVtBcb7phA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 23-3-2017 09:02, kefu chai wrote:
> + ceph-devel

Things were hidden in a large bluestore commit from Sage.
Found it after bisecting...

--WjW

> On Wed, Mar 22, 2017 at 8:17 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>> Hi Kefu,
>>
>> Any idea why I all of a sudden get these bluestore errors from includes??
>> I tried blaming all files I could think of, but that all seems rather
>> stable and only changed long ago..
>>
>> In file included from
>> /home/jenkins/workspace/ceph-master/src/test/objectstore/store_test_fixture.cc:8:
>> In file included from
>> /home/jenkins/workspace/ceph-master/src/os/bluestore/BlueStore.h:42:
>> /home/jenkins/workspace/ceph-master/src/os/bluestore/BlockDevice.h:41:12:
>> error: no member named 'aio_t' in 'FS'
>>   list<FS::aio_t> pending_aios;    ///< not yet submitted
>>        ~~~~^
>> /home/jenkins/workspace/ceph-master/src/os/bluestore/BlockDevice.h:42:12:
>> error: no member named 'aio_t' in 'FS'
>>   list<FS::aio_t> running_aios;    ///< submitting or submitted
>>        ~~~~^
>>
>> thanx for any ideas...
> 
> 
> see https://github.com/ceph/ceph/commit/52c93f5b71e34625969660e7d47e733aee8ea98b
> 
> 
> 

