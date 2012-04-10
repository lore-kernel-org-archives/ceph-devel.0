From: Greg Farnum <gregory.farnum@dreamhost.com>
Subject: Re: [PATCH] Statically binding ports for ceph-osd
Date: Tue, 10 Apr 2012 16:51:40 -0700
Message-ID: <972033DB59DD46758EEB4CB7E439F457@dreamhost.com>
References: <CAPud5_4Fhjxwb2AjznBNPif8gLUrsJYqtkLX5OzBLMA1JAvw3g@mail.gmail.com>
 <CAPud5_7B8DG4hnVTqBnw7aHuJf8CJnPUjo3ZUfOjDPo89rqvSQ@mail.gmail.com>
 <C1A5CCB0C744475E8F129F38DAE60867@dreamhost.com>
 <CAPud5_7uh6k7=5aT2YH0Lyv23+L=r5Awuw8zdhhdwvhzaWm_qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:55225 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755786Ab2DJXvm convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Apr 2012 19:51:42 -0400
Received: by obbtb18 with SMTP id tb18so457751obb.19
        for <ceph-devel@vger.kernel.org>; Tue, 10 Apr 2012 16:51:42 -0700 (PDT)
In-Reply-To: <CAPud5_7uh6k7=5aT2YH0Lyv23+L=r5Awuw8zdhhdwvhzaWm_qw@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nick Bartos <nick@pistoncloud.com>
Cc: ceph-devel@vger.kernel.org

I think we've already branched off 0.45, so it'll have to wait until 0.=
46 unless we decide to pull it over. Sage could probably be talked into=
 it if you ask nicely? =20
-Greg


On Tuesday, April 10, 2012 at 4:45 PM, Nick Bartos wrote:

> Awesome, thanks so much! Can I assume this will make it into the next
> ceph stable release? I'll probably just backport it now before we
> actually start using it, so I don't have to change the config later.
> =20
> On Tue, Apr 10, 2012 at 4:16 PM, Greg Farnum
> <gregory.farnum@dreamhost.com (mailto:gregory.farnum@dreamhost.com)> =
wrote:
> > Yep, you're absolutely correct. Might as well let users specify the=
 whole address rather than just the port, though =E2=80=94 since your p=
atch won't apply to current upstream due to some heartbeating changes I=
 whipped up another one which adds the "osd heartbeat addr" option. It'=
s pushed it to master in commit 6fbac10dc68e67d1c700421f311cf5e26991d39=
c, but you'll want to backport (easy) or carry your change until you up=
grade (and remember to change the config!). :)
> > Thanks for the report!
> > -Greg
> > =20
> > =20
> > On Tuesday, April 10, 2012 at 12:56 PM, Nick Bartos wrote:
> > =20
> > > After doing some more looking at the code, it appears that this o=
ption
> > > is not supported. I created a small patch (attached) which adds t=
he
> > > functionality. Is there any way we could get this, or something l=
ike
> > > this, applied upstream? I think this is important functionality f=
or
> > > firewalled environments, and seems like a simple fix since all th=
e
> > > other services (including ones for ceph-mon and ceph-mds) already
> > > allow you to specify a static port.
> > > =20
> > > =20
> > > On Mon, Apr 9, 2012 at 5:27 PM, Nick Bartos <nick@pistoncloud.com=
 (mailto:nick@pistoncloud.com)> wrote:
> > > > I'm trying to get ceph-osd's listening ports to be set statical=
ly for
> > > > firewall reasons. I am able to get 2 of the 3 ports set statica=
lly,
> > > > however the 3rd one is still getting set dynamically.
> > > > =20
> > > > I am using:
> > > > =20
> > > > [osd.48]
> > > > host =3D 172.16.0.13
> > > > cluster addr =3D 172.16.0.13:6944
> > > > public addr =3D 172.16.0.13:6945
> > > > =20
> > > > The daemon will successfully bind to 6944 and 6945, but also bi=
nds to
> > > > 6800. What additional option do I need? I started looking at th=
e
> > > > code and thought "hb addr =3D 172.16.0.13:6946" would do it, bu=
t
> > > > specifying that option seems to have no effect (or at least doe=
s not
> > > > achieve the desired result).
> > > =20
> > > =20
> > > =20
> > > =20
> > > =20
> > > Attachments:
> > > - ceph-0.41-osd_hb_port.patch
> > =20
> =20



--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
