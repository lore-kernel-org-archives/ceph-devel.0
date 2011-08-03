From: Sage Weil <sage@newdream.net>
Subject: Re: Consistency vs efficiency
Date: Wed, 3 Aug 2011 09:45:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1108030941380.20062@cobra.newdream.net>
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
 <CAJD3hpV0dLivWAhY_p7DeWS8xFTaziK6mnSBCaoGo_dJvi8SAA@mail.gmail.com>
 <Pine.LNX.4.64.1108012026570.21689@cobra.newdream.net>
 <CAJD3hpXmM0i0zNVoWo3xS-v2rTgu3sD63Red8dMX=FzP_JZP7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1195898124-1312389900=:20062"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46244 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754249Ab1HCQkv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Aug 2011 12:40:51 -0400
In-Reply-To: <CAJD3hpXmM0i0zNVoWo3xS-v2rTgu3sD63Red8dMX=FzP_JZP7w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jojy Varghese <jojy.varghese@gmail.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1195898124-1312389900=:20062
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

It looks like you're running pretty old version of the client AND server. =
=20
I'm 90% sure this was fixed by 5dc09dd6b81c622960f628acdabda9eac8af1ceb on=
=20
the server and/or 2f90b852e3ae73889d7f6de6ecf429b9b6a6b103 on the kernel=20
side will fix this.  Running a new versin of either one should fix this,=20
but I'd recommend running a current version of both!

sage


On Tue, 2 Aug 2011, Jojy Varghese wrote:

> Updated the bug.
>=20
> On Mon, Aug 1, 2011 at 8:31 PM, Sage Weil <sage@newdream.net> wrote:
> > On Tue, 26 Jul 2011, Jojy Varghese wrote:
> >> Sage
> >> =A0 =A0Attached is the dmesg outputs after an scp of three level
> >> directory. Here is how the directory tree looks like:
> >>
> >>
> >> testscpdirB/
> >> =FF=FF=FF=FF=FF=FF level1
> >> =A0 =A0 =FF=FF=FF=FF=FF=FF l1f1
> >> =A0 =A0 =FF=FF=FF=FF=FF=FF l1f2
> >> =A0 =A0 =FF=FF=FF=FF=FF=FF l1f3
> >> =A0 =A0 =FF=FF=FF=FF=FF=FF level2
> >> =A0 =A0 =A0 =A0 =FF=FF=FF=FF=FF=FF l2f1
> >> =A0 =A0 =A0 =A0 =FF=FF=FF=FF=FF=FF l2f2
> >> =A0 =A0 =A0 =A0 =FF=FF=FF=FF=FF=FF l2f3
> >> =A0 =A0 =A0 =A0 =FF=FF=FF=FF=FF=FF l2f4
> >> =A0 =A0 =A0 =A0 =FF=FF=FF=FF=FF=FF level3
> >> =A0 =A0 =A0 =A0 =A0 =A0 =FF=FF=FF=FF=FF=FF l3f1
> >>
> >> "scp_c_kernel.log" has one more level of detail in the log
> >> (ceph_fill_trace) and I changed the top level directory name. You will
> >> observe that the top level directory has "have_lease" false.
> >>
> >> As you will see in the log, the top level dentry is looked up multiple=
 times.
> >
> > Hmm, yep, that is strange! =A0 Looks like a bug, although it may be one=
 we
> > already fixed in the last kernel. =A0Can you confirm which version of t=
he
> > kernel client and server side you are running?
> >
> > Also, can you do it one more time with everything in inode.c and caps.c
> > enabled (or just the scripts/kcon_most.sh from ceph.git), and also the =
mds
> > log (debug mds =3D 20, debug ms =3D 1)? =A0That will have everything I =
need.
> >
> > Opened ticket #1350 to track this.
> >
> > Thanks!
> > sage
> >
> >
> >>
> >>
> >> thx,
> >> Jojy
> >>
> >>
> >>
> >> On Tue, Jul 26, 2011 at 10:56 AM, Sage Weil <sage@newdream.net> wrote:
> >> > On Tue, 26 Jul 2011, Jojy Varghese wrote:
> >> >> Sage
> >> >> =A0I tried the simple use case of mkdir on the ceph mounted dir but
> >> >> still see the issue. So i am wondering if our setup has anything to=
 do
