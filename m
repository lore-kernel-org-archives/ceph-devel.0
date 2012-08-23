From: Sage Weil <sage@inktank.com>
Subject: Re: kernel oops on 0.47.2, kernel 3.4.4
Date: Thu, 23 Aug 2012 13:59:31 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1208231357530.29719@cobra.newdream.net>
References: <CA+jddaNnKmTEwxdv4Y65LA0sGF5K0OdYPQdN8VM+E1qypT7-Bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56234 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934396Ab2HWU7c (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Aug 2012 16:59:32 -0400
In-Reply-To: <CA+jddaNnKmTEwxdv4Y65LA0sGF5K0OdYPQdN8VM+E1qypT7-Bg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mandell Degerness <mandell@pistoncloud.com>
Cc: ceph-devel@vger.kernel.org

On Thu, 23 Aug 2012, Mandell Degerness wrote:
> I know this is an old build, but I just want to verify that this isn't
> an unknown bug.  For context, the attached log covers the time from
> when server .15 dropped off the net (we think power failure at this
> point).  OSDs 72, 73, 74, and 75 are on the node which apparently lost
> power.
> 
> Ceph version 0.47.2
> Kernel version 3.4.4

Yep, that looks like #2867 / #2790.  The fix is a largish refactor of the 
messenger, so it won't go into the stable kernels, unfortunately.

sage


> 
> Patches applied:
> rbd-don-t-hold-spinlock-during-messenger-flush.patch
> crush-adjust-local-retry-threshold.patch
> crush-be-more-tolerant-of-nonsensical-crush-maps.patchcrush-fix-tree-node-weight-lookup.patch
> crush-fix-memory-leak-when-destroying-tree-buckets.patch
> ceph-osd_client-fix-endianness-bug-in-osd_req_encode.patchrbd-protect-read-of-snapshot-sequence-number.patch
> rbd-store-snapshot-id-instead-of-index.patchceph-don-t-set-WRITE_PENDING-too-early.patch
> ceph-messenger-rework-prepare_connect_authorizer.patchceph-messenger-check-return-from-get_authorizer.patch
> ceph-define-ceph_auth_handshake-type.patchceph-messenger-reduce-args-to-create_authorizer.patch
> ceph-ensure-auth-ops-are-defined-before-use.patchceph-have-get_authorizer-methods-return-pointers.patch
> ceph-use-info-returned-by-get_authorizer.patchceph-return-pointer-from-prepare_connect_authorizer.patch
> ceph-rename-prepare_connect_authorizer.patchceph-add-auth-buf-in-prepare_write_connect.patch
> libceph-avoid-unregistering-osd-request-when-not-reg.patchlibceph-fix-pg_temp-updates.patch
> ceph-check-PG_Private-flag-before-accessing-page-pri.patchrbd-Fix-ceph_snap_context-size-calculation.patch
> rbd-endian-bug-in-rbd_req_cb.patchlibceph-osd_client-don-t-drop-reply-reference-too-ea.patch
> libceph-use-con-get-put-ops-from-osd_client.patchrbd-Clear-ceph_msg-bio_iter-for-retransmitted-messag.patch
> libceph-flush-msgr-queue-during-mon_client-shutdown.patch
> 
> Build options:
>                 --with-cryptopp --without-nss --with-radosgw --without-fuse \
> 		--with-tcmalloc --without-hadoop --with-libatomic-ops \
> 		--with-system-libs3 --with-libaio --without-gtk2 \
> 		--localstatedir=/var
> 
