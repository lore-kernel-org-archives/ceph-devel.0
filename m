From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: debian packaging for wip-10587-split-servers
Date: Fri, 10 Jul 2015 16:54:16 -0600
Message-ID: <55A04D18.70202@redhat.com>
References: <559E99D8.9060208@redhat.com>
 <CAJE9aOO5Wfxgtgvuj=Mx20C_ToVpY4VU37tS+7uGRbEjKZYEww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53978 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752162AbbGJWyS (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 10 Jul 2015 18:54:18 -0400
In-Reply-To: <CAJE9aOO5Wfxgtgvuj=Mx20C_ToVpY4VU37tS+7uGRbEjKZYEww@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>
Cc: ceph-maintainers@ceph.com, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 07/10/2015 08:21 AM, kefu chai wrote:
> can we
> - have another package named "ceph-base" which packages whatever ceph
> currently has now.
> - make the "ceph" a meta package which only offers the dependencies to
> ceph-mon, ceph-osd, ceph-mds? and let ceph-{mon,osd,mds} Depends on
> "ceph-base" instead?

I was hoping to avoid this route because it seemed complex, but the
further I dig on this, I think your suggestion is going to be the best
way forward.

So to re-state the plan: Files that are shared between multiple servers
will move into "ceph-base", and then:

For RPMs:
- "ceph-{mon,osd,mds}" Require: ceph-base.
- "ceph" will become a metapackage that Requires: ceph-{mon,osd,mds}.

For DEBs:
- "ceph-{mon,osd,mds}" will Depends: ceph-base.
- "ceph" will become a metapackage that Depends: ceph-{mon,osd}.
- "ceph" will continue to Recommends: ceph-mds

I've done some testing with a dummy package and this works. "apt-get
upgrade" kept the update back, since there were new packages introduced,
but "apt-get dist-upgrade" worked. Is that expected? (... newbie Debian
user here :D )

I've pushed this approach to
https://github.com/ceph/ceph/tree/wip-10587-split-servers.

- Ken