> >> >> with it (although ideally it should not). Anything i should be look=
ing
> >> >> at given this behavior?'
> >> >
> >> > Can you capture the mds and kernel logs for the simple case?
> >> >
> >> > debug mds =3D 20
> >> > debug ms =3D 1
> >> >
> >> > and for the kernel side run ceph.git's src/scripts/kcon_most.sh (or
> >> > similar)
> >> >
> >> > Thanks!
> >> > sage
> >> >
> >> >>
> >> >>
> >> >>
> >> >> thx
> >> >> Jojy
> >> >>
> >> >> On Mon, Jul 25, 2011 at 9:12 PM, Sage Weil <sage@newdream.net> wrot=
e:
> >> >> > On Mon, 25 Jul 2011, Jojy Varghese wrote:
> >> >> >> What i observe is that after a mkdir, the inode CAPS loses the
> >> >> >> lease(FILE_SHARED). I would have thought that the owing client s=
hould
> >> >> >> have a FILE_EXCL on the files/dirs it creates.
> >> >> >>
> >> >> >> Since it doesnt have a lease, the dentry(after splicing) is not =
cached.
> >> >> >
> >> >> > Can you describe the specific sequence of operations you're doing=
? =A0I'm
> >> >> > not seeing this behavior. =A0I see
> >> >> >
> >> >> > $ mkdir foo
> >> >> > =A0 =A0 =A0 =A0client->mds lookup #1/foo
> >> >> > =A0 =A0 =A0 =A0client->mds mkdir #1/foo
> >> >> > $ mkdir foo/a
> >> >> > =A0 =A0 =A0 =A0client->mds lookup #100000000/a
> >> >> > =A0 =A0 =A0 =A0client->mds mkdir #100000000/a
> >> >> >
> >> >> > with no repeated lookup on foo.
> >> >> >
> >> >> > sage
> >> >> >
> >> >> >
> >> >> >>
> >> >> >> thanks
> >> >> >> Jojy
> >> >> >>
> >> >> >> On Sat, Jul 23, 2011 at 2:56 PM, Sage Weil <sage@newdream.net> w=
rote:
> >> >> >> > On Fri, 22 Jul 2011, Jojy Varghese wrote:
> >> >> >> >> Not sure how it is designed to work but I assume that some ki=
nd of
> >> >> >> >> async RPC mechanism exists from the MDCs to the clients to up=
date the
> >> >> >> >> CAP for a file from "exclusive" to "shared". This will allow =
the
> >> >> >> >> cached dentries to be pruned/dropped when another client upda=
tes the
> >> >> >> >> file.
> >> >> >> >
> >> >> >> > Right. =A0If the MDS needs to modify a dentry, it revoke any i=
ssued client
> >> >> >> > leases before granting the write/exclusive lock to process the=
 request.
