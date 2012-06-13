From: Xiaopong Tran <xiaopong.tran@gmail.com>
Subject: Re: auth settings
Date: Thu, 14 Jun 2012 07:11:36 +0800
Message-ID: <efb7513b-6ec6-4347-adac-9fc7890cbd09@email.android.com>
References: <Pine.LNX.4.64.1206130839450.25437@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:51569 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752648Ab2FMXLt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Jun 2012 19:11:49 -0400
Received: by pbbrp8 with SMTP id rp8so2940066pbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 13 Jun 2012 16:11:49 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1206130839450.25437@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

Cool=EF=BC=81Will that be merged into master and ready for 0.48 as well=
=EF=BC=9F

cheers

Xiaopong


Sage Weil <sage@inktank.com> wrote:

>The wip-auth branch has a revamp of the authentication settings.=20
>Currently, there is a single option, 'auth supported', which is an
>ordered=20
>list of authentication methods (cephx or none) to use.  This is
>somewhat=20
>limiting
>
>This branch replaces that with 3 new settings:
>
>auth cluster required -- authentication method(s) required between cep=
h
>    cluster daemons (e.g., mds to mds, mds to mon, etc.)
> auth service required -- auth method(s) required by daemons of client=
s
> auth client required  -- what clients require of daemons
>
>This lets you do a few things:
>
>- Require the cluster to internally use authentication, so that nobody
>can
>impersonate an osd or monitor.  You could still leave auth off for
>clients
>   if you don't want to deal with distributing keys to users.
>- Make the cluster require that clients authentication, but let the
>clients =20
>   connect to whatever.
>
>For compatibility, the idea is that these are all blank by default, an=
d
>in=20
>that case default to the deprecated 'auth supported' option that many
>are=20
>already using to enable cephx across the board. =20
>
>There's also some preliminary docs on what cephx gets you and what it=20
>doesn't, and on how to enable authentication on a cluster without it.
>
>This gets us one step closer to enabling auth by default...
>
>sage
>--
>To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
