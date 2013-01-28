From: Dan Mick <dan.mick@inktank.com>
Subject: Re: RadosGW performance and disk space usage
Date: Sun, 27 Jan 2013 18:32:13 -0800
Message-ID: <5105E32D.3000308@inktank.com>
References: <CAJVE5RXTM4iARw=wpaUX_ofZgP6tHLjiG6JoakpbhEXf7ZgVLQ@mail.gmail.com> <CAKMAVE-JJVsinn4ys2o-p=b-7-_u9KGvd1fxwfMX0=44fS4T8w@mail.gmail.com> <51036B24.3070006@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:42263 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349Ab3A1CcR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 27 Jan 2013 21:32:17 -0500
Received: by mail-pa0-f42.google.com with SMTP id rl6so1230432pac.29
        for <ceph-devel@vger.kernel.org>; Sun, 27 Jan 2013 18:32:17 -0800 (PST)
In-Reply-To: <51036B24.3070006@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sam Lang <sam.lang@inktank.com>
Cc: Cesar Mello <cmello@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 1/25/2013 9:35 PM, Dan Mick wrote:
>
>>> If the S3 API is not well suited to my scenario, then my effort should
>>> be better directed to porting or writing a native ceph client for
>>> Windows. I just need an API to read and write/append blocks to files.
>>> Any comments are really appreciated.
>>
>> Hopefully someone with more windows experience will give you better
>> info/advice than I can.
>
> The python bindings should Just Work(tm).  Just a thought.

...but of course, as Sam points out, they rely on the C++ libs.  Duh. 
Sorry to mislead.
