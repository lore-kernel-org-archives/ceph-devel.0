From: Derek Yarnell <derek@umiacs.umd.edu>
Subject: Re: RadosGW admin API
Date: Tue, 22 Apr 2014 10:05:47 -0400
Message-ID: <5356773B.60807@umiacs.umd.edu>
References: <CAK7XC_k+4epfF81F4kDmq7tS_R39-xpJi69Skw-GcBPrf24exw@mail.gmail.com>	<CABBk=J84CNCdhxKpbQ5U7gPYwRzhX7UGDjHOAQQqFz6MFSvN6A@mail.gmail.com>	<CAK7XC_=kmSUe0uFi6kMOLpTNXZp8h=FULNJD45LHxRx6CxfUOA@mail.gmail.com>	<CABBk=J93Us-K+BwcThsSgqe0ZvaudMUboUWcjspBGxy3m4v=PQ@mail.gmail.com> <CAK7XC_m4LrYY5Fzhqa6iP8ZL=XCSrDCeRyPS-OLXSPqXCF1ZJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from pompom.umiacs.umd.edu ([128.8.120.254]:45735 "EHLO
	pompom.umiacs.umd.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752807AbaDVOUp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Apr 2014 10:20:45 -0400
In-Reply-To: <CAK7XC_m4LrYY5Fzhqa6iP8ZL=XCSrDCeRyPS-OLXSPqXCF1ZJA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alain Dechorgnat <dechorgnata@gmail.com>, Yehuda Sadeh <yehuda@inktank.com>
Cc: derek@umiacs.umd.edu, ceph-devel <ceph-devel@vger.kernel.org>

On 4/22/14, 8:21 AM, Alain Dechorgnat wrote:
> Great, get /admin/metadata/user works fine.
> 
> This api is not in documentation, I was trying to find it out from
> sources and I saw others like log, opstate, replica_log and config.
> Is it planned to make doc about those apis? Maybe we can participate in this?
> 

Hi Alain,

I have written a python RadosGW admin[1] REST API for most of the
functionality up to emperor (bucket linking needs some testing).  I am
not sure it is useful for you or not.  I am working on some of the
features for firefly including quota support that hopefully will be
showing up soon as I am testing on the RC.

[1] - https://github.com/dyarnell/rgwadmin

Thanks,
derek

-- 
Derek T. Yarnell
University of Maryland
Institute for Advanced Computer Studies
