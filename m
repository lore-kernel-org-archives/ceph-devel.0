From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Assertion error in librados
Date: Tue, 25 Feb 2014 09:51:32 -0800
Message-ID: <530CD824.2000107@inktank.com>
References: <20140225144900.GA30739@philipgian-mac>	<CAPYLRzhnPTEgycnmZ0HXeEW=ADe01QKS8nUmL8451rYYtoMvgw@mail.gmail.com>	<20140225155838.GB30739@philipgian-mac> <CA+Hcz59dVj1CPiV6Xzo8_Z4WzhehNRiHyef_DE+MPBT19FHd4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:53854 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752598AbaBYRxg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Feb 2014 12:53:36 -0500
Received: by mail-pd0-f177.google.com with SMTP id g10so2428966pdj.8
        for <ceph-devel@vger.kernel.org>; Tue, 25 Feb 2014 09:53:35 -0800 (PST)
In-Reply-To: <CA+Hcz59dVj1CPiV6Xzo8_Z4WzhehNRiHyef_DE+MPBT19FHd4Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <noah.watkins@inktank.com>, Filippos Giannakos <philipgian@grnet.gr>
Cc: Gregory Farnum <greg@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, synnefo-devel@googlegroups.com

That's a good idea. This particular assert in a Mutex is almost always
a use-after-free of the Mutex or structure containing it though.

On 02/25/2014 09:33 AM, Noah Watkins wrote:
> Perhaps using gtest-style asserts (ASSERT_EQ(r, 0)) in Ceph would be
> useful so we can see parameter values to the assertion in the log. In
> this case, the return value from pthread_mutex_lock is almost
> certainly EINVAL, but it'd be informative to know for sure.
>
> On Tue, Feb 25, 2014 at 7:58 AM, Filippos Giannakos <philipgian@grnet.gr> wrote:
>> Hi Greg,
>>
>> Unfortunately we don't keep any Ceph related logs on the client side. On the
>> server side, we kept the default log settings to avoid overlogging.
>> Do you think that there might be something usefull on the OSD side ?
>>
>> On Tue, Feb 25, 2014 at 07:28:30AM -0800, Gregory Farnum wrote:
>>> Do you have logs? The assert indicates that the messenger got back
>>> something other than "okay" when trying to grab a local Mutex, which
>>> shouldn't be able to happen. It may be that some error-handling path
>>> didn't drop it (within the same thread that later tried to grab it
>>> again), but we'll need more details to track it down.

