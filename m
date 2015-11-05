From: Martin Millnert <martin@millnert.se>
Subject: Re: civetweb upstream/downstream divergence
Date: Thu, 05 Nov 2015 01:04:54 +0100
Message-ID: <1446681894.12033.61.camel@millnert.se>
References: <5631E4A5.9020003@suse.cz>
	 <CADRKj5T5ZZBb+Mhut2jnzKoBEtTjw0tGWptqWVamgoLWaQfpgQ@mail.gmail.com>
	 <20151029225738.51b8b2e5@lembas.zaitcev.lan>
	 <CALqRxCwPNA0WFYu0oJ-70L3vgR0G8WLs4paU=K1xZCyf=a3Fjw@mail.gmail.com>
	 <1446486438.12033.24.camel@millnert.se> <56387CDD.9070605@suse.cz>
	 <alpine.DEB.2.00.1511030320340.32232@cobra.newdream.net>
	 <CALqRxCzhOOKziRML1DtptXSNyP1GJ-JHBqn69Q=aFeg7i2wr9g@mail.gmail.com>
	 <CALqRxCwfoeak4QhAxacyd=XM8t3RhiVUwfCN+p76xiYNTYu7zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ncis.millnert.se ([185.19.66.196]:33334 "EHLO mail.millnert.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932797AbbKEAGW (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 4 Nov 2015 19:06:22 -0500
In-Reply-To: <CALqRxCwfoeak4QhAxacyd=XM8t3RhiVUwfCN+p76xiYNTYu7zw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, Nathan Cutler <ncutler@suse.cz>, Pete Zaitcev <zaitcev@redhat.com>, Yehuda Sadeh-Weinraub <yehuda@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 2015-11-04 at 16:43 -0700, Ken Dreyer wrote:
> When I was talking about a "parallel effort", what I meant is that
> we'd get vanilla civetweb upstream into the distros, and we'd also
> continue to bundle civetweb in Ceph, until we can reliably use the
> upstream Civetweb package.

That's what sounds logical to me too.
So that aside, [Sage's] concern to this could probably be reduced to:
 1) getting new code out to clients via distro packages is slow,
 2) getting new code into upstream projects is tricky

2) as I understand it, has shown tricky for, for example for Sage, with
some FS projects, at least. And there's probably a risk to fall back
into the urge to fork again in the future if.
1) is probably a minor concern, at least simply considering how we're
deploying packages currently (as ceph operator). If you want the latest
and greatest, you solve your dependencies... If you run distro packages,
well, you're on distro packages already and they are packaged for
compatibility as-is. Maintainers of Ceph distro packages would need to
assure they work with civetweb packages.

Ultimately it's a question of whether or not the added labor of keeping
a fork is worth the benefit it brings in reduction of external
dependencies when deploying. The downside is, as in this case, risk of
lagging behind if fork isn't kept up-to-date.

Not obvious which is better.
/M

