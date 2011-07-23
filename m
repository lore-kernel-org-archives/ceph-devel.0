From: Sage Weil <sage@newdream.net>
Subject: Re: Consistency vs efficiency
Date: Fri, 22 Jul 2011 20:51:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1107222049100.30052@cobra.newdream.net>
References: <CAJD3hpW_WjumjD1P1bOhwXWPZieQxyay0HOCH8AFpXfQCT4HMg@mail.gmail.com>
 <Pine.LNX.4.64.1107210944550.5868@cobra.newdream.net>
 <CAJD3hpUw_AW-w3pK-GUSHY92U9=SvL5xdtMqC4rUUK+fnnO6mw@mail.gmail.com>
 <Pine.LNX.4.64.1107211047280.5868@cobra.newdream.net>
 <CAJD3hpW3JLB+VH3Kg5JouSoDG0-fpXO-g=kMBJPx_1bWDgauNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1211676047-1311393062=:30052"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56161 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751178Ab1GWDrT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Jul 2011 23:47:19 -0400
In-Reply-To: <CAJD3hpW3JLB+VH3Kg5JouSoDG0-fpXO-g=kMBJPx_1bWDgauNQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jojy Varghese <jojy.varghese@gmail.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1211676047-1311393062=:30052
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 22 Jul 2011, Jojy Varghese wrote:
> Sage would the latest patches fix the lookup issue?

No, the blocker there is the '[PATCH] vfs: add d_prune dentry operation'=20
email on Jul 8 to linux-fsdevel and lkml.  Once this set goes in (and=20
cleans up a bunch of stuff Al found in a code audit last weekend) I'll be=
=20
bugging him about it again.

sage



>=20
> On Thu, Jul 21, 2011 at 10:55 AM, Sage Weil <sage@newdream.net> wrote:
> > On Thu, 21 Jul 2011, Jojy Varghese wrote:
> >> Thanks for the response Sage. We are using 2.6.39 kernel and in the
> >> "ceph_lookup" method, i see that there is a shortcut for deciding
> >> ENOENT but after the MDS lookup, i dont see a d_add. I am sure i am
> >> missing something here.
> >
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dout(" dir %p complete, =
-ENOENT\n", dir);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0d_add(dentry, NULL);
> >
> > ...but that is only for the negative lookup in a directory with the
> > 'complete' flag set. =A0And it's never set currently because we don't h=
ave
> > d_prune yet (and the old use of d_release was racy). =A0So ignore this =
part
> > for now!
> >
> > You have an existing, unchanging, directory that you're seeing repeated
> > lookups on, right? =A0Like the top-level directory in the heirarchy you=
're
> > copying? =A0And the client is doing repeated lookups on the same name?
> >
> > The way to debug this is probably to start with the messages passing to
> > the MDS and verifying that lookups are duplicated. =A0Then enable the
> > logging on the kernel client and see why the client isn't uses leases o=
r
> > the FILE_SHARED cap to avoid them. =A0We can help you through that on #=
ceph
> > if you like.
> >
> > sage
> >
> >
> >>
> >> thanks again
> >> Jojy
> >>
> >> On Thu, Jul 21, 2011 at 9:49 AM, Sage Weil <sage@newdream.net> wrote:
> >> > On Thu, 21 Jul 2011, Jojy Varghese wrote:
> >> >> Hi
> >> >> =A0 I just started looking at the ceph code in kernel and had a que=
stion
> >> >> about performance considerations for lookup operations. I noticed t=
hat
> >> >> for every operation (say copying a directory), the root dentry is
> >> >> "looked" up multiple times and since they all go to MDS for the act=
ual
> >> >> lookup operation, it effects the performance. I am sure consistency=
 is
> >> >> the winner here. Is there any plan to improve this, maybe by having
> >> >> MDS push the capability down to the clients when the dentry is
> >> >> updated. So say from CAP_EXCL to CAP_SHARED when the dentry is
> >> >> modified. This was the client node can cache the lookup operation a=
nd
> >> >> does not have to make a round trip to the MDS.
> >> >
> >> > In general, the MDS has two ways of keeping a client's cached dentry
> >> > consistent:
> >> >
> >> > =A0- it can issue the FILE_SHARED capability bit on the parent direc=
tory,
> >> > which means the entire directory is static and the client can cache
> >> > dentry.
> >> > =A0- if it can't do that, it will issue a per-dentry lease
> >> >
> >> > There is an additional 'complete' bit that is used to indicate on th=
e
> >> > client that it has the _entire_ directory in cache. =A0If set, it ca=
n do
> >> > negative lookups and readdir without hitting the MDS. =A0That's curr=
ently
> >> > broken, pending the addition of a d_prune dentry_operation (see
> >> > linux-fsdevel email from July 8).
> >> >
> >> > Anyway, long story short, if you're seeing repeated lookups on a den=
try
> >> > that isn't changing, something is broken. =A0Can you describe the wo=
rkload
> >> > in more detail? =A0Which versions of the client and mds are you runn=
ing?
> >> >
> >> > sage
> >> >
> >> >
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> >>
> >>
>=20
>=20
--557981400-1211676047-1311393062=:30052--
