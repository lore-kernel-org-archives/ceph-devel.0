From: David Disseldorp <ddiss@suse.de>
Subject: Re: [PATCH 2/2] ceph osd: add support for new op cmpext
Date: Thu, 10 Mar 2016 13:03:41 +0100
Message-ID: <20160310130341.444c76af@g21.suse.de>
References: <[PATCH 0/2] ceph osd: initial VMware VAAI support>
	<1457591672-17430-1-git-send-email-mchristi@redhat.com>
	<1457591672-17430-3-git-send-email-mchristi@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35986 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751289AbcCJMDn (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 10 Mar 2016 07:03:43 -0500
In-Reply-To: <1457591672-17430-3-git-send-email-mchristi@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mike Christie <mchristi@redhat.com>
Cc: ceph-devel@vger.kernel.org

Hi Mike,

On Thu, 10 Mar 2016 00:34:32 -0600, Mike Christie wrote:

> This adds support for a new op cmpext. The request will read
> extent.length bytes and compare them to extent.length bytes at
> extent.offset on disk. If there is a miscompare the osd will return
> -EILSEQ, and the mismatched buffer that was read.
> 
> rbd will use this in a multi op request to implement the
> SCSI COMPARE_AND_WRITE request which is used by VMware for
> its atomic test and set request.
> 
> v2:
> - Merge David's tracing fixes.
> - Instead of returning the mismatch offset and buffer on matching
> failure just return the buffer. The client can figure out the offset
> if it needs it.

What's your reason for dropping the mismatch offset? The osd has
to perform the comparison, so might as well do something with the
result, even if it's ignored by the client in some cases.

Cheers, David
