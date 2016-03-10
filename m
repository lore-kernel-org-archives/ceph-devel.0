From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: [PATCH 0/2] ceph osd: initial VMware VAAI support
Date: Thu, 10 Mar 2016 14:45:38 -0800
Message-ID: <56E1F912.1000509@redhat.com>
References: <[PATCH 0/2] ceph osd: initial VMware VAAI support>
 <1457591672-17430-1-git-send-email-mchristi@redhat.com>
 <56E11607.8070200@redhat.com> <20160310130423.1383631a@echidna.suse>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53201 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932712AbcCJWpj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 10 Mar 2016 17:45:39 -0500
In-Reply-To: <20160310130423.1383631a@echidna.suse>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Disseldorp <ddiss@suse.de>, Mike Christie <mchristi@redhat.com>
Cc: ceph-devel@vger.kernel.org

On 03/10/2016 04:04 AM, David Disseldorp wrote:
> On Thu, 10 Mar 2016 00:36:55 -0600, Mike Christie wrote:
>
> ...
>>> This does not include support for XCOPY/extended copy. I
>>> am still looking into this, but it seems it might be
>>> difficult to support due to rbd being more tuned to cloning
>>> entire devices. When we implement VASA, the cloneVirtualVolume
>>> might be something we can support though.
>
> I suppose the src-and-dest-in-same-pg requirement would complicate
> things quite a bit, but wouldn't clonerange be an option for XCOPY
> offloads?

It's not a good fit, since with multiple clones putting data on the
same set of osds, the workload and space utilization gets skewed for
that set of osds compared to the rest of the cluster.

It also won't give you fast cloning - it's a full copy on xfs, and
you'd need to do one for every object affected.

Due to these limitations, lack of existing clonerange use, and the
complications it brings to the osd as the only op affecting more than
one object, we've talked about removing the clonerange op.

Josh
