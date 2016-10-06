From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: [sepia] teuthology support for the new build system
Date: Thu, 6 Oct 2016 11:59:55 -0600
Message-ID: <CAJ4mKGZhEXiLBs-g438QD0_4hjOB4=PZK1nkEkwyRjsk2zWqXA@mail.gmail.com>
References: <CACk6Fjm9x=j+QwKfcOqivEvk0xocvsVHHB6ZBUd_AfoSsCCweg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f44.google.com ([209.85.214.44]:37267 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751346AbcJFR75 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Oct 2016 13:59:57 -0400
Received: by mail-it0-f44.google.com with SMTP id j69so37345607itb.0
        for <ceph-devel@vger.kernel.org>; Thu, 06 Oct 2016 10:59:56 -0700 (PDT)
In-Reply-To: <CACk6Fjm9x=j+QwKfcOqivEvk0xocvsVHHB6ZBUd_AfoSsCCweg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zack Cerza <zack@redhat.com>
Cc: "Development, Ceph" <ceph-devel@vger.kernel.org>, sepia@ceph.com, John Spray <jspray@redhat.com>

On Wed, Oct 5, 2016 at 2:14 PM, Zack Cerza <zack@redhat.com> wrote:
> Hi all,
>
> You've probably heard that we've been working on replacing the
> gitbuilders with a new build system. I recently did some work [0] in
> teuthology to support that new system, and that work got merged
> yesterday. Here's an overview of its current state:
>
> The way it works is that it talks to Shaman [1] to locate the package
> repository to use. It is not enabled by default as it isn't yet able
> to cover all gitbuilder use cases. It can be enabled by setting
> "use_shaman: true" in either your teuthology.yaml or your job's yaml.
> It can be set for an entire suite-run by doing something like:
>
> $ echo "use_shaman: true" > ./shaman.yaml
> $ teuthology-suite -v -c jewel -s upgrade/jewel-x -m vps -k distro
> $PWD/shaman.yaml --dry-run
>
> Of course, later on when we can fully replace gitbuilders this
> behavior will be the default. At some point after that we'll be
> decommissioning the gitbuilders.
>
> Please note that using it in the following scenarios will *not* do
> what you want:
>
> * Any job that requires one of our testing kernels, as the new system
> isn't building our kernels yet
> * Any job that uses the install task for samba, for the same reason
> * Any job that uses ceph-deploy, as ceph-deploy isn't using the new system yet

I think Alfredo mentioned this in his thread, but we also don't seem
to be building the "notcmalloc" flavors, so don't try and run any
valgrind tests against it.
Are there other flavors we know are missing?

An FS run (http://pulpito.ceph.com/gregf-2016-10-05_20:40:25-fs-master---basic-mira/)
had quite a few other failures, but just scanning the errors I don't
think any of the others are because of the build system.
-Greg

>
> Please try to give this new system some exercise. It's been tested
> well but of course we can't necessarily anticipate everything.
> Teuthology bugs, as always, should go here [2] and bugs related to the
> new build system should go here [3].
