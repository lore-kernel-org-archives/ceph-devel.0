From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Unittest_rbd_miiror: Build failed in Jenkins: ceph-master #1448
Date: Fri, 17 Nov 2017 09:25:08 +0100
Message-ID: <a51ef995-78bf-aba4-e7f5-09d8c20ac580@digiware.nl>
References: <1672609555.4.1510819269612.JavaMail.jenkins@cephdev.digiware.nl>
 <3eda6263-6c8a-0292-9aaa-863f6075cb77@digiware.nl>
 <20171116093341.o7msuimn4vo3cfhd@fedora-vs>
 <8e509950-886d-6b6d-e9dc-eff6380ad9b3@digiware.nl>
 <20171116130248.7dom32jkpqugyt7s@fedora-vs>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:34309 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964923AbdKQIZL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 17 Nov 2017 03:25:11 -0500
In-Reply-To: <20171116130248.7dom32jkpqugyt7s@fedora-vs>
Content-Language: nl
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Venky Shankar <vshankar@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 16/11/2017 14:02, Venky Shankar wrote:
> On 17-11-16 10:46:02, Willem Jan Withagen wrote:
>> On 16/11/2017 10:33, Venky Shankar wrote:
>>> On 17-11-16 09:56:36, Willem Jan Withagen wrote:
>>>> Hi
>>>>
>>>> Unittest_rbd_mirror consistently (twice already) fails in the same test and
>>>> the same traceback.
>>>>
>>>> Any suggestions as to where to start looking?
>>>
>>> Kefu has a PR for this: https://github.com/ceph/ceph/pull/18964
>>>
>> Ah, thnax.
>> I'll run the patch and report with the PR.
> 
> This should fix it: https://github.com/ceph/ceph/pull/18969

This morning FreeBSD-jenkins was happy again.

--WjW

