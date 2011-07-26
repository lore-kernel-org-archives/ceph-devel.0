From: Sage Weil <sage@newdream.net>
Subject: Re: Consistency vs efficiency
Date: Tue, 26 Jul 2011 13:21:40 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1107261316220.2373@cobra.newdream.net>
References: <CAJD3hpW_WjumjD1P1bOhwXWPZieQxyay0HOCH8AFpXfQCT4HMg@mail.gmail.com>
 <Pine.LNX.4.64.1107210944550.5868@cobra.newdream.net>
 <CAJD3hpUw_AW-w3pK-GUSHY92U9=SvL5xdtMqC4rUUK+fnnO6mw@mail.gmail.com>
 <Pine.LNX.4.64.1107211047280.5868@cobra.newdream.net>
 <CAJD3hpW3JLB+VH3Kg5JouSoDG0-fpXO-g=kMBJPx_1bWDgauNQ@mail.gmail.com>
 <Pine.LNX.4.64.1107222049100.30052@cobra.newdream.net>
 <CAJD3hpW6o9snd1UiLBLEewAxmKz3xi2Rer4E7X6m6wbwPV=byA@mail.gmail.com>
 <Pine.LNX.4.64.1107231455180.15589@cobra.newdream.net>
 <CAJD3hpWrEdjjM2ua2jOy7DSbyOnVhNAM1uZz+7N2sbDsMxZavg@mail.gmail.com>
 <Pine.LNX.4.64.1107252109130.25672@cobra.newdream.net>
 <CAJD3hpX_9=1CQ0Lbgsbq9HQR_8p1FYeJ7KQfAGsi849yGr-2vg@mail.gmail.com>
 <Pine.LNX.4.64.1107261055280.2373@cobra.newdream.net>
 <CAJD3hpU6_PMT1kobijdEg6UdT+PtyBq=i1bCHwZsPYk1_UnzEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1356234843-1311711700=:2373"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51105 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752695Ab1GZURs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Jul 2011 16:17:48 -0400
In-Reply-To: <CAJD3hpU6_PMT1kobijdEg6UdT+PtyBq=i1bCHwZsPYk1_UnzEQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jojy Varghese <jojy.varghese@gmail.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1356234843-1311711700=:2373
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 26 Jul 2011, Jojy Varghese wrote:
> Sage,
> Will get back to you with the logs.
>=20
> Had another question about the implementation:
>=20
>=20
> Here is the piece of code that I am a bit confused about:
>=20
> In "fs/ceph/inode.c" ( function "ceph_fill_trace")
>=20
> =09=09=09/* do we have a lease on the whole dir? */
> =09=09have_dir_cap =3D
> =09=09=09(le32_to_cpu(rinfo->diri.in->cap.caps) &
> =09=09=09 CEPH_CAP_FILE_SHARED);
>=20
> =09=09/* do we have a dn lease? */
> =09=09have_lease =3D have_dir_cap ||
> =09=09=09(le16_to_cpu(rinfo->dlease->mask) &
> =09=09=09 CEPH_LOCK_DN);
>=20
> So we check the capability "CEPH_CAP_FILE_SHARED" to make sure the
> entire directory has the lease.  "have_lease" is then used to
> determine if the dentry can be cached.

Right.
=20
> I would have thought that it should be "CEPH_CAP_FILE_EXCL" that
> should be used to determine if a dentry can be cached since it would
> mean that the client created the file and has "update" capabilities.

There are two cases we care about: FILE_SHARED and FILE_SHARED|FILE_EXCL. =
=20
In the former case, the tree is static, and all clients can cache the=20
dentry.  In the latter case, a single client is using the directory and=20
can still cache it.

The client doesn't make any namespace modifications locally, however;=20
those currently always go to the MDS.  In practical terms it means the=20
client doesn't have to release the caps to perform a conflicting operation=
=20
(i.e. relase FILE_EXCL on the directory to create a file within it).  (In=
=20
contrast, a client with just FILE_SHARED will release that along with the=
=20
create request to avoid an extra exchange for the mds to revoke it.)

BTW, there is a fix that was just pushed for 3.1 that may be affecting the=
=20
lease behavior, see commit b1c9396ee20a3b37804376ba23bd780068d0ccf7 on the=
=20
kernel side and 5dc09dd6b81c622960f628acdabda9eac8af1ceb on the server=20
side.  That might explain what you're seeing... I forgot about it earlier.

sage



