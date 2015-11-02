From: Martin Millnert <martin@millnert.se>
Subject: Re: civetweb upstream/downstream divergence
Date: Mon, 02 Nov 2015 18:47:18 +0100
Message-ID: <1446486438.12033.24.camel@millnert.se>
References: <5631E4A5.9020003@suse.cz>
	 <CADRKj5T5ZZBb+Mhut2jnzKoBEtTjw0tGWptqWVamgoLWaQfpgQ@mail.gmail.com>
	 <20151029225738.51b8b2e5@lembas.zaitcev.lan>
	 <CALqRxCwPNA0WFYu0oJ-70L3vgR0G8WLs4paU=K1xZCyf=a3Fjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ncis.millnert.se ([185.19.66.196]:45195 "EHLO mail.millnert.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754375AbbKBRsm (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 2 Nov 2015 12:48:42 -0500
In-Reply-To: <CALqRxCwPNA0WFYu0oJ-70L3vgR0G8WLs4paU=K1xZCyf=a3Fjw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, Yehuda Sadeh-Weinraub <yehuda@redhat.com>, Nathan Cutler <ncutler@suse.cz>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, 2015-10-30 at 15:38 -0600, Ken Dreyer wrote:
> On Thu, Oct 29, 2015 at 10:57 PM, Pete Zaitcev <zaitcev@redhat.com> wrote:
> > Dunno about SuSE, but as a Fedora packager I would prefer if we (Ceph)
> > talked upstream into making regular releases and then for us to stop
> > carrying it entirely. One less git submodule if nothing else.
> 
> I would heartily support the effort to get civetweb into the distros,
> too, and make this a proper package with a shared library that RGW can
> link against. This can be done in parallel to the "reconciling the
> code content with civetweb upstream" effort of course :)

From a "devops" perspective with local CI infra, this (proper package
with shared libs) is a preferred packaging model.

/M

