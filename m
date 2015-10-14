From: David Disseldorp <ddiss@suse.de>
Subject: Re: [PATCH] ceph/osd_client: add support for CEPH_OSD_OP_GETXATTR
Date: Wed, 14 Oct 2015 19:37:40 +0200
Message-ID: <20151014193740.40e7238f@plati.site>
References: <1444401789-17396-1-git-send-email-ddiss@suse.de>
	<1444401789-17396-2-git-send-email-ddiss@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46471 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932555AbbJNRhl (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 14 Oct 2015 13:37:41 -0400
In-Reply-To: <1444401789-17396-2-git-send-email-ddiss@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: mchristi@redhat.com, idryomov@gmail.com

On Fri,  9 Oct 2015 16:43:09 +0200, David Disseldorp wrote:

> Allows for xattr retrieval. Response data buffer allocation is the
> responsibility of the osd_req_op_xattr_init() caller.

Ping, any feedback on the patch?

Cheers, David
