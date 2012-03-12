From: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 0/7 v3] Push file_update_time() into .page_mkwrite
Date: Mon, 12 Mar 2012 09:22:20 +0100
Message-ID: <20120312082220.GA5998@quack.suse.cz>
References: <1330959258-23211-1-git-send-email-jack@suse.cz>
 <1331497397.4641.87.camel@fourier>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:41073 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753236Ab2CLIWa (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 12 Mar 2012 04:22:30 -0400
Content-Disposition: inline
In-Reply-To: <1331497397.4641.87.camel@fourier>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kamal Mostafa <kamal@canonical.com>
Cc: Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>, Christoph Hellwig <hch@infradead.org>, Jaya Kumar <jayalk@intworks.biz>, Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@gmail.com>, Ron Minnich <rminnich@sandia.gov>, Latchesar Ionkov <lucho@ionkov.net>, v9fs-developer@lists.sourceforge.net, Steven Whitehouse <swhiteho@redhat.com>, cluster-devel@redhat.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Sun 11-03-12 13:23:17, Kamal Mostafa wrote:
> On Mon, 2012-03-05 at 15:54 +0100, Jan Kara wrote:
> > Hello,
> > 
> >   to provide reliable support for filesystem freezing, filesystems need to have
> > complete control over when metadata is changed.  [...]
> 
> This patch set has been tested at Canonical along with the testing for
> "[PATCH 00/19] Fix filesystem freezing deadlocks".
> 
> Please add the following endorsements for these patches (those actually
> exercised by our test case):  1, 2, 6, 7
> 
> Tested-by: Kamal Mostafa <kamal@canonical.com>
> Tested-by: Peter M. Petrakis <peter.petrakis@canonical.com>
> Tested-by: Dann Frazier <dann.frazier@canonical.com>
> Tested-by: Massimo Morana <massimo.morana@canonical.com>
  Thanks for testing guys!

								Honza
-- 
Jan Kara <jack@suse.cz>
SUSE Labs, CR