>=20
> thanks
> -Jojy
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
> On Tue, Jul 26, 2011 at 10:56 AM, Sage Weil <sage@newdream.net> wrote:
> > On Tue, 26 Jul 2011, Jojy Varghese wrote:
> >> Sage
> >> =A0I tried the simple use case of mkdir on the ceph mounted dir but
> >> still see the issue. So i am wondering if our setup has anything to do
> >> with it (although ideally it should not). Anything i should be looking
> >> at given this behavior?'
> >
> > Can you capture the mds and kernel logs for the simple case?
> >
> > debug mds =3D 20
> > debug ms =3D 1
> >
> > and for the kernel side run ceph.git's src/scripts/kcon_most.sh (or
> > similar)
> >
> > Thanks!
> > sage
> >
> >>
> >>
> >>
> >> thx
> >> Jojy
> >>
> >> On Mon, Jul 25, 2011 at 9:12 PM, Sage Weil <sage@newdream.net> wrote:
> >> > On Mon, 25 Jul 2011, Jojy Varghese wrote:
> >> >> What i observe is that after a mkdir, the inode CAPS loses the
> >> >> lease(FILE_SHARED). I would have thought that the owing client shou=
ld
> >> >> have a FILE_EXCL on the files/dirs it creates.
> >> >>
> >> >> Since it doesnt have a lease, the dentry(after splicing) is not cac=
hed.
> >> >
> >> > Can you describe the specific sequence of operations you're doing? =
=A0I'm
> >> > not seeing this behavior. =A0I see
> >> >
> >> > $ mkdir foo
> >> > =A0 =A0 =A0 =A0client->mds lookup #1/foo
> >> > =A0 =A0 =A0 =A0client->mds mkdir #1/foo
> >> > $ mkdir foo/a
> >> > =A0 =A0 =A0 =A0client->mds lookup #100000000/a
> >> > =A0 =A0 =A0 =A0client->mds mkdir #100000000/a
> >> >
> >> > with no repeated lookup on foo.
> >> >
> >> > sage
> >> >
> >> >
> >> >>
> >> >> thanks
> >> >> Jojy
> >> >>
> >> >> On Sat, Jul 23, 2011 at 2:56 PM, Sage Weil <sage@newdream.net> wrot=
e:
> >> >> > On Fri, 22 Jul 2011, Jojy Varghese wrote:
> >> >> >> Not sure how it is designed to work but I assume that some kind =
of
> >> >> >> async RPC mechanism exists from the MDCs to the clients to updat=
e the
> >> >> >> CAP for a file from "exclusive" to "shared". This will allow the
> >> >> >> cached dentries to be pruned/dropped when another client updates=
 the
