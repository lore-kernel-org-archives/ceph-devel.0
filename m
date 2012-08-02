From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: TIER: combine SSDs and HDDs into a single block device
Date: Thu, 02 Aug 2012 16:49:11 -0500
Message-ID: <501AF5D7.9060004@inktank.com>
References: <CADvuQRExAsO2yKo6pT+MMfj8Gwt7a7SGkkOgm-0kjQ+nRzU75g@mail.gmail.com> <501AB2B4.2010406@inktank.com> <20120802175700.GA16693@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:34700 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753090Ab2HBVt0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Aug 2012 17:49:26 -0400
Received: by obbuo13 with SMTP id uo13so24384obb.19
        for <ceph-devel@vger.kernel.org>; Thu, 02 Aug 2012 14:49:25 -0700 (PDT)
In-Reply-To: <20120802175700.GA16693@infradead.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Tommi Virtanen <tv@inktank.com>, ceph-devel@vger.kernel.org

On 08/02/2012 12:57 PM, Christoph Hellwig wrote:
> On Thu, Aug 02, 2012 at 12:02:44PM -0500, Mark Nelson wrote:
>> Alex is also trying to bug the XFS guys (and Sage bugged the BTRFS
>> guys) about ways to put metadata on SSD while keeping data on
>> spinning disk. It sounds like there is a hack for XFS that would let
>> us keep inodes in the lower portion of a volume up to some
>> configurable boundary and then we could use lvm to assign that
>> portion of the volume to an SSD.  The BTRFS guys have a SOC project
>> in the works to separate out metadata onto another disk.
>
> Also with XFS you can use the realtime device for data and the main
> device for all metadata.
>

I was thinking of doing that.  Is the realtime allocator a good fit for 
this kind of thing?  I think dchinner mentioned on the xfs mailing list 
last year that it's single threaded and not very well optimized (and 
maybe not production viable?)

Mark

-- 
Mark Nelson
Performance Engineer
Inktank
