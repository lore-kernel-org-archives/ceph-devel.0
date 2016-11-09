From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: bump librados' soversion
Date: Wed, 9 Nov 2016 08:52:37 -0500
Message-ID: <CA+aFP1BE+PFCnkYBwxARuL=PMGy5REdVW22tEvJGYkuchvhxiw@mail.gmail.com>
References: <CAJE9aOMoOJSccnXA=gCxuO3KN+0fziF3mRhMxBcF3dy4tmwy9A@mail.gmail.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f44.google.com ([209.85.215.44]:35636 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932719AbcKINwj (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Nov 2016 08:52:39 -0500
Received: by mail-lf0-f44.google.com with SMTP id b14so164634622lfg.2
        for <ceph-devel@vger.kernel.org>; Wed, 09 Nov 2016 05:52:38 -0800 (PST)
In-Reply-To: <CAJE9aOMoOJSccnXA=gCxuO3KN+0fziF3mRhMxBcF3dy4tmwy9A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>

Am I correct in assuming the original issue that forced this change
was because a >2GB message was sent over the wire and that bug has
been fixed?

If so, can we just revert the API change and do a soversion bump when
we really clean up the librados API, which has been talked about for a
while now? There is some cleanup work needed in the librbd API that
would break the API, so it would be nice to do it all at once instead
of library-by-library, release-by-release.

There only seems to be a few places within the codebase that even use
"advance", and they could be switched over to a new a "advance2" /
"advance64" method in the interim if required.

If we do bump the soversion for this, obviously the current failing
client upgrade test would just need to be removed.


On Wed, Nov 9, 2016 at 1:16 AM, kefu chai <tchaikov@gmail.com> wrote:
> hi cephers,
>
> i am proposing bumping the soversion of librados2 to librados3. as in
> 053bfa6[0], we changed the function signature of
> ceph::buffer::list::advance(), which is incompatible with the prior
> version of librados. that's partially why we have
> http://tracker.ceph.com/issues/17809, in which, the old librbd client
> fails to start, due to unresolved symbols.
>
> and if user has some (homebrew) packages depending on librados2. those
> packages will be broken as well. the same applies to executables
> linked against librados2 shared library. so we need to bump the
> soversion. but to minimize the impact, i think we will not introduce
> incompatible changes between major releases, in other words, the
> soversion won't change from jewel to kraken, for example. if i
> understand sage's comment correctly.
>
> yes, i knew this issue was raised before from time to time. but maybe
> this is a good chance to do the soversion change in kraken.
>
> a PR is posted to address this problem. see
> https://github.com/ceph/ceph/pull/11843.
>
> --
> [0] https://github.com/ceph/ceph/pull/9395/commits/053bfa650ba1d656dfb20e389ef25afc4c383bb3
> [1] https://github.com/ceph/ceph/pull/9395#issuecomment-224278945
>
> --
> Regards
> Kefu Chai



-- 
Jason
