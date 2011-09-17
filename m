From: Martin Mailand <martin@tuxadero.com>
Subject: Re: rbd snap
Date: Sat, 17 Sep 2011 18:09:55 +0200
Message-ID: <4E74C653.6080404@tuxadero.com>
References: <4E736107.4050309@tuxadero.com> <Pine.LNX.4.64.1109160928170.11043@cobra.newdream.net> <4E73C064.7020104@tuxadero.com> <4E73CC58.9070503@dreamhost.com>
Reply-To: martin@tuxadero.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:44362 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755288Ab1IQQKF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 17 Sep 2011 12:10:05 -0400
In-Reply-To: <4E73CC58.9070503@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

Okay, with the btrfs patch and the right commandline snapshotting works 
like a charm.

best regards,
  martin

Josh Durgin schrieb:
> On 09/16/2011 02:32 PM, Martin Mailand wrote:
>> root@c-brick-001:~# rbd rm --snap=2011091601 test
>> *** Caught signal (Segmentation fault) **
>> in thread 0x7f203d749740
>> ceph version 0.34 (commit:2f039eeeb745622b866d80feda7afa055e15f6d6)
>> 1: rbd() [0x457062]
>> 2: (()+0xfc60) [0x7f203ccf6c60]
>> 3: (librbd::snap_set(librbd::ImageCtx*, char const*)+0x10) 
>> [0x7f203d32ecd0]
>> 4: (main()+0x59f) [0x4518ff]
>> 5: (__libc_start_main()+0xff) [0x7f203b6cdeff]
>> 6: rbd() [0x44d569]
>> Segmentation fault
> 
> I added a bug to the tracker for this 
> (http://tracker.newdream.net/issues/1545). It shouldn't crash the way 
> you ran it, but if you're trying to remove a snapshot you need to use 
> the 'snap rm' command, i.e.:
> $ rbd snap rm --snap=2011091601 test
> -- 
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
