From: Alfredo Deza <adeza@redhat.com>
Subject: Re: Running multiple Jenkins on one host??
Date: Thu, 13 Oct 2016 08:12:32 -0400
Message-ID: <CAC-Np1wOJTZWMsUyu8t88BzAFJw-x1E1evgse1q4Bk3+6ywzxg@mail.gmail.com>
References: <f01169fc-17c9-19dc-58d4-63c58085bb10@digiware.nl>
 <CALqRxCwCFNVhUuf5=9H7RHqYUzPRML+hD9O+P-cuCGPpG4EAhg@mail.gmail.com> <359a1cc9-93a0-ecf1-19ac-f2ce414f9d55@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:34078 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755047AbcJMMMf (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Oct 2016 08:12:35 -0400
Received: by mail-qk0-f174.google.com with SMTP id f128so82378567qkb.1
        for <ceph-devel@vger.kernel.org>; Thu, 13 Oct 2016 05:12:34 -0700 (PDT)
In-Reply-To: <359a1cc9-93a0-ecf1-19ac-f2ce414f9d55@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ken Dreyer <kdreyer@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Oct 13, 2016 at 6:32 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> On 12-10-2016 18:40, Ken Dreyer wrote:
>> For jenkins.ceph.com, when we set up each Jenkins slave in OpenStack
>> and connect it up to our Jenkins master, we only assign a single
>> executor per slave, so we haven't seen issues with /tmp or colliding
>> ports.
>>
>> If we want to parallelize Jenkins jobs further, we create more VMs
>> (https://github.com/ceph/mita/)
>
> Yes, makes sense if you already have a OpenStack running.
> Did not want to burden our cluster with this, but perhaps it is the
> easier road

Note that this isn't tied to openstack only, it uses libcloud to start
machines and make them join Jenkins as slaves, so it can
talk to AWS and other providers libcloud supports.

Even in the case you don't want to use it, you should have nodes in
Jenkins (vs. having everything in the master).

Having everything running in the master defeats the main purpose of
Jenkins itself: distributing builds on machines that have have
availability.

See: https://wiki.jenkins-ci.org/display/JENKINS/Distributed+builds

>
> --WjW
>
>> On Wed, Oct 12, 2016 at 6:52 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>>> Hi,
>>>
>>> Are people running multiple builds in Jenkins in parallel on the same
>>> host/vm?
>>>
>>> Or is everybody using one Jenkings thread per VM, and thus avoiding
>>> classes in /tmp and in port-usuage?
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
