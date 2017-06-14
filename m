From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Clang does not like constexpression
Date: Wed, 14 Jun 2017 11:25:43 +0200
Message-ID: <5b92e37d-ddc5-baa2-ba9a-d6f747ea697a@digiware.nl>
References: <3b811d53-d45f-7ed2-a65f-b7114739e891@digiware.nl>
 <CA+H5UW2k7ZEJVYJXE4aGvbNkjBsN3mVaDiNpRY585CvyGpOdeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:11535 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751624AbdFNJ0E (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 14 Jun 2017 05:26:04 -0400
In-Reply-To: <CA+H5UW2k7ZEJVYJXE4aGvbNkjBsN3mVaDiNpRY585CvyGpOdeA@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Radoslaw Zarzynski <rzarzynski@mirantis.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 14-6-2017 11:08, Radoslaw Zarzynski wrote:
> Thanks for the info, Willem. I'm on it.
> 
> BTW: it would be nice to have a Clang builder to find out similar
> issues as early as possible.

This is always after the fact of committing, but I run a FreeBSD/Clang
build every 4 hours if something has changed in master. And you can
check that. I get emails of success and failure, which I then report
back here. Like this one.

http://cephdev.digiware.nl:8180/jenkins/job/ceph-master/lastBuild/console

But than again, that is after the fact.

BTW: My easy fix by just removing the `constexpr` keyword does not cut it:
In file included from
/home/jenkins/workspace/ceph-master/src/rgw/rgw_auth_s3.cc:12:
/home/jenkins/workspace/ceph-master/src/rgw/rgw_auth_s3.h:171:19: error:
non-const static data member must be initialized out of line
    static size_t META_MAX_SIZE = \
                  ^

And there are a few more Clang errors in that same fiel. So You would do
me a huge favour in checking it out, and mail me fixes (as diff), which
I'm happy to test-run for you. I know that Kefu has Clang installed as
second compiler and is able to test drive his compiles to help me out me
with the more intricate details.

BTW2: I've taken it up with the team that manages the builders to add
Clang compiles, but from what I learn, it is easier said than done. Let
alone that we start fully building all PRs with FreeBSD/Clang which
requires a full set of extra VMs to do about 400 builds a day.

--WjW

> Regards,
> Radek
> 
> On Wed, Jun 14, 2017 at 10:49 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>> I guess that in Clang strlen is not evaluation to a constant.
>>
>> --WjW
>>
>> In file included from
>> /home/jenkins/workspace/ceph-master/src/rgw/rgw_auth_keystone.cc:22:
>> /home/jenkins/workspace/ceph-master/src/rgw/rgw_auth_s3.h:171:29: error:
>> constexpr variable 'META_MAX_SIZE' must be initialized by a constant
>> expression
>>     static constexpr size_t META_MAX_SIZE = \
>>                             ^
>> /home/jenkins/workspace/ceph-master/src/rgw/rgw_auth_s3.h:172:7: note:
>> non-constexpr function 'strlen' cannot be used in a constant expression
>>       strlen("\r\nffffffffffffffff;chunk-signature=") + SIG_SIZE +
>> strlen("\r\n");
>>       ^
>> /home/jenkins/workspace/ceph-master/src/rgw/rgw_auth_s3.h:175:29: error:
>> constexpr variable 'META_MIN_SIZE' must be initialized by a constant
>> expression
>>     static constexpr size_t META_MIN_SIZE = \
>>                             ^
>> /home/jenkins/workspace/ceph-master/src/rgw/rgw_auth_s3.h:176:7: note:
>> non-constexpr function 'strlen' cannot be used in a constant expression
>>       strlen("0;chunk-signature=") + SIG_SIZE + strlen("\r\n");
>>       ^
>> /home/jenkins/workspace/ceph-master/src/rgw/rgw_auth_s3.h:204:41: error:
>> non-type template argument is not a constant expression
>>   boost::container::static_vector<char, ChunkMeta::META_MAX_SIZE>
>> parsing_buf;
>>                                         ^~~~~~~~~~~~~~~~~~~~~~~~
>> /home/jenkins/workspace/ceph-master/src/rgw/rgw_auth_s3.h:204:41: note:
>> initializer of 'META_MAX_SIZE' is not a constant expression
>> /home/jenkins/workspace/ceph-master/src/rgw/rgw_auth_s3.h:171:29: note:
>> declared here
>>     static constexpr size_t META_MAX_SIZE = \
>>                             ^
>> 3 errors generated.
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

