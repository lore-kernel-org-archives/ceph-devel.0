From: Greg Farnum <greg@inktank.com>
Subject: Re: I have some problem to mount ceph file system
Date: Thu, 24 May 2012 10:58:52 -0700
Message-ID: <B69080A16F7045E1A0C3B8925F70A80B@inktank.com>
References: <loom.20120523T104810-478@post.gmane.org>
 <CAPYLRzi8cDg7nQRGnK8iytD8SuCwkB5qVr+fWuUDm2o1_ckQfA@mail.gmail.com>
 <Pine.LNX.4.64.1205231432240.15923@cobra.newdream.net>
 <CAJjC8bRHJ-9OGt4oKJWg7bC=mKLZ8PWPqdf6pifbHty4ZdXfJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:51994 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754043Ab2EXR64 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 May 2012 13:58:56 -0400
Received: by dady13 with SMTP id y13so69304dad.19
        for <ceph-devel@vger.kernel.org>; Thu, 24 May 2012 10:58:56 -0700 (PDT)
In-Reply-To: <CAJjC8bRHJ-9OGt4oKJWg7bC=mKLZ8PWPqdf6pifbHty4ZdXfJg@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: FrankWOO Su <frankwoo.scc@gmail.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

That's not an option any more, since malicious clients can fake it so e=
asily. :( =20


On Wednesday, May 23, 2012 at 10:35 PM, FrankWOO Su wrote:

> So in this version, can i do some settings about mount command limite=
d by IP ?
> =20
> any example ??
> =20
> Thanks
> -Frank
> =20
> 2012/5/24 Sage Weil <sage@inktank.com (mailto:sage@inktank.com)>
> > On Wed, 23 May 2012, Gregory Farnum wrote:
> > > On Wed, May 23, 2012 at 1:51 AM, Frank <frankwoo.scc@gmail.com (m=
ailto:frankwoo.scc@gmail.com)> wrote:
> > > > Hello
> > > > I have a question about ceph.
> > > > =20
> > > > When I mount ceph, I do the command as follow :
> > > > =20
> > > > # mount -t ceph -o name=3Dadmin,secret=3DXXXXXX 10.1.0.1:6789/ =
(http://10.1.0.1:6789/) /mnt/ceph -vv
> > > > =20
> > > > now I create an user "foo" and make a secretkey by ceph-authtoo=
l like that :
> > > > =20
> > > > # ceph-authtool /etc/ceph/keyring.bin -n client.foo --gen-key
> > > > =20
> > > > then I add the key into ceph :
> > > > =20
> > > > # ceph auth add client.foo osd 'allow *' mon 'allow *' mds 'all=
ow' -i
> > > > /etc/ceph/keyring.bin
> > > > =20
> > > > so i can mount ceph by foo :
> > > > =20
> > > > # mount -t ceph -o name=3Dfoo,secret=3DXOXOXO 10.1.0.1:6789/ (h=
ttp://10.1.0.1:6789/) /mnt/ceph -vv
> > > > =20
> > > > my question is if i don't want "foo" that has permission to mou=
nt 10.1.0.1:6789/ (http://10.1.0.1:6789/)
> > > > =20
> > > > HOW TO DO IT=C3=BF=C3=BF
> > > > =20
> > > > if there is a directory "foo"
> > > > =20
> > > > I want he can mount 10.1.0.1:6789:/foo/
> > > > =20
> > > > but have no access to mount 10.1.0.1:6789:/
> > > =20
> > > I'm afraid that's not an option with Ceph right now, that I'm awa=
re
> > > of. It was built and designed for a trusted set of servers and
> > > clients, and while we're slowly carving out areas of security, th=
is
> > > isn't one we've done yet.
> > > If it's an important feature for you, you should create a feature
> > > request in the tracker (tracker.newdream.net (http://tracker.newd=
ream.net)) for it, which we will
> > > prioritize and work on once we've moved to focus on the full
> > > filesystem. :)
> > =20
> > =20
> > http://tracker.newdream.net/issues/1237
> > =20
> > (tho the final config will probably not look like that; suggestions
> > welcome.)
> > =20
> > sag
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
