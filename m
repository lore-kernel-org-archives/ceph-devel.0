From: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: Moving away from Yum/DNF repo priorities for Ceph and
 ceph-deploy
Date: Fri, 24 Jul 2015 17:24:00 -0600
Message-ID: <20150724172400.77454881@guren.zaitcev.lan>
References: <0FA51B40-C040-4A64-A2BF-266083E740B6@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51873 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752193AbbGXXYB convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Jul 2015 19:24:01 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id 88A5DC1F71
	for <ceph-devel@vger.kernel.org>; Fri, 24 Jul 2015 23:24:01 +0000 (UTC)
Received: from guren.zaitcev.lan (vpn-58-48.rdu2.redhat.com [10.10.58.48])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t6ONO01q024288
	for <ceph-devel@vger.kernel.org>; Fri, 24 Jul 2015 19:24:01 -0400
In-Reply-To: <0FA51B40-C040-4A64-A2BF-266083E740B6@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 23 Jul 2015 16:12:59 -0700
Travis Rhoden <trhoden@redhat.com> wrote:

> I=E2=80=99m working on ways to improve Ceph installation with ceph-de=
ploy, and
> a common hurdle we have hit involves dependency issues between ceph.c=
om
> hosted RPM repos, and packages within EPEL.  For a while we were able=
 to
> managed this with the priorities plugin, but then EPEL shipped packag=
es
> that included changes that weren=E2=80=99t available on the ceph.com =
packages,
> and the EPEL packages =E2=80=9Cobsoleted=E2=80=9D the ceph.com ones. =
[...]

This happens every time repos want to conflict with packages provided
by the base distro or EPEL. I think the only sensible way to manage it =
is
not to conflict and rely on the base packages. That means getting the r=
ight
versions in. In old EPEL/CentOS/RHEL this may mean versioned names or o=
ther
tricks, but the point is to get them in. You have access to experienced
packagers such as Haikel G., who can help you.

So, I'm just curious, what are the specific pain points that we're hitt=
ing,
which prevent using EPEL packages? What are you duplicating and why?

-- Pete
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
