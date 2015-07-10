From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: debian packaging for wip-10587-split-servers
Date: Fri, 10 Jul 2015 16:56:48 -0600
Message-ID: <55A04DB0.1070400@redhat.com>
References: <559E99D8.9060208@redhat.com>
 <CAJE9aOO5Wfxgtgvuj=Mx20C_ToVpY4VU37tS+7uGRbEjKZYEww@mail.gmail.com>
 <55A04D18.70202@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40985 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752009AbbGJW4u (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 10 Jul 2015 18:56:50 -0400
In-Reply-To: <55A04D18.70202@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>
Cc: ceph-maintainers@ceph.com, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 07/10/2015 04:54 PM, Ken Dreyer wrote:
> I've done some testing with a dummy package and this works. "apt-get
> upgrade" kept the update back, since there were new packages introduced,
> but "apt-get dist-upgrade" worked. Is that expected? (... newbie Debian
> user here :D )
> 
> I've pushed this approach to
> https://github.com/ceph/ceph/tree/wip-10587-split-servers.

Whoops, I lied, there's nothing new on that branch yet. I'll have to
pick this back up on Monday :)

Hopefully my reasoning above sounds correct, though?

- Ken

