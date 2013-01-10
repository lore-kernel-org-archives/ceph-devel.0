From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: Ceph version 0.56.1, data loss on power failure
Date: Thu, 10 Jan 2013 15:40:36 +0100
Message-ID: <CAF6-1L7otPweDqmq-MzEnO+TU5aHSZ3JKW+SaqG740Hw5q9ULA@mail.gmail.com>
References: <CA+-7kDCRhRnijbEt2NxX2BgAqfF5fLaXoMOB7VUTCpeTgn9X9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:57024 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753100Ab3AJOkh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Jan 2013 09:40:37 -0500
Received: by mail-ob0-f182.google.com with SMTP id 16so604700obc.27
        for <ceph-devel@vger.kernel.org>; Thu, 10 Jan 2013 06:40:36 -0800 (PST)
In-Reply-To: <CA+-7kDCRhRnijbEt2NxX2BgAqfF5fLaXoMOB7VUTCpeTgn9X9Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Marcin Szukala <szukala.marcin@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi,

> I hava a ubuntu 12.10 host with image mapped with rbd module. The
> problem is that when this host
> face a power failure all data on the mapped image is lost. If I unmap
> the image via the rbd unmap command, the data is preserved. I've
> noticed this problem also in version 0.56

Make sure you use a recent kernel (like latest 3.6.x or more recent).

I remember having RBD corruption and panics when I was using 3.2
series, but since I moved to recent RBD code, it never happenned
again.

Cheers,

    Sylvain
