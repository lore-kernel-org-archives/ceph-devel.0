From: Tommi Virtanen <tv@inktank.com>
Subject: Re: Multiple named clusters on same nodes
Date: Wed, 23 May 2012 11:12:48 -0700
Message-ID: <CADvuQRHFR8_6EPy-02Xm9Zx-vUnPg3ngiTEr5hLZkKgaLNA--A@mail.gmail.com>
References: <201205231100.28327.a.ott@m-privacy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:39668 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756717Ab2EWSNJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 May 2012 14:13:09 -0400
Received: by pbbrp8 with SMTP id rp8so10215185pbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 23 May 2012 11:13:09 -0700 (PDT)
In-Reply-To: <201205231100.28327.a.ott@m-privacy.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Amon Ott <a.ott@m-privacy.de>
Cc: ceph-devel@vger.kernel.org

On Wed, May 23, 2012 at 2:00 AM, Amon Ott <a.ott@m-privacy.de> wrote:
> So I started experimenting with the new "cluster" variable, but it does not
> seem to be well supported so far. mkcephfs does not even know about it and
> always uses "ceph" as cluster name. Setting a value for "cluster" in global
> section of ceph.conf (homeuser.conf, backup.conf, ...) does not work, it is
> not even used in the same config file, instead it has the fixed value "ceph".

"cluster" is not meant to be set in the config file; that's too late,
the config file is read from /etc/ceph/$cluster.conf. Instead, you
pass in --cluster=foo, and that is early enough to influence what
config file is read.

The --cluster argument will be more useful with the new-style Chef
deployment. All the new daemon running infrastructure will already
happily run osds and mons from multiple cluster, even though several
locations still have "ceph" hardcoded, just due to time pressure.

I don't think anyone is likely to fix mkcephfs to work with it -- I'm
personally trying to get mkcephfs declared obsolete. It's
fundamentally the wrong tool; for example, it cannot expand or
reconfigure an existing cluster.
