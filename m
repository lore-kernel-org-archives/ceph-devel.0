From: Andrew Woodward <xarses@gmail.com>
Subject: Re: Moving away from Yum/DNF repo priorities for Ceph and ceph-deploy
Date: Fri, 24 Jul 2015 16:52:30 -0700
Message-ID: <CACEfbZiwU4vMdst7OahtaDAuAC6ZdQaEaFaPYUJ1z8EAyQ7bHw@mail.gmail.com>
References: <0FA51B40-C040-4A64-A2BF-266083E740B6@redhat.com>
	<20150724172400.77454881@guren.zaitcev.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:38675 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754516AbbGXXwb convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Jul 2015 19:52:31 -0400
Received: by iggf3 with SMTP id f3so30783266igg.1
        for <ceph-devel@vger.kernel.org>; Fri, 24 Jul 2015 16:52:30 -0700 (PDT)
In-Reply-To: <20150724172400.77454881@guren.zaitcev.lan>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Pete Zaitcev <zaitcev@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

We already had a similar problem with stackforge/puppet-ceph and went
around in circles for a while trying to account for the issue. We
ultimately resulted in [1] to resolve the issue for us.

[1] https://review.openstack.org/#/c/197302/1/manifests/repo.pp


On Fri, Jul 24, 2015 at 4:28 PM Pete Zaitcev <zaitcev@redhat.com> wrote=
:
>
> On Thu, 23 Jul 2015 16:12:59 -0700
> Travis Rhoden <trhoden@redhat.com> wrote:
>
> > I=E2=80=99m working on ways to improve Ceph installation with ceph-=
deploy, and
> > a common hurdle we have hit involves dependency issues between ceph=
=2Ecom
> > hosted RPM repos, and packages within EPEL.  For a while we were ab=
le to
> > managed this with the priorities plugin, but then EPEL shipped pack=
ages
> > that included changes that weren=E2=80=99t available on the ceph.co=
m packages,
> > and the EPEL packages =E2=80=9Cobsoleted=E2=80=9D the ceph.com ones=
=2E [...]
>
> This happens every time repos want to conflict with packages provided
> by the base distro or EPEL. I think the only sensible way to manage i=
t is
> not to conflict and rely on the base packages. That means getting the=
 right
> versions in. In old EPEL/CentOS/RHEL this may mean versioned names or=
 other
> tricks, but the point is to get them in. You have access to experienc=
ed
> packagers such as Haikel G., who can help you.
>
> So, I'm just curious, what are the specific pain points that we're hi=
tting,
> which prevent using EPEL packages? What are you duplicating and why?
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