> >> >> >> >
> >> >> >> > sage
> >> >> >> >
> >> >> >> >>
> >> >> >> >> -Jojy
> >> >> >> >>
> >> >> >> >> On Fri, Jul 22, 2011 at 8:51 PM, Sage Weil <sage@newdream.net=
> wrote:
> >> >> >> >> > On Fri, 22 Jul 2011, Jojy Varghese wrote:
> >> >> >> >> >> Sage would the latest patches fix the lookup issue?
> >> >> >> >> >
> >> >> >> >> > No, the blocker there is the '[PATCH] vfs: add d_prune dent=
ry operation'
> >> >> >> >> > email on Jul 8 to linux-fsdevel and lkml. =A0Once this set =
goes in (and
> >> >> >> >> > cleans up a bunch of stuff Al found in a code audit last we=
ekend) I'll be
> >> >> >> >> > bugging him about it again.
> >> >> >> >> >
> >> >> >> >> > sage
> >> >> >> >> >
> >> >> >> >> >
> >> >> >> >> >
> >> >> >> >> >>
> >> >> >> >> >> On Thu, Jul 21, 2011 at 10:55 AM, Sage Weil <sage@newdream=
=2Enet> wrote:
> >> >> >> >> >> > On Thu, 21 Jul 2011, Jojy Varghese wrote:
> >> >> >> >> >> >> Thanks for the response Sage. We are using 2.6.39 kerne=
l and in the
> >> >> >> >> >> >> "ceph_lookup" method, i see that there is a shortcut fo=
r deciding
> >> >> >> >> >> >> ENOENT but after the MDS lookup, i dont see a d_add. I =
am sure i am
> >> >> >> >> >> >> missing something here.
> >> >> >> >> >> >
> >> >> >> >> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dout(" di=
r %p complete, -ENOENT\n", dir);
> >> >> >> >> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0d_add(den=
try, NULL);
> >> >> >> >> >> >
> >> >> >> >> >> > ...but that is only for the negative lookup in a directo=
ry with the
> >> >> >> >> >> > 'complete' flag set. =A0And it's never set currently bec=
ause we don't have
> >> >> >> >> >> > d_prune yet (and the old use of d_release was racy). =A0=
So ignore this part
> >> >> >> >> >> > for now!
> >> >> >> >> >> >
> >> >> >> >> >> > You have an existing, unchanging, directory that you're =
seeing repeated
> >> >> >> >> >> > lookups on, right? =A0Like the top-level directory in th=
e heirarchy you're
> >> >> >> >> >> > copying? =A0And the client is doing repeated lookups on =
the same name?
> >> >> >> >> >> >
> >> >> >> >> >> > The way to debug this is probably to start with the mess=
ages passing to
> >> >> >> >> >> > the MDS and verifying that lookups are duplicated. =A0Th=
en enable the
> >> >> >> >> >> > logging on the kernel client and see why the client isn'=
t uses leases or
> >> >> >> >> >> > the FILE_SHARED cap to avoid them. =A0We can help you th=
rough that on #ceph
> >> >> >> >> >> > if you like.
> >> >> >> >> >> >
> >> >> >> >> >> > sage
> >> >> >> >> >> >
> >> >> >> >> >> >
> >> >> >> >> >> >>
> >> >> >> >> >> >> thanks again
> >> >> >> >> >> >> Jojy
> >> >> >> >> >> >>
> >> >> >> >> >> >> On Thu, Jul 21, 2011 at 9:49 AM, Sage Weil <sage@newdre=
am.net> wrote:
> >> >> >> >> >> >> > On Thu, 21 Jul 2011, Jojy Varghese wrote:
> >> >> >> >> >> >> >> Hi
> >> >> >> >> >> >> >> =A0 I just started looking at the ceph code in kerne=
l and had a question
> >> >> >> >> >> >> >> about performance considerations for lookup operatio=
ns. I noticed that
> >> >> >> >> >> >> >> for every operation (say copying a directory), the r=
oot dentry is
> >> >> >> >> >> >> >> "looked" up multiple times and since they all go to =
MDS for the actual
> >> >> >> >> >> >> >> lookup operation, it effects the performance. I am s=
ure consistency is
> >> >> >> >> >> >> >> the winner here. Is there any plan to improve this, =
maybe by having
> >> >> >> >> >> >> >> MDS push the capability down to the clients when the=
 dentry is
> >> >> >> >> >> >> >> updated. So say from CAP_EXCL to CAP_SHARED when the=
 dentry is
> >> >> >> >> >> >> >> modified. This was the client node can cache the loo=
kup operation and
> >> >> >> >> >> >> >> does not have to make a round trip to the MDS.
> >> >> >> >> >> >> >
> >> >> >> >> >> >> > In general, the MDS has two ways of keeping a client'=
s cached dentry
> >> >> >> >> >> >> > consistent:
> >> >> >> >> >> >> >
> >> >> >> >> >> >> > =A0- it can issue the FILE_SHARED capability bit on t=
he parent directory,
> >> >> >> >> >> >> > which means the entire directory is static and the cl=
ient can cache
> >> >> >> >> >> >> > dentry.
> >> >> >> >> >> >> > =A0- if it can't do that, it will issue a per-dentry =
lease
> >> >> >> >> >> >> >
> >> >> >> >> >> >> > There is an additional 'complete' bit that is used to=
 indicate on the
> >> >> >> >> >> >> > client that it has the _entire_ directory in cache. =
=A0If set, it can do
> >> >> >> >> >> >> > negative lookups and readdir without hitting the MDS.=
 =A0That's currently
> >> >> >> >> >> >> > broken, pending the addition of a d_prune dentry_oper=
ation (see
> >> >> >> >> >> >> > linux-fsdevel email from July 8).
> >> >> >> >> >> >> >
> >> >> >> >> >> >> > Anyway, long story short, if you're seeing repeated l=
ookups on a dentry
> >> >> >> >> >> >> > that isn't changing, something is broken. =A0Can you =
describe the workload
> >> >> >> >> >> >> > in more detail? =A0Which versions of the client and m=
ds are you running?
> >> >> >> >> >> >> >
> >> >> >> >> >> >> > sage
> >> >> >> >> >> >> >
> >> >> >> >> >> >> >
> >> >> >> >> >> >> --
> >> >> >> >> >> >> To unsubscribe from this list: send the line "unsubscri=
be ceph-devel" in
> >> >> >> >> >> >> the body of a message to majordomo@vger.kernel.org
> >> >> >> >> >> >> More majordomo info at =A0http://vger.kernel.org/majord=
omo-info.html
> >> >> >> >> >> >>
> >> >> >> >> >> >>
> >> >> >> >> >>
> >> >> >> >> >>
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
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-1195898124-1312389900=:20062--
