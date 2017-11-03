From: Abhishek Lekshmanan <abhishek@suse.com>
Subject: Re: 12.2.2 status
Date: Fri, 03 Nov 2017 18:44:02 +0100
Message-ID: <874lqbcl5p.fsf@suse.com>
References: <87fua6c4xy.fsf@suse.com> <CA+2bHPYXuma-e-4_XAdLp6rxcT7NBYL+xF4Rz0PAvptLoXvQdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:47208 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754823AbdKCRoJ (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Fri, 3 Nov 2017 13:44:09 -0400
In-Reply-To: <CA+2bHPYXuma-e-4_XAdLp6rxcT7NBYL+xF4Rz0PAvptLoXvQdw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Patrick Donnelly <pdonnell@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sage@newdream.net>, Matt Benjamin <mbenjamin@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>, Karol Mroz <KMroz@suse.com>

Patrick Donnelly <pdonnell@redhat.com> writes:

> On Thu, Oct 26, 2017 at 8:19 AM, Abhishek Lekshmanan <abhishek@suse.com> wrote:
>> Also for the leads, Sage, Yehuda. Jason, Josh, Patrick are there any
>> critical PRs that we need to have in 12.2.2 so that we can include
>> them in the next round of testing before handing over to QE?
>
> Please include:
>
> https://github.com/ceph/ceph/pull/18019
> https://github.com/ceph/ceph/pull/18008

I've added the all the PRs in the milestone with the label wip-abhi-testing,
https://github.com/ceph/ceph/pulls?q=is%3Aopen+is%3Apr+label%3Awip-abhi-testing

However all the ubuntu/debian tests in teuthology seem to fail with a
dependency issue not seen in centos,

For eg: 
http://pulpito.ceph.com/abhi-2017-11-03_16:49:11-ceph-disk-wip-luminous-backports-distro-basic-vps/

or
http://pulpito.ceph.com/abhi-2017-11-03_15:09:21-rados-wip-luminous-backports-distro-basic-smithi/

something in the lines of
ceph-mds : Depends: ceph-base (= 12.2.1-688-g83b8263-1trusty) but it is
not going to be installed

though not sure why these are failing as the packages themselves seem to
be present at the chacra url, so something else in the dependency chain
somewhere? Has anyone else seen errors of this nature ?


-- 
Abhishek 
