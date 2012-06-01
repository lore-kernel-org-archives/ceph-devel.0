From: Tommi Virtanen <tv@inktank.com>
Subject: Re: OSD deadlock with cephfs client and OSD on same machine
Date: Fri, 1 Jun 2012 14:57:19 -0700
Message-ID: <CADvuQRGt53zY7TkSQ_o_tKLK4X=A=HTGEgL5xnZ5f=Xx1vstPQ@mail.gmail.com>
References: <201205290944.33983.a.ott@m-privacy.de> <Pine.LNX.4.64.1205290836350.14433@cobra.newdream.net>
 <201205300908.56991.a.ott@m-privacy.de> <201206011135.38119.a.ott@m-privacy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52581 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759438Ab2FAV5k (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Jun 2012 17:57:40 -0400
Received: by pbbrp8 with SMTP id rp8so3498822pbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 01 Jun 2012 14:57:40 -0700 (PDT)
In-Reply-To: <201206011135.38119.a.ott@m-privacy.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Amon Ott <a.ott@m-privacy.de>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

[Whoops, resending as plain text to make vger happy.]

On Fri, Jun 1, 2012 at 2:35 AM, Amon Ott <a.ott@m-privacy.de> wrote:
> Thanks for the new log lines in master git. The warning without syncfs()
> support could be a bit more clear though - the system is not only slower, it
> hangs needing a reset and reboot. This is much worse, specially if cephfs is

That warning, introduced in
https://github.com/ceph/ceph/commit/07498d66233f388807a458554640cb77424114c0
, is more about running multiple OSDs on a single server, and without
syncfs(2) one OSD syncing causes all to sync. It's not related to your
case of loopback mounting, what has *never* worked well, with the
apparent exception of ceph-fuse

> say that syncfs() makes it significantly more stable than sync(). We will
> make a several day load test soon.

That still won't make it reliable, just less likely to trigger. Good
luck, you'll need it with loopback mounts.
