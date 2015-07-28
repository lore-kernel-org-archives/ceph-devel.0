From: Gregory Farnum <greg@gregs42.com>
Subject: Re: Criteria to become a Ceph project
Date: Tue, 28 Jul 2015 09:44:09 +0100
Message-ID: <CAC6JEv9wTCkb6XEtSSN0e-9MNuLF=2V_OEk_AnxP33t=3nG+tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:35948 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752778AbbG1IoL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Jul 2015 04:44:11 -0400
Received: by igbij6 with SMTP id ij6so106589029igb.1
        for <ceph-devel@vger.kernel.org>; Tue, 28 Jul 2015 01:44:10 -0700 (PDT)
Received: from mail-ig0-f174.google.com (mail-ig0-f174.google.com. [209.85.213.174])
        by smtp.gmail.com with ESMTPSA id vk8sm8095813igb.4.2015.07.28.01.44.10
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jul 2015 01:44:10 -0700 (PDT)
Received: by igbpg9 with SMTP id pg9so112023125igb.0
        for <ceph-devel@vger.kernel.org>; Tue, 28 Jul 2015 01:44:09 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Jul 28, 2015 at 7:38 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi Ceph,
>
> The title sounds a little strange (Citerias to become a Ceph project) because I'm not aware of projects initiated by someone external to Ceph that later became part of the Ceph nebula of projects (as found at http://tracker.ceph.com/projects/ or http://github.com/ceph/). I can however imagine that a piece of software developed with no interaction with the Ceph development community could be contributed and become a valuable addition (port to non GNU/Linux Operating Systems, monitoring applications for mobile devices etc.).
>
> Although publishing the code of such a component under a Free Software license is a natural first step, there is more to do before it becomes part of what we (the community of Ceph developers) care for on a regular basis. Borrowing the OpenStack requirements ( at http://governance.openstack.org/reference/new-projects-requirements.html ), it could be expressed as:
>
>     Free Software:
>         The proposed project uses a Free Software license as published at http://www.gnu.org/licenses/license-list.html#SoftwareLicenses
>         Project must have no library dependencies which effectively restrict how the project may be distributed or deployed
>     Open Community:
>         The leadership is chosen by the contributors to the project
>         The project has regular public meetings on IRC and those meetings are logged and published
>     Open Development:
>         The project uses public code reviews
>         The project has core reviewers and adopts a test-driven gate
>         The project provides liaisons that serve as contacts for the work of cross-project teams in Ceph
>         Where it makes sense, the project cooperates with existing projects rather than gratuitously competing or reinventing the wheel
>         Where appropriate, the project adopts technology and patterns used by existing Ceph projects
>     Open Design:
>         The project direction is discussed at the Ceph Design Summit and/or on public forums
>         The project uses the ceph-devel ML to discuss issues
>
> These requirements are formal in the case of OpenStack but they could also be used in the context of Ceph, not as requirements but as a guideline.
>
> What do you think ?

Several small projects have been added to the Ceph constellation
despite being initially implemented outside of our systems. Mostly
things like rados-java and phprados.

Obviously those are small and related to Ceph, and the process was
"let's add this to the Ceph Github?" "Okay." I think if we need more
formal rules we can invent them as we go; Ceph is not OpenStack and
isn't going to be supervising the same volume nor breadth of
individual groups.
-Greg
