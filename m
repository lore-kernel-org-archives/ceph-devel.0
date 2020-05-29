From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH 3/5] libceph: crush_location infrastructure
Date: Fri, 29 May 2020 15:10:43 -0400
Message-ID: <c76c2f3634898c3618ef536f4c507423196eb876.camel@kernel.org>
References: <20200529151952.15184-1-idryomov@gmail.com>
         <20200529151952.15184-4-idryomov@gmail.com>
         <adbdcc0f39b050252241c7afab17e7a4a6ba5a43.camel@kernel.org>
         <CAOi1vP-UPktbA7gcx0tQvN9wi1L2DB1zHyb212x5kbErkchR=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726829AbgE2TKp (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 29 May 2020 15:10:45 -0400
In-Reply-To: <CAOi1vP-UPktbA7gcx0tQvN9wi1L2DB1zHyb212x5kbErkchR=Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, 2020-05-29 at 20:38 +0200, Ilya Dryomov wrote:
> On Fri, May 29, 2020 at 7:27 PM Jeff Layton <jlayton@kernel.org> wrote:
> > On Fri, 2020-05-29 at 17:19 +0200, Ilya Dryomov wrote:
> > > Allow expressing client's location in terms of CRUSH hierarchy as
> > > a set of (bucket type name, bucket name) pairs.  The userspace syntax
> > > "crush_location = key1=value1 key2=value2" is incompatible with mount
> > > options and needed adaptation:
> > > 
> > > - ':' separator
> > > - one key:value pair per crush_location option
> > > - crush_location options are combined together
> > > 
> > > So for:
> > > 
> > >   crush_location = host=foo rack=bar
> > > 
> > > one would write:
> > > 
> > >   crush_location=host:foo,crush_location=rack:bar
> > > 
> > > As in userspace, "multipath" locations are supported, so indicating
> > > locality for parallel hierarchies is possible:
> > > 
> > >   crush_location=rack:foo1,crush_location=rack:foo2,crush_location=datacenter:bar
> > > 
> > 
> > Blech, that syntax is hideous. It's also problematic in that the options
> > are additive -- you can't override an option that was given earlier
> > (e.g. in fstab), or in a shell script.
> > 
> > Is it not possible to do something with a single crush_location= option?
> > Maybe:
> > 
> >     crush_location=rack:foo1/rack:foo2/datacenter:bar
> > 
> > It's still ugly with the embedded '=' signs, but it would at least make
> > it so that the options aren't additive.
> 
> I suppose we could do something like that at the cost of more
> parsing boilerplate, but I'm not sure additive options are that
> hideous.  I don't think additive options are unprecedented and
> more importantly I think many simple boolean and integer options
> are not properly overridable even in major filesystems.
> 

That is the long-standing convention though. There are reasons to
deviate from it, but I don't see it here. Plus, I think the syntax I
proposed above is more readable (and compact) as well.

It would mean a bit more parsing code though, granted.

> What embedded '=' signs are you referring to?  I see ':' and '/'
> in your suggested syntax.
> 

Sorry, yeah... I had originally done one that had '=' chars in it, but
converted it to the above. Please disregard that paragraph.

-- 
Jeff Layton <jlayton@kernel.org>
