From: David Disseldorp <ddiss@suse.de>
Subject: Re: [PATCH 1/2] ceph osd: add support for new op writesame
Date: Thu, 10 Mar 2016 13:03:51 +0100
Message-ID: <20160310130351.0efc5775@g21.suse.de>
References: <[PATCH 0/2] ceph osd: initial VMware VAAI support>
	<1457591672-17430-1-git-send-email-mchristi@redhat.com>
	<1457591672-17430-2-git-send-email-mchristi@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36011 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751912AbcCJMDx (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 10 Mar 2016 07:03:53 -0500
In-Reply-To: <1457591672-17430-2-git-send-email-mchristi@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mike Christie <mchristi@redhat.com>
Cc: ceph-devel@vger.kernel.org

On Thu, 10 Mar 2016 00:34:31 -0600, Mike Christie wrote:

> This adds a new ceph request writesame that writes a buffer of length
> writesame.data_length bytes at writesame.offset over
> writesame.length bytes.
> 
> This command maps to SCSI's WRITE SAME request, so users like LIO+rbd
> can pass this to the OSD. Right now, it only saves having to transfer
> writesame.length bytes over the network, but future versions will be
> to fully offload it by passing it directly to the FS/devices if they
> support it.
> 
> v2:
> - Merge David's tracing fixes.
> 
> Signed-off-by: Mike Christie <mchristi@redhat.com>

Looks good Mike.
Reviewed-by: David Disseldorp <ddiss@suse.de>

Cheers, David
