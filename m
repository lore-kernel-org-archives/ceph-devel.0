From: Sage Weil <sage@inktank.com>
Subject: Re: I have some problem to mount ceph file system
Date: Wed, 23 May 2012 14:32:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1205231432240.15923@cobra.newdream.net>
References: <loom.20120523T104810-478@post.gmane.org>
 <CAPYLRzi8cDg7nQRGnK8iytD8SuCwkB5qVr+fWuUDm2o1_ckQfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-996527474-1337808778=:15923"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43072 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758864Ab2EWVdC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 May 2012 17:33:02 -0400
In-Reply-To: <CAPYLRzi8cDg7nQRGnK8iytD8SuCwkB5qVr+fWuUDm2o1_ckQfA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Frank <frankwoo.scc@gmail.com>, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-996527474-1337808778=:15923
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 23 May 2012, Gregory Farnum wrote:
> On Wed, May 23, 2012 at 1:51 AM, Frank <frankwoo.scc@gmail.com> wrote:
> > Hello
> > I have a question about ceph.
> >
> > When I mount ceph, I do the command as follow :
> >
> > # mount -t ceph -o name=3Dadmin,secret=3DXXXXXX 10.1.0.1:6789/ /mnt/cep=
h -vv
> >
> > now I create an user "foo" and make a secretkey by ceph-authtool like t=
hat :
> >
> > # ceph-authtool /etc/ceph/keyring.bin -n client.foo --gen-key
> >
> > then I add the key into ceph :
> >
> > # ceph auth add client.foo osd 'allow *' mon 'allow *' mds 'allow' -i
> > /etc/ceph/keyring.bin
> >
> > so i can mount ceph by foo :
> >
> > # mount -t ceph -o name=3Dfoo,secret=3DXOXOXO 10.1.0.1:6789/ /mnt/ceph =
-vv
> >
> > my question is if i don't want "foo" that has permission to mount 10.1.=
0.1:6789/
> >
> > HOW TO DO IT=FF=FF
> >
> > if there is a directory "foo"
> >
> > I want he can mount 10.1.0.1:6789:/foo/
> >
> > but have no access to mount 10.1.0.1:6789:/
>=20
> I'm afraid that's not an option with Ceph right now, that I'm aware
> of. It was built and designed for a trusted set of servers and
> clients, and while we're slowly carving out areas of security, this
> isn't one we've done yet.
> If it's an important feature for you, you should create a feature
> request in the tracker (tracker.newdream.net) for it, which we will
> prioritize and work on once we've moved to focus on the full
> filesystem. :)

http://tracker.newdream.net/issues/1237

(tho the final config will probably not look like that; suggestions=20
welcome.)

sage
--557981400-996527474-1337808778=:15923--
