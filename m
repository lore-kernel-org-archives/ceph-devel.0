From: David Disseldorp <ddiss@suse.de>
Subject: Re: [PATCH 0/2] ceph osd: initial VMware VAAI support
Date: Thu, 10 Mar 2016 13:04:23 +0100
Message-ID: <20160310130423.1383631a@echidna.suse>
References: <[PATCH 0/2] ceph osd: initial VMware VAAI support>
	<1457591672-17430-1-git-send-email-mchristi@redhat.com>
	<56E11607.8070200@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36088 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753629AbcCJMEZ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 10 Mar 2016 07:04:25 -0500
In-Reply-To: <56E11607.8070200@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mike Christie <mchristi@redhat.com>
Cc: ceph-devel@vger.kernel.org

On Thu, 10 Mar 2016 00:36:55 -0600, Mike Christie wrote:

...
> > This does not include support for XCOPY/extended copy. I
> > am still looking into this, but it seems it might be
> > difficult to support due to rbd being more tuned to cloning
> > entire devices. When we implement VASA, the cloneVirtualVolume
> > might be something we can support though.

I suppose the src-and-dest-in-same-pg requirement would complicate
things quite a bit, but wouldn't clonerange be an option for XCOPY
offloads?

Cheers, David
