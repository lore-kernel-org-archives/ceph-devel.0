From: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: [rgw] Multi-tenancy support in radosgw
Date: Mon, 14 Sep 2015 23:10:36 -0600
Message-ID: <20150914231036.4cb235a0@guren.zaitcev.lan>
References: <CA+H5UW0Y2Yc7jSG=iZ5bFpSEFsPpb50tgG1FUxRZFihf904yiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32937 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751536AbbIOFKi (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 15 Sep 2015 01:10:38 -0400
In-Reply-To: <CA+H5UW0Y2Yc7jSG=iZ5bFpSEFsPpb50tgG1FUxRZFihf904yiQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Radoslaw Zarzynski <rzarzynski@mirantis.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Yehuda Sadeh-Weinraub <yehuda@redhat.com>, zaitcev@redhat.com

On Sat, 12 Sep 2015 00:24:27 +0200
Radoslaw Zarzynski <rzarzynski@mirantis.com> wrote:

> Each already existing user would obtain empty bucket namespace
> by default. It will be possible to create user  with his own, unique
> namespace. [...]

> 2. We will always need ID of namespace in order to access proper
>     bucket entry points. [...]

> I would like to ask for reviews of the idea and feedback.

I still don't understand how this is different from tenants in wip-5073.
Each tenant defines what amounts to a namespace for buckets. Could you
clear this up? I heard you discussing it a little bit during the RGW
team stand-up call, but I can't wrap my head around it.

Secondly, have you given a thought to exact API here, or is it all
hand-waved for now? As you may know, initially I hoped we'd get by
without adding any special syntax for tenants. Just off-load it onto
the authentication system, I thought. That didn't work and now we
have the tenant$user syntax allowed all over.

What I mean by that, a client has to do "swift -U tenant\$user:subuser -K pass"
in 5073, and that looks a bit fraught. I presume you avoided that.

Specifically though, imagine I'm doing "radosgw-admin user info",
what do I get under your plan?

-- Pete

P.S. What repo/branch do you use for this? I know you quoted it before,
but just so we're at the same place.
