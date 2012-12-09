From: Jonathan Proulx <jon@jonproulx.com>
Subject: Why cephx rather then kerberos?
Date: Sun, 9 Dec 2012 15:03:52 -0500
Message-ID: <CABZB-sig_O-s1cXZ5k4QMu5DZBgTUERg+HLGoe24AwLvwtxbJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:51230 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751607Ab2LIUDw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 9 Dec 2012 15:03:52 -0500
Received: by mail-ob0-f174.google.com with SMTP id ta14so1769914obb.19
        for <ceph-devel@vger.kernel.org>; Sun, 09 Dec 2012 12:03:52 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi All,

the docs continuously describe cephx as Kerberos-like, curious why
Kereros isn't used instead.

Developing new security protocols is almost always a bad idea from a
security perspective.  I haven't looked deeply into cephx to see how
much is novel (and likely to contain novel bugs) ans how much is reuse
of well worn crypto.  So this is just a first impression concern.

More importantly to me I already have a Kerberos infrastructure all my
users have principals all my hosts have keytabs and I would really
like to reuse that for securing data access rather than managing yet
another a separate set of credentials.

The only reason I can see documented is "Unlike Kerberos, each monitor
can authenticate users and distribute keys, so there is no single
point of failure or bottleneck when using chepx."  Kerberos using
multiple KDCs  needn't have a single point of failure, and "each
monitor" probably means 3-5 systems in practice which is a typical
scale for production Kerberos deployments.  Now it's true with
Kerberos if the admin server goes down I can't add new principals
(users) or perform other administrative functions, but authentication
continues and users (human and daemon) don't really care.

Am I missing something? Any plans to either add Kerberos as an
authentication method or provide a pluggable authentication scheme?

I'm fairly excited about all things Ceph from a design and direction
perspective, but this piece (IMO) is the one thing that is just
painfully close but not quite right.

Thanks,
-Jon
