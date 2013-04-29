From: Gregory Farnum <greg@inktank.com>
Subject: Re: mount.ceph: modprobe failed
Date: Mon, 29 Apr 2013 08:59:25 -0700
Message-ID: <CAPYLRzhM0J_ZmBUkLGqF=jpT5nUWO3oMTFZht142z9EJPCO75Q@mail.gmail.com>
References: <def4bfdc122665143a614f7487f0b553@pl1.haspere.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:52256 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757353Ab3D2P70 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Apr 2013 11:59:26 -0400
Received: by mail-qa0-f53.google.com with SMTP id p6so1114227qad.5
        for <ceph-devel@vger.kernel.org>; Mon, 29 Apr 2013 08:59:25 -0700 (PDT)
In-Reply-To: <def4bfdc122665143a614f7487f0b553@pl1.haspere.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: YS3fpFE2ykfB@dyweni.com
Cc: Ceph Devel <ceph-devel@vger.kernel.org>

On Mon, Apr 29, 2013 at 4:49 AM, Dyweni - Ceph-Devel
<YS3fpFE2ykfB@dyweni.com> wrote:
> Hello List!
>
>
> I'd like to report the following bug.
>
> # ceph -v
> ceph version 0.60 (f26f7a39021dbf440c28d6375222e21c94fe8e5c)
>
> Mount.ceph command still attempts to load the ceph (ceph fs) kernel module
> even though it has been compiled into the kernel.  I would recommend that
> the command check /proc/filesystems for the presence of the 'ceph' file
> system, and then only attempt to load the module if it isn't present.
>
>
> The confusing part of the whole bug is that despite the nasty 'modprobe
> failed, exit status 1' message, the command still succeeds to mount the ceph
> fs.  This caught me by surprise.

Hmm, you're right. Looks like the source is catching the errors, too,
so it should be pretty easy to whitelist if it's already loaded. Can
you put a bug in the tracker? (tracker.ceph.com)
Thanks for the report!
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
