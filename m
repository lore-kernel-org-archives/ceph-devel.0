From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: rbd device would disappear after re-boot
Date: Thu, 08 Dec 2011 16:58:21 -0800
Message-ID: <4EE15D2D.8070204@dreamhost.com>
References: <8512670932FB654F81AF0FEF1BE6D49D943112@WHQBEMAIL1.whq.wistron> <CAORUGqDjAW-PpqtfL_hzDKZEk3HbgozBBjip-nBYhG6yYgduTg@mail.gmail.com> <8512670932FB654F81AF0FEF1BE6D49D9433C2@WHQBEMAIL1.whq.wistron> <CAORUGqAhUEZXnjzpxvG0d7q5K-zjvefN5LQhTqiyYSRTLk+tGg@mail.gmail.com> <8512670932FB654F81AF0FEF1BE6D49D943CC9@WHQBEMAIL1.whq.wistron>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:59376 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752792Ab1LIA6V (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Dec 2011 19:58:21 -0500
In-Reply-To: <8512670932FB654F81AF0FEF1BE6D49D943CC9@WHQBEMAIL1.whq.wistron>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Eric_YH_Chen@wistron.com
Cc: tommi.virtanen@dreamhost.com, ceph-devel@vger.kernel.org, Chris_YT_Huang@wistron.com

On 12/07/2011 11:31 PM, Eric_YH_Chen@wistron.com wrote:
> Hi, Tommi:
>
> What I see is like this.
>
> lrwxrwxrwx 1 root root 10 2011-12-07 16:48 foo1:0 ->  ../../rbd0
> lrwxrwxrwx 1 root root 10 2011-12-07 16:50 foo2:1 ->  ../../rbd1
>
> The extra number (:0 and :1) behind the image name make the problem still exists.

I'm not sure why we had the device number in the udev rule. I removed it 
in 891025e539a92b5d75011e2e75c475fc0c272042.

>
> -----Original Message-----
> From: Tommi Virtanen [mailto:tommi.virtanen@dreamhost.com]
> Sent: Thursday, December 08, 2011 1:31 AM
> To: Eric YH Chen/WHQ/Wistron
> Cc: ceph-devel@vger.kernel.org; Chris YT Huang/WHQ/Wistron
> Subject: Re: rbd device would disappear after re-boot
>
> On Tue, Dec 6, 2011 at 18:38,<Eric_YH_Chen@wistron.com>  wrote:
>> I have another little question. Could I map specific image to specific device?
>>
>> For example:
>> Before re-boot
>> id      pool    image   snap    device
>> 0       rbd     foo1    -       /dev/rbd0
>> 1       rbd     foo3    -       /dev/rbd2
>>
>> How could I re-map the image(foo3) to device(/dev/rbd2) but skip rbd1?  The command provided by ceph CLI cannot achieve this.
>>
>> If I re-map the image to another device, it would not sync with iSCSI configuration and may cause problem.
>
> I'm just confirming what Damien said. Don't rely on the numbering to
> be consistent even from one boot to another; we provide a udev helper
> that assigns more permanent names, based on the pool, image name, and
> potentially snapshot name. You'll get a symlink like
> /dev/rbd/POOL/IMAGE or /dev/rbd/POOL/IMAGE@SNAP, use that name.
