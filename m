From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH 0/5] rbd_tcm cluster COMPARE AND WRITE
Date: Tue, 28 Jul 2015 23:58:56 -0700
Message-ID: <20150729065856.GC27890@infradead.org>
References: <1438132552-14673-1-git-send-email-ddiss@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:36140 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbbG2G65 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Jul 2015 02:58:57 -0400
Content-Disposition: inline
In-Reply-To: <1438132552-14673-1-git-send-email-ddiss@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Disseldorp <ddiss@suse.de>
Cc: mchristi@redhat.com, ceph-devel@vger.kernel.org

Hi David,

please introduce a proper compare and write API at the block layer
instead of bypassing it.  Thanks!

