From: Sage Weil <sweil@redhat.com>
Subject: Re: [RFC PATCH 07/10] ceph: update cap message struct version to 9
Date: Mon, 7 Nov 2016 23:21:23 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1611072318290.29278@piezo.us.to>
References: <alpine.DEB.2.11.1611072121100.29278@piezo.us.to> <CAJ4mKGZ8hJ8183Nj8vtexswRcqN4Ye8Qoqtrav6-GCs2d3hmgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1089753980-1478560886=:29278"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48980 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751081AbcKGXV1 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 7 Nov 2016 18:21:27 -0500
In-Reply-To: <CAJ4mKGZ8hJ8183Nj8vtexswRcqN4Ye8Qoqtrav6-GCs2d3hmgw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Jeff Layton <jlayton@redhat.com>, "Yan, Zheng" <ukernel@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, Ilya Dryomov <idryomov@gmail.com>, Zheng Yan <zyan@redhat.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1089753980-1478560886=:29278
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 7 Nov 2016, Gregory Farnum wrote:
> On Mon, Nov 7, 2016 at 1:21 PM, Sage Weil <sweil@redhat.com> wrote:
> > On Mon, 7 Nov 2016, Jeff Layton wrote:
> >> On Mon, 2016-11-07 at 20:09 +0000, Sage Weil wrote:
> >> > On Mon, 7 Nov 2016, Gregory Farnum wrote:
> >> > > On Mon, Nov 7, 2016 at 10:39 AM, Jeff Layton <jlayton@redhat.com> wrote:
> >> > > > On Mon, 2016-11-07 at 14:36 +0000, Sage Weil wrote:
> >> > > >> On Mon, 7 Nov 2016, Jeff Layton wrote:
> >> > > >> > On Mon, 2016-11-07 at 14:05 +0000, Sage Weil wrote:
> >> > > >> > > On Mon, 7 Nov 2016, Jeff Layton wrote:
> >> > > >> > > > On Mon, 2016-11-07 at 16:43 +0800, Yan, Zheng wrote:
> >> > > >> > > > > On Fri, Nov 4, 2016 at 8:57 PM, Jeff Layton <jlayton@redhat.com> wrote:
> >> > > >> > > > > >

[okay, time to prune this a bit]

> >> It still seems to me like that should just be a check for superuser
> >> status. Something like:
> >>
> >>       if (mask & MAY_CHOWN) {
> >>       // only root can chown
> >>         if (i->match.uid != 0 || caller_uid != 0)
> >>           continue;
> >>         }
> >>       }
> >>
> >> i.e. only allow chown if the capability has a uid of 0 and the
> >> caller_uid is also 0.
> >>
> >> I don't think we want to ever grant an unprivileged user the ability to
> >> chown, do we?
> >
> > Ah, yep.  Except that the Locker.cc caller needs to be fixed to only ask
> > for MAY_CHOWN if the uid is changing.  Right now it's only passing
> > MAY_WRITE which looks wrong too...
> 
> Don't we want to let users chown between their own UIDs? A POSIX
> superuser — ie root — really has very little meaning in terms of CephX
> permissions. But it's perfectly legitimate for a tenant with 3 users
> to chmod files between those 3. :/

Maybe, but it'd be a different kind of check though, because it depends on 
multiple caps in order to permit the operation.  So we'd need a couple 
function-global bools like chown_src_allowed and chown_dst_allowed or 
something like that.

I'm not sure it would work even then, though, because on the client the 
user would still have to sudo chown ... to get past the client kernel's 
checks (I assume?).

sage
--8323329-1089753980-1478560886=:29278--
