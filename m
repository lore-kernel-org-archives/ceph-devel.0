From: Alex Elder <elder@inktank.com>
Subject: Re: CEPH RBD client kernel panic when OSD connection is lost on kernel
 3.2, 3.5, 3.5.4
Date: Tue, 25 Sep 2012 10:49:13 -0500
Message-ID: <5061D279.7070205@inktank.com>
References: <CAP5wSLcy90qhsTnNxM=t+_SB1kpfNvchrSqdAG91P6tCe0RPRA@mail.gmail.com> <5060E5B5.8040807@inktank.com> <CAP5wSLeuLhJxrqmiaz8-4SXo_Sfzs8xY23UMO2O7vivnBMNDBg@mail.gmail.com> <50612747.6090805@inktank.com> <CAP5wSLcVt5AqbNoe=snK_2gCscAion-=s9YuPQo_KeYNVCx+oQ@mail.gmail.com> <CAP5wSLdBMjyF=4mUWDKYpi8yfG8qOA5gFr8iZ9_3DtdKM8x_0w@mail.gmail.com> <CAFtEh-cp6K5VGp0qp_mOpofckb0OWEiZHpMjnbbuUUpx_b18+g@mail.gmail.com> <5061A01B.8040303@inktank.com> <CAP5wSLcvnAgwK8LPgqbDO3V2pQPZnU7iw4tz0X2QAhrfwttZvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:54518 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757148Ab2IYPtR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Sep 2012 11:49:17 -0400
Received: by ieak13 with SMTP id k13so14258061iea.19
        for <ceph-devel@vger.kernel.org>; Tue, 25 Sep 2012 08:49:17 -0700 (PDT)
In-Reply-To: <CAP5wSLcvnAgwK8LPgqbDO3V2pQPZnU7iw4tz0X2QAhrfwttZvg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Huang <ythuang@gmail.com>
Cc: Damien Churchill <damoxc@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 09/25/2012 09:38 AM, Christian Huang wrote:
> Hi Alex,
>      just realized I made a mistake on the provided environment
> information for the additional verification, it's Ubuntu 12.04, not
> 12.10.
>      we use 12.04 with either stock kernel(3.2 series), or 3.5 from
> ubuntu-quantal or 3.5/3.6 from kernel ppa.
> 
> Best Regards.
> Chris.

FYI I believe I reproduced the problem.  If I find anything worth
reporting I will share it with you.

Thank you for your detailed problem description, it helps a lot.

					-Alex


