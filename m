From: Sage Weil <sage@newdream.net>
Subject: Re: Consistency vs efficiency
Date: Mon, 25 Jul 2011 21:12:36 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1107252109130.25672@cobra.newdream.net>
References: <CAJD3hpW_WjumjD1P1bOhwXWPZieQxyay0HOCH8AFpXfQCT4HMg@mail.gmail.com>
 <Pine.LNX.4.64.1107210944550.5868@cobra.newdream.net>
 <CAJD3hpUw_AW-w3pK-GUSHY92U9=SvL5xdtMqC4rUUK+fnnO6mw@mail.gmail.com>
 <Pine.LNX.4.64.1107211047280.5868@cobra.newdream.net>
 <CAJD3hpW3JLB+VH3Kg5JouSoDG0-fpXO-g=kMBJPx_1bWDgauNQ@mail.gmail.com>
 <Pine.LNX.4.64.1107222049100.30052@cobra.newdream.net>
 <CAJD3hpW6o9snd1UiLBLEewAxmKz3xi2Rer4E7X6m6wbwPV=byA@mail.gmail.com>
 <Pine.LNX.4.64.1107231455180.15589@cobra.newdream.net>
 <CAJD3hpWrEdjjM2ua2jOy7DSbyOnVhNAM1uZz+7N2sbDsMxZavg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-283702396-1311653556=:25672"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36121 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717Ab1GZEIq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Jul 2011 00:08:46 -0400
In-Reply-To: <CAJD3hpWrEdjjM2ua2jOy7DSbyOnVhNAM1uZz+7N2sbDsMxZavg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jojy Varghese <jojy.varghese@gmail.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-283702396-1311653556=:25672
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 25 Jul 2011, Jojy Varghese wrote:
> What i observe is that after a mkdir, the inode CAPS loses the
> lease(FILE_SHARED). I would have thought that the owing client should
> have a FILE_EXCL on the files/dirs it creates.
>=20
> Since it doesnt have a lease, the dentry(after splicing) is not cached.

Can you describe the specific sequence of operations you're doing?  I'm=20
not seeing this behavior.  I see

$ mkdir foo
=09client->mds lookup #1/foo
=09client->mds mkdir #1/foo
$ mkdir foo/a
=09client->mds lookup #100000000/a
=09client->mds mkdir #100000000/a

with no repeated lookup on foo.

sage


>=20
> thanks
> Jojy
>=20
> On Sat, Jul 23, 2011 at 2:56 PM, Sage Weil <sage@newdream.net> wrote:
> > On Fri, 22 Jul 2011, Jojy Varghese wrote:
> >> Not sure how it is designed to work but I assume that some kind of
> >> async RPC mechanism exists from the MDCs to the clients to update the
> >> CAP for a file from "exclusive" to "shared". This will allow the
> >> cached dentries to be pruned/dropped when another client updates the
> >> file.
> >
> > Right. =A0If the MDS needs to modify a dentry, it revoke any issued cli=
ent
> > leases before granting the write/exclusive lock to process the request.
> >
> > sage
> >
> >>
> >> -Jojy
> >>
> >> On Fri, Jul 22, 2011 at 8:51 PM, Sage Weil <sage@newdream.net> wrote:
> >> > On Fri, 22 Jul 2011, Jojy Varghese wrote:
> >> >> Sage would the latest patches fix the lookup issue?
> >> >
> >> > No, the blocker there is the '[PATCH] vfs: add d_prune dentry operat=
ion'
> >> > email on Jul 8 to linux-fsdevel and lkml. =A0Once this set goes in (=
and
> >> > cleans up a bunch of stuff Al found in a code audit last weekend) I'=
ll be
> >> > bugging him about it again.
> >> >
> >> > sage
> >> >
> >> >
> >> >
> >> >>
> >> >> On Thu, Jul 21, 2011 at 10:55 AM, Sage Weil <sage@newdream.net> wro=
te:
> >> >> > On Thu, 21 Jul 2011, Jojy Varghese wrote:
> >> >> >> Thanks for the response Sage. We are using 2.6.39 kernel and in =
the
> >> >> >> "ceph_lookup" method, i see that there is a shortcut for decidin=
g
> >> >> >> ENOENT but after the MDS lookup, i dont see a d_add. I am sure i=
 am
