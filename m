From: Alex Elder <elder@dreamhost.com>
Subject: Re: [PATCH 0/6] ceph: virtual extended attribute cleanup
Date: Tue, 28 Feb 2012 21:15:21 -0800
Message-ID: <4F4DB469.4030109@dreamhost.com>
References: <4F4D98D5.1010506@dreamhost.com> <20120229042044.GB1865@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:39787 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243Ab2B2FPW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Feb 2012 00:15:22 -0500
In-Reply-To: <20120229042044.GB1865@infradead.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: ceph-devel@vger.kernel.org

On 02/28/2012 08:20 PM, Christoph Hellwig wrote:
> On Tue, Feb 28, 2012 at 07:17:41PM -0800, Alex Elder wrote:
>> This series cleans up some code involving ceph's virtual extended
>> attributes.  Three of them define some simple macros are set up to
>> help ensure the attributes are defined in a consistent way.  One
>> makes the size of certain constant values get defined at startup
>> time rather than repeatedly, and the remaining two are some very
>> small changes made for clarity.
>
> Is there any reason you can't use the generic_*xattr helpers that
> parse attribute names and use the handler array in the superblock?

We should.  And I started to look at that but decided to at least
start moving the code in a better, more regular direction.  I've
got it on a list but haven't gotten around to it.  Lots of this
stuff is just the result of taking my first walk through some
of this code.

> I'm still vaguely planning on getting all remaining filesystems
> converted over to it.

OK.  I'll look into converting this stuff soon.

					-Alex
