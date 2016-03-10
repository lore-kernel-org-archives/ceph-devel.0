From: David Disseldorp <ddiss@suse.de>
Subject: Re: [PATCH 2/2] ceph osd: add support for new op cmpext
Date: Thu, 10 Mar 2016 18:12:32 +0100
Message-ID: <20160310181232.1e2cceee@g21.suse.de>
References: <[PATCH 0/2] ceph osd: initial VMware VAAI support>
	<1457591672-17430-1-git-send-email-mchristi@redhat.com>
	<1457591672-17430-3-git-send-email-mchristi@redhat.com>
	<20160310130341.444c76af@g21.suse.de>
	<56E1A98E.6030405@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59145 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753173AbcCJRMe (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 10 Mar 2016 12:12:34 -0500
In-Reply-To: <56E1A98E.6030405@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mike Christie <mchristi@redhat.com>
Cc: ceph-devel@vger.kernel.org

On Thu, 10 Mar 2016 11:06:22 -0600, Mike Christie wrote:

> > What's your reason for dropping the mismatch offset?  
> 
> I was not sure if anyone else was going to use it. I can add it back. It
> does not matter to me.

Thanks - I'd prefer to keep it, given that it doesn't cost anything.

Cheers, David
