From: Christoph Hellwig <hch@infradead.org>
Subject: Re: Issuing custom IOCTLs to SCSI LLD
Date: Tue, 10 May 2016 22:27:32 -0700
Message-ID: <20160511052732.GA15789@infradead.org>
References: <loom.20160509T111456-471@post.gmane.org>
 <loom.20160511T061343-334@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:44635 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123AbcEKF1d (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 May 2016 01:27:33 -0400
Content-Disposition: inline
In-Reply-To: <loom.20160511T061343-334@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Naveen <Naveen.Chandrasekaran@radisys.com>
Cc: ceph-devel@vger.kernel.org

Short answer is: don't do it.  Use the SES interface for your example,
or ensure a proper API exists if the example was just made up.
