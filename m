From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Clang not happy with unittest_hostname
Date: Thu, 2 Mar 2017 12:01:24 +0100
Message-ID: <2f7065f4-9b14-8d30-0097-764691de6f50@digiware.nl>
References: <3ae8a4ec-3cd2-6d06-8562-74a5c80f44d0@digiware.nl>
 <4ACE5332-92D1-4D12-BFE4-7A28B9013C86@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:35094 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751035AbdCBL6E (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 2 Mar 2017 06:58:04 -0500
In-Reply-To: <4ACE5332-92D1-4D12-BFE4-7A28B9013C86@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?5YiY55WF?= <liuchang0812@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 2-3-2017 02:53, 刘畅 wrote:
> I will fix it soon, thanks 

Thanx,
If you have some code to run thru Clang, just let me know.

--WjW


> 发自我的 iPhone
> 
>> 在 2017年3月2日，08:54，Willem Jan Withagen <wjw@digiware.nl> 写道：
>>
>> This is with Clang on FreeBSD:
>>
>> [100%] Building CXX object
>> src/test/common/CMakeFiles/unittest_hostname.dir/test_hostname.cc.o
>> /home/jenkins/workspace/ceph-master/src/test/common/test_hostname.cc:34:27:
>> error: implicit instantiation of undefined template
>> 'std::__1::array<char, 128>'
>>    std::array<char, 128> buffer;
>>                          ^
>> /usr/include/c++/v1/__tuple:198:65: note: template is declared here
>> template <class _Tp, size_t _Size> struct _LIBCPP_TYPE_VIS_ONLY array;
>>
>> --WjW
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

