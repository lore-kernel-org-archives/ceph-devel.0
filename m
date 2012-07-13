From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH] ceph: fix potential double free
Date: Fri, 13 Jul 2012 10:39:44 -0500
Message-ID: <50004140.8010901@inktank.com>
References: <20120713142839.23587.58658.stgit@localhost.localdomain> <50003289.5010805@inktank.com> <20120713155610.4638b307@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:51453 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148Ab2GMPjq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Jul 2012 11:39:46 -0400
Received: by yenl2 with SMTP id l2so3692551yen.19
        for <ceph-devel@vger.kernel.org>; Fri, 13 Jul 2012 08:39:45 -0700 (PDT)
In-Reply-To: <20120713155610.4638b307@pyramind.ukuu.org.uk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: ceph-devel@vger.kernel.org

On 07/13/2012 09:56 AM, Alan Cox wrote:
> On Fri, 13 Jul 2012 09:36:57 -0500
> Alex Elder <elder@inktank.com> wrote:
> 
>> On 07/13/2012 09:28 AM, Alan Cox wrote:
>>> From: Alan Cox <alan@linux.intel.com>
>>>
>>> We re-run the loop but we don't re-set the attrs pointer back to NULL.
>>
>> It looks to me like we're OK here without this.
>>
>> At the top of the loop, the if condition either holds or it does not.
>> - If it does not, we don't touch "xattrs" again, before returning "err".
>> - If the condition holds, the next time "xattrs" is touched is when its
>>   value is assigned the result of a kcalloc() call.
> 
> 
> If the condition is invariant across the race/retry then a better fix
> would be to move the start label to re-execute only the relevant code ?

I haven't looked at this code in a while so I might be missing
something.  Let's see if I can explain what's going on to see
if it clears anything up.

The condition is not invariant across the race.  The spin lock
ci->i_ceph_lock is held on entry to the function, and that
protects the ci->i_xattrs structure, including updates to its
"blob" field.

The xattrs "blob" is a buffer that holds a copy of the on-disk
representation of the extended attributes.  There is a red-black
tree "index" version of that information also.  Whether the index
is up-to-date with what's on disk is determined by whether the
value of index_version is at or above the value of the (on-disk)
version of the xattrs.

This block of code is re-building red-black tree index.  The
"if" statement at the top is determining whether there actually
is anything to build (iov_len <= 4 means there are no attributes
in the blob).

The "xattrs" variable your patch affects holds an array of
structures holding xattr information that will be referred to
by entries in the red-black tree (index).  Its size is determined
by the content of the "blob".  We drop the lock while allocating
the "xattrs" array, and as a result the "blob" could change, meaning
the size of the "xattrs" array we allocated could be wrong after
re-acquiring the lock.  This is checked by seeing if the version
changed, and if so, the array is freed and we start over, by jumping
back to the "start" label.

Is that clear?  Is there something I'm still missing?

I do have some changes I've been sitting on that clean this stuff
up a bit but I'm not sure they affect this particular spot in the
code.

In any case, as I said, I plan to include your proposed fix.

					-Alex
