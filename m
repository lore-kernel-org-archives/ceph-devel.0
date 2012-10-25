From: Dan Mick <dan.mick@inktank.com>
Subject: Re: Seeking review of a pull request in teuthology
Date: Wed, 24 Oct 2012 21:01:25 -0700
Message-ID: <5088B995.7030008@inktank.com>
References: <508893F7.4070502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:47693 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750712Ab2JYEB2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Oct 2012 00:01:28 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so841339pad.19
        for <ceph-devel@vger.kernel.org>; Wed, 24 Oct 2012 21:01:28 -0700 (PDT)
In-Reply-To: <508893F7.4070502@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joe Buck <jbbuck@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

LGTM.  I might emphasize "user" rather than "owner", but that's clearly 
a nit.   Also, does this now obviate the #TODO?

On 10/24/2012 06:20 PM, Joe Buck wrote:
> I submitted a pull request for teuthology/task/workunit.py that uses the
> configured owner rather than using the hard-coded "ubuntu" username when
> creating a scratch directory in /tmp.
>
> -Joe Buck
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
