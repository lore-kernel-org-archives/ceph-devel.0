From: Oleg Krasnianskiy <oleg.krasnianskiy@gmail.com>
Subject: Re: rados_clone_range for different pgs
Date: Tue, 8 Oct 2013 17:40:05 +0300
Message-ID: <CA+CdmLYG3m8VdG0dFsPE19BOi3SyLLBkss8JT20my3CebfQC_Q@mail.gmail.com>
References: <CA+CdmLbW+Tb2Wz1+DNJ4yFZ7-gDG1XsPfvKGZ-H5iJZQJ=QvZw@mail.gmail.com>
	<alpine.DEB.2.00.1308020615420.15391@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:56699 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754128Ab3JHOkH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Oct 2013 10:40:07 -0400
Received: by mail-ie0-f175.google.com with SMTP id aq17so38015iec.20
        for <ceph-devel@vger.kernel.org>; Tue, 08 Oct 2013 07:40:07 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1308020615420.15391@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

We use ceph to store huge files stripped into small (4mb) objects.
Due to the fact that files can be changed unpredictably (data
insertion/modification/deletion in any part of a file), we have to
copy parts of the objects and it is done via the client.
I see the following ways to solve this problem:
 - implement a client that is launched on the same host as the source
osd, that will handle the copy process
 - add functionality to the osd, so it can do copy to other osds

Which way best suits with the ceph ideology?

2013/8/2 Sage Weil <sage@inktank.com>:
> Hi Oleg,
>
> On Fri, 2 Aug 2013, Oleg Krasnianskiy wrote:
>> Hi
>>
>> I have asked this question in ceph-users, but did not get any
>> response, so I'll test my luck again, but with ceph-devel =)
>
> Sorry about that!
>
>> Is there any way to copy part of one object into another one if they
>> reside in different pgs?
>> There is rados_clone_range, but it requires both objects to be inside one pg.
>
> There is no way currently.  The clone_range can only (reliably) work on an
> OSD if it is stored with the same locator key; otherwise you have a ~R/N
> chance of that happening (where N is the number of OSDs, R is the number
> of replicas), which isn't worth optimizing for.  If the objects aren't
> stored together, you need to read and then write the data; this avoids
> adding additional complexity to the OSD for minimal gain.
>
> Do you have a use-case in mind where this functionality is important?
>
> sage
>
