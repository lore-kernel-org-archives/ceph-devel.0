From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: on disk encryption
Date: Sat, 15 Sep 2012 07:22:22 -0500
Message-ID: <505472FE.7030602@inktank.com>
References: <alpine.DEB.2.00.1209150428490.16190@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:57722 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753512Ab2IOMWV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 15 Sep 2012 08:22:21 -0400
Received: by ieje11 with SMTP id e11so7589739iej.19
        for <ceph-devel@vger.kernel.org>; Sat, 15 Sep 2012 05:22:20 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1209150428490.16190@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org, dustin.kirkland@gmail.com

On 09/15/2012 06:54 AM, Sage Weil wrote:
> Hey,
>
> A common requirement that's come up in conversation a few times now is
> on-disk, at-rest encryption.  Usually, this is really just about making
> sure the bits on an individual disk are useless in isolation, so that
> drives can be safely discarded or RMAed without compromising customer
> data.
>
> I suspect the simplest way to accomplish this would be through something
> like dm-crypt.  The trick would be keeping the keys for the osd's block
> device and journal elsewhere.
>

Sounds good to me.  dm-crypt can use AES-NI which seems to help out a 
lot of the CPU usage front.  It'd be nice to make sure it works.

> One option would be to use the monitor as a lock box to securely store the
> disk encryption key, secured by the osd's existing cephx key is provided.
> The startup scripts (triggered via upstart, sysvinit, whatever) would need
> to get the keyring off the disk (separate, unencrypted partition?), get
> the disk key from the monitor, set up the dm-crypt devices, mount the
> osd's fs, and then start ceph-osd.  An attacker in possession of a
> recovered disk would be need network connectivity to the cluster (prior to
> the keys getting revoked/destroyed) in order to decrypt it.
>
> Looking forward, another option might be to implement encryption inside
> btrfs (placeholder fields are there in the disk format, introduced along
> with the compression code way back when).  This would let ceph-osd handle
> more of the key handling internally and do something like, say, only
> encrypt the current/ and snap_*/ subdirectories.
>

Sounds like this would make our code paths for btrfs and other 
filesystems diverge more rather than less.  I like the idea of not 
making our startup scripts that much more complicated, but what we end 
up doing for xfs and others?  Would we end up having to do the startup 
script path anyway or not support encryption on those FS?

> Other ideas?  Thoughts?
>
> sage
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

