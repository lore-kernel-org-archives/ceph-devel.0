From: Alfredo Deza <adeza@redhat.com>
Subject: Re: [sepia] teuthology support for the new build system
Date: Thu, 6 Oct 2016 16:58:36 -0400
Message-ID: <CAC-Np1zFqwQC=99Eft+7DQF+8LsTJzisFORKh7L0MKfOGew64g@mail.gmail.com>
References: <CACk6Fjm9x=j+QwKfcOqivEvk0xocvsVHHB6ZBUd_AfoSsCCweg@mail.gmail.com>
 <CAJ4mKGZhEXiLBs-g438QD0_4hjOB4=PZK1nkEkwyRjsk2zWqXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:38684 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933506AbcJFU6i (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Oct 2016 16:58:38 -0400
Received: by mail-wm0-f52.google.com with SMTP id i130so30523855wmg.1
        for <ceph-devel@vger.kernel.org>; Thu, 06 Oct 2016 13:58:37 -0700 (PDT)
In-Reply-To: <CAJ4mKGZhEXiLBs-g438QD0_4hjOB4=PZK1nkEkwyRjsk2zWqXA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Zack Cerza <zack@redhat.com>, sepia@ceph.com, "Development, Ceph" <ceph-devel@vger.kernel.org>

On Thu, Oct 6, 2016 at 1:59 PM, Gregory Farnum <gfarnum@redhat.com> wrote:
> On Wed, Oct 5, 2016 at 2:14 PM, Zack Cerza <zack@redhat.com> wrote:
>> Hi all,
>>
>> You've probably heard that we've been working on replacing the
>> gitbuilders with a new build system. I recently did some work [0] in
>> teuthology to support that new system, and that work got merged
>> yesterday. Here's an overview of its current state:
>>
>> The way it works is that it talks to Shaman [1] to locate the package
>> repository to use. It is not enabled by default as it isn't yet able
>> to cover all gitbuilder use cases. It can be enabled by setting
>> "use_shaman: true" in either your teuthology.yaml or your job's yaml.
>> It can be set for an entire suite-run by doing something like:
>>
>> $ echo "use_shaman: true" > ./shaman.yaml
>> $ teuthology-suite -v -c jewel -s upgrade/jewel-x -m vps -k distro
>> $PWD/shaman.yaml --dry-run
>>
>> Of course, later on when we can fully replace gitbuilders this
>> behavior will be the default. At some point after that we'll be
>> decommissioning the gitbuilders.
>>
>> Please note that using it in the following scenarios will *not* do
>> what you want:
>>
>> * Any job that requires one of our testing kernels, as the new system
>> isn't building our kernels yet
>> * Any job that uses the install task for samba, for the same reason
>> * Any job that uses ceph-deploy, as ceph-deploy isn't using the new system yet
>
> I think Alfredo mentioned this in his thread, but we also don't seem
> to be building the "notcmalloc" flavors, so don't try and run any
> valgrind tests against it.
> Are there other flavors we know are missing?
>
> An FS run (http://pulpito.ceph.com/gregf-2016-10-05_20:40:25-fs-master---basic-mira/)
> had quite a few other failures, but just scanning the errors I don't
> think any of the others are because of the build system.

I may be hijacking this thread a bit, but this is the kind of stuff
that *I* (and Andrew) are looking forward to:

what are things that you expected and are not working quite right? (or
if they are working quite well, also tell us :))


> -Greg
>
>>
>> Please try to give this new system some exercise. It's been tested
>> well but of course we can't necessarily anticipate everything.
>> Teuthology bugs, as always, should go here [2] and bugs related to the
>> new build system should go here [3].
> _______________________________________________
> Sepia mailing list
> Sepia@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/sepia-ceph.com
