From: Alex Elder <elder@inktank.com>
Subject: Re: CEPH RBD client kernel panic when OSD connection is lost on kernel
 3.2, 3.5, 3.5.4
Date: Tue, 25 Sep 2012 07:14:19 -0500
Message-ID: <5061A01B.8040303@inktank.com>
References: <CAP5wSLcy90qhsTnNxM=t+_SB1kpfNvchrSqdAG91P6tCe0RPRA@mail.gmail.com> <5060E5B5.8040807@inktank.com> <CAP5wSLeuLhJxrqmiaz8-4SXo_Sfzs8xY23UMO2O7vivnBMNDBg@mail.gmail.com> <50612747.6090805@inktank.com> <CAP5wSLcVt5AqbNoe=snK_2gCscAion-=s9YuPQo_KeYNVCx+oQ@mail.gmail.com> <CAP5wSLdBMjyF=4mUWDKYpi8yfG8qOA5gFr8iZ9_3DtdKM8x_0w@mail.gmail.com> <CAFtEh-cp6K5VGp0qp_mOpofckb0OWEiZHpMjnbbuUUpx_b18+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:43290 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507Ab2IYMOW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Sep 2012 08:14:22 -0400
Received: by ieak13 with SMTP id k13so13621091iea.19
        for <ceph-devel@vger.kernel.org>; Tue, 25 Sep 2012 05:14:21 -0700 (PDT)
In-Reply-To: <CAFtEh-cp6K5VGp0qp_mOpofckb0OWEiZHpMjnbbuUUpx_b18+g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Damien Churchill <damoxc@gmail.com>
Cc: Christian Huang <ythuang@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 09/25/2012 04:26 AM, Damien Churchill wrote:
> On 25 September 2012 07:09, Christian Huang <ythuang@gmail.com> wrote:
>>     we used Ubuntu 12.10 as base OS
> 
> Just a heads up, the 3.5.0-15.22 kernel in 12.10 has that patch already.
> 
> 

Thanks, I've been working with the 3.2.0 kernel from the logs provided
and I guess I didn't look at that kernel's source before sending it.

Chris has provided a pretty small and detailed recipe for reproducing
it so I'm hoping to have some luck doing so this morning.

					-Alex
