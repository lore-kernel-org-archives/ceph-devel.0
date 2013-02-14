From: Gregory Farnum <greg@inktank.com>
Subject: Re: [ceph-commit] [ceph/ceph] e330b7: mon: create fail_mds_gid()
 helper; make 'ceph mds ...
Date: Thu, 14 Feb 2013 11:43:07 -0800
Message-ID: <CAPYLRzhd9GRrHAQuZZfzvc=RhNX2YM9SrpgvSxdgXtqaDM6_+w@mail.gmail.com>
References: <511d3d8377c3d_44de16cbaf025029@sh4.rs.github.com.mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qe0-f45.google.com ([209.85.128.45]:38808 "EHLO
	mail-qe0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761570Ab3BNTnI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Feb 2013 14:43:08 -0500
Received: by mail-qe0-f45.google.com with SMTP id b4so1264504qen.32
        for <ceph-devel@vger.kernel.org>; Thu, 14 Feb 2013 11:43:07 -0800 (PST)
In-Reply-To: <511d3d8377c3d_44de16cbaf025029@sh4.rs.github.com.mail>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Feb 14, 2013 at 11:39 AM, GitHub <noreply@github.com> wrote:
>   Branch: refs/heads/master
>   Home:   https://github.com/ceph/ceph
>   Commit: e330b7ec54f89ca799ada376d5615e3c1dfc54f0
>       https://github.com/ceph/ceph/commit/e330b7ec54f89ca799ada376d5615e3c1dfc54f0
>   Author: Sage Weil <sage@inktank.com>
>   Date:   2013-01-17 (Thu, 17 Jan 2013)
>
>   Changed paths:
>     M src/mon/MDSMonitor.cc
>     M src/mon/MDSMonitor.h
>
>   Log Message:
>   -----------
>   mon: create fail_mds_gid() helper; make 'ceph mds rm ...' more generic
>
> Take a gid or a rank or a name.  Use a nicer helper.
>
> Signed-off-by: Sage Weil <sage@inktank.com>
>
>
>   Commit: 2e112333397750a1b683c41f58c3fae05321fc49
>       https://github.com/ceph/ceph/commit/2e112333397750a1b683c41f58c3fae05321fc49
>   Author: Sage Weil <sage@inktank.com>
>   Date:   2013-01-17 (Thu, 17 Jan 2013)
>
>   Changed paths:
>     M src/common/config_opts.h
>     M src/mds/MDSMap.h
>     M src/mon/MDSMonitor.cc
>
>   Log Message:
>   -----------
>   mon: enforce unique name in mdsmap
>
> Add 'mds enforce unique name' option, defaulting to true.
>
> If set, when an MDS boots, it will kick any previous mds with the same
> name from the mdsmap.  This is possibly less confusing for users.  If
> an mds daemon restarts, it will immediately replace its previous
> instantiation.
>
> Two misconfigured daemons running with the same name will fight over
> the same role.
>
> Fixes: #3857
> Signed-off-by: Sage Weil <sage@inktank.com>
>
>
>   Commit: dd7caf5f411696f8e7dc108270a8e85a34f3e80c
>       https://github.com/ceph/ceph/commit/dd7caf5f411696f8e7dc108270a8e85a34f3e80c
>   Author: Sage Weil <sage@inktank.com>
>   Date:   2013-01-17 (Thu, 17 Jan 2013)
>
>   Changed paths:
>     M src/mds/MDS.cc
>
>   Log Message:
>   -----------
>   mds: gracefully exit if newer gid replaces us by name
>
> If 'mds enforce unique name' is set, and another MDS with the same name
> kicks us out of the MDSMap, gracefully exit instead of respawning and
> fighting over our position.
>
> Signed-off-by: Sage Weil <sage@inktank.com>
>
>
>   Commit: 6f28faf9e6613bff403bcd958818d8dccd004f9d
>       https://github.com/ceph/ceph/commit/6f28faf9e6613bff403bcd958818d8dccd004f9d
>   Author: Sage Weil <sage@inktank.com>
>   Date:   2013-01-17 (Thu, 17 Jan 2013)
>
>   Changed paths:
>     M src/mds/MDCache.cc
>
>   Log Message:
>   -----------
>   mds: open mydir after replay
>
> In certain cases, we may replay the journal and not end up with the
> dirfrag for mydir open.  This is fine--we just need to open it up and
> fetch it below.
>
> Signed-off-by: Sage Weil <sage@inktank.com>

In the tests I ran last night on this branch I saw some Valgrind
warnings in the OSDs and Monitors, but I couldn't figure out any way
for this series to have caused them so I assume they're latent and pop
up occasionally in master? In any case, please keep an eye out in case
I was wrong. :)
-Greg
