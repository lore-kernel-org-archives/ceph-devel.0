From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH 3/5] libceph: crush_location infrastructure
Date: Sat, 30 May 2020 17:47:32 +0200
Message-ID: <CAOi1vP8gmuxfvZ6zhwy+-_DeGFsRWwam_9a-W9_7oPYj7dnFjQ@mail.gmail.com>
References: <20200529151952.15184-1-idryomov@gmail.com> <20200529151952.15184-4-idryomov@gmail.com>
 <adbdcc0f39b050252241c7afab17e7a4a6ba5a43.camel@kernel.org>
 <CAOi1vP-UPktbA7gcx0tQvN9wi1L2DB1zHyb212x5kbErkchR=Q@mail.gmail.com>
 <c76c2f3634898c3618ef536f4c507423196eb876.camel@kernel.org> <CAOi1vP82akP6L4kGyVmBxLYEDxqimPiiP9=DyvuUkHcQ4gawwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728927AbgE3Pr2 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 30 May 2020 11:47:28 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EADC03E969
        for <ceph-devel@vger.kernel.org>; Sat, 30 May 2020 08:47:28 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id a13so634573ilh.3
        for <ceph-devel@vger.kernel.org>; Sat, 30 May 2020 08:47:28 -0700 (PDT)
In-Reply-To: <CAOi1vP82akP6L4kGyVmBxLYEDxqimPiiP9=DyvuUkHcQ4gawwQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, May 29, 2020 at 10:42 PM Ilya Dryomov <idryomov@gmail.com> wrote:
>
> On Fri, May 29, 2020 at 9:10 PM Jeff Layton <jlayton@kernel.org> wrote:
> >
> > On Fri, 2020-05-29 at 20:38 +0200, Ilya Dryomov wrote:
> > > On Fri, May 29, 2020 at 7:27 PM Jeff Layton <jlayton@kernel.org> wrote:
> > > > On Fri, 2020-05-29 at 17:19 +0200, Ilya Dryomov wrote:
> > > > > Allow expressing client's location in terms of CRUSH hierarchy as
> > > > > a set of (bucket type name, bucket name) pairs.  The userspace syntax
> > > > > "crush_location = key1=value1 key2=value2" is incompatible with mount
> > > > > options and needed adaptation:
> > > > >
> > > > > - ':' separator
> > > > > - one key:value pair per crush_location option
> > > > > - crush_location options are combined together
> > > > >
> > > > > So for:
> > > > >
> > > > >   crush_location = host=foo rack=bar
> > > > >
> > > > > one would write:
> > > > >
> > > > >   crush_location=host:foo,crush_location=rack:bar
> > > > >
> > > > > As in userspace, "multipath" locations are supported, so indicating
> > > > > locality for parallel hierarchies is possible:
> > > > >
> > > > >   crush_location=rack:foo1,crush_location=rack:foo2,crush_location=datacenter:bar
> > > > >
> > > >
> > > > Blech, that syntax is hideous. It's also problematic in that the options
> > > > are additive -- you can't override an option that was given earlier
> > > > (e.g. in fstab), or in a shell script.
> > > >
> > > > Is it not possible to do something with a single crush_location= option?
> > > > Maybe:
> > > >
> > > >     crush_location=rack:foo1/rack:foo2/datacenter:bar
> > > >
> > > > It's still ugly with the embedded '=' signs, but it would at least make
> > > > it so that the options aren't additive.
> > >
> > > I suppose we could do something like that at the cost of more
> > > parsing boilerplate, but I'm not sure additive options are that
> > > hideous.  I don't think additive options are unprecedented and
> > > more importantly I think many simple boolean and integer options
> > > are not properly overridable even in major filesystems.
> > >
> >
> > That is the long-standing convention though. There are reasons to
> > deviate from it, but I don't see it here. Plus, I think the syntax I
> > proposed above is more readable (and compact) as well.
> >
> > It would mean a bit more parsing code though, granted.
> >
> > > What embedded '=' signs are you referring to?  I see ':' and '/'
> > > in your suggested syntax.
> > >
> >
> > Sorry, yeah... I had originally done one that had '=' chars in it, but
> > converted it to the above. Please disregard that paragraph.
>
> One of the reasons I did it this way is that crush_location is
> inherently additive.  I don't have a strong opinion on this though
> so let's adhere to the convention.
>
> I'll implement the suggested syntax and repost.

I went with '|' instead of '/' for the separator to try to stress
the additivity (in the OR sense).  '/' makes it look like a path to
the root of the tree which it really isn't.

Thanks,

                Ilya
