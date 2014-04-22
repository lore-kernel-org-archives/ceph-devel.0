From: Alain Dechorgnat <dechorgnata@gmail.com>
Subject: Re: RadosGW admin API
Date: Tue, 22 Apr 2014 14:21:12 +0200
Message-ID: <CAK7XC_m4LrYY5Fzhqa6iP8ZL=XCSrDCeRyPS-OLXSPqXCF1ZJA@mail.gmail.com>
References: <CAK7XC_k+4epfF81F4kDmq7tS_R39-xpJi69Skw-GcBPrf24exw@mail.gmail.com>
	<CABBk=J84CNCdhxKpbQ5U7gPYwRzhX7UGDjHOAQQqFz6MFSvN6A@mail.gmail.com>
	<CAK7XC_=kmSUe0uFi6kMOLpTNXZp8h=FULNJD45LHxRx6CxfUOA@mail.gmail.com>
	<CABBk=J93Us-K+BwcThsSgqe0ZvaudMUboUWcjspBGxy3m4v=PQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:37449 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755594AbaDVMVN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Apr 2014 08:21:13 -0400
Received: by mail-la0-f42.google.com with SMTP id el20so841613lab.1
        for <ceph-devel@vger.kernel.org>; Tue, 22 Apr 2014 05:21:12 -0700 (PDT)
In-Reply-To: <CABBk=J93Us-K+BwcThsSgqe0ZvaudMUboUWcjspBGxy3m4v=PQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Great, get /admin/metadata/user works fine.

This api is not in documentation, I was trying to find it out from
sources and I saw others like log, opstate, replica_log and config.
Is it planned to make doc about those apis? Maybe we can participate in this?

Alain

2014-04-21 18:47 GMT+02:00 Yehuda Sadeh <yehuda@inktank.com>:
> On Fri, Apr 18, 2014 at 8:35 AM, Alain Dechorgnat <dechorgnata@gmail.com> wrote:
>> Thanks Yehuda for your confirmation
>>
>> I've found that I can get the user list by the command : radosgw-admin
>> metadata list user
>>
>> But I have never heard about the metadata api. What do you mean by this?
>
> There's a RESTful entry point for metadata operations. Off the top of
> my head for listing users you should do something like:
>
> GET /admin/metadata/user
>
> Let me know if this works for you (you'll need the 'metadata' read cap).
>
> Yehuda
>
>
>>
>>
>> 2014-04-18 17:07 GMT+02:00 Yehuda Sadeh <yehuda@inktank.com>:
>>
>>> On Fri, Apr 18, 2014 at 2:36 AM, Alain Dechorgnat <dechorgnata@gmail.com>
>>> wrote:
>>> > Hi all,
>>> >
>>> > I'm working on an administration GUI (Inkscope).
>>> > For this, I am using RadosGW admin API from python scripts and it's
>>> > working rather well.
>>> > I achieve to call getUserInfo for a user
>>> >
>>> > But, in Radosgw admin ops API documentation, it's said for getUserInfo:
>>> > " If no user is specified returns the list of all users along with
>>> > suspension information."
>>> >
>>> > But when I don't put the uid, I got a 403 Forbidden error.
>>> > In the radosgw.log file, I can see that signature is OK, op_mask is OK
>>> > but it return 403.
>>> > This happens on a Dumpling platform and an Emperor platform.
>>> >
>>> > Is this a bug in the documentation or the code, or am I doing something
>>> > wrong?
>>> >
>>>
>>> Looking at the code now, it sounds like a documentation issue. You
>>> should be able to list users through the metadata api.
>>>
>>> Yehuda
>>
>>
