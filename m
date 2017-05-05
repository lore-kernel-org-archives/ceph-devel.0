From: kefu chai <tchaikov@gmail.com>
Subject: Re: Babeltrace error in FreeBSD, Build failed in Jenkins: ceph-master #634
Date: Fri, 5 May 2017 16:10:30 +0800
Message-ID: <CAJE9aOOVq+10+15pML3YhxKkYgi1Ydgi8Te2PXPXirWzFb2D7w@mail.gmail.com>
References: <730308550.32.1493921080870.JavaMail.jenkins@cephdev.digiware.nl>
 <36b2e3a7-93b7-f0ee-e76a-6830017b6f4a@digiware.nl> <CAJE9aON0zxZyMiQviPdZE-peV-7v+qmfKt_mSyK+29Hq9EheVg@mail.gmail.com>
 <042a3107-47cb-d0cc-fd12-a07554ad1bbb@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f174.google.com ([209.85.217.174]:36485 "EHLO
        mail-ua0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751362AbdEEIKb (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 5 May 2017 04:10:31 -0400
Received: by mail-ua0-f174.google.com with SMTP id p8so24141818uaa.3
        for <ceph-devel@vger.kernel.org>; Fri, 05 May 2017 01:10:31 -0700 (PDT)
In-Reply-To: <042a3107-47cb-d0cc-fd12-a07554ad1bbb@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, May 5, 2017 at 3:11 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> On 05-05-17 08:57, kefu chai wrote:
>> On Fri, May 5, 2017 at 3:51 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>>>
>>> http://cephdev.digiware.nl:8180/jenkins/job/ceph-master/634/console
>>>
>>> Cmake fails on babletrace.
>>> Uptill now babeltrace was optional, but if it is not really 100%
>>> required I'll look into it in 2 weeks after my vacation.
>>> Otherwise it would be nice if it was made optional again.
>>
>> Willem, we fixed some FindXXX.cmake scripts in
>> https://github.com/ceph/ceph/pull/14951, that's why babel failed to be
>> found in your environment, and cmake errored out if you don't disable
>> it explicitly by passing `-DHAVE_BABELTRACE=OFF` to cmake. babeltrace
>> support is always optional, but it's ON by default.
>
> Hi Kefu,
>
> Ah, that made me wonder. I looked at the code in ./CMakeLists.txt and it
> had been in there already for a long time. But missed the fix in the
> findXXX files. So I started wondering where the other switch was.
> BUt I understand that it was just "(bad)luck" on FreeBSD.

actually, (bad)luck on any env without babeltrace installed and with
the default cmake project settings.

>
> The suggested fix  will work.
> Like I said after the vacation I'll check to see what happens when I try
> binding with babeltrace.
>


-- 
Regards
Kefu Chai
