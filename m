From: Greg Farnum <gregory.farnum@dreamhost.com>
Subject: Re: [PATCH] Statically binding ports for ceph-osd
Date: Tue, 10 Apr 2012 16:16:20 -0700
Message-ID: <C1A5CCB0C744475E8F129F38DAE60867@dreamhost.com>
References: <CAPud5_4Fhjxwb2AjznBNPif8gLUrsJYqtkLX5OzBLMA1JAvw3g@mail.gmail.com>
 <CAPud5_7B8DG4hnVTqBnw7aHuJf8CJnPUjo3ZUfOjDPo89rqvSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:44619 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756662Ab2DJXQW convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Apr 2012 19:16:22 -0400
Received: by obbtb18 with SMTP id tb18so421837obb.19
        for <ceph-devel@vger.kernel.org>; Tue, 10 Apr 2012 16:16:22 -0700 (PDT)
In-Reply-To: <CAPud5_7B8DG4hnVTqBnw7aHuJf8CJnPUjo3ZUfOjDPo89rqvSQ@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nick Bartos <nick@pistoncloud.com>
Cc: ceph-devel@vger.kernel.org

Yep, you're absolutely correct. Might as well let users specify the who=
le address rather than just the port, though =E2=80=94 since your patch=
 won't apply to current upstream due to some heartbeating changes I whi=
pped up another one which adds the "osd heartbeat addr" option. It's pu=
shed it to master in commit 6fbac10dc68e67d1c700421f311cf5e26991d39c, b=
ut you'll want to backport (easy) or carry your change until you upgrad=
e (and remember to change the config!). :)
Thanks for the report!
-Greg


On Tuesday, April 10, 2012 at 12:56 PM, Nick Bartos wrote:

> After doing some more looking at the code, it appears that this optio=
n
> is not supported. I created a small patch (attached) which adds the
> functionality. Is there any way we could get this, or something like
> this, applied upstream? I think this is important functionality for
> firewalled environments, and seems like a simple fix since all the
> other services (including ones for ceph-mon and ceph-mds) already
> allow you to specify a static port.
> =20
> =20
> On Mon, Apr 9, 2012 at 5:27 PM, Nick Bartos <nick@pistoncloud.com (ma=
ilto:nick@pistoncloud.com)> wrote:
> > I'm trying to get ceph-osd's listening ports to be set statically f=
or
> > firewall reasons. I am able to get 2 of the 3 ports set statically,
> > however the 3rd one is still getting set dynamically.
> > =20
> > I am using:
> > =20
> > [osd.48]
> > host =3D 172.16.0.13
> > cluster addr =3D 172.16.0.13:6944
> > public addr =3D 172.16.0.13:6945
> > =20
> > The daemon will successfully bind to 6944 and 6945, but also binds =
to
> > 6800. What additional option do I need? I started looking at the
> > code and thought "hb addr =3D 172.16.0.13:6946" would do it, but
> > specifying that option seems to have no effect (or at least does no=
t
> > achieve the desired result).
> =20
> =20
> =20
> Attachments: =20
> - ceph-0.41-osd_hb_port.patch
> =20



--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
