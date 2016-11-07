From: Sage Weil <sweil@redhat.com>
Subject: Re: [RFC PATCH 07/10] ceph: update cap message struct version to 9
Date: Mon, 7 Nov 2016 20:09:17 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1611071958480.18089@piezo.us.to>
References: <1478259273-3471-1-git-send-email-jlayton@redhat.com> <1478259273-3471-8-git-send-email-jlayton@redhat.com> <1478264250.27698.1.camel@redhat.com> <CAAM7YAnzECeDocm5Mf+5DwDzyMgC0HXrh3jC9RLbi17T76XXOw@mail.gmail.com> <1478517694.2386.13.camel@redhat.com>
 <alpine.DEB.2.11.1611071400160.18089@piezo.us.to> <1478528548.2386.26.camel@redhat.com> <alpine.DEB.2.11.1611071431420.18089@piezo.us.to> <1478543967.2386.43.camel@redhat.com> <CAJ4mKGb11tH+JYLeUNy+nyda=t-DHHYM5xV13tVhtOG7NTsLFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-636446153-1478549359=:18089"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41670 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751056AbcKGUJU (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 7 Nov 2016 15:09:20 -0500
In-Reply-To: <CAJ4mKGb11tH+JYLeUNy+nyda=t-DHHYM5xV13tVhtOG7NTsLFw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Jeff Layton <jlayton@redhat.com>, "Yan, Zheng" <ukernel@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, Ilya Dryomov <idryomov@gmail.com>, Zheng Yan <zyan@redhat.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-636446153-1478549359=:18089
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 7 Nov 2016, Gregory Farnum wrote:
> On Mon, Nov 7, 2016 at 10:39 AM, Jeff Layton <jlayton@redhat.com> wrote:
> > On Mon, 2016-11-07 at 14:36 +0000, Sage Weil wrote:
> >> On Mon, 7 Nov 2016, Jeff Layton wrote:
> >> > On Mon, 2016-11-07 at 14:05 +0000, Sage Weil wrote:
> >> > > On Mon, 7 Nov 2016, Jeff Layton wrote:
> >> > > > On Mon, 2016-11-07 at 16:43 +0800, Yan, Zheng wrote:
> >> > > > > On Fri, Nov 4, 2016 at 8:57 PM, Jeff Layton <jlayton@redhat.com> wrote:
> >> > > > > >
> >> > > > > > On Fri, 2016-11-04 at 07:34 -0400, Jeff Layton wrote:
> >> > > > > > >
> >> > > > > > > The userland ceph has MClientCaps at struct version 9. This brings the
> >> > > > > > > kernel up the same version.
> >> > > > > > >
> >> > > > > > > With this change, we have to start tracking the btime and change_attr,
> >> > > > > > > so that the client can pass back sane values in cap messages. The
> >> > > > > > > client doesn't care about the btime at all, so this is just passed
> >> > > > > > > around, but the change_attr is used when ceph is exported via NFS.
> >> > > > > > >
> >> > > > > > > For now, the new "sync" parm is left at 0, to preserve the existing
> >> > > > > > > behavior of the client.
> >> > > > > > >
> >> > > > > > > Signed-off-by: Jeff Layton <jlayton@redhat.com>
> >> > > > > > > ---
> >> > > > > > >  fs/ceph/caps.c | 33 +++++++++++++++++++++++++--------
> >> > > > > > >  1 file changed, 25 insertions(+), 8 deletions(-)
> >> > > > > > >
> >> > > > > > > diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> >> > > > > > > index 6e99866b1946..452f5024589f 100644
> >> > > > > > > --- a/fs/ceph/caps.c
> >> > > > > > > +++ b/fs/ceph/caps.c
> >> > > > > > > @@ -991,9 +991,9 @@ struct cap_msg_args {
> >> > > > > > >       struct ceph_mds_session *session;
> >> > > > > > >       u64                     ino, cid, follows;
> >> > > > > > >       u64                     flush_tid, oldest_flush_tid, size, max_size;
> >> > > > > > > -     u64                     xattr_version;
> >> > > > > > > +     u64                     xattr_version, change_attr;
> >> > > > > > >       struct ceph_buffer      *xattr_buf;
> >> > > > > > > -     struct timespec         atime, mtime, ctime;
> >> > > > > > > +     struct timespec         atime, mtime, ctime, btime;
> >> > > > > > >       int                     op, caps, wanted, dirty;
> >> > > > > > >       u32                     seq, issue_seq, mseq, time_warp_seq;
> >> > > > > > >       kuid_t                  uid;
> >> > > > > > > @@ -1026,13 +1026,13 @@ static int send_cap_msg(struct cap_msg_args *arg)
> >> > > > > > >
> >> > > > > > >       /* flock buffer size + inline version + inline data size +
> >> > > > > > >        * osd_epoch_barrier + oldest_flush_tid */
> >> > > > > > > -     extra_len = 4 + 8 + 4 + 4 + 8;
> >> > > > > > > +     extra_len = 4 + 8 + 4 + 4 + 8 + 4 + 4 + 4 + 8 + 8 + 1;
> >> > > > > > >       msg = ceph_msg_new(CEPH_MSG_CLIENT_CAPS, sizeof(*fc) + extra_len,
> >> > > > > > >                          GFP_NOFS, false);
> >> > > > > > >       if (!msg)
> >> > > > > > >               return -ENOMEM;
> >> > > > > > >
> >> > > > > > > -     msg->hdr.version = cpu_to_le16(6);
> >> > > > > > > +     msg->hdr.version = cpu_to_le16(9);
> >> > > > > > >       msg->hdr.tid = cpu_to_le64(arg->flush_tid);
> >> > > > > > >
> >> > > > > > >       fc = msg->front.iov_base;
> >> > > > > > > @@ -1068,17 +1068,30 @@ static int send_cap_msg(struct cap_msg_args *arg)
> >> > > > > > >       }
> >> > > > > > >
> >> > > > > > >       p = fc + 1;
> >> > > > > > > -     /* flock buffer size */
> >> > > > > > > +     /* flock buffer size (version 2) */
> >> > > > > > >       ceph_encode_32(&p, 0);
> >> > > > > > > -     /* inline version */
> >> > > > > > > +     /* inline version (version 4) */
> >> > > > > > >       ceph_encode_64(&p, arg->inline_data ? 0 : CEPH_INLINE_NONE);
> >> > > > > > >       /* inline data size */
> >> > > > > > >       ceph_encode_32(&p, 0);
> >> > > > > > > -     /* osd_epoch_barrier */
> >> > > > > > > +     /* osd_epoch_barrier (version 5) */
> >> > > > > > >       ceph_encode_32(&p, 0);
> >> > > > > > > -     /* oldest_flush_tid */
> >> > > > > > > +     /* oldest_flush_tid (version 6) */
> >> > > > > > >       ceph_encode_64(&p, arg->oldest_flush_tid);
> >> > > > > > >
> >> > > > > > > +     /* caller_uid/caller_gid (version 7) */
> >> > > > > > > +     ceph_encode_32(&p, (u32)-1);
> >> > > > > > > +     ceph_encode_32(&p, (u32)-1);
> >> > > > > >
> >> > > > > > A bit of self-review...
> >> > > > > >
> >> > > > > > Not sure if we want to set the above to something else -- maybe 0 or to
> >> > > > > > current's creds? That may not always make sense though (during e.g.
> >> > > > > > writeback).
> >> > > > > >
> >> > > >
> >> > > > Looking further, I'm not quite sure I understand why we send creds at
> >> > > > all in cap messages. Can you clarify where that matters?
> >> > > >
> >> > > > The way I look at it, would be to consider caps to be something like a
> >> > > > more granular NFS delegation or SMB oplock.
> >> > > >
> >> > > > In that light, a cap flush is just the client sending updated attrs for
> >> > > > the exclusive caps that it has already been granted. Is there a
> >> > > > situation where we would ever want to refuse that update?
> >> > >
> >> > > A chmod or chown can be done locally if you have excl caps and flushed
> >> > > back to the MDS via a caps message.  We need to verify the user has
> >> > > permission to make the change.
> >> > >
> >> >
> >> > My take is that once the MDS has delegated Ax to the client, then it's
> >> > effectively trusting the client to handle permissions enforcement
> >> > correctly. I don't see why we should second guess that.
> >> >
> >> > > > Note that nothing ever checks the return code for _do_cap_update in the
> >> > > > userland code. If the permissions check fails, then we'll end up
> >> > > > silently dropping the updated attrs on the floor.
> >> > >
> >> > > Yeah.  This was mainly for expediency... the protocol assumes that flushes
> >> > > don't fail.  Given that the client does it's own permissions check, I
> >> > > think the way to improve this is to have it prevent the flush in the first
> >> > > place, so that it's only nefarious clients that are effected (and who
> >> > > cares if they get confused).  I don't think we have a particularly good
> >> > > way to tell the client it can't, say, sudo chmod 0:0 a file, though.
> >> > >
> >> >
> >> > Sorry, I don't quite follow. How would we prevent the flush from a
> >> > nefarious client (which is not something we can really control)?
> >> >
> >> > In any case...ISTM that the permissions check in _do_cap_update ought to
> >> > be replaced by a cephx key check. IOW, what we really want to know is
> >> > whether the client is truly the one to which we delegated the caps. If
> >> > so, then we sort of have to trust that it's doing the right thing with
> >> > respect to permissions checking here.
> >>
> >> The capability can say "you are allowed to be uid 1000 or uid 1020." We
> >> want to delegate the EXCL caps to the client so that a create + chmod +
> >> chown + write can all happen efficiently, but we still need to ensure that
> >> the values they set are legal (a permitted uid/gid combo).
> >>
> >> A common example would be user workstations that are allowed access to
> >> /home/user and restricted via their mds caps to their uid/gid.  We need to
> >> prevent them from doing a 'sudo chown 0:0 foo'...
> >>
> >>
> >
> >
> > On what basis do you make such a decision though? For instance, NFS does
> > root-squashing which is (generally) a per-export+per-client thing.
> > It sounds like you're saying that ceph has different semantics here?
> >
> > (cc'ing Greg here)
> 
> As Sage says, we definitely avoid the root squash semantics. We
> discussed them last year and concluded they were an inappropriate
> match for Ceph's permission model.
> 
> >
> > Also, chown (at least under POSIX) is reserved for superuser only, and
> > now that I look, I think this check in MDSAuthCaps::is_capable may be
> > wrong:
> >
> >       // chown/chgrp
> >       if (mask & MAY_CHOWN) {
> >         if (new_uid != caller_uid ||   // you can't chown to someone else
> >             inode_uid != caller_uid) { // you can't chown from someone else
> >           continue;
> >         }
> >       }
> >
> > Shouldn't this just be a check for whether the caller_uid is 0 (or
> > whatever the correct check for the equivalent to the kernel's CAP_CHOWN
> > would be)?

Oops, I skipped over this part ^
 
> Without context, this does look a little weird — does it allow *any*
> change, given caller_uid needs to match both new and inode uid?
> Sort of the common case would be that the admin cap gets hit toward
> the beginning of the function and just allows it without ever reaching
> this point.

Yeah, the check is a bit weird.  It looks like

1- A normal cap that specifies a uid can't ever change the uid.  This 
conditional could be simplified/clarified...

2- If you have a pair of caps, like

  allow * uid=1, allow * uid=2

we still don't let you chown between uid 1 and 2.  Well, not as caller_uid 
1 or 2 (which is fine), but

3- Jeff is right, we don't allow root to chown between allowed uids.  
Like if you had

  allow * uid=0

shouldn't that let you chown anything?  I didn't really consider this 
case since most users would just do

  allow *

which can do anything (including chown).  But probably the 'allow * uid=0' 
case should be handled properly.

sage
--8323329-636446153-1478549359=:18089--
