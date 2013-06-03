From: Chris Dunlop <chris@onthe.net.au>
Subject: Re: Speed up 'rbd rm'
Date: Mon, 3 Jun 2013 19:15:46 +1000
Message-ID: <20130603091546.GA28293@onthe.net.au>
References: <20130529055942.GA3977@onthe.net.au>
 <51A65523.10107@inktank.com>
 <20130530022307.GA27809@onthe.net.au>
 <51A7BB86.3020106@inktank.com>
 <20130531014049.GA424@onthe.net.au>
 <51A8052C.60309@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.onthe.net.au ([203.22.196.249]:59249 "EHLO
	smtp1.onthe.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752516Ab3FCJPx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Jun 2013 05:15:53 -0400
Content-Disposition: inline
In-Reply-To: <51A8052C.60309@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Thu, May 30, 2013 at 07:04:28PM -0700, Josh Durgin wrote:
> On 05/30/2013 06:40 PM, Chris Dunlop wrote:
>> On Thu, May 30, 2013 at 01:50:14PM -0700, Josh Durgin wrote:
>>> On 05/29/2013 07:23 PM, Chris Dunlop wrote:
>>>> On Wed, May 29, 2013 at 12:21:07PM -0700, Josh Durgin wrote:
>>>>> On 05/28/2013 10:59 PM, Chris Dunlop wrote:
>>>>>> I see there's a new commit to speed up an 'rbd rm':
>>>>>>
>>>>>> http://tracker.ceph.com/projects/ceph/repository/revisions/40956410169709c32a282d9b872cb5f618a48926
>>>>>>
>>>>>> Is it safe to cherry-pick this commit on top of 0.56.6 (or, if not, v0.61.2) to speed up the remove?
>>>>>
>>>>> You'll need 537386d906b8c0e395433461dcb03a82eb33f34f as well. It should
>>>>> apply cleanly to 0.61.2, and probably 0.56.6 too.
>>>>
>>>> Thanks. I'll see how I go, I may just leave the 'rm' running all
>>>> weekend rather than futzing around recompiling ceph and getting
>>>> off the mainline track.

# time rbd rm rbd/large-image
Removing image: 36% complete...Terminated
real    2819m37.117s

I.e. 47 hours and only 36% complete before I gave up (I wanted
to restart that server). At that rate it would take 5.5 days to
remove!

>>> If you're mainly interested in getting rid of the accidentally 1.5PB
>>> image, you can just delete the header (and id object if it's format 2)
>>> and then 'rbd rm' will just remove it from the rbd_directory index, and
>>> not try to delete all the non-existent data objects.
>>
>> Yes, that's my main interest. Sorry, I haven't yet delved far
>> into the details of how the rbd stuff hangs together: can you
>> give me a hint or point me towards any docs regarding what
>> "delete the header (and id object" would look like?
> 
> For a format 2 image, 'rbd info imagename' will show a block_prefix
> like 'rbd_data.101574b0dc51'.
> 
> The random suffix after the '.' is the id of the image.
> For format 2, the header is named after this id, so you'd do:
> 
> rados -p poolname rm rbd_header.101574b0dc51
> 
> For format 1 images, the header object is named after the image name,
> like 'imagename.rbd'.
>
> After removing the header object manually, rbd rm will clean up the
> rest.

The problematical image is format 2.

If it's tricky to manually remove, it's not doing any harm just
sitting there (it it??) so I guess I can just wait until the
parallelized delete is available in a stable release, i.e.
dumpling, or backported to bobtail or cuttlefish.

Cheers,

Chris.
