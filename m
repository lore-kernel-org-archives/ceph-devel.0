From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Running multiple Jenkins on one host??
Date: Thu, 13 Oct 2016 21:33:03 +0200
Message-ID: <1c69e03f-1e9b-b718-e0c1-ba220ad3e4fa@digiware.nl>
References: <f01169fc-17c9-19dc-58d4-63c58085bb10@digiware.nl>
 <CALqRxCwCFNVhUuf5=9H7RHqYUzPRML+hD9O+P-cuCGPpG4EAhg@mail.gmail.com>
 <359a1cc9-93a0-ecf1-19ac-f2ce414f9d55@digiware.nl>
 <CAC-Np1wOJTZWMsUyu8t88BzAFJw-x1E1evgse1q4Bk3+6ywzxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:53023 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755687AbcJMTmL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 13 Oct 2016 15:42:11 -0400
In-Reply-To: <CAC-Np1wOJTZWMsUyu8t88BzAFJw-x1E1evgse1q4Bk3+6ywzxg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>
Cc: Ken Dreyer <kdreyer@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 13-10-2016 14:12, Alfredo Deza wrote:
> On Thu, Oct 13, 2016 at 6:32 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>> On 12-10-2016 18:40, Ken Dreyer wrote:
>>> For jenkins.ceph.com, when we set up each Jenkins slave in OpenStack
>>> and connect it up to our Jenkins master, we only assign a single
>>> executor per slave, so we haven't seen issues with /tmp or colliding
>>> ports.
>>>
>>> If we want to parallelize Jenkins jobs further, we create more VMs
>>> (https://github.com/ceph/mita/)
>>
>> Yes, makes sense if you already have a OpenStack running.
>> Did not want to burden our cluster with this, but perhaps it is the
>> easier road
> 
> Note that this isn't tied to openstack only, it uses libcloud to start
> machines and make them join Jenkins as slaves, so it can
> talk to AWS and other providers libcloud supports.
> 
> Even in the case you don't want to use it, you should have nodes in
> Jenkins (vs. having everything in the master).
> 
> Having everything running in the master defeats the main purpose of
> Jenkins itself: distributing builds on machines that have have
> availability.
> 
> See: https://wiki.jenkins-ci.org/display/JENKINS/Distributed+builds

I understand others desires in this area. Mine was much less far
reaching, if only because the budget does go so far.

I'd like to expose the compile/build/test results of github:ceph/HEAD
and my github:ceph fork on FreeBSD now that I have once been able to run
all tests to completion. Sort of in the hope that showing the (most
obvious) incompatibilities would help me and submitters fix the
inevitable difference between Linux and FreeBSD.

So in essence I need to run two builds over and over and over...
Jenkins capable to do much more, but it does this with 2 fingers in its
nose, and gives a nice interface as bonus.

But for now I'll just build 2 VMs to do the work.
Keeping your remarks in the back of my head when it starts growing out
of proportions.

--WjW


