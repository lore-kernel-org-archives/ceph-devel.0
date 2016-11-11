From: Jeff Layton <jlayton@redhat.com>
Subject: Re: [RFC PATCH 07/10] ceph: update cap message struct version to 9
Date: Fri, 11 Nov 2016 07:45:17 -0500
Message-ID: <1478868317.2482.23.camel@redhat.com>
References: <alpine.DEB.2.11.1611072121100.29278@piezo.us.to>
         <CAJ4mKGZ8hJ8183Nj8vtexswRcqN4Ye8Qoqtrav6-GCs2d3hmgw@mail.gmail.com>
         <alpine.DEB.2.11.1611072318290.29278@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f174.google.com ([209.85.216.174]:36474 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756415AbcKKMpc (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Nov 2016 07:45:32 -0500
Received: by mail-qt0-f174.google.com with SMTP id w33so8640653qtc.3
        for <ceph-devel@vger.kernel.org>; Fri, 11 Nov 2016 04:45:21 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1611072318290.29278@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Gregory Farnum <gfarnum@redhat.com>
Cc: "Yan, Zheng" <ukernel@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, Ilya Dryomov <idryomov@gmail.com>, Zheng Yan <zyan@redhat.com>

On Mon, 2016-11-07 at 23:21 +0000, Sage Weil wrote:
> On Mon, 7 Nov 2016, Gregory Farnum wrote:
> > On Mon, Nov 7, 2016 at 1:21 PM, Sage Weil <sweil@redhat.com> wrote:
> > > On Mon, 7 Nov 2016, Jeff Layton wrote:
> > >> On Mon, 2016-11-07 at 20:09 +0000, Sage Weil wrote:
> > >> > On Mon, 7 Nov 2016, Gregory Farnum wrote:
> > >> > > On Mon, Nov 7, 2016 at 10:39 AM, Jeff Layton <jlayton@redhat.com> wrote:
> > >> > > > On Mon, 2016-11-07 at 14:36 +0000, Sage Weil wrote:
> > >> > > >> On Mon, 7 Nov 2016, Jeff Layton wrote:
> > >> > > >> > On Mon, 2016-11-07 at 14:05 +0000, Sage Weil wrote:
> > >> > > >> > > On Mon, 7 Nov 2016, Jeff Layton wrote:
> > >> > > >> > > > On Mon, 2016-11-07 at 16:43 +0800, Yan, Zheng wrote:
> > >> > > >> > > > > On Fri, Nov 4, 2016 at 8:57 PM, Jeff Layton <jlayton@redhat.com> wrote:
> > >> > > >> > > > > >
> 
> [okay, time to prune this a bit]
> 
> > >> It still seems to me like that should just be a check for superuser
> > >> status. Something like:
> > >>
> > >>       if (mask & MAY_CHOWN) {
> > >>       // only root can chown
> > >>         if (i->match.uid != 0 || caller_uid != 0)
> > >>           continue;
> > >>         }
> > >>       }
> > >>
> > >> i.e. only allow chown if the capability has a uid of 0 and the
> > >> caller_uid is also 0.
> > >>
> > >> I don't think we want to ever grant an unprivileged user the ability to
> > >> chown, do we?
> > >
> > > Ah, yep.  Except that the Locker.cc caller needs to be fixed to only ask
> > > for MAY_CHOWN if the uid is changing.  Right now it's only passing
> > > MAY_WRITE which looks wrong too...
> > 
> > Don't we want to let users chown between their own UIDs? A POSIX
> > superuser — ie root — really has very little meaning in terms of CephX
> > permissions. But it's perfectly legitimate for a tenant with 3 users
> > to chmod files between those 3. :/
> 
> Maybe, but it'd be a different kind of check though, because it depends on 
> multiple caps in order to permit the operation.  So we'd need a couple 
> function-global bools like chown_src_allowed and chown_dst_allowed or 
> something like that.
> 
> I'm not sure it would work even then, though, because on the client the 
> user would still have to sudo chown ... to get past the client kernel's 
> checks (I assume?).
> 
> 

Not necessarily. Most kernel filesystems call setattr_prepare, which is
where the CAP_CHOWN check happens, but (e.g.) NFS doesn't call it as it
always delegates the permission checking for setattr to the server.

Looks like both the in-kernel and Ceph client and FUSE always call that
function, so CAP_CHOWN permissions are always checked client-side there.
Still, with libcephfs a program need not deal with the kernel at all, so
you can't really rely on that.

Isn't this potentially silent metadata corruption? You could end up with
a program that issues an ownership change that appears to work, only to
find later that it got reverted because the mds decided it didn't want
to apply it once the caps got updated.

I think the simplest solution would be to just not issue exclusive caps
at all if you aren't prepared to accept cached updates from the client
for the corresponding metadata. Those clients would get shared caps
only. So, you could have clients to which you allow Fx caps, but only
As?

-- 
Jeff Layton <jlayton@redhat.com>
