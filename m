From: Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: richacl packaging for cephfs
Date: Thu, 22 Sep 2016 14:01:10 +0200
Message-ID: <CAHc6FU6Uu3S+QrOFw7DG0U0x-gT2nEhAGEDCxaRsoymCdrQfyQ@mail.gmail.com>
References: <CALe9h7f_q9iGzTRYhXHKiNFfn2qKfc-UUh+eWJ_XqTh9YoqQWg@mail.gmail.com>
 <1474384235.19989.35.camel@redhat.com> <CAHc6FU5WKczSkNPd9GPB5TmVA4A2P4aE3kUkNX4-oeEtGB8Hkg@mail.gmail.com>
 <1474460349.30941.1.camel@redhat.com> <CAHc6FU7GaK8oQDFN_5HCyW_4GZcETxKDfVRvPqToTZqF87LsDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f53.google.com ([209.85.213.53]:33896 "EHLO
        mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751957AbcIVMBN (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Sep 2016 08:01:13 -0400
Received: by mail-vk0-f53.google.com with SMTP id u196so21174140vkd.1
        for <ceph-devel@vger.kernel.org>; Thu, 22 Sep 2016 05:01:13 -0700 (PDT)
In-Reply-To: <CAHc6FU7GaK8oQDFN_5HCyW_4GZcETxKDfVRvPqToTZqF87LsDA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@redhat.com>
Cc: John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, James Page <james.page@canonical.com>, Tim Serong <tserong@suse.com>, Ken Dreyer <kdreyer@redhat.com>

On Wed, Sep 21, 2016 at 2:59 PM, Andreas Gruenbacher
<agruenba@redhat.com> wrote:
> On Wed, Sep 21, 2016 at 2:19 PM, Jeff Layton <jlayton@redhat.com> wrote:
>> On Wed, 2016-09-21 at 13:24 +0200, Andreas Gruenbacher wrote:
>>> Not sure how long it will take to get that approved or if any
>>> additional steps are needed; I guess we'll find out.
>>
>> Thanks Andreas! Last time I did it, it took around a day or so. You'll
>> also need to kick off a package build once it's done. That should be
>> all that's needed though.
>
> Things went fast this time. I've pushed the code to the epel7 branch
> and kicked off a build; the packages are ready.

The package needs one more karma point to make it into epel7 stable, please:

  https://bodhi.fedoraproject.org/updates/FEDORA-EPEL-2016-dfe8979003

Thanks,
Andreas
