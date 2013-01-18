From: Dan Mick <dan.mick@inktank.com>
Subject: Re: radosgw boto issue
Date: Thu, 17 Jan 2013 16:37:32 -0800
Message-ID: <50F8994C.1020609@inktank.com>
References: <50F86DA5.4070502@umiacs.umd.edu> <CAC-hyiGOdY=F7a74u=f3=BK1VH2rB15SkDG+ezALhHd04tVRZw@mail.gmail.com> <50F88896.4090405@umiacs.umd.edu> <CAC-hyiFHnbUObLorWYqS7rwX1CiovZsc0xOXU6GYvfNogiBAYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f42.google.com ([209.85.210.42]:58687 "EHLO
	mail-da0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752076Ab3ARAhg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Jan 2013 19:37:36 -0500
Received: by mail-da0-f42.google.com with SMTP id z17so1362511dal.29
        for <ceph-devel@vger.kernel.org>; Thu, 17 Jan 2013 16:37:35 -0800 (PST)
In-Reply-To: <CAC-hyiFHnbUObLorWYqS7rwX1CiovZsc0xOXU6GYvfNogiBAYg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: derek@umiacs.umd.edu, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Derek, see

http://ceph.com/docs/master/radosgw/manual-install/

for details.

On 01/17/2013 04:01 PM, Yehuda Sadeh wrote:
> The vanilla mod_fastcgi doesn't handle 100-continue at all. We've
> created a modified version that does handle it.
>
> Yehuda
>
> On Thu, Jan 17, 2013 at 3:26 PM, Derek Yarnell <derek@umiacs.umd.edu> wrote:
>> On 1/17/13 4:47 PM, Yehuda Sadeh wrote:
>>> rgw print continue = false
>>
>> Hi Yehuda,
>>
>> Thanks once again for a very helpful answer.  I am running apache with
>> mod_fastcgi.  Is this a deficiency in mod_fastcgi/apache that doesn't
>> deal with the 100-continue correctly?
>>
>> Thanks,
>> derek
>>
>> --
>> ---
>> Derek T. Yarnell
>> University of Maryland
>> Institute for Advanced Computer Studies
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
