From: Christian Huang <ythuang@gmail.com>
Subject: Re: CEPH RBD client kernel panic when OSD connection is lost on
 kernel 3.2, 3.5, 3.5.4
Date: Thu, 27 Sep 2012 09:34:57 +0800
Message-ID: <CAP5wSLf9-RhAhCzx33n8+KAbdxyxGtv5C1z99H+kFhxD7jB+tA@mail.gmail.com>
References: <CAP5wSLcy90qhsTnNxM=t+_SB1kpfNvchrSqdAG91P6tCe0RPRA@mail.gmail.com>
	<5060E5B5.8040807@inktank.com>
	<CAP5wSLeuLhJxrqmiaz8-4SXo_Sfzs8xY23UMO2O7vivnBMNDBg@mail.gmail.com>
	<50612747.6090805@inktank.com>
	<CAP5wSLcVt5AqbNoe=snK_2gCscAion-=s9YuPQo_KeYNVCx+oQ@mail.gmail.com>
	<CAP5wSLdBMjyF=4mUWDKYpi8yfG8qOA5gFr8iZ9_3DtdKM8x_0w@mail.gmail.com>
	<CAFtEh-cp6K5VGp0qp_mOpofckb0OWEiZHpMjnbbuUUpx_b18+g@mail.gmail.com>
	<5061A01B.8040303@inktank.com>
	<CAP5wSLcvnAgwK8LPgqbDO3V2pQPZnU7iw4tz0X2QAhrfwttZvg@mail.gmail.com>
	<5061D279.7070205@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:62056 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753600Ab2I0Be5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Sep 2012 21:34:57 -0400
Received: by ieak13 with SMTP id k13so3169471iea.19
        for <ceph-devel@vger.kernel.org>; Wed, 26 Sep 2012 18:34:57 -0700 (PDT)
In-Reply-To: <5061D279.7070205@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: Damien Churchill <damoxc@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi Alex,
    should we open an issue on the tracker to better track it?

Best Regards,
Chris

On Tue, Sep 25, 2012 at 11:49 PM, Alex Elder <elder@inktank.com> wrote:
> On 09/25/2012 09:38 AM, Christian Huang wrote:
>> Hi Alex,
>>      just realized I made a mistake on the provided environment
>> information for the additional verification, it's Ubuntu 12.04, not
>> 12.10.
>>      we use 12.04 with either stock kernel(3.2 series), or 3.5 from
>> ubuntu-quantal or 3.5/3.6 from kernel ppa.
>>
>> Best Regards.
>> Chris.
>
> FYI I believe I reproduced the problem.  If I find anything worth
> reporting I will share it with you.
>
> Thank you for your detailed problem description, it helps a lot.
>
>                                         -Alex
>
>
