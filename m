From: Sage Weil <sage@newdream.net>
Subject: Re: Consistency vs efficiency
Date: Tue, 26 Jul 2011 10:56:40 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1107261055280.2373@cobra.newdream.net>
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
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-456717804-1311703000=:2373"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42360 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426Ab1GZRwt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Jul 2011 13:52:49 -0400
In-Reply-To: <CAJD3hpX_9=1CQ0Lbgsbq9HQR_8p1FYeJ7KQfAGsi849yGr-2vg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jojy Varghese <jojy.varghese@gmail.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-456717804-1311703000=:2373
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 26 Jul 2011, Jojy Varghese wrote:
> Sage
>  I tried the simple use case of mkdir on the ceph mounted dir but
> still see the issue. So i am wondering if our setup has anything to do
> with it (although ideally it should not). Anything i should be looking
> at given this behavior?'

Can you capture the mds and kernel logs for the simple case?

debug mds =3D 20
debug ms =3D 1

and for the kernel side run ceph.git's src/scripts/kcon_most.sh (or=20
similar)

Thanks!
sage

>=20
>=20
>=20
> thx
> Jojy
>=20
> On Mon, Jul 25, 2011 at 9:12 PM, Sage Weil <sage@newdream.net> wrote:
> > On Mon, 25 Jul 2011, Jojy Varghese wrote:
> >> What i observe is that after a mkdir, the inode CAPS loses the
> >> lease(FILE_SHARED). I would have thought that the owing client should
> >> have a FILE_EXCL on the files/dirs it creates.
> >>
> >> Since it doesnt have a lease, the dentry(after splicing) is not cached=
=2E
> >
> > Can you describe the specific sequence of operations you're doing? =A0I=
'm
> > not seeing this behavior. =A0I see
> >
> > $ mkdir foo
> > =A0 =A0 =A0 =A0client->mds lookup #1/foo
> > =A0 =A0 =A0 =A0client->mds mkdir #1/foo
> > $ mkdir foo/a
> > =A0 =A0 =A0 =A0client->mds lookup #100000000/a
> > =A0 =A0 =A0 =A0client->mds mkdir #100000000/a
> >
> > with no repeated lookup on foo.
> >
> > sage
> >
> >
> >>
> >> thanks
> >> Jojy
> >>
> >> On Sat, Jul 23, 2011 at 2:56 PM, Sage Weil <sage@newdream.net> wrote:
> >> > On Fri, 22 Jul 2011, Jojy Varghese wrote:
> >> >> Not sure how it is designed to work but I assume that some kind of
> >> >> async RPC mechanism exists from the MDCs to the clients to update t=
he
> >> >> CAP for a file from "exclusive" to "shared". This will allow the
> >> >> cached dentries to be pruned/dropped when another client updates th=
e
> >> >> file.
> >> >
> >> > Right. =A0If the MDS needs to modify a dentry, it revoke any issued =
client
> >> > leases before granting the write/exclusive lock to process the reque=
st.
> >> >
> >> > sage
> >> >
> >> >>
> >> >> -Jojy
> >> >>
> >> >> On Fri, Jul 22, 2011 at 8:51 PM, Sage Weil <sage@newdream.net> wrot=
e:
> >> >> > On Fri, 22 Jul 2011, Jojy Varghese wrote:
> >> >> >> Sage would the latest patches fix the lookup issue?
> >> >> >
> >> >> > No, the blocker there is the '[PATCH] vfs: add d_prune dentry ope=
ration'
> >> >> > email on Jul 8 to linux-fsdevel and lkml. =A0Once this set goes i=
n (and
> >> >> > cleans up a bunch of stuff Al found in a code audit last weekend)=
 I'll be
