From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Fwd: Build failed in Jenkins: ceph-master #94
Date: Mon, 19 Dec 2016 18:07:06 +0100
Message-ID: <0f3cc084-45b8-720e-9469-c77bac329681@digiware.nl>
References: <2025831951.53.1481945498160.JavaMail.jenkins@cephdev.digiware.nl>
 <93c0f8ac-a1e1-eaed-19bc-1be68b31f06f@digiware.nl>
 <20161219070242.GA1543@gmail.com>
 <516684dd-33b1-e7d2-89d9-22f0ba74ecb8@digiware.nl>
 <CA+aFP1DtKTfZZKCbp3bLKfBEoE=kvT9hmpFAr_5z5HAyrPB=EA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:25560 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933265AbcLSRHW (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 19 Dec 2016 12:07:22 -0500
In-Reply-To: <CA+aFP1DtKTfZZKCbp3bLKfBEoE=kvT9hmpFAr_5z5HAyrPB=EA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: dillaman@redhat.com
Cc: Mykola Golub <to.my.trociny@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 19-12-2016 16:45, Jason Dillaman wrote:
> Actually, it's already merged into the master branch [1]. Thanks.
> 
> [1] https://github.com/ceph/ceph/pull/12565

Yup, I saw... Thanx for the speedy patch.

in the mean time also submitted:
Clang/str_list.h: fix clang warning about std::move #12570

So I guess we're working out the odd bits and pieces that Clang brings
with it.

--WjW


> On Mon, Dec 19, 2016 at 10:43 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>> On 19-12-2016 08:02, Mykola Golub wrote:
>>> This is due to the recently added config option validators [1] (aimed
>>> to solve the API issue with rbd_default_features option).
>>>
>>> It uses std::is_constructible to check if a type exists or just
>>> forward declared. Apparently, it does not work for clang. Using
>>> std::is_destructible instead looks like work [2].
>>>
>>> [1] https://github.com/ceph/ceph/pull/12486
>>> [2] https://github.com/trociny/ceph/commit/bd584fe797e30d666800cd4d9b440d4b51d1d27e
>>
>> Hi Mykola,
>>
>> This seems to be a nice workaround.
>> I'll submit a PR.
>>
>> --WjW
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 

