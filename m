From: "Matt W. Benjamin" <matt@linuxbox.com>
Subject: Re: libcephfs: Open-By-Handle API - our patch and it's description
Date: Thu, 27 Jun 2013 10:37:31 -0400 (EDT)
Message-ID: <1167545057.44.1372343851509.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <138894132.40.1372343148764.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:3450 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753819Ab3F0Ohl convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Jun 2013 10:37:41 -0400
In-Reply-To: <138894132.40.1372343148764.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: aemerson <aemerson@linuxbox.com>, David Zafman <david.zafman@inktank.com>, ceph-devel@vger.kernel.org, Ilya Storozhilov <Ilya_Storozhilov@epam.com>

Hi Sage,

Adam and I haven't looked in detail yet, but based on the prior email d=
iscussion, and not counting nits, Ilya's changes seem fine.

If you agree, I and Adam take on the task of rebasing all our changes c=
urrently on wip-libcephfs, into a small number of changes, following yo=
ur lead in the "rebase" branch where possible.  (I had some questions a=
bout how the rebase branch was assembled initially, before bugging you,=
 we'll have a fresh look at it.) We may need some interaction on IRC, b=
ut with luck can have a prototype branch somewhere today or tomorrow.  =
(David, Sage, wrt IRC availability, does that sound likely to work?)

Our work in progress changes logically follow all of this, so I'm not w=
orried about those yet.

Matt

----- "Sage Weil" <sage@inktank.com> wrote:

> Hi Ilya!
>=20
> On Thu, 27 Jun 2013, Ilya Storozhilov wrote:
> > Hi Matt (CC Sage, David, Adam),
> >=20
> >=20
> > we have completed with our prototype of NFS/CIFS frontends to CEPH
> > filesystem. In order to do it we had to fork ?wip-libcephfs? branch
> (see
> > https://github.com/ferustigris/ceph and it?s ?open_by_handle_api?
> branch) to fix
> > some issues with libcephfs open-by-handle API - see below. I?ve
> attached a
> > respective patch, which:
>=20
> I posted some comments on github on the changes.  I think we're
> close!
>=20
> > Does it possible to merge our changes to ?wip-libcephfs? branch of
> the official
> > CEPH repository? If some action is needed from our side (further
> amendments,
> > merge-requests, etc.) - let us know, please.
>=20
> Matt, what is your plan for this branch?  Is it/are you rebasing?  Ar=
e
>=20
> there other changes in progress?
>=20
> I'd very much like to get the basic changes (the open by handle stuff=
)
>=20
> into the tree during the next week or two so that we make the dumplin=
g
>=20
> release cutoff.  Getting some of the additional bits that you guys=20
> specifically need ironed out (like the flushing and cap ref stuff) is
> less=20
> important for that timeframe, if that helps.
>=20
> Ideally, the patch series would look more like the rebased version I=20
> pushed (but with updated changelogs for each patch and correct=20
> authorship/sign-off.  If it's based on current master, and this patch
> goes=20
> on top, I'll pull it in.
>=20
> It would also be great to see some tests in test/libcephfs/ for the
> new=20
> calls as well... :)
>=20
> > There are still some unresolved issues in libcephfs, which are have
> to be
> > reported:
> >=20
> >  *=20
> >=20
> >     A file could be manipulated by it?s resource handle (inode) eve=
n
> if it has
> >     been already removed by another client and syncing all data in
> both
> >     cephfs connections is not helpful in this case;
>=20
> If I'm understanding you, this is normal unix behavior: open, unlink,
> do=20
> i/o for as long as you want, close.  That is by design.
>=20
> >  *=20
> >=20
> >     Invalid hardlinks count for directories: always 1 instead of 2
> plus one
> >     per each subdirectory as it?s dictated by POSIX.
>=20
> This is a very common divergence from POSIX, and one you'll find with
>=20
> btrfs and others as well.  IIRC the de facto convention is that if th=
e
>=20
> link count is 1 it does not reflect the sub directory count, but if i=
t
> is=20
> >=3D 2 it does.  You'll see code to this effect in GNU find (which tr=
ies
> to=20
> use the link count to optimize its search when -type d).
>=20
> Thanks!
> sage
>=20
>=20
> >=20
> > Should we report this bugs on github?
> >=20
> >=20
> > Best regards!
> >=20
> > --
> > Ilya Storozhilov
> > Lead Software Engineer
> > =C2=A0
> > EPAM Systems
> > Tver office, Russia
> > GMT+4
> >=20
> > ________________________________________
> > ??: Matt W. Benjamin [matt@linuxbox.com]
> > ??????????: 6 ???? 2013 ?.21:47
> > To: Ilya Storozhilov
> > Cc: Sage Weil; aemerson; David Zafman
> > ????: DRAFT: Re: HA: libcephfs: Open-By-Handle API question
> >=20
> > Hi Ilya (CC Sage, David, Adam),
> >=20
> > Thanks for looking at the branch.
> >=20
> > We'll try to help you get the most out of Ganesha+Ceph, if that's
> your goal.
> >=20
> > I dont overly like "open-by-handle" as a descriptor for all the
> changes we
> > and David Zafman have made so far, but obviously, that's a core
> > functionality it's providing to, e.g., an NFS re-exporter.
> >=20
> > In terms of your document,
> >=20
> > #1 The "resource handle" vs. pointer to opaque object distinction
> seems like
> > a merely cosmetic change. What the API does now is typical of many =
C
> APIs
> > (see cred_t in NetBSD kernel, many others), as well as C-over-C++
> APIs.
> > (Perhaps this branch has actual C++ leakage, if so, it's
> inadvertant, and
> > we'll fix.)
> >=20
> > #2 The "recoverable handle" concept needs to be subordinate to the
> semantics
> > of the objects and capability model of Ceph. It sounds like you're
> generally
> > speaking about objects at the NFS protocol level. With respect to
> NFS
> > filehandles, everything you're asserting is already true. With
> respect to
> > open state and other cluster coherence concepts, you've gone past
> the NFS
> > protocol to details of a clustered implementation. Our team has
> specific
> > requirements here that may differ from yours, just fyi.
> >=20
> > #3, #4 I (and Adam here) aren't fully persuaded of this. While
> embedding
> > objects in Ganesha handle memory would save small allocations, that
> > may not be a critical consideration. From a Ganesha perspective,
> it's
> > definitely just a hidden property of the driver implementation. I
> think
> > intuitively we're not really keen on having Inode objects (say) be
> expanded
> > in caller handles, although yes, Ganesha itself can support it.
> >=20
> > #5 No objection here.
> >=20
> > #6 I've been thinking of the "which level of API clients should use=
,
> and
> > which a slight modification" in more historical, and less
> prescriptive
> > terms. I do think it makes sense to continue refactoring to reduce
> code
> > duplication, in addition to getting thread-level concurrency in the
> Client
> > cache (that's what my api-concurrent topic branch is focused on).
> Obviously,
> > we want to do this without inconveniencing other users.
> >=20
> > Other points from your email:
> >=20
> > The lack of a convenience function for getting the root inode is
> just
> > artifact of Fuse, Ganesha+Ceph, and others being able to construct
> the inode
> > descriptively. I don't think it's really a C++ encapsulation issue.
> We can
> > add an API (inline in Client) to get the root inode, however, and
> will add
> > it, if there's no objection.
> >=20
> > Getattr fixes. May not be API related. I planned to push a revision
> of
> > libcephfs-wip this week, so perhaps fixes can follow this.
> >=20
> > We haven't spent time with extended attributes so far, because
> Ganesha's
> > current xattr implementation is a prototype likely to change soon.
> We may
> > have missed something obvious here, though, I'll look at it.
> >=20
> > Regards,
> >=20
> > Matt
> >=20
> > ----- "Ilya Storozhilov" <Ilya_Storozhilov@epam.com> wrote:
> >=20
> > > Hi Matt,
> > >
> > > we have organized some testing of the open-by-handle API staff
> from
> > > the ?libcephfs-wip? Ceph repo branch and I?m sending to you our
> > > thoughts about it. I will mention inode structure as ?resource
> handle?
> > > in this letter - this is how NFS-Ganesha considers it.
> > >
> > > First of all there is a small bug, when while trying to make file
> > > operations on the resource which has been already removed in
> another
> > > CephFS connection - you can even open this file for writing and
> append
> > > some data to it. Actually there should be a ENOENT error, but
> there is
> > > not. An ceph_ll_getattr() operation returns no error on this
> resource
> > > handle but the amount of hard-links equals to zero in returned
> stat
> > > structure.
> > >
> > > There is no method for listing extended attributes (e.g.
> > > ceph_ll_listxattr()) and to lookup a root resource handle (e.g.
> > > ceph_ll_lookup_root() - it was mentioned in my previous letter).
> > >
> > > If you try to fetch an extended attribute value by calling
> > > ceph_ll_getxattr() after setting in using ceph_ll_setxattr() you
> will
> > > receive a ENODATA error. ceph_ll_removexattr() does not return
> ENODATA
> > > when trying to remove non-existent extended attribute.
> > >
> > > So at the moment we have made a draft list of key requirements to
> the
> > > open-by-handle CephFS API and created an API header prototype -
> look
> > > at the attached file, please. What do you think about it?
> > >
> > > P.S. Generally speaking I think we can provide you with the
> patch,
> > > which fixes these issues, if you need. But mostly there will be
> only
> > > workarounds, cause, from my point of view a little reengineering
> is
> > > needed - see attached document.
> > >
> > > Best regards,
> > > Ilya
> > >
> > > ________________________________________
> > > ??: Matt W. Benjamin [matt@linuxbox.com]
> > > ??????????: 4 ???? 2013 ?.17:10
> > > To: Ilya Storozhilov
> > > Cc: ceph-devel@vger.kernel.org
> > > ????: Re: libcephfs: Open-By-Handle API question
> > >
> > > Hi Ilya,
> > >
> > > The changes on this branch originated in our Ganesha NFS driver
> for
> > > Ceph, so I'm not sure where the gap is, if any.
> > >
> > > I'll send an update to the list when we've finish re-integrating
> > > against
> > > the libcephfs-wip merge branch.
> > >
> > > Matt
> > >
> > > ----- "Ilya Storozhilov" <Ilya_Storozhilov@epam.com> wrote:
> > >
> > > > Hi Ceph developers,
> > > >
> > > > in order to represent NFS-frontend to CephFS data storage we
> are
> > > > trying to use innovative Open-By-Handle API from
> > > > 'src/include/cephfs/libcephfs.h' file, which is of
> 'wip-libcephfs'
> > > > branch at the moment. API looks quite consistent and useful but
> we
> > > > couldn't find a method to get a pointer to root inode of the
> mounted
> > > > Ceph filesystem.
> > > >
> > > > At the moment we have found only one place, where it could be
> > > fetched
> > > > from: an 'Inode* root' member from the 'Client' class
> > > > ('src/client/Client.h') but it is in 'protected' section, so
> some
> > > hack
> > > > is needed (e.g. to introduce a Client's descendant, which is
> > > providing
> > > > a method to acces this protected member). Do you know, how to
> fetch
> > > a
> > > > pointer to the root inode of the mounted Ceph filesystem withou=
t
> any
> > > > hacking (using just an official CephFS API only)?
> > > >
> > > > Thank you and best wishes,
> > > > Ilya V. Storozhilov
> > > > EPAM Systems
> > > > Lead Software Engineer
> > > >
> > > > P.S. What do you think about to make 'Open-By-Handle' API to be
> a
> > > > primary and not low-level API to CephFS and to make POSIX-like
> API
> > > to
> > > > be just a helper addendum to it?--
> > > > To unsubscribe from this list: send the line "unsubscribe
> > > ceph-devel"
> > > > in
> > > > the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at
> http://vger.kernel.org/majordomo-info.html
> > >
> > > --
> > > Matt Benjamin
> > > The Linux Box
> > > 206 South Fifth Ave. Suite 150
> > > Ann Arbor, MI 48104
> > >
> > > http://linuxbox.com
> > >
> > > tel. 734-761-4689
> > > fax. 734-769-8938
> > > cel. 734-216-5309
> >=20
> > --
> > Matt Benjamin
> > The Linux Box
> > 206 South Fifth Ave. Suite 150
> > Ann Arbor, MI 48104
> >=20
> > http://linuxbox.com
> >=20
> > tel. 734-761-4689
> > fax. 734-769-8938
> > cel. 734-216-5309
> >=20
> >

--=20
Matt Benjamin
The Linux Box
206 South Fifth Ave. Suite 150
Ann Arbor, MI  48104

http://linuxbox.com

tel.  734-761-4689=20
fax.  734-769-8938=20
cel.  734-216-5309=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
