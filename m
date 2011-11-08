From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: How to recover degraded objects?
Date: Tue, 8 Nov 2011 10:00:06 -0800
Message-ID: <CAORUGqC1A_eUgNwX9mriAzWpmV9iiA44U=fa8ZZZAnc061aG2w@mail.gmail.com>
References: <CAMiHsJL4bYiKXMRKs142PyetmsEBtizp9T-V97wf-5qpJVf6sw@mail.gmail.com>
 <CAMiHsJLAYTbysxh4n-v3hgcDiqoS0eyva+CELz4Fdkv-K+fkZA@mail.gmail.com>
 <CAMiHsJJ73xofKdNfqPzF1x1ax5AVGLb5Y+p-4Swhaxn8skaPFA@mail.gmail.com>
 <CAORUGqB5WAvW8Bchy=afdZJM=zMddWKs0=18RofspQ+x0w8_OA@mail.gmail.com>
 <CAMiHsJK4omXsDNRuhqoWDNnYbdBaJDhAMA7vTeAkyS1RWrunTA@mail.gmail.com>
 <CANExM-Ogrbn8-6z1JgNAY3DjT20ZNk512as8ELpmJVPBe0xz1g@mail.gmail.com>
 <CAMiHsJLe+3OHNOQ0FfBha-bWu+W6uXJSJSjx5e7HOKXro9A17g@mail.gmail.com>
 <CAORUGqC5xTYaKTpyBrbpQe0BPkBNOpQENnYOZyZYz=ShhxUyiA@mail.gmail.com> <CAMiHsJ+pf1h=JU7LYOR5WZUhequMUCgR-jrCUR2oc3oSwQGb0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:58921 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753050Ab1KHSA2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Nov 2011 13:00:28 -0500
Received: by wwi36 with SMTP id 36so1154158wwi.1
        for <ceph-devel@vger.kernel.org>; Tue, 08 Nov 2011 10:00:27 -0800 (PST)
In-Reply-To: <CAMiHsJ+pf1h=JU7LYOR5WZUhequMUCgR-jrCUR2oc3oSwQGb0w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Atish Kathpal <atish.kathpal@gmail.com>
Cc: Henry C Chang <henry.cy.chang@gmail.com>, ceph-devel@vger.kernel.org

On Sun, Nov 6, 2011 at 21:16, Atish Kathpal <atish.kathpal@gmail.com> wrote:
> root@atish-virtual-machine:/etc/ceph# ceph osd dump -o -|grep pg_size
> pg_pool 2 'rbd' pg_pool(rep pg_size 2 crush_ruleset 2 object_hash
> rjenkins pg_num 64 pgp_num 64 lpg_num 2 lpgp_num 2 last_change 1 owner
> 0)

It seems the desired number of copes for the "rbd" pool is still set to 2. Run

ceph osd pool set rbd size 1

and then your 1-osd setup should be happier.
