From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Haven't been paying attention: Gperf missing
Date: Mon, 22 May 2017 11:59:20 +0200
Message-ID: <9c1c2403-c114-bec9-d37b-e217d2d23e69@digiware.nl>
References: <9cc2b255-f617-e109-b9b9-23a32ea8509f@digiware.nl>
 <CAF-wwdFP4Wy-4Bx+wkW=btjCQokTW3QaLSaVudJJyBM=2XmaLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:51504 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751832AbdEVJ7Y (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 22 May 2017 05:59:24 -0400
In-Reply-To: <CAF-wwdFP4Wy-4Bx+wkW=btjCQokTW3QaLSaVudJJyBM=2XmaLA@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brad Hubbard <bhubbard@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 22-05-17 11:27, Brad Hubbard wrote:
> On Mon, May 22, 2017 at 6:16 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>> But from the things below gperf is now an essential requirement?
>>
>> --WjW
>>
>> -- Check if the system is big endian - little endian
>> -- Found PythonInterp: /usr/local/bin/python2.7 (found version "2.7.13")
>> -- Boost version: 1.64.0
>> CMake Error at src/rgw/CMakeLists.txt:30 (message):
>>   Can't find gperf
> 
> https://github.com/ceph/ceph/commit/6761a838a3750998ffc0e315d429168858a80a0a

Hi Brad,

That'll will fix a bit of my pain on FreeBSD.
But What if I don't want to build with gperf, like I used too?
Is that still possible?

If so I'll PR a if-then-else change...

--WjW

>>
>>
>> -- Configuring incomplete, errors occurred!
>> See also
>> "/home/jenkins/workspace/ceph-master/build/CMakeFiles/CMakeOutput.log".
>> See also "/home/jenkins/workspace/ceph-master/build/CMakeFiles/CMa
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 

