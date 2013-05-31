From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Speed up 'rbd rm'
Date: Thu, 30 May 2013 19:04:28 -0700
Message-ID: <51A8052C.60309@inktank.com>
References: <20130529055942.GA3977@onthe.net.au> <51A65523.10107@inktank.com> <20130530022307.GA27809@onthe.net.au> <51A7BB86.3020106@inktank.com> <20130531014049.GA424@onthe.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:51794 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751455Ab3EaCEd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 May 2013 22:04:33 -0400
Received: by mail-pd0-f177.google.com with SMTP id u11so1360457pdi.8
        for <ceph-devel@vger.kernel.org>; Thu, 30 May 2013 19:04:33 -0700 (PDT)
In-Reply-To: <20130531014049.GA424@onthe.net.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chris Dunlop <chris@onthe.net.au>
Cc: ceph-devel@vger.kernel.org

On 05/30/2013 06:40 PM, Chris Dunlop wrote:
> On Thu, May 30, 2013 at 01:50:14PM -0700, Josh Durgin wrote:
>> On 05/29/2013 07:23 PM, Chris Dunlop wrote:
>>> On Wed, May 29, 2013 at 12:21:07PM -0700, Josh Durgin wrote:
>>>> On 05/28/2013 10:59 PM, Chris Dunlop wrote:
>>>>> I see there's a new commit to speed up an 'rbd rm':
>>>>>
>>>>> http://tracker.ceph.com/projects/ceph/repository/revisions/40956410169709c32a282d9b872cb5f618a48926
>>>>>
>>>>> Is it safe to cherry-pick this commit on top of 0.56.6 (or, if not, v0.61.2) to speed up the remove?
>>>>
>>>> You'll need 537386d906b8c0e395433461dcb03a82eb33f34f as well. It should
>>>> apply cleanly to 0.61.2, and probably 0.56.6 too.
>>>
>>> Thanks. I'll see how I go, I may just leave the 'rm' running all
>>> weekend rather than futzing around recompiling ceph and getting
>>> off the mainline track.
>>
>> If you're mainly interested in getting rid of the accidentally 1.5PB
>> image, you can just delete the header (and id object if it's format 2)
>> and then 'rbd rm' will just remove it from the rbd_directory index, and
>> not try to delete all the non-existent data objects.
>
> Yes, that's my main interest. Sorry, I haven't yet delved far
> into the details of how the rbd stuff hangs together: can you
> give me a hint or point me towards any docs regarding what
> "delete the header (and id object" would look like?

For a format 2 image, 'rbd info imagename' will show a block_prefix like 
'rbd_data.101574b0dc51'.

The random suffix after the '.' is the id of the image.
For format 2, the header is named after this id, so you'd do:

rados -p poolname rm rbd_header.101574b0dc51

For format 1 images, the header object is named after the image name, 
like 'imagename.rbd'.

After removing the header object manually, rbd rm will clean up the
rest.
