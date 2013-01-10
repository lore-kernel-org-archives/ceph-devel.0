From: Marcin Szukala <szukala.marcin@gmail.com>
Subject: Re: Ceph version 0.56.1, data loss on power failure
Date: Thu, 10 Jan 2013 17:56:52 +0100
Message-ID: <CA+-7kDAxr7pa2MsVxsdxH5BLghDwDMs+SrKZhpAcJSjXwG=RuQ@mail.gmail.com>
References: <CA+-7kDCRhRnijbEt2NxX2BgAqfF5fLaXoMOB7VUTCpeTgn9X9Q@mail.gmail.com>
	<CAF6-1L7otPweDqmq-MzEnO+TU5aHSZ3JKW+SaqG740Hw5q9ULA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:49107 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753467Ab3AJQ4x (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Jan 2013 11:56:53 -0500
Received: by mail-la0-f54.google.com with SMTP id fp12so867329lab.27
        for <ceph-devel@vger.kernel.org>; Thu, 10 Jan 2013 08:56:52 -0800 (PST)
In-Reply-To: <CAF6-1L7otPweDqmq-MzEnO+TU5aHSZ3JKW+SaqG740Hw5q9ULA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: ceph-devel@vger.kernel.org

Hi,

Scenario is correct but the last line. I can mount the image, but the
data that was written to the image before power failure is lost.

Currently the ceph cluster is not healthy, but i dont think its
related because I had this issue before the cluster itsef had issues
(about that I will write in different post not to mix topics).

Regards,
Marcin


2013/1/10 Sylvain Munaut <s.munaut@whatever-company.com>:
> Hi,
>
>> I hava a ubuntu 12.10 host with image mapped with rbd module. The
>> problem is that when this host
>> face a power failure all data on the mapped image is lost. If I unmap
>> the image via the rbd unmap command, the data is preserved. I've
>> noticed this problem also in version 0.56
>
> Make sure you use a recent kernel (like latest 3.6.x or more recent).
>
> I remember having RBD corruption and panics when I was using 3.2
> series, but since I moved to recent RBD code, it never happenned
> again.
>
> Cheers,
>
>     Sylvain
