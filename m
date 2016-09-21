From: Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: richacl packaging for cephfs
Date: Wed, 21 Sep 2016 14:59:42 +0200
Message-ID: <CAHc6FU7GaK8oQDFN_5HCyW_4GZcETxKDfVRvPqToTZqF87LsDA@mail.gmail.com>
References: <CALe9h7f_q9iGzTRYhXHKiNFfn2qKfc-UUh+eWJ_XqTh9YoqQWg@mail.gmail.com>
 <1474384235.19989.35.camel@redhat.com> <CAHc6FU5WKczSkNPd9GPB5TmVA4A2P4aE3kUkNX4-oeEtGB8Hkg@mail.gmail.com>
 <1474460349.30941.1.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f173.google.com ([209.85.161.173]:36813 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932713AbcIUNA2 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Sep 2016 09:00:28 -0400
Received: by mail-yw0-f173.google.com with SMTP id t67so50744380ywg.3
        for <ceph-devel@vger.kernel.org>; Wed, 21 Sep 2016 05:59:43 -0700 (PDT)
In-Reply-To: <1474460349.30941.1.camel@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@redhat.com>
Cc: John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, James Page <james.page@canonical.com>, Tim Serong <tserong@suse.com>, Ken Dreyer <kdreyer@redhat.com>

On Wed, Sep 21, 2016 at 2:19 PM, Jeff Layton <jlayton@redhat.com> wrote:
> On Wed, 2016-09-21 at 13:24 +0200, Andreas Gruenbacher wrote:
>> > On Tue, Sep 20, 2016 at 5:10 PM, Jeff Layton <jlayton@redhat.com> wrote:
>> >
>> > On Tue, 2016-09-20 at 15:57 +0100, John Spray wrote:
>> > >
>> > > Hi all,
>> > >
>> > > I was just taking an updated look at how we could proceed to get
>> > > richacl support[1,2,3] built and tested in cephfs (probably for
>> > > luminous).
>> > >
>> > > The packages exist currently for Fedora.  For testing, we will need
>> > > them for Ubuntu (probably just Xenial?), CentOS and RHEL (once there
>> > > are RHEL nodes in the sepia lab).
>> > >
>> > > I'm not very aware of ways forward for Ubuntu, but on the CentOS front
>> > > it seems like we have at least a couple of possibilities:
>> > >  * Build ourselves (using some branch of the fedora packaging?) on a
>> > > Ceph gitbuilder/jenkins job and install from that repo in teuthology
>> > > jobs
>> > >  * Get packages into CentOS Storage SIG and point teuthology at
>> > > external storage SIG repos during testing
>> > >
>> > > I believe we could ask nicely for some help from the storage SIG to
>> > > package richacl, but I'm not immediately sure if that's actually our
>> > > preferred approach for consuming packages in our CI vs. self-building
>> > > anything that's not in the distro.
>> > >
>> > > Does anybody have thoughts on the best way to go?
>> > >
>> > > Would also love to hear any thoughts about richacl  SUSE and Ubuntu
>> > >
>> > > John
>> > >
>> > > 1. https://github.com/ceph/ceph/pull/6341
>> > > 2. https://github.com/andreas-gruenbacher/richacl
>> > > 3. http://pkgs.fedoraproject.org/cgit/rpms/richacl.git/
>> > > --
>> >
>> > (cc'ing andreas)
>> >
>> > There are already richacl packages for Fedora, and the build
>> > requirements are pretty reasonable. Is there any reason not to just ask
>> > for those packages to be added to EPEL7? Should be pretty trivial to
>> > get them built.
>>
>> I've requested an epel7 branch to be added to:
>>
>>   https://admin.fedoraproject.org/pkgdb/package/rpms/richacl/
>>
>> as per:
>>
>>   https://fedoraproject.org/wiki/PackageDB_admin_requests#Additional_branches_for_existing_packagesadded
>>
>> Not sure how long it will take to get that approved or if any
>> additional steps are needed; I guess we'll find out.
>>
>> Thanks,
>> Andreas
>
> Thanks Andreas! Last time I did it, it took around a day or so. You'll
> also need to kick off a package build once it's done. That should be
> all that's needed though.

Things went fast this time. I've pushed the code to the epel7 branch
and kicked off a build; the packages are ready.

Andreas
