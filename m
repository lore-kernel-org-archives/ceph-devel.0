From: Alain Dechorgnat <dechorgnata@gmail.com>
Subject: Re: RadosGW admin API
Date: Tue, 22 Apr 2014 17:04:06 +0200
Message-ID: <CAK7XC_keTEjiRpkv6YhUvovnxCXBxSpryu_C6TLCr_TwXd+Shw@mail.gmail.com>
References: <CAK7XC_k+4epfF81F4kDmq7tS_R39-xpJi69Skw-GcBPrf24exw@mail.gmail.com>
	<CABBk=J84CNCdhxKpbQ5U7gPYwRzhX7UGDjHOAQQqFz6MFSvN6A@mail.gmail.com>
	<CAK7XC_=kmSUe0uFi6kMOLpTNXZp8h=FULNJD45LHxRx6CxfUOA@mail.gmail.com>
	<CABBk=J93Us-K+BwcThsSgqe0ZvaudMUboUWcjspBGxy3m4v=PQ@mail.gmail.com>
	<CAK7XC_m4LrYY5Fzhqa6iP8ZL=XCSrDCeRyPS-OLXSPqXCF1ZJA@mail.gmail.com>
	<5356773B.60807@umiacs.umd.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:35797 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932934AbaDVPEH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Apr 2014 11:04:07 -0400
Received: by mail-la0-f43.google.com with SMTP id e16so4516204lan.30
        for <ceph-devel@vger.kernel.org>; Tue, 22 Apr 2014 08:04:06 -0700 (PDT)
In-Reply-To: <5356773B.60807@umiacs.umd.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Derek Yarnell <derek@umiacs.umd.edu>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Derek,

I looked at your work, it looks very good.
However, it does not correspond to the approach we had for writing a
UI for radosgw admin.

Alain

2014-04-22 16:05 GMT+02:00 Derek Yarnell <derek@umiacs.umd.edu>:
> On 4/22/14, 8:21 AM, Alain Dechorgnat wrote:
>> Great, get /admin/metadata/user works fine.
>>
>> This api is not in documentation, I was trying to find it out from
>> sources and I saw others like log, opstate, replica_log and config.
>> Is it planned to make doc about those apis? Maybe we can participate in this?
>>
>
> Hi Alain,
>
> I have written a python RadosGW admin[1] REST API for most of the
> functionality up to emperor (bucket linking needs some testing).  I am
> not sure it is useful for you or not.  I am working on some of the
> features for firefly including quota support that hopefully will be
> showing up soon as I am testing on the RC.
>
> [1] - https://github.com/dyarnell/rgwadmin
>
> Thanks,
> derek
>
> --
> Derek T. Yarnell
> University of Maryland
> Institute for Advanced Computer Studies
