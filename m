From: Martin Mailand <martin@tuxadero.com>
Subject: Re: rbd snap
Date: Fri, 23 Sep 2011 20:08:59 +0200
Message-ID: <4E7CCB3B.7080606@tuxadero.com>
References: <4E736107.4050309@tuxadero.com> <Pine.LNX.4.64.1109160928170.11043@cobra.newdream.net> <4E73C064.7020104@tuxadero.com> <4E73CC58.9070503@dreamhost.com> <4E74C653.6080404@tuxadero.com>
Reply-To: martin@tuxadero.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:33592 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736Ab1IWSJJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Sep 2011 14:09:09 -0400
Received: from [192.168.1.106] (e178239125.adsl.alicedsl.de [85.178.239.125])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p8NI90Wf029864
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Fri, 23 Sep 2011 20:09:07 +0200
In-Reply-To: <4E74C653.6080404@tuxadero.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,
is it possible to access snapshots without to rollback the head of the 
rbd volumen?
Because I want to do a snapshot of a vm running via librbd and qemu, and 
use the snapshot to make a offsite backup of the vm.

Best Regards,
  Martin


Martin Mailand schrieb:
> Okay, with the btrfs patch and the right commandline snapshotting works 
> like a charm.
> 
> best regards,
>  martin
> 
> Josh Durgin schrieb:
>> On 09/16/2011 02:32 PM, Martin Mailand wrote:
>>> root@c-brick-001:~# rbd rm --snap=2011091601 test
>>> *** Caught signal (Segmentation fault) **
>>> in thread 0x7f203d749740
>>> ceph version 0.34 (commit:2f039eeeb745622b866d80feda7afa055e15f6d6)
>>> 1: rbd() [0x457062]
>>> 2: (()+0xfc60) [0x7f203ccf6c60]
>>> 3: (librbd::snap_set(librbd::ImageCtx*, char const*)+0x10) 
>>> [0x7f203d32ecd0]
>>> 4: (main()+0x59f) [0x4518ff]
>>> 5: (__libc_start_main()+0xff) [0x7f203b6cdeff]
>>> 6: rbd() [0x44d569]
>>> Segmentation fault
>>
>> I added a bug to the tracker for this 
>> (http://tracker.newdream.net/issues/1545). It shouldn't crash the way 
>> you ran it, but if you're trying to remove a snapshot you need to use 
>> the 'snap rm' command, i.e.:
>> $ rbd snap rm --snap=2011091601 test
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> -- 
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
