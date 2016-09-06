From: John Spray <jspray@redhat.com>
Subject: Re: [Tendrl-devel] Former Console 2.0 QE upstream CI strategy
Date: Tue, 6 Sep 2016 16:38:41 +0100
Message-ID: <CALe9h7c7HYXNit3imgBUU_Tw0c15jsy7WeAJ7kABBsfys7ogpw@mail.gmail.com>
References: <bac7f609-dc6f-eb75-ed78-d643c071cf60@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:34325 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752962AbcIFPjD (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Sep 2016 11:39:03 -0400
Received: by mail-qk0-f171.google.com with SMTP id t7so221705982qkh.1
        for <ceph-devel@vger.kernel.org>; Tue, 06 Sep 2016 08:39:03 -0700 (PDT)
In-Reply-To: <bac7f609-dc6f-eb75-ed78-d643c071cf60@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Kudlej <mkudlej@redhat.com>
Cc: tendrl-devel@redhat.com, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Sep 6, 2016 at 4:24 PM, Martin Kudlej <mkudlej@redhat.com> wrote:
> Hello all Tendrl fans,
>
> I would like to present our view of CI and how we would like to build our CI
> infrastructure.
> Workflow schema:
>
> 1) there are some git repositories
> 2) all unit tests run
> 3) there are packages
> 4) all package sanity tests run
> 5) all machines for integration testing are ready
> 6) packages are installed on proper machines
> 7) all integration tests run
>
> You can replace "packages" to any other distribution package like QCow2
> image or container.
>
> There are some git repositories where source code of all Tendrl components
> is stored. If trigger is fired all unit tests will run. Trigger can be for
> example daily cron, patch is merged to master, during package building or
> any other event. It's easy to change this in CI tool. If all unit tests pass
> packages are built. Once packages are successfully built they are checked by
> package sanity tests. If packages are OK then required machines for
> integration testing are deployed and packages are installed on them. If
> installation is successful all integration tests run.
>
> There are some tasks in Jira for making this workflow happened. We need to
> move our integration tests to upstream so everybody is able to do 7) and 4).
> It will be great if anybody can see what we are testing.
>
> There are tasks which depends on environment(5 and 6). Because we have no
> resources to maintain publicly available environment, deployment scripts
> will be private for now.

This point would be a good reason to consider using the existing Ceph
test framework (teuthology) -- we have a public environment.  You
could for example have a private teuthology environment if you wanted,
but when folks wanted to run their tests in a public upstream
environment they could either ask for resources in the "sepia" Ceph
environment, or they could use teuthology's openstack mode to run on
an openstack cloud.

John

> Sanity of git repositories, code there and building packages (1, 2, 3) are
> domains of software developers and details depend mostly on developers. If
> we can we would like to help with those tasks too.
>
> Results from testing will be publicly available somewhere(should be decided,
> I expect tendrl.org).
>
> Please share with us your comments about our plans. Thank you!
>
>
> --
> Best Regards,
> Martin Kudlej.
> RHSC/USM Senior Quality Assurance Engineer
> Red Hat Czech s.r.o.
>
> Phone: +420 532 294 155
> E-mail:mkudlej at redhat.com
> IRC:   mkudlej at #brno, #gluster, #storage-qa, #rhs, #rh-ceph, #usm-meeting
> @ redhat
>                     #tendrl-devel @ freenode
>
> _______________________________________________
> Tendrl-devel mailing list
> Tendrl-devel@redhat.com
> https://www.redhat.com/mailman/listinfo/tendrl-devel
