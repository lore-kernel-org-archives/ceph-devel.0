From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Speed up 'rbd rm'
Date: Thu, 30 May 2013 13:50:14 -0700
Message-ID: <51A7BB86.3020106@inktank.com>
References: <20130529055942.GA3977@onthe.net.au> <51A65523.10107@inktank.com> <20130530022307.GA27809@onthe.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:35624 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811Ab3E3UuT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 May 2013 16:50:19 -0400
Received: by mail-pb0-f52.google.com with SMTP id xa12so1008709pbc.25
        for <ceph-devel@vger.kernel.org>; Thu, 30 May 2013 13:50:19 -0700 (PDT)
In-Reply-To: <20130530022307.GA27809@onthe.net.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chris Dunlop <chris@onthe.net.au>
Cc: ceph-devel@vger.kernel.org

On 05/29/2013 07:23 PM, Chris Dunlop wrote:
> On Wed, May 29, 2013 at 12:21:07PM -0700, Josh Durgin wrote:
>> On 05/28/2013 10:59 PM, Chris Dunlop wrote:
>>> I see there's a new commit to speed up an 'rbd rm':
>>>
>>> http://tracker.ceph.com/projects/ceph/repository/revisions/40956410169709c32a282d9b872cb5f618a48926
>>>
>>> Is it safe to cherry-pick this commit on top of 0.56.6 (or, if not, v0.61.2) to speed up the remove?
>>
>> You'll need 537386d906b8c0e395433461dcb03a82eb33f34f as well. It should
>> apply cleanly to 0.61.2, and probably 0.56.6 too.
>
> Thanks. I'll see how I go, I may just leave the 'rm' running all
> weekend rather than futzing around recompiling ceph and getting
> off the mainline track.

If you're mainly interested in getting rid of the accidentally 1.5PB
image, you can just delete the header (and id object if it's format 2)
and then 'rbd rm' will just remove it from the rbd_directory index, and
not try to delete all the non-existent data objects.

> Perhaps as a low-churn high-impact (for those that need it) change,
> this is a candidate to be back-patched into 0.61.3 and perhaps 0.56.7 ?
>
> Cheers,
>
> Chris.

