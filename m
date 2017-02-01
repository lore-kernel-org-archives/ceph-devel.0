From: Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH v2 01/13] ceph: add new r_req_flags field to
 ceph_mds_request
Date: Wed, 01 Feb 2017 14:14:18 -0500
Message-ID: <1485976458.2559.1.camel@redhat.com>
References: <20170130161942.16537-1-jlayton@redhat.com>
         <20170201114914.20808-1-jlayton@redhat.com>
         <20170201114914.20808-2-jlayton@redhat.com>
         <CAOi1vP9hGnsqVMnZV7RO7f4AQUEFsnD0VeuAcumTOcQu2sZ8+Q@mail.gmail.com>
         <1485971230.20965.1.camel@redhat.com>
         <CAOi1vP9BszmpzTfM-gC2+JGY4MZeJJfAZPhNh+uXYJpKKwHjqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f180.google.com ([209.85.216.180]:33138 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751104AbdBATOW (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Feb 2017 14:14:22 -0500
Received: by mail-qt0-f180.google.com with SMTP id v23so280262540qtb.0
        for <ceph-devel@vger.kernel.org>; Wed, 01 Feb 2017 11:14:22 -0800 (PST)
In-Reply-To: <CAOi1vP9BszmpzTfM-gC2+JGY4MZeJJfAZPhNh+uXYJpKKwHjqw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>

On Wed, 2017-02-01 at 20:10 +0100, Ilya Dryomov wrote:
> On Wed, Feb 1, 2017 at 6:47 PM, Jeff Layton <jlayton@redhat.com> wrote:
> > On Wed, 2017-02-01 at 15:08 +0100, Ilya Dryomov wrote:
> > > On Wed, Feb 1, 2017 at 12:49 PM, Jeff Layton <jlayton@redhat.com> wrote:
> > > > ...and start moving bool flags into it.
> > > > 
> > > > Signed-off-by: Jeff Layton <jlayton@redhat.com>
> > > > ---
> > > >  fs/ceph/dir.c        | 2 +-
> > > >  fs/ceph/mds_client.c | 2 +-
> > > >  fs/ceph/mds_client.h | 4 +++-
> > > >  3 files changed, 5 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> > > > index d4385563b70a..04fa4ae3deca 100644
> > > > --- a/fs/ceph/dir.c
> > > > +++ b/fs/ceph/dir.c
> > > > @@ -371,7 +371,7 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
> > > >                 /* hints to request -> mds selection code */
> > > >                 req->r_direct_mode = USE_AUTH_MDS;
> > > >                 req->r_direct_hash = ceph_frag_value(frag);
> > > > -               req->r_direct_is_hash = true;
> > > > +               set_bit(CEPH_MDS_R_DIRECT_IS_HASH, &req->r_req_flags);
> > > 
> > > Hi Jeff,
> > > 
> > > Just a couple of nits:
> > > 
> > > These are atomic -- should probably mention in the commit message why
> > > is atomicity needed.
> > > 
> > 
> > It's not strictly needed for most of this stuff. DIRECT_IS_HASH in
> > particular could just use __set_bit.
> > 
> > The rest of the flags, I think are already protected from concurrent
> > writes by mutexes in the code. What I'm not sure of is whether they are
> > protected by the _same_ lock. That's a requirement if we mix all of the
> > flags together into the same word and don't want to use the atomic
> > *_bit macros.
> > 
> > I can look and see if that's possible. Even if it's not though, using
> > the atomic *_bit macros is generally not that expensive (particularly
> > in a situation where we're already using sleeping locks anyway).
> 
> Auditing for whether __set_bit, etc can be used instead is probably not
> worth it.  I'm not saying we shouldn't use atomic bitops here -- just
> wanted to get this explanation in the commit message.
> 
> 

Thanks, done. I went ahead and changed DIRECT_IS_HASH to use __set_bit
(it's pretty clear that that's safe there), but the others do need the
atomic versions as they can have other tasks manipulating them.

I went ahead and merged the squashed set into ceph-client/testing with
an updated commit message. Let me know if you see any other issues with
the set.

-- 
Jeff Layton <jlayton@redhat.com>
