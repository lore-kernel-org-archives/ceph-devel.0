From: John Spray <jspray@redhat.com>
Subject: Re: richacl packaging for cephfs
Date: Wed, 21 Sep 2016 13:00:18 +0100
Message-ID: <CALe9h7dPwMvEVXA0vWxT=SjLm2RNRMVPv1MMAOScJo3sVawk_Q@mail.gmail.com>
References: <CALe9h7f_q9iGzTRYhXHKiNFfn2qKfc-UUh+eWJ_XqTh9YoqQWg@mail.gmail.com>
 <CAHpGcMJ4KAnrbsgTJhru7AGWVP3Ch_LmZOtjiZBMkAGBkEhwNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f180.google.com ([209.85.220.180]:36698 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933777AbcIUMAk (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Sep 2016 08:00:40 -0400
Received: by mail-qk0-f180.google.com with SMTP id z190so42650788qkc.3
        for <ceph-devel@vger.kernel.org>; Wed, 21 Sep 2016 05:00:39 -0700 (PDT)
In-Reply-To: <CAHpGcMJ4KAnrbsgTJhru7AGWVP3Ch_LmZOtjiZBMkAGBkEhwNg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, James Page <james.page@canonical.com>, Tim Serong <tserong@suse.com>, Ken Dreyer <kdreyer@redhat.com>

On Wed, Sep 21, 2016 at 12:31 PM, Andreas Grünbacher
<andreas.gruenbacher@gmail.com> wrote:
> 2016-09-20 16:57 GMT+02:00 John Spray <jspray@redhat.com>:
>> Hi all,
>>
>> I was just taking an updated look at how we could proceed to get
>> richacl support[1,2,3] built and tested in cephfs (probably for
>> luminous).
>>
>> The packages exist currently for Fedora.  For testing, we will need
>> them for Ubuntu (probably just Xenial?), CentOS and RHEL (once there
>> are RHEL nodes in the sepia lab).
>>
>> I'm not very aware of ways forward for Ubuntu, but on the CentOS front
>> it seems like we have at least a couple of possibilities:
>>  * Build ourselves (using some branch of the fedora packaging?) on a
>> Ceph gitbuilder/jenkins job and install from that repo in teuthology
>> jobs
>>  * Get packages into CentOS Storage SIG and point teuthology at
>> external storage SIG repos during testing
>>
>> I believe we could ask nicely for some help from the storage SIG to
>> package richacl, but I'm not immediately sure if that's actually our
>> preferred approach for consuming packages in our CI vs. self-building
>> anything that's not in the distro.
>>
>> Does anybody have thoughts on the best way to go?
>
> As Jeff has suggested, does having the package in epel7 help you?

I think this should work for the Ceph CI, I believe we already point
our test nodes to EPEL -- thank you.

John

>
>> Would also love to hear any thoughts about richacl  SUSE and Ubuntu
>
> I don't have any experience with Ubuntu packaging. We can add stuff to
> the upstream repository if that helps.
>
> Thanks,
> Andreas
