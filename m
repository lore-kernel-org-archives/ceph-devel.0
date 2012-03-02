From: Alex Elder <elder@dreamhost.com>
Subject: Re: [PATCH 0/3] libceph: clean up some code involving CRCs
Date: Fri, 02 Mar 2012 15:30:27 -0800
Message-ID: <4F515813.2000704@dreamhost.com>
References: <4F4DAE4E.4000903@dreamhost.com> <Pine.LNX.4.64.1203021347240.6413@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:55559 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965463Ab2CBXa2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Mar 2012 18:30:28 -0500
In-Reply-To: <Pine.LNX.4.64.1203021347240.6413@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On 03/02/2012 01:47 PM, Sage Weil wrote:
> These look good.. but where is the crc bug actually fixed?  Not seeing
> that patch...

I haven't addressed it yet.  Soon, very soon...

					-Alex


> Reviewed-by: Sage Weil<sage@newdream.net>
>
> On Tue, 28 Feb 2012, Alex Elder wrote:
>
>> Rename a few variables so it's clearer which indicate that a
>> CRC should be computed and which hold an actual CRC value.
>> Separate CRC calculation from byte swapping to improve
>> readability.  And move some code that runs on only on
>> the last pass through a couple of loops outside the loop
>> body.
>>
>> 					-Alex
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>

