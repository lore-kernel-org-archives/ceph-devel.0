From: Travis Rhoden <trhoden@gmail.com>
Subject: Re: Moving away from Yum/DNF repo priorities for Ceph and ceph-deploy
Date: Fri, 24 Jul 2015 16:57:43 -0700
Message-ID: <CACkq2mrBc0y+YXrsr-QQ5KJb9wZVVJEF0E8ZVDue_y6UOyR42g@mail.gmail.com>
References: <0FA51B40-C040-4A64-A2BF-266083E740B6@redhat.com> <20150724172400.77454881@guren.zaitcev.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:36100 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824AbbGXX6D convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Jul 2015 19:58:03 -0400
Received: by oibn4 with SMTP id n4so27328332oib.3
        for <ceph-devel@vger.kernel.org>; Fri, 24 Jul 2015 16:58:02 -0700 (PDT)
In-Reply-To: <20150724172400.77454881@guren.zaitcev.lan>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Pete Zaitcev <zaitcev@redhat.com>, Ken Dreyer <kdreyer@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Pete,

Thanks for the input.  I think Ken can probably help shed some light
on this as well for you, but some things I can add...

On Fri, Jul 24, 2015 at 4:24 PM, Pete Zaitcev <zaitcev@redhat.com> wrot=
e:
> On Thu, 23 Jul 2015 16:12:59 -0700
> Travis Rhoden <trhoden@redhat.com> wrote:
>
>> I=E2=80=99m working on ways to improve Ceph installation with ceph-d=
eploy, and
>> a common hurdle we have hit involves dependency issues between ceph.=
com
>> hosted RPM repos, and packages within EPEL.  For a while we were abl=
e to
>> managed this with the priorities plugin, but then EPEL shipped packa=
ges
>> that included changes that weren=E2=80=99t available on the ceph.com=
 packages,
>> and the EPEL packages =E2=80=9Cobsoleted=E2=80=9D the ceph.com ones.=
 [...]
>
> This happens every time repos want to conflict with packages provided
> by the base distro or EPEL.

My examples were a bit contrived, in that I purposely had to use an
"old" version of Ceph.  But it's an old version that the community
still supports for many months to come.  The latest packages do not
conflict with EPEL in any way.

However, going back in time, it was never the case that Ceph wanted to
conflict.  It was more of a case where some packages that got pushed
to EPEL were pushed a bit pre-maturely, where a package was split into
multiple subcomponents and the old packages was then obsoleted.  This
was done *before* the upstream packages had the same thing done to
them.  This only happened once, but it did cause all kind of
headaches.

> I think the only sensible way to manage it is
> not to conflict and rely on the base packages. That means getting the=
 right
> versions in.

This is indeed what Ceph does.  It relies on what is in EPEL.  It was
just that for two of our releases (Firefly and Giant), the package
obsoletions made installation without a lot of extra configuration
impossible.  In a way this is a "one off", and does not effect the
current release Hammer.

> In old EPEL/CentOS/RHEL this may mean versioned names or other
> tricks, but the point is to get them in. You have access to experienc=
ed
> packagers such as Haikel G., who can help you.
>
> So, I'm just curious, what are the specific pain points that we're hi=
tting,
> which prevent using EPEL packages? What are you duplicating and why?

We don't want to duplicate EPEL packages - and for the most part we
don't.  The only packages that are duplicated (I think) are Ceph
packages themselves.  EPEL includes a version of Ceph, but upstream
can and does provide repos with newer versions.  However, upstream
*also* absolutely depends on EPEL.  We use everything we can from
there.  In the cases of Firefly and Giant, there was this weird
situation where EPEL packages obsoleted our own, but that was a bit of
a feature mismanagement that we had to work around.

My proposal to install Ceph into two pieces (install Ceph EPEL
dependencies explicitly, then install the rest of Ceph with EPEL
disabled) is motived by two things. First is to simplify ceph-deploy
so that it doesn't have to add Yum plugins and configure them "just
right" to make things work.  Second is to play nice with Calamari.

Calamari is a bit more fragile when it comes to package versions.  It
depends on an older version of certain things packages that have newer
versions in EPEL.  So if there is a working installation and EPEL is
enabled, a "yum update" will break it.  I'm hoping to help with that
problem by playing nice and leaving EPEL disabled by default on Ceph
nodes.


>
> -- Pete
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