> >> >> > bugging him about it again.
> >> >> >
> >> >> > sage
> >> >> >
> >> >> >
> >> >> >
> >> >> >>
> >> >> >> On Thu, Jul 21, 2011 at 10:55 AM, Sage Weil <sage@newdream.net> =
wrote:
> >> >> >> > On Thu, 21 Jul 2011, Jojy Varghese wrote:
> >> >> >> >> Thanks for the response Sage. We are using 2.6.39 kernel and =
in the
> >> >> >> >> "ceph_lookup" method, i see that there is a shortcut for deci=
ding
> >> >> >> >> ENOENT but after the MDS lookup, i dont see a d_add. I am sur=
e i am
> >> >> >> >> missing something here.
> >> >> >> >
> >> >> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dout(" dir %p c=
omplete, -ENOENT\n", dir);
> >> >> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0d_add(dentry, N=
ULL);
> >> >> >> >
> >> >> >> > ...but that is only for the negative lookup in a directory wit=
h the
> >> >> >> > 'complete' flag set. =A0And it's never set currently because w=
e don't have
> >> >> >> > d_prune yet (and the old use of d_release was racy). =A0So ign=
ore this part
> >> >> >> > for now!
> >> >> >> >
> >> >> >> > You have an existing, unchanging, directory that you're seeing=
 repeated
> >> >> >> > lookups on, right? =A0Like the top-level directory in the heir=
archy you're
> >> >> >> > copying? =A0And the client is doing repeated lookups on the sa=
me name?
> >> >> >> >
> >> >> >> > The way to debug this is probably to start with the messages p=
assing to
> >> >> >> > the MDS and verifying that lookups are duplicated. =A0Then ena=
ble the
> >> >> >> > logging on the kernel client and see why the client isn't uses=
 leases or
> >> >> >> > the FILE_SHARED cap to avoid them. =A0We can help you through =
that on #ceph
> >> >> >> > if you like.
> >> >> >> >
> >> >> >> > sage
> >> >> >> >
> >> >> >> >
> >> >> >> >>
> >> >> >> >> thanks again
> >> >> >> >> Jojy
> >> >> >> >>
> >> >> >> >> On Thu, Jul 21, 2011 at 9:49 AM, Sage Weil <sage@newdream.net=
> wrote:
> >> >> >> >> > On Thu, 21 Jul 2011, Jojy Varghese wrote:
> >> >> >> >> >> Hi
> >> >> >> >> >> =A0 I just started looking at the ceph code in kernel and =
had a question
> >> >> >> >> >> about performance considerations for lookup operations. I =
noticed that
> >> >> >> >> >> for every operation (say copying a directory), the root de=
ntry is
> >> >> >> >> >> "looked" up multiple times and since they all go to MDS fo=
r the actual
> >> >> >> >> >> lookup operation, it effects the performance. I am sure co=
nsistency is
> >> >> >> >> >> the winner here. Is there any plan to improve this, maybe =
by having
> >> >> >> >> >> MDS push the capability down to the clients when the dentr=
y is
> >> >> >> >> >> updated. So say from CAP_EXCL to CAP_SHARED when the dentr=
y is
> >> >> >> >> >> modified. This was the client node can cache the lookup op=
eration and
> >> >> >> >> >> does not have to make a round trip to the MDS.
> >> >> >> >> >
> >> >> >> >> > In general, the MDS has two ways of keeping a client's cach=
ed dentry
> >> >> >> >> > consistent:
> >> >> >> >> >
> >> >> >> >> > =A0- it can issue the FILE_SHARED capability bit on the par=
ent directory,
> >> >> >> >> > which means the entire directory is static and the client c=
an cache
> >> >> >> >> > dentry.
> >> >> >> >> > =A0- if it can't do that, it will issue a per-dentry lease
> >> >> >> >> >
> >> >> >> >> > There is an additional 'complete' bit that is used to indic=
ate on the
> >> >> >> >> > client that it has the _entire_ directory in cache. =A0If s=
et, it can do
> >> >> >> >> > negative lookups and readdir without hitting the MDS. =A0Th=
at's currently
> >> >> >> >> > broken, pending the addition of a d_prune dentry_operation =
(see
> >> >> >> >> > linux-fsdevel email from July 8).
> >> >> >> >> >
> >> >> >> >> > Anyway, long story short, if you're seeing repeated lookups=
 on a dentry
> >> >> >> >> > that isn't changing, something is broken. =A0Can you descri=
be the workload
> >> >> >> >> > in more detail? =A0Which versions of the client and mds are=
 you running?
> >> >> >> >> >
> >> >> >> >> > sage
> >> >> >> >> >
> >> >> >> >> >
> >> >> >> >> --
> >> >> >> >> To unsubscribe from this list: send the line "unsubscribe cep=
h-devel" in
> >> >> >> >> the body of a message to majordomo@vger.kernel.org
> >> >> >> >> More majordomo info at =A0http://vger.kernel.org/majordomo-in=
fo.html
> >> >> >> >>
> >> >> >> >>
> >> >> >>
> >> >> >>
> >> >> --
> >> >> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
> >> >> the body of a message to majordomo@vger.kernel.org
> >> >> More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
> >> >>
> >> >>
> >>
> >>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-456717804-1311703000=:2373--
