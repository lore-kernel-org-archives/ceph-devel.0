From: kefu chai <tchaikov@gmail.com>
Subject: Re: success-comment of github pr trigger
Date: Thu, 2 Nov 2017 15:43:52 +0800
Message-ID: <CAJE9aOPu=2GRdL_HRTq7e53FF1TV3etKOE-ETjgTxru-5zDrpg@mail.gmail.com>
References: <CAJE9aOMiVa8SeXJ3Jd5Jyj0agLsoo=SMcu==ypj-i=yC2xQinQ@mail.gmail.com>
 <07f40898-ef71-95da-806d-1187b6986647@redhat.com> <6402d745-c1b9-9fc3-3637-f7db7c9b8c4f@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:52199 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755104AbdKBHnx (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Nov 2017 03:43:53 -0400
Received: by mail-oi0-f53.google.com with SMTP id j126so7656757oib.8
        for <ceph-devel@vger.kernel.org>; Thu, 02 Nov 2017 00:43:53 -0700 (PDT)
In-Reply-To: <6402d745-c1b9-9fc3-3637-f7db7c9b8c4f@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Galloway <dgallowa@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Alfredo Deza <adeza@redhat.com>

On Thu, Nov 2, 2017 at 1:14 AM, David Galloway <dgallowa@redhat.com> wrote:
>
>
> On 11/01/2017 12:11 PM, David Galloway wrote:
>> On 11/01/2017 01:48 AM, kefu chai wrote:
>>> hi Alfredo,
>>>
>>> i found that jenkins started to comment on PRs when completing a job.
>>> for example, see
>>> https://github.com/ceph/ceph/pull/18659#issuecomment-340964973. this
>>> is a little bit annoying and distracting. but i checked
>>> https://github.com/ceph/ceph-build/blob/master/ceph-pull-requests/config/definitions/ceph-pull-requests.yml#L39,
>>> we don't specify the success-comment there. i wonder it might be jjb?
>>> but i checked the jjb 2.0.0.0b2, it looks sane. see
>>> https://github.com/openstack-infra/jenkins-job-builder/blob/04348c2c00657490b4712ae61c6a1bed691a3e3a/jenkins_jobs/modules/triggers.py#L1122.
>>> do you have any idea off the head? are we experimenting some new
>>> features?
>>>
>>
>>
>> I suspect something in GitHub's API changed and the Github Pull Request
>> Builder plugin is behind/out of date.
>>
>> Starting at Nov 01, 2017 2:57:31 AM UTC, ghprb started to indicate it
>> was failing to update PR statuses (although I don't think it was) and
>> started sending comments.
>>
>> "Use comments to report results when updating commit status fails" was
>> checked in the Jenkins settings.  I've unchecked it so hopefully the
>> comments will stop for now.
>>
>> Please let me know if that's not the case.
>
> Looks like comments stopped.
>
> We're hitting this/these:
> https://github.com/kohsuke/github-api/issues/387
> https://issues.jenkins-ci.org/browse/JENKINS-47601
>
> I will update the plugins and restart Jenkins when things are quiet.

David, thanks for the quick fix!

-- 
Regards
Kefu Chai
