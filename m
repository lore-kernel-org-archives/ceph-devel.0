From: Noah Watkins <noah.watkins@inktank.com>
Subject: Re: Assertion error in librados
Date: Tue, 25 Feb 2014 09:33:48 -0800
Message-ID: <CA+Hcz59dVj1CPiV6Xzo8_Z4WzhehNRiHyef_DE+MPBT19FHd4Q@mail.gmail.com>
References: <20140225144900.GA30739@philipgian-mac>
	<CAPYLRzhnPTEgycnmZ0HXeEW=ADe01QKS8nUmL8451rYYtoMvgw@mail.gmail.com>
	<20140225155838.GB30739@philipgian-mac>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:63542 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752653AbaBYRdt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Feb 2014 12:33:49 -0500
Received: by mail-qc0-f176.google.com with SMTP id r5so6349757qcx.7
        for <ceph-devel@vger.kernel.org>; Tue, 25 Feb 2014 09:33:48 -0800 (PST)
In-Reply-To: <20140225155838.GB30739@philipgian-mac>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Filippos Giannakos <philipgian@grnet.gr>
Cc: Gregory Farnum <greg@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, synnefo-devel@googlegroups.com

Perhaps using gtest-style asserts (ASSERT_EQ(r, 0)) in Ceph would be
useful so we can see parameter values to the assertion in the log. In
this case, the return value from pthread_mutex_lock is almost
certainly EINVAL, but it'd be informative to know for sure.

On Tue, Feb 25, 2014 at 7:58 AM, Filippos Giannakos <philipgian@grnet.gr> wrote:
> Hi Greg,
>
> Unfortunately we don't keep any Ceph related logs on the client side. On the
> server side, we kept the default log settings to avoid overlogging.
> Do you think that there might be something usefull on the OSD side ?
>
> On Tue, Feb 25, 2014 at 07:28:30AM -0800, Gregory Farnum wrote:
>> Do you have logs? The assert indicates that the messenger got back
>> something other than "okay" when trying to grab a local Mutex, which
>> shouldn't be able to happen. It may be that some error-handling path
>> didn't drop it (within the same thread that later tried to grab it
>> again), but we'll need more details to track it down.
>> -Greg
>> Software Engineer #42 @ http://inktank.com | http://ceph.com
>>
>
> Kind Regards,
> --
> Filippos
> <philipgian@grnet.gr>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
