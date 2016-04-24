From: David Disseldorp <ddiss@suse.de>
Subject: Re: memcpy() avoidance using decode(bufferlist)
Date: Mon, 25 Apr 2016 00:56:55 +0200
Message-ID: <20160425005655.022ff812@echidna.suse.de>
References: <20160422155355.06c5ef4c@echidna.suse.de>
	<571A67DB.6010903@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36917 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752036AbcDXW46 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 24 Apr 2016 18:56:58 -0400
In-Reply-To: <571A67DB.6010903@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Casey Bodley <cbodley@redhat.com>
Cc: ceph-devel@vger.kernel.org

Thanks for the tips Casey!

On Fri, 22 Apr 2016 14:05:15 -0400, Casey Bodley wrote:

> This append_buffer is not 
> currently exposed by the interface, but if there was a way to provide 
> your own buffer::ptr from buffer::create_static(), you could 
> hypothetically use that to avoid the copy.

That's a pity. In that case, I guess I'll keep the extra memcpy until
there's an API to directly provide the bufferlist destination buffer
here.

Cheers, David
