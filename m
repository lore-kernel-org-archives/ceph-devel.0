From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: radosgw boto issue
Date: Thu, 17 Jan 2013 16:01:19 -0800
Message-ID: <CAC-hyiFHnbUObLorWYqS7rwX1CiovZsc0xOXU6GYvfNogiBAYg@mail.gmail.com>
References: <50F86DA5.4070502@umiacs.umd.edu>
	<CAC-hyiGOdY=F7a74u=f3=BK1VH2rB15SkDG+ezALhHd04tVRZw@mail.gmail.com>
	<50F88896.4090405@umiacs.umd.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f176.google.com ([209.85.210.176]:39896 "EHLO
	mail-ia0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211Ab3ARABU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Jan 2013 19:01:20 -0500
Received: by mail-ia0-f176.google.com with SMTP id i18so907995iac.21
        for <ceph-devel@vger.kernel.org>; Thu, 17 Jan 2013 16:01:19 -0800 (PST)
In-Reply-To: <50F88896.4090405@umiacs.umd.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: derek@umiacs.umd.edu
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

The vanilla mod_fastcgi doesn't handle 100-continue at all. We've
created a modified version that does handle it.

Yehuda

On Thu, Jan 17, 2013 at 3:26 PM, Derek Yarnell <derek@umiacs.umd.edu> wrote:
> On 1/17/13 4:47 PM, Yehuda Sadeh wrote:
>> rgw print continue = false
>
> Hi Yehuda,
>
> Thanks once again for a very helpful answer.  I am running apache with
> mod_fastcgi.  Is this a deficiency in mod_fastcgi/apache that doesn't
> deal with the 100-continue correctly?
>
> Thanks,
> derek
>
> --
> ---
> Derek T. Yarnell
> University of Maryland
> Institute for Advanced Computer Studies
