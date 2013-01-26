From: Dan Mick <dan.mick@inktank.com>
Subject: Re: RadosGW performance and disk space usage
Date: Fri, 25 Jan 2013 21:35:32 -0800
Message-ID: <51036B24.3070006@inktank.com>
References: <CAJVE5RXTM4iARw=wpaUX_ofZgP6tHLjiG6JoakpbhEXf7ZgVLQ@mail.gmail.com> <CAKMAVE-JJVsinn4ys2o-p=b-7-_u9KGvd1fxwfMX0=44fS4T8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:58882 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750751Ab3AZFff (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 26 Jan 2013 00:35:35 -0500
Received: by mail-pa0-f48.google.com with SMTP id fa1so638151pad.35
        for <ceph-devel@vger.kernel.org>; Fri, 25 Jan 2013 21:35:35 -0800 (PST)
In-Reply-To: <CAKMAVE-JJVsinn4ys2o-p=b-7-_u9KGvd1fxwfMX0=44fS4T8w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sam Lang <sam.lang@inktank.com>
Cc: Cesar Mello <cmello@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


>> If the S3 API is not well suited to my scenario, then my effort should
>> be better directed to porting or writing a native ceph client for
>> Windows. I just need an API to read and write/append blocks to files.
>> Any comments are really appreciated.
>
> Hopefully someone with more windows experience will give you better
> info/advice than I can.

The python bindings should Just Work(tm).  Just a thought.
