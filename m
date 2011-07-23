From: Sage Weil <sage@newdream.net>
Subject: Re: Consistency vs efficiency
Date: Sat, 23 Jul 2011 14:56:32 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1107231455180.15589@cobra.newdream.net>
References: <CAJD3hpW_WjumjD1P1bOhwXWPZieQxyay0HOCH8AFpXfQCT4HMg@mail.gmail.com>
 <Pine.LNX.4.64.1107210944550.5868@cobra.newdream.net>
 <CAJD3hpUw_AW-w3pK-GUSHY92U9=SvL5xdtMqC4rUUK+fnnO6mw@mail.gmail.com>
 <Pine.LNX.4.64.1107211047280.5868@cobra.newdream.net>
 <CAJD3hpW3JLB+VH3Kg5JouSoDG0-fpXO-g=kMBJPx_1bWDgauNQ@mail.gmail.com>
 <Pine.LNX.4.64.1107222049100.30052@cobra.newdream.net>
 <CAJD3hpW6o9snd1UiLBLEewAxmKz3xi2Rer4E7X6m6wbwPV=byA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-481904298-1311458192=:15589"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46762 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751374Ab1GWVwr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 23 Jul 2011 17:52:47 -0400
In-Reply-To: <CAJD3hpW6o9snd1UiLBLEewAxmKz3xi2Rer4E7X6m6wbwPV=byA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jojy Varghese <jojy.varghese@gmail.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-481904298-1311458192=:15589
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 22 Jul 2011, Jojy Varghese wrote:
> Not sure how it is designed to work but I assume that some kind of
> async RPC mechanism exists from the MDCs to the clients to update the
> CAP for a file from "exclusive" to "shared". This will allow the
> cached dentries to be pruned/dropped when another client updates the
> file.

Right.  If the MDS needs to modify a dentry, it revoke any issued client=20
leases before granting the write/exclusive lock to process the request.

sage

>=20
> -Jojy
>=20
> On Fri, Jul 22, 2011 at 8:51 PM, Sage Weil <sage@newdream.net> wrote:
> > On Fri, 22 Jul 2011, Jojy Varghese wrote:
> >> Sage would the latest patches fix the lookup issue?
> >
> > No, the blocker there is the '[PATCH] vfs: add d_prune dentry operation=
'
> > email on Jul 8 to linux-fsdevel and lkml. =A0Once this set goes in (and
> > cleans up a bunch of stuff Al found in a code audit last weekend) I'll =
be
> > bugging him about it again.
> >
> > sage
> >
> >
> >
> >>
> >> On Thu, Jul 21, 2011 at 10:55 AM, Sage Weil <sage@newdream.net> wrote:
> >> > On Thu, 21 Jul 2011, Jojy Varghese wrote:
> >> >> Thanks for the response Sage. We are using 2.6.39 kernel and in the
> >> >> "ceph_lookup" method, i see that there is a shortcut for deciding
> >> >> ENOENT but after the MDS lookup, i dont see a d_add. I am sure i am
> >> >> missing something here.
> >> >
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dout(" dir %p complet=
e, -ENOENT\n", dir);
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0d_add(dentry, NULL);
> >> >
> >> > ...but that is only for the negative lookup in a directory with the
> >> > 'complete' flag set. =A0And it's never set currently because we don'=
t have
> >> > d_prune yet (and the old use of d_release was racy). =A0So ignore th=
is part
> >> > for now!
> >> >
> >> > You have an existing, unchanging, directory that you're seeing repea=
ted
> >> > lookups on, right? =A0Like the top-level directory in the heirarchy =
you're
> >> > copying? =A0And the client is doing repeated lookups on the same nam=
e?
> >> >
> >> > The way to debug this is probably to start with the messages passing=
 to
> >> > the MDS and verifying that lookups are duplicated. =A0Then enable th=
e
> >> > logging on the kernel client and see why the client isn't uses lease=
s or
> >> > the FILE_SHARED cap to avoid them. =A0We can help you through that o=
n #ceph
> >> > if you like.
> >> >
> >> > sage
> >> >
> >> >
> >> >>
> >> >> thanks again
> >> >> Jojy
> >> >>
> >> >> On Thu, Jul 21, 2011 at 9:49 AM, Sage Weil <sage@newdream.net> wrot=
e:
> >> >> > On Thu, 21 Jul 2011, Jojy Varghese wrote:
> >> >> >> Hi
> >> >> >> =A0 I just started looking at the ceph code in kernel and had a =
question
> >> >> >> about performance considerations for lookup operations. I notice=
d that
> >> >> >> for every operation (say copying a directory), the root dentry i=
s
> >> >> >> "looked" up multiple times and since they all go to MDS for the =
actual
> >> >> >> lookup operation, it effects the performance. I am sure consiste=
ncy is
> >> >> >> the winner here. Is there any plan to improve this, maybe by hav=
ing
> >> >> >> MDS push the capability down to the clients when the dentry is
> >> >> >> updated. So say from CAP_EXCL to CAP_SHARED when the dentry is
> >> >> >> modified. This was the client node can cache the lookup operatio=
n and
> >> >> >> does not have to make a round trip to the MDS.
> >> >> >
> >> >> > In general, the MDS has two ways of keeping a client's cached den=
try
> >> >> > consistent:
> >> >> >
> >> >> > =A0- it can issue the FILE_SHARED capability bit on the parent di=
rectory,
> >> >> > which means the entire directory is static and the client can cac=
he
> >> >> > dentry.
> >> >> > =A0- if it can't do that, it will issue a per-dentry lease
> >> >> >
> >> >> > There is an additional 'complete' bit that is used to indicate on=
 the
> >> >> > client that it has the _entire_ directory in cache. =A0If set, it=
 can do
> >> >> > negative lookups and readdir without hitting the MDS. =A0That's c=
urrently
> >> >> > broken, pending the addition of a d_prune dentry_operation (see
> >> >> > linux-fsdevel email from July 8).
> >> >> >
> >> >> > Anyway, long story short, if you're seeing repeated lookups on a =
dentry
> >> >> > that isn't changing, something is broken. =A0Can you describe the=
 workload
> >> >> > in more detail? =A0Which versions of the client and mds are you r=
unning?
> >> >> >
> >> >> > sage
> >> >> >
> >> >> >
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
--557981400-481904298-1311458192=:15589--
