From: Chris Dunlop <chris@onthe.net.au>
Subject: Re: krbd + format=2 ?
Date: Sat, 8 Jun 2013 12:48:52 +1000
Message-ID: <20130608024852.GA31065@onthe.net.au>
References: <20130603092428.GB28293@onthe.net.au>
 <51B2103C.7040402@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.onthe.net.au ([203.22.196.249]:55761 "EHLO
	smtp1.onthe.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927Ab3FHCtA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Jun 2013 22:49:00 -0400
Content-Disposition: inline
In-Reply-To: <51B2103C.7040402@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Fri, Jun 07, 2013 at 11:54:20AM -0500, Alex Elder wrote:
> On 06/03/2013 04:24 AM, Chris Dunlop wrote:
>> I pulled the for-linus branch (@ 3abef3b) on top of 3.10.0-rc4, and it's
>> letting me map a format=2 image (created under bobtail), however reading
>> from the block device returns zeros rather than the data. The same image
>> correctly shows data (NTFS filesystem) when mounted into kvm using librbd.
> 
> Have you tried using a format 2 image that you created using
> the Linux rbd environment?  It would be good to know whether
> that works for you.

Sorry, how to you mean "created using the Linux rbd environment"?
The one I was trying was created using:

rbd create --format 2 xxx --size nnnnn

...then populated using qemu/librbd.

> Can you also send me the result of running each of these commands:
> 
> foo=$(rados get --pool=rbd rbd_id.xxx - | strings)
> rados ls --pool=rbd | grep rbd_data | grep "${foo}"
> unset foo

That results in a 3.2MB, 83973-line file, starting like:

rbd_data.e4d72ae8944a.0000000000027066
rbd_data.e4d72ae8944a.000000000001bc77
rbd_data.e4d72ae8944a.000000000002112e
rbd_data.e4d72ae8944a.000000000002550c
rbd_data.e4d72ae8944a.000000000001b6b3
rbd_data.e4d72ae8944a.000000000002875b

Complete file is at: https://www.dropbox.com/s/5bw6ba7ifatf1mu/rbd_data.out

(Note: it's a long w'end here on Oz, I won't be back at this till Tue.)

Cheers,

Chris
