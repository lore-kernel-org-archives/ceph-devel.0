From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: rbd map command hangs for 15 minutes during system start up
Date: Thu, 08 Nov 2012 17:43:02 -0800
Message-ID: <509C5FA6.7010600@inktank.com>
References: <CA+jddaMAx8OKd8-uHaj-eDx8PJwZB=ew7PkkSAy8Y3Uwm5S85g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:54692 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753523Ab2KIBn0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Nov 2012 20:43:26 -0500
Received: by mail-pb0-f46.google.com with SMTP id rr4so2460702pbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 08 Nov 2012 17:43:25 -0800 (PST)
In-Reply-To: <CA+jddaMAx8OKd8-uHaj-eDx8PJwZB=ew7PkkSAy8Y3Uwm5S85g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mandell Degerness <mandell@pistoncloud.com>
Cc: ceph-devel@vger.kernel.org

On 11/08/2012 02:10 PM, Mandell Degerness wrote:
> We are seeing a somewhat random, but frequent hang on our systems
> during startup.  The hang happens at the point where an "rbd map
> <rbdvol>" command is run.
>
> I've attached the ceph logs from the cluster.  The map command happens
> at Nov  8 18:41:09 on server 172.18.0.15.  The process which hung can
> be seen in the log as 172.18.0.15:0/1143980479.
>
> It appears as if the TCP socket is opened to the OSD, but then times
> out 15 minutes later, the process gets data when the socket is closed
> on the client server and it retries.
>
> Please help.
>
> We are using ceph version 0.48.2argonaut
> (commit:3e02b2fad88c2a95d9c0c86878f10d1beb780bfe).
>
> We are using a 3.5.7 kernel with the following list of patches applied:
>
> 1-libceph-encapsulate-out-message-data-setup.patch
> 2-libceph-dont-mark-footer-complete-before-it-is.patch
> 3-libceph-move-init-of-bio_iter.patch
> 4-libceph-dont-use-bio_iter-as-a-flag.patch
> 5-libceph-resubmit-linger-ops-when-pg-mapping-changes.patch
> 6-libceph-re-initialize-bio_iter-on-start-of-message-receive.patch
> 7-ceph-close-old-con-before-reopening-on-mds-reconnect.patch
> 8-libceph-protect-ceph_con_open-with-mutex.patch
> 9-libceph-reset-connection-retry-on-successfully-negotiation.patch
> 10-rbd-only-reset-capacity-when-pointing-to-head.patch
> 11-rbd-set-image-size-when-header-is-updated.patch
> 12-libceph-fix-crypto-key-null-deref-memory-leak.patch
> 13-ceph-tolerate-and-warn-on-extraneous-dentry-from-mds.patch
> 14-ceph-avoid-divide-by-zero-in-__validate_layout.patch
> 15-rbd-drop-dev-reference-on-error-in-rbd_open.patch
> 16-ceph-Fix-oops-when-handling-mdsmap-that-decreases-max_mds.patch
> 17-libceph-check-for-invalid-mapping.patch
> 18-ceph-propagate-layout-error-on-osd-request-creation.patch
> 19-rbd-BUG-on-invalid-layout.patch
> 20-ceph-return-EIO-on-invalid-layout-on-GET_DATALOC-ioctl.patch
> 21-ceph-avoid-32-bit-page-index-overflow.patch
> 23-ceph-fix-dentry-reference-leak-in-encode_fh.patch
>
> Any suggestions?

The log shows your monitors don't have time sychronized enough among
them to make much progress (including authenticating new connections).
That's probably the real issue. 0.2s is pretty large clock drift.

> One thought is that the following patch (which we could not apply) is
> what is required:
>
> 22-rbd-reset-BACKOFF-if-unable-to-re-queue.patch

This is certainly useful too, but I don't think it's the cause of
the delay in this case.

Josh
