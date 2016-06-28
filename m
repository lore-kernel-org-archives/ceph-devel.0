From: Jeff Layton <jlayton@redhat.com>
Subject: Re: new statx() like interface for libcephfs
Date: Tue, 28 Jun 2016 15:05:24 -0400
Message-ID: <1467140724.32374.32.camel@redhat.com>
References: <1467137825.32374.29.camel@redhat.com>
	 <CAL-2WbF5HAoAvbje8xr91OP5Cd1ye7UF7W+PA01m-V1+O==DjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:35819 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752202AbcF1TF1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Jun 2016 15:05:27 -0400
Received: by mail-qk0-f171.google.com with SMTP id a125so47556293qkc.2
        for <ceph-devel@vger.kernel.org>; Tue, 28 Jun 2016 12:05:26 -0700 (PDT)
In-Reply-To: <CAL-2WbF5HAoAvbje8xr91OP5Cd1ye7UF7W+PA01m-V1+O==DjA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Daniel Gryniewicz <dang@redhat.com>
Cc: "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>, Ganesha NFS List <nfs-ganesha-devel@lists.sourceforge.net>, David Howells <dhowells@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, 2016-06-28 at 14:53 -0400, Daniel Gryniewicz wrote:
> Is stx_version a generation ID for the inode that can be used for the
> NFSv4 Change ID?=C2=A0=C2=A0If so, that would be quite useful to us.=C2=
=A0=C2=A0Otherwise,
> I'm not sure there's that much in there that's useful beyond what sta=
t
> already provides, unless I'm missing something.
>=20

Yeah, I think that's the idea behind that field in statx calls, but
I'll note that I didn't wire that up here. That is the nice thing about
the proposed statx API though. We can add stuff like that in a
piecemeal fashion, as long as the callers check the stx_mask to make
sure the returned values are legit.

I'll look at whether it's possible to wire that up as well if it's
helpful for ganesha.

> On Tue, Jun 28, 2016 at 2:17 PM, Jeff Layton <jlayton@redhat.com> wro=
te:
> >=20
> > I have a patchset queued up for ceph that adds btime (birthtime)
> > support to it. What was lacking though was a mechanism to get the b=
time
> > out of the inode.
> >=20
> > Rather than cook up a brand new interface just for the btime, I dec=
ided
> > to "borrow" the work that David Howells did with the new proposed
> > statx() interface. The pull request to add this to ceph is up here:
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0https://github.com/ceph/ceph/pull/996=
5
> >=20
> > Sage has already closed it out which I take to mean that he has pul=
led
> > the patches into a staging branch for eventual merge.
> >=20
> > It occurs to me though that I didn't ask anyone who is working on t=
he
> > samba vfs or ganesha fsal code whether they think this interface is
> > acceptable.
> >=20
> > Since Samba and Ganesha are the targeted users of this interface, i=
t'd
> > be good to have developers from both communities take a look and se=
e if
> > there are any problems here.
> >=20
> > Does anyone see any issues with the above pull request?
> > --
> > Jeff Layton <jlayton@redhat.com>
> >=20
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at=C2=A0=C2=A0http://vger.kernel.org/majordomo-=
info.html
--=20
Jeff Layton <jlayton@redhat.com>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
