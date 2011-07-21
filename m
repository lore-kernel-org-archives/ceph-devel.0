From: Sage Weil <sage@newdream.net>
Subject: Re: Consistency vs efficiency
Date: Thu, 21 Jul 2011 10:55:21 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1107211047280.5868@cobra.newdream.net>
References: <CAJD3hpW_WjumjD1P1bOhwXWPZieQxyay0HOCH8AFpXfQCT4HMg@mail.gmail.com>
 <Pine.LNX.4.64.1107210944550.5868@cobra.newdream.net>
 <CAJD3hpUw_AW-w3pK-GUSHY92U9=SvL5xdtMqC4rUUK+fnnO6mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1806910933-1311270921=:5868"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52624 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419Ab1GURvl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Jul 2011 13:51:41 -0400
In-Reply-To: <CAJD3hpUw_AW-w3pK-GUSHY92U9=SvL5xdtMqC4rUUK+fnnO6mw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jojy Varghese <jojy.varghese@gmail.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1806910933-1311270921=:5868
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 21 Jul 2011, Jojy Varghese wrote:
> Thanks for the response Sage. We are using 2.6.39 kernel and in the
> "ceph_lookup" method, i see that there is a shortcut for deciding
> ENOENT but after the MDS lookup, i dont see a d_add. I am sure i am
> missing something here.

=09=09=09dout(" dir %p complete, -ENOENT\n", dir);
=09=09=09d_add(dentry, NULL);

=2E..but that is only for the negative lookup in a directory with the=20
'complete' flag set.  And it's never set currently because we don't have=20
d_prune yet (and the old use of d_release was racy).  So ignore this part=
=20
for now!

You have an existing, unchanging, directory that you're seeing repeated=20
lookups on, right?  Like the top-level directory in the heirarchy you're=20
copying?  And the client is doing repeated lookups on the same name?

The way to debug this is probably to start with the messages passing to=20
the MDS and verifying that lookups are duplicated.  Then enable the=20
logging on the kernel client and see why the client isn't uses leases or=20
the FILE_SHARED cap to avoid them.  We can help you through that on #ceph=
=20
if you like.

sage


>=20
> thanks again
> Jojy
>=20
> On Thu, Jul 21, 2011 at 9:49 AM, Sage Weil <sage@newdream.net> wrote:
> > On Thu, 21 Jul 2011, Jojy Varghese wrote:
> >> Hi
> >> =A0 I just started looking at the ceph code in kernel and had a questi=
on
> >> about performance considerations for lookup operations. I noticed that
> >> for every operation (say copying a directory), the root dentry is
> >> "looked" up multiple times and since they all go to MDS for the actual
> >> lookup operation, it effects the performance. I am sure consistency is
> >> the winner here. Is there any plan to improve this, maybe by having
> >> MDS push the capability down to the clients when the dentry is
> >> updated. So say from CAP_EXCL to CAP_SHARED when the dentry is
> >> modified. This was the client node can cache the lookup operation and
> >> does not have to make a round trip to the MDS.
> >
> > In general, the MDS has two ways of keeping a client's cached dentry
> > consistent:
> >
> > =A0- it can issue the FILE_SHARED capability bit on the parent director=
y,
> > which means the entire directory is static and the client can cache
> > dentry.
> > =A0- if it can't do that, it will issue a per-dentry lease
> >
> > There is an additional 'complete' bit that is used to indicate on the
> > client that it has the _entire_ directory in cache. =A0If set, it can d=
o
> > negative lookups and readdir without hitting the MDS. =A0That's current=
ly
> > broken, pending the addition of a d_prune dentry_operation (see
> > linux-fsdevel email from July 8).
> >
> > Anyway, long story short, if you're seeing repeated lookups on a dentry
> > that isn't changing, something is broken. =A0Can you describe the workl=
oad
> > in more detail? =A0Which versions of the client and mds are you running=
?
> >
> > sage
> >
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-1806910933-1311270921=:5868--
