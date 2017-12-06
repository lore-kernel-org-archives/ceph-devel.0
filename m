From: kefu chai <tchaikov@gmail.com>
Subject: Re: conditionalize build on branch using jenkins
Date: Thu, 7 Dec 2017 02:51:05 +0800
Message-ID: <CAJE9aOPH4xMUFw+qNrUcK5JD8EaYYfKBboPV7kAOY-gmdwh6EA@mail.gmail.com>
References: <CAJE9aOM-h17ErsTjqX-0RFKBqnZ4Lvkh4G5ajSGoUFaBaOf4LA@mail.gmail.com>
 <CAC-Np1xCdkWY-4fwHq33t2KoajJthfDe35_nU+vBshBK-Ly75Q@mail.gmail.com> <CAJE9aOMn7p4nVm5AZkXQPc-d_OrfJ0Z3U1FSp4E8kb+vfYRexQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f172.google.com ([209.85.216.172]:33968 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751815AbdLFSvG (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Dec 2017 13:51:06 -0500
Received: by mail-qt0-f172.google.com with SMTP id 33so11458109qtv.1
        for <ceph-devel@vger.kernel.org>; Wed, 06 Dec 2017 10:51:06 -0800 (PST)
In-Reply-To: <CAJE9aOMn7p4nVm5AZkXQPc-d_OrfJ0Z3U1FSp4E8kb+vfYRexQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Dec 6, 2017 at 9:25 PM, kefu chai <tchaikov@gmail.com> wrote:
> On Wed, Dec 6, 2017 at 7:57 PM, Alfredo Deza <adeza@redhat.com> wrote:
>> On Wed, Dec 6, 2017 at 2:18 AM, kefu chai <tchaikov@gmail.com> wrote:
>>> hey Alfredo and other Cephers,
>>>
>>> i am trying to disable master,mimic-* and probably PRs targeting these
>>> branches building on trusty. otherwise the binaries built on trusty
>>> with the new GCC ABI will not be able to run on trusty installation
>>> without the new libstdc++ installed due to missing libstdc++ ABI
>>> symbols. for more context, please see the recent discussion thread in
>>> this mailing list, search "C++11, std::list_size(), and trusty"  for
>>> it.
>>>
>>> for example, if a branch is pushed to ceph/ceph-ci, jenkins will build
>>> it, and upload the built packages to chacra. even if all trusty
>>> testnodes are reimaged with xenial. we still want to make sure that
>>> people using trusty won't run into troubles if they want to use the
>>> packages built using our build infrastructure. so, we need to use the
>>> old toolchain to build jewel and luminous.
>>>
>>> so the status quo is:
>>>
>>> - jewel, luminous, mimic-dev* and master built on trusty are using GCC-7
>>>
>>> and the goal is to
>>>
>>> 1. build jewel and luminous on trusty with the old GCC shipped with the distro
>
> https://github.com/ceph/ceph-build/pull/928 should address this one.
>
>>> 2. do not build master, mimic-dev* branches on trusty
>>>
>>> the same applies to the branches targeting respective releases pushed
>>> to ceph/ceph-ci .
>>>
>>> but after digging around in ceph/ceph-build, i realized that probably we need:
>>>
>>> 1. a naming convention for branches targeting jewel/luminous, like
>>> wip-fix-a-bug-luminous.
>>
>> A naming convention sounds OK to me. I would prefer to have luminous
>> at the beginning. If using 'wip-' is a must, then something like:
>>
>>     wip-luminous-fix-a-bug
>>
>> Otherwise:
>>
>>     luminous-fix-a-bug
>>
>> On ceph-volume pull requests we've followed the latter.
>>
>>>
>>> this helps with solving goal #1: so we can skip the steps preparing
>>> the GCC-7 when setup pbuilder.
>>>
>>> this also helps with solving gobal #2: we have no way to tell if a wip
>>> branch is targeting which release without actually cloning it and
>>> looking at the source files or using "git describe". but typically,
>>> jenkins will not have access to the source files or the .git directory
>>> of a PR or a ceph-ci repo before the "ceph-*-setup" job. and i'd like
>>> to prevent jenkins from scheduling a job at the very beginning: so the
>>> only metadata at that phase is the "$GIT_BRANCH". that's why i suggest
>>> use a naming convention for these branches. so jenkins is able to
>>> identify them.
>>
>> This is all on point on how we detect these, and what is available at that point
>>
>>>
>>> 2. we need to have a "combination-filter"[1] referencing the
>>> $GIT_BRANCH, like "!(["master", "mimic-dev1"].contains(branch) &&
>>> DIST=="trusty)". where "branch" is an axis, calculated using
>>> $GIT_BRANCH.
>>>
>>> i am not sure if #2 is a feasible approach. because i *think* the
>>> supported axises are setup when the jenkins-job-builder populate the
>>> yaml configuration files to jenkins. if that's the case, we cannot
>>> parameterize the "combination-filter" at run-time.
>>
>> We do have a job that 'triggers' these other ones, configured with the
>> 'trigger-builds' section on JenkinsJobBuilder. We don't use
>> 'factories' there but that might be able to help here:
>>
>> https://docs.openstack.org/infra/jenkins-job-builder/builders.html#builders.trigger-builds
>>
>
> thank you, Alfredo! i will give it a try later on.
>

here is what i whip up while listening the CDM:
https://github.com/ceph/ceph-build/pull/931 =)

Alfredo, would be great if you could help review it also!


-- 
Regards
Kefu Chai
