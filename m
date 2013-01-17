From: Derek Yarnell <derek@umiacs.umd.edu>
Subject: Re: radosgw boto issue
Date: Thu, 17 Jan 2013 18:26:14 -0500
Message-ID: <50F88896.4090405@umiacs.umd.edu>
References: <50F86DA5.4070502@umiacs.umd.edu> <CAC-hyiGOdY=F7a74u=f3=BK1VH2rB15SkDG+ezALhHd04tVRZw@mail.gmail.com>
Reply-To: derek@umiacs.umd.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from pompom.umiacs.umd.edu ([128.8.120.254]:37061 "EHLO
	pompom.umiacs.umd.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120Ab3AQXl1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Jan 2013 18:41:27 -0500
In-Reply-To: <CAC-hyiGOdY=F7a74u=f3=BK1VH2rB15SkDG+ezALhHd04tVRZw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: derek@umiacs.umd.edu, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 1/17/13 4:47 PM, Yehuda Sadeh wrote:
> rgw print continue = false

Hi Yehuda,

Thanks once again for a very helpful answer.  I am running apache with
mod_fastcgi.  Is this a deficiency in mod_fastcgi/apache that doesn't
deal with the 100-continue correctly?

Thanks,
derek

-- 
---
Derek T. Yarnell
University of Maryland
Institute for Advanced Computer Studies
