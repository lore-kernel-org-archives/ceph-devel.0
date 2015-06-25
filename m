From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] libceph: Remove spurious kunmap() of the zero page
Date: Thu, 25 Jun 2015 12:12:32 +0300
Message-ID: <CAOi1vP-mSkuw5WHbV3ON7ipY8HG8tUd9O8Prs8fLpHFn0rCaFQ@mail.gmail.com>
References: <1435180719-12000-1-git-send-email-benoit.canet@nodalink.com>
	<1435180719-12000-2-git-send-email-benoit.canet@nodalink.com>
	<558B4CB9.3000907@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:33546 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751256AbbFYJMe convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Jun 2015 05:12:34 -0400
Received: by wiwl6 with SMTP id l6so11667964wiw.0
        for <ceph-devel@vger.kernel.org>; Thu, 25 Jun 2015 02:12:33 -0700 (PDT)
In-Reply-To: <558B4CB9.3000907@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: =?UTF-8?Q?Beno=C3=AEt_Canet?= <benoit.canet@nodalink.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Jun 25, 2015 at 3:35 AM, Alex Elder <elder@ieee.org> wrote:
> On 06/24/2015 04:18 PM, Beno=C3=AEt Canet wrote:
>>
>> ceph_tcp_sendpage already does the work of mapping/unmapping
>> the zero page if needed.
>>
>> Signed-off-by: Beno=C3=AEt Canet <benoit.canet@nodalink.com>
>
>
> This looks good.
>
> Reviewed-by: Alex Elder <elder@linaro.org>

Applied.

Thanks,

                Ilya
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