> >> >> >> file.
> >> >> >
> >> >> > Right. =A0If the MDS needs to modify a dentry, it revoke any issu=
ed client
> >> >> > leases before granting the write/exclusive lock to process the re=
quest.
> >> >> >
> >> >> > sage
> >> >> >
> >> >> >>
> >> >> >> -Jojy
> >> >> >>
> >> >> >> On Fri, Jul 22, 2011 at 8:51 PM, Sage Weil <sage@newdream.net> w=
rote:
> >> >> >> > On Fri, 22 Jul 2011, Jojy Varghese wrote:
> >> >> >> >> Sage would the latest patches fix the lookup issue?
> >> >> >> >
> >> >> >> > No, the blocker there is the '[PATCH] vfs: add d_prune dentry =
operation'
> >> >> >> > email on Jul 8 to linux-fsdevel and lkml. =A0Once this set goe=
s in (and
> >> >> >> > cleans up a bunch of stuff Al found in a code audit last weeke=
nd) I'll be
> >> >> >> > bugging him about it again.
> >> >> >> >
> >> >> >> > sage
> >> >> >> >
> >> >> >> >
> >> >> >> >
> >> >> >> >>
> >> >> >> >> On Thu, Jul 21, 2011 at 10:55 AM, Sage Weil <sage@newdream.ne=
t> wrote:
> >> >> >> >> > On Thu, 21 Jul 2011, Jojy Varghese wrote:
> >> >> >> >> >> Thanks for the response Sage. We are using 2.6.39 kernel a=
nd in the
> >> >> >> >> >> "ceph_lookup" method, i see that there is a shortcut for d=
eciding
> >> >> >> >> >> ENOENT but after the MDS lookup, i dont see a d_add. I am =
sure i am
> >> >> >> >> >> missing something here.
> >> >> >> >> >
> >> >> >> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dout(" dir %=
p complete, -ENOENT\n", dir);
> >> >> >> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0d_add(dentry=
, NULL);
> >> >> >> >> >
> >> >> >> >> > ...but that is only for the negative lookup in a directory =
with the
> >> >> >> >> > 'complete' flag set. =A0And it's never set currently becaus=
e we don't have
> >> >> >> >> > d_prune yet (and the old use of d_release was racy). =A0So =
ignore this part
> >> >> >> >> > for now!
> >> >> >> >> >
> >> >> >> >> > You have an existing, unchanging, directory that you're see=
ing repeated
> >> >> >> >> > lookups on, right? =A0Like the top-level directory in the h=
eirarchy you're
> >> >> >> >> > copying? =A0And the client is doing repeated lookups on the=
 same name?
> >> >> >> >> >
> >> >> >> >> > The way to debug this is probably to start with the message=
s passing to
> >> >> >> >> > the MDS and verifying that lookups are duplicated. =A0Then =
enable the
> >> >> >> >> > logging on the kernel client and see why the client isn't u=
ses leases or
> >> >> >> >> > the FILE_SHARED cap to avoid them. =A0We can help you throu=
gh that on #ceph
> >> >> >> >> > if you like.
> >> >> >> >> >
> >> >> >> >> > sage
> >> >> >> >> >
> >> >> >> >> >
> >> >> >> >> >>
> >> >> >> >> >> thanks again
> >> >> >> >> >> Jojy
> >> >> >> >> >>
> >> >> >> >> >> On Thu, Jul 21, 2011 at 9:49 AM, Sage Weil <sage@newdream.=
net> wrote:
> >> >> >> >> >> > On Thu, 21 Jul 2011, Jojy Varghese wrote:
> >> >> >> >> >> >> Hi
> >> >> >> >> >> >> =A0 I just started looking at the ceph code in kernel a=
nd had a question
> >> >> >> >> >> >> about performance considerations for lookup operations.=
 I noticed that
> >> >> >> >> >> >> for every operation (say copying a directory), the root=
 dentry is
> >> >> >> >> >> >> "looked" up multiple times and since they all go to MDS=
 for the actual
> >> >> >> >> >> >> lookup operation, it effects the performance. I am sure=
 consistency is
> >> >> >> >> >> >> the winner here. Is there any plan to improve this, may=
be by having
> >> >> >> >> >> >> MDS push the capability down to the clients when the de=
ntry is
> >> >> >> >> >> >> updated. So say from CAP_EXCL to CAP_SHARED when the de=
ntry is
> >> >> >> >> >> >> modified. This was the client node can cache the lookup=
 operation and
> >> >> >> >> >> >> does not have to make a round trip to the MDS.
> >> >> >> >> >> >
> >> >> >> >> >> > In general, the MDS has two ways of keeping a client's c=
ached dentry
> >> >> >> >> >> > consistent:
> >> >> >> >> >> >
> >> >> >> >> >> > =A0- it can issue the FILE_SHARED capability bit on the =
parent directory,
> >> >> >> >> >> > which means the entire directory is static and the clien=
t can cache
> >> >> >> >> >> > dentry.
> >> >> >> >> >> > =A0- if it can't do that, it will issue a per-dentry lea=
se
> >> >> >> >> >> >
> >> >> >> >> >> > There is an additional 'complete' bit that is used to in=
dicate on the
> >> >> >> >> >> > client that it has the _entire_ directory in cache. =A0I=
f set, it can do
> >> >> >> >> >> > negative lookups and readdir without hitting the MDS. =
=A0That's currently
> >> >> >> >> >> > broken, pending the addition of a d_prune dentry_operati=
on (see
> >> >> >> >> >> > linux-fsdevel email from July 8).
> >> >> >> >> >> >
> >> >> >> >> >> > Anyway, long story short, if you're seeing repeated look=
ups on a dentry
> >> >> >> >> >> > that isn't changing, something is broken. =A0Can you des=
cribe the workload
> >> >> >> >> >> > in more detail? =A0Which versions of the client and mds =
are you running?
> >> >> >> >> >> >
> >> >> >> >> >> > sage
> >> >> >> >> >> >
> >> >> >> >> >> >
> >> >> >> >> >> --
> >> >> >> >> >> To unsubscribe from this list: send the line "unsubscribe =
ceph-devel" in
> >> >> >> >> >> the body of a message to majordomo@vger.kernel.org
> >> >> >> >> >> More majordomo info at =A0http://vger.kernel.org/majordomo=
-info.html
> >> >> >> >> >>
> >> >> >> >> >>
> >> >> >> >>
> >> >> >> >>
> >> >> >> --
> >> >> >> To unsubscribe from this list: send the line "unsubscribe ceph-d=
evel" in
> >> >> >> the body of a message to majordomo@vger.kernel.org
> >> >> >> More majordomo info at =A0http://vger.kernel.org/majordomo-info.=
html
> >> >> >>
> >> >> >>
> >> >>
> >> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> >>
> >>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-1356234843-1311711700=:2373--
