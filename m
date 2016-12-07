From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: enabling shared ccache dirs in default builds
Date: Wed, 7 Dec 2016 08:46:40 -0800
Message-ID: <CAJ4mKGZW35ULXFmf14rjmtEvBtJZfPN2eHPM-ogSw4xx8rmS+w@mail.gmail.com>
References: <CAJ4mKGZSnN+RE7d5wrzghmtWZA1w1e7NT8JeW4nArwVdijggkQ@mail.gmail.com>
 <fde7b31e-75ba-9c71-a0d2-1467e65b1d54@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:33723 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752362AbcLGQql (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Dec 2016 11:46:41 -0500
Received: by mail-oi0-f49.google.com with SMTP id w63so423424147oiw.0
        for <ceph-devel@vger.kernel.org>; Wed, 07 Dec 2016 08:46:41 -0800 (PST)
In-Reply-To: <fde7b31e-75ba-9c71-a0d2-1467e65b1d54@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Dec 7, 2016 at 1:26 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> On 7-12-2016 01:09, Gregory Farnum wrote:
>> The default (or at least, ./do_cmake.sh-setup) Ceph build makes use of
>> cmake. This is nice for speeding up builds, but as the amount of disk
>> space increases it really explodes disk usage on dev boxes. As of
>> today, a Ceph repo with build artifacts is ~30GB, and my ccache
>> directory is ~32GB.
>>
>> For me and many of the other Red Hat devs, that's a significant
>> fraction of the 256GB available on our (shared box) home-dir SSDs, and
>> I don't think there's *too* much advantage to be gained by giving each
>> dev their own ccache dir. If anybody has expertise configuring ccache
>> and wants to tweak our build scripts to make setting that up easy,
>> it'd be cool — I started in on the ccache man page and it doesn't look
>> too hard but I've never configured any of it. Created a ticket at
>> http://tracker.ceph.com/issues/18160
>
> From the ccache site:
> "Another reason to use ccache is that the same cache is used for builds
> in different directories. If you have several versions or branches of a
> software stored in different directories, many of the object files in a
> build directory can probably be taken from the cache even if they were
> compiled for another version or branch
> "
>
> So why not have a shared/global ccache. I would expect the larger part
> of the project to generate the same code over and over for most of the
> users? On average only a small fraction of the compile is different
> between developers, and even that will be absorbed by a large general
> cache. The trick with a cache is that the benifits increase if there are
> more users doing/reusing more of the same. So the advantage of 300G
> cache is better that 10*30G. Note that ccache can even compress data in
> the cache, leading to even more objects in your cache. With an even
> better hit ratio.
>
> Get ride of all personal ccache.conf files and
> in global /etc/ccache.conf
> cache_dir = /somewhere/you/want/then/ccache
> max_size = as large as possible
> umask = 777
> # or 775 if devs are all in the same group.

Yes, something like this would be involved too. But if you grep for
ccache in ceph.git you'll notice it's doing some level of autoconfig —
I don't know how much — which needs to play nicely as well.
Now that I look at it with fresh eyes it looks like maybe our tooling
is only invoking ccache and we do just need the config; I'm just a
little fidgety about it because some of the test-dir contents are
referencing specific directories and I'm not sure if we invoke any of
those bits via make check or similar.
-Greg

>
> --WjW
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
