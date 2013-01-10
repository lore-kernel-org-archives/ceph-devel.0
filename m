From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Ceph version 0.56.1, data loss on power failure
Date: Thu, 10 Jan 2013 14:58:14 +0100
Message-ID: <50EEC8F6.7060503@widodh.nl>
References: <CA+-7kDCRhRnijbEt2NxX2BgAqfF5fLaXoMOB7VUTCpeTgn9X9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:53508 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382Ab3AJN6O (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Jan 2013 08:58:14 -0500
In-Reply-To: <CA+-7kDCRhRnijbEt2NxX2BgAqfF5fLaXoMOB7VUTCpeTgn9X9Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Marcin Szukala <szukala.marcin@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 01/10/2013 02:54 PM, Marcin Szukala wrote:
> Hi,
>
> I hava a ubuntu 12.10 host with image mapped with rbd module. The
> problem is that when this host
> face a power failure all data on the mapped image is lost. If I unmap
> the image via the rbd unmap command, the data is preserved. I've
> noticed this problem also in version 0.56
>

What kind of filesystem are you using on the mapped RBD image?

Are you sure the filesystem isn't corrupted?

Which kernel are you using on the host, the stock kernel from Ubuntu 12.10?

Wido

> Best regards,
> Marcin
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

