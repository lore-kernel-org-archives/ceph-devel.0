From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 00/15] fix more issues from clang(++) and cppchecker
Date: Sat, 9 Feb 2013 22:02:35 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1302092201010.11665@cobra.newdream.net>
References: <1360266123-28972-1-git-send-email-danny.al-gaaf@bisect.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54244 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752082Ab3BJGCf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 10 Feb 2013 01:02:35 -0500
In-Reply-To: <1360266123-28972-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Cc: ceph-devel@vger.kernel.org, Danny Al-Gaaf <dalgaaf@suse.de>

Hey Danny-

These look good, modulo those 2 comments.  Do you have a public git tree 
with these patches I can cherry-pick or pull from?  It's a bit faster than 
yanking them off the list for merge (although posting to the list for 
review is still good, of course).

Thanks!
sage


On Thu, 7 Feb 2013, Danny Al-Gaaf wrote:

> Here another set of patches to fix issues found by clang/clang++ 
> and cppchecker.
> 
> Danny Al-Gaaf (15):
>   kv_flat_btree_async.cc: use vector instead of VLA's
>   common/config.h: declaration of config_option as struct
>   src/msg/msg_types.h: pass function parameter by reference
>   fuse_ll.cc: fix -Wgnu-designator
>   common/AsyncReserver.h: use empty() instead of size()
>   common/WorkQueue.h: use empty() instead of size()
>   common/config.cc: fix -Wgnu-designator
>   src/log/Entry.h: pass function parameter by reference
>   src/mon/PGMonitor.cc: remove unused variable
>   src/msg/Messenger.h: pass function parameter by reference
>   src/osd/OSD.h: use empty() instead of size()
>   src/osd/PG.h: use empty() instead of size()
>   src/osd/osd_types.h: pass function parameter by reference
>   test_mon_workloadgen.cc: fix -Wgnu
>   librados/librados.cc: fix implicitly-defined namespace 'std'
> 
>  src/client/fuse_ll.cc                      | 68 +++++++++++++++---------------
>  src/common/AsyncReserver.h                 |  2 +-
>  src/common/WorkQueue.h                     |  2 +-
>  src/common/config.cc                       | 14 +++---
>  src/common/config.h                        |  2 +-
>  src/key_value_store/kv_flat_btree_async.cc | 14 +++---
>  src/librados/librados.cc                   | 16 ++++++-
>  src/log/Entry.h                            |  2 +-
>  src/mon/PGMonitor.cc                       |  1 -
>  src/msg/Messenger.h                        |  2 +-
>  src/msg/msg_types.h                        |  2 +-
>  src/osd/OSD.h                              |  4 +-
>  src/osd/PG.h                               |  2 +-
>  src/osd/osd_types.h                        |  2 +-
>  src/test/mon/test_mon_workloadgen.cc       |  3 +-
>  15 files changed, 74 insertions(+), 62 deletions(-)
> 
> -- 
> 1.8.1.2
> 
> 
