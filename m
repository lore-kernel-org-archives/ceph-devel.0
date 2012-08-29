From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Integration work
Date: Wed, 29 Aug 2012 15:40:22 +0200
Message-ID: <503E1BC6.8080308@widodh.nl>
References: <503D0A00.2080905@inktank.com> <CAF6-1L6QKQbgPZvXYMQw+0_vaLrP0cr_P0_nZs56Lh+A2B9k8Q@mail.gmail.com> <503DE69B.70804@widodh.nl> <CAF6-1L4sVnMsx79APO5X0zEEUyDoBD2PUvjTZw6Gzb7rgfpKkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:59613 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752717Ab2H2Nk2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Aug 2012 09:40:28 -0400
In-Reply-To: <CAF6-1L4sVnMsx79APO5X0zEEUyDoBD2PUvjTZw6Gzb7rgfpKkg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: Ross Turk <ross@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 08/29/2012 02:35 PM, Sylvain Munaut wrote:
>> Correct me if I'm wrong, but when I was at Citrix in May this year somebody
>> there told me that Xen was going 100% Qemu?
>
> Huh ... I've never heard this. Also the guys in ##xen haven't either.
> I'm not really involved in xen dev and don't follow it closely but
> that seems unlikely. The few slides I looked at from the Xen Summit a
> couple days ago show that they really like their PV model.
>

I must be wrong then!

> AFAIK QEMU is only used for HVM guests to emulate the hw. And even for
> those HVM guest, it's recommended to use PV drivers for performance
> which bypass the qemu layer all together.
>

Not sure where this came from then, but in that case it would take work 
from Citrix to get RBD in Xen.

Wido

> Cheers,
>
>      Sylvain
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