> >> >> >> missing something here.
> >> >> >
> >> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dout(" dir %p comp=
lete, -ENOENT\n", dir);
> >> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0d_add(dentry, NULL=
);
> >> >> >
> >> >> > ...but that is only for the negative lookup in a directory with t=
he
> >> >> > 'complete' flag set. =A0And it's never set currently because we d=
on't have
> >> >> > d_prune yet (and the old use of d_release was racy). =A0So ignore=
 this part
> >> >> > for now!
> >> >> >
> >> >> > You have an existing, unchanging, directory that you're seeing re=
peated
> >> >> > lookups on, right? =A0Like the top-level directory in the heirarc=
hy you're
> >> >> > copying? =A0And the client is doing repeated lookups on the same =
name?
> >> >> >
> >> >> > The way to debug this is probably to start with the messages pass=
ing to
> >> >> > the MDS and verifying that lookups are duplicated. =A0Then enable=
 the
> >> >> > logging on the kernel client and see why the client isn't uses le=
ases or
> >> >> > the FILE_SHARED cap to avoid them. =A0We can help you through tha=
t on #ceph
> >> >> > if you like.
> >> >> >
> >> >> > sage
> >> >> >
> >> >> >
> >> >> >>
> >> >> >> thanks again
> >> >> >> Jojy
> >> >> >>
> >> >> >> On Thu, Jul 21, 2011 at 9:49 AM, Sage Weil <sage@newdream.net> w=
rote:
> >> >> >> > On Thu, 21 Jul 2011, Jojy Varghese wrote:
> >> >> >> >> Hi
> >> >> >> >> =A0 I just started looking at the ceph code in kernel and had=
 a question
> >> >> >> >> about performance considerations for lookup operations. I not=
iced that
> >> >> >> >> for every operation (say copying a directory), the root dentr=
y is
> >> >> >> >> "looked" up multiple times and since they all go to MDS for t=
he actual
> >> >> >> >> lookup operation, it effects the performance. I am sure consi=
stency is
> >> >> >> >> the winner here. Is there any plan to improve this, maybe by =
having
> >> >> >> >> MDS push the capability down to the clients when the dentry i=
s
> >> >> >> >> updated. So say from CAP_EXCL to CAP_SHARED when the dentry i=
s
> >> >> >> >> modified. This was the client node can cache the lookup opera=
tion and
> >> >> >> >> does not have to make a round trip to the MDS.
> >> >> >> >
> >> >> >> > In general, the MDS has two ways of keeping a client's cached =
dentry
> >> >> >> > consistent:
> >> >> >> >
> >> >> >> > =A0- it can issue the FILE_SHARED capability bit on the parent=
 directory,
> >> >> >> > which means the entire directory is static and the client can =
cache
> >> >> >> > dentry.
> >> >> >> > =A0- if it can't do that, it will issue a per-dentry lease
> >> >> >> >
> >> >> >> > There is an additional 'complete' bit that is used to indicate=
 on the
> >> >> >> > client that it has the _entire_ directory in cache. =A0If set,=
 it can do
> >> >> >> > negative lookups and readdir without hitting the MDS. =A0That'=
s currently
> >> >> >> > broken, pending the addition of a d_prune dentry_operation (se=
e
> >> >> >> > linux-fsdevel email from July 8).
> >> >> >> >
> >> >> >> > Anyway, long story short, if you're seeing repeated lookups on=
 a dentry
> >> >> >> > that isn't changing, something is broken. =A0Can you describe =
the workload
> >> >> >> > in more detail? =A0Which versions of the client and mds are yo=
u running?
> >> >> >> >
> >> >> >> > sage
> >> >> >> >
> >> >> >> >
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
>=20
>=20
--557981400-283702396-1311653556=:25672--
