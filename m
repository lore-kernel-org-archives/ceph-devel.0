From: Sage Weil <sage@newdream.net>
Subject: Re: How to recover degraded objects?
Date: Tue, 8 Nov 2011 10:07:04 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1111081005510.27378@cobra.newdream.net>
References: <CAMiHsJL4bYiKXMRKs142PyetmsEBtizp9T-V97wf-5qpJVf6sw@mail.gmail.com>
 <CAMiHsJLAYTbysxh4n-v3hgcDiqoS0eyva+CELz4Fdkv-K+fkZA@mail.gmail.com>
 <CAMiHsJJ73xofKdNfqPzF1x1ax5AVGLb5Y+p-4Swhaxn8skaPFA@mail.gmail.com>
 <CAORUGqB5WAvW8Bchy=afdZJM=zMddWKs0=18RofspQ+x0w8_OA@mail.gmail.com>
 <CAMiHsJK4omXsDNRuhqoWDNnYbdBaJDhAMA7vTeAkyS1RWrunTA@mail.gmail.com>
 <CANExM-Ogrbn8-6z1JgNAY3DjT20ZNk512as8ELpmJVPBe0xz1g@mail.gmail.com>
 <CAMiHsJLe+3OHNOQ0FfBha-bWu+W6uXJSJSjx5e7HOKXro9A17g@mail.gmail.com>
 <CAORUGqC5xTYaKTpyBrbpQe0BPkBNOpQENnYOZyZYz=ShhxUyiA@mail.gmail.com>
 <CAMiHsJ+pf1h=JU7LYOR5WZUhequMUCgR-jrCUR2oc3oSwQGb0w@mail.gmail.com>
 <CAORUGqC1A_eUgNwX9mriAzWpmV9iiA44U=fa8ZZZAnc061aG2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57758 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754448Ab1KHSHI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Nov 2011 13:07:08 -0500
In-Reply-To: <CAORUGqC1A_eUgNwX9mriAzWpmV9iiA44U=fa8ZZZAnc061aG2w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: Atish Kathpal <atish.kathpal@gmail.com>, Henry C Chang <henry.cy.chang@gmail.com>, ceph-devel@vger.kernel.org

On Tue, 8 Nov 2011, Tommi Virtanen wrote:
> On Sun, Nov 6, 2011 at 21:16, Atish Kathpal <atish.kathpal@gmail.com> wrote:
> > root@atish-virtual-machine:/etc/ceph# ceph osd dump -o -|grep pg_size
> > pg_pool 2 'rbd' pg_pool(rep pg_size 2 crush_ruleset 2 object_hash
> > rjenkins pg_num 64 pgp_num 64 lpg_num 2 lpgp_num 2 last_change 1 owner
> > 0)
> 
> It seems the desired number of copes for the "rbd" pool is still set to 2. Run
> 
> ceph osd pool set rbd size 1
> 
> and then your 1-osd setup should be happier.

One caveat: the pg status currently doesn't get refreshed when the actual 
pg mapping doesn't change, and in this case the pool size change of 2->1 
won't.  It will refresh if you restart the OSDs, though.

sage

