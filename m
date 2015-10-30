From: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: civetweb upstream/downstream divergence
Date: Thu, 29 Oct 2015 22:57:38 -0600
Message-ID: <20151029225738.51b8b2e5@lembas.zaitcev.lan>
References: <5631E4A5.9020003@suse.cz>
	<CADRKj5T5ZZBb+Mhut2jnzKoBEtTjw0tGWptqWVamgoLWaQfpgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51940 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750801AbbJ3E5l (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 30 Oct 2015 00:57:41 -0400
In-Reply-To: <CADRKj5T5ZZBb+Mhut2jnzKoBEtTjw0tGWptqWVamgoLWaQfpgQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Cc: Nathan Cutler <ncutler@suse.cz>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 29 Oct 2015 10:58:07 -0700
Yehuda Sadeh-Weinraub <yehuda@redhat.com> wrote:

> We should definitely do it. We're based off civetweb 1.6, and there
> was no official civetweb version for quite a while, but 1.7 was tagged
> a few months ago. I made some effort and got most of our material
> changes upstream, however, there are some changes that might need some
> more work before we can get them merged, or might not make complete
> sense at all.

I take it Nathan is volunteering to parse the delta into logical pieces
and identify what upstream is willing to accept, right?

Dunno about SuSE, but as a Fedora packager I would prefer if we (Ceph)
talked upstream into making regular releases and then for us to stop
carrying it entirely. One less git submodule if nothing else.

-- Pete
