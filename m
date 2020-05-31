From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH v2 3/5] libceph: crush_location infrastructure
Date: Sun, 31 May 2020 23:07:13 +0200
Message-ID: <CAOi1vP_r5YF5i35d416OY8Uy4TaW2cQz1FfT_6NA0nhJfTNCrQ@mail.gmail.com>
References: <20200530153439.31312-1-idryomov@gmail.com> <20200530153439.31312-4-idryomov@gmail.com>
 <5b152390be256d3ae93933baf9cf84fa4e5f001f.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgEaVHI (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 31 May 2020 17:07:08 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777D7C061A0E
        for <ceph-devel@vger.kernel.org>; Sun, 31 May 2020 14:07:08 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id h4so1647088iob.10
        for <ceph-devel@vger.kernel.org>; Sun, 31 May 2020 14:07:08 -0700 (PDT)
In-Reply-To: <5b152390be256d3ae93933baf9cf84fa4e5f001f.camel@kernel.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Josh Durgin <jdurgin@redhat.com>, Sage Weil <sage@redhat.com>, Jason Dillaman <dillaman@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>

On Sun, May 31, 2020 at 3:27 PM Jeff Layton <jlayton@kernel.org> wrote:
>
> On Sat, 2020-05-30 at 17:34 +0200, Ilya Dryomov wrote:
> > Allow expressing client's location in terms of CRUSH hierarchy as
> > a set of (bucket type name, bucket name) pairs.  The userspace syntax
> > "crush_location = key1=value1 key2=value2" is incompatible with mount
> > options and needed adaptation.  Key-value pairs are separated by '|'
> > and we use ':' instead of '=' to separate keys from values.  So for:
> >
> >   crush_location = host=foo rack=bar
> >
> > one would write:
> >
> >   crush_location=host:foo|rack:bar
> >
> > As in userspace, "multipath" locations are supported, so indicating
> > locality for parallel hierarchies is possible:
> >
> >   crush_location=rack:foo1|rack:foo2|datacenter:bar
> >
>
> This looks much nicer.
>
> The only caveat I have is that using '|' means that you'll need to quote
> or escape the option string on the command line or in shell scripts
> (lest the shell consider it a pipeline directive).
>
> It's hard to find ascii special characters that don't have _some_
> special meaning however. '/' would fill the bill, but I understand what
> you mean about that having connotations of a pathname.

Yeah, the problem with '/' is that crush_location of the form
"host:foo/rack:bar/row:baz" is not a path to the root of the tree,
but rather just a set of nodes: foo, bar and baz can belong to
completely different subtrees and would be matched independent of
each other.  The only reason that is not ambiguous is that CRUSH
enforces globally unique bucket names.

Having to escape is unfortunate, but I thought it was a (slightly)
lesser evil.  If folks think that '/' isn't that confusing or have
other ideas, now is the time to speak up!

Thanks,

                Ilya
