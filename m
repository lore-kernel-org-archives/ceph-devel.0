From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: v10.1.2 Jewel release candidate release
Date: Wed, 13 Apr 2016 15:09:11 -0700
Message-ID: <CAJ4mKGa_APTdJzXR86_GjN141igBft=4JvY79EkS_ZkPbgcAVQ@mail.gmail.com>
References: <alpine.DEB.2.11.1604131753570.31812@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f44.google.com ([209.85.213.44]:34740 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928AbcDMWJN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Apr 2016 18:09:13 -0400
Received: by mail-vk0-f44.google.com with SMTP id e185so88328621vkb.1
        for <ceph-devel@vger.kernel.org>; Wed, 13 Apr 2016 15:09:12 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1604131753570.31812@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>, ceph-maintainers@ceph.com, ceph-announce@ceph.com

On Wed, Apr 13, 2016 at 3:02 PM, Sage Weil <sage@redhat.com> wrote:
> Hi everyone,
>
> The third (and likely final) Jewel release candidate is out.  We have a
> very small number of remaining blocker issues and a bit of final polish
> before we publish Jewel 10.2.0, probably next week.
>
> There are no known issues with this release that are serious enough to
> warn about here.  Greg is adding some CephFS checks so that admins don't
> accidentally start using less-stable features,

s/is adding/has added/

>         http://docs.ceph.com/docs/master/release-notes/

As noted in another thread, there's still a big CephFS warning in the
online docs. We'll be cleaning those up, since we now have the
recovery tools we desire! Some things are known to still be slow or
sub-optimal, but we consider CephFS stable and safe at this time when
run in the default single-MDS configuration. (It won't let you do
anything bad without very explicitly setting flags and acknowledging
they're dangerous.)
:)
-Greg
