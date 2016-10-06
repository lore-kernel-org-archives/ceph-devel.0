From: Vasu Kulkarni <vakulkar@redhat.com>
Subject: Re: [sepia] teuthology support for the new build system
Date: Thu, 6 Oct 2016 14:05:32 -0700
Message-ID: <CAKPXa=atQ6qG1y5KjWEmkyBz6Y5LQGhwPpkY2d29c8VVAf4ZJQ@mail.gmail.com>
References: <CACk6Fjm9x=j+QwKfcOqivEvk0xocvsVHHB6ZBUd_AfoSsCCweg@mail.gmail.com>
 <CAEPMp+7A3qy-ut-8ALHucU1bG6TPwd3+iVXdqAqyAdfP3c2s3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:36836 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934857AbcJFVLo (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Oct 2016 17:11:44 -0400
Received: by mail-oi0-f44.google.com with SMTP id m72so36205837oik.3
        for <ceph-devel@vger.kernel.org>; Thu, 06 Oct 2016 14:11:43 -0700 (PDT)
In-Reply-To: <CAEPMp+7A3qy-ut-8ALHucU1bG6TPwd3+iVXdqAqyAdfP3c2s3Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrew Schoen <aschoen@redhat.com>
Cc: Zack Cerza <zack@redhat.com>, "Development, Ceph" <ceph-devel@vger.kernel.org>, sepia@ceph.com

The builds page is really nice looking and fast page, It will be nice
to have another top table with *released* builds that are latest
like, jewel and hammer with last build date for rpm/deb  and probably
the last successful *master* for easy reference

On Thu, Oct 6, 2016 at 8:37 AM, Andrew Schoen <aschoen@redhat.com> wrote:
> I'd like to add that we've just finished up a first iteration of a UI
> for shaman. This can be used to check on the status of builds and
> repos. Currently jenkins is building a repo for every push to the ceph
> repo just as gitbuilders did.
>
> Here's a couple links for that:
>
> https://shaman.ceph.com/
> https://shaman.ceph.com/builds/ceph/
> https://shaman.ceph.com/repos/ceph/
>
> Any feedback would be appreciated.
>
> Thanks,
> Andrew
>
> On Wed, Oct 5, 2016 at 3:14 PM, Zack Cerza <zack@redhat.com> wrote:
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
>>
>> Please try to give this new system some exercise. It's been tested
>> well but of course we can't necessarily anticipate everything.
>> Teuthology bugs, as always, should go here [2] and bugs related to the
>> new build system should go here [3].
>>
>> Thanks for reading!
>> Zack
>>
>> [0] https://github.com/ceph/teuthology/pull/951
>> [1] https://github.com/ceph/shaman/
>> [2] http://tracker.ceph.com/projects/teuthology/issues/new
>> [3] http://tracker.ceph.com/projects/ci/issues/new
>> _______________________________________________
>> Sepia mailing list
>> Sepia@lists.ceph.com
>> http://lists.ceph.com/listinfo.cgi/sepia-ceph.com
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
