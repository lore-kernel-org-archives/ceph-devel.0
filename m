From: Jeff Layton <jlayton@redhat.com>
Subject: Re: richacl packaging for cephfs
Date: Tue, 20 Sep 2016 11:10:35 -0400
Message-ID: <1474384235.19989.35.camel@redhat.com>
References: <CALe9h7f_q9iGzTRYhXHKiNFfn2qKfc-UUh+eWJ_XqTh9YoqQWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:34119 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753182AbcITPKk (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Sep 2016 11:10:40 -0400
Received: by mail-qk0-f177.google.com with SMTP id n185so18057188qke.1
        for <ceph-devel@vger.kernel.org>; Tue, 20 Sep 2016 08:10:39 -0700 (PDT)
In-Reply-To: <CALe9h7f_q9iGzTRYhXHKiNFfn2qKfc-UUh+eWJ_XqTh9YoqQWg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>
Cc: James Page <james.page@canonical.com>, Tim Serong <tserong@suse.com>, Ken Dreyer <kdreyer@redhat.com>, Andreas Gruenbacher <agruenba@redhat.com>

On Tue, 2016-09-20 at 15:57 +0100, John Spray wrote:
> Hi all,
> 
> I was just taking an updated look at how we could proceed to get
> richacl support[1,2,3] built and tested in cephfs (probably for
> luminous).
> 
> The packages exist currently for Fedora.  For testing, we will need
> them for Ubuntu (probably just Xenial?), CentOS and RHEL (once there
> are RHEL nodes in the sepia lab).
> 
> I'm not very aware of ways forward for Ubuntu, but on the CentOS front
> it seems like we have at least a couple of possibilities:
>  * Build ourselves (using some branch of the fedora packaging?) on a
> Ceph gitbuilder/jenkins job and install from that repo in teuthology
> jobs
>  * Get packages into CentOS Storage SIG and point teuthology at
> external storage SIG repos during testing
> 
> I believe we could ask nicely for some help from the storage SIG to
> package richacl, but I'm not immediately sure if that's actually our
> preferred approach for consuming packages in our CI vs. self-building
> anything that's not in the distro.
> 
> Does anybody have thoughts on the best way to go?
> 
> Would also love to hear any thoughts about richacl  SUSE and Ubuntu
> 
> John
> 
> 1. https://github.com/ceph/ceph/pull/6341
> 2. https://github.com/andreas-gruenbacher/richacl
> 3. http://pkgs.fedoraproject.org/cgit/rpms/richacl.git/
> --

(cc'ing andreas)

There are already richacl packages for Fedora, and the build
requirements are pretty reasonable. Is there any reason not to just ask
for those packages to be added to EPEL7? Should be pretty trivial to
get them built.

In fact, I went ahead and built some candidate packages for el7
directly from the rawhide srpm and it seems to have worked:

    http://koji.fedoraproject.org/koji/taskinfo?taskID=15718383

-- 
Jeff Layton <jlayton@redhat.com>
