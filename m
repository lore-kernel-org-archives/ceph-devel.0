From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH] remove unbalanced kunmap
Date: Wed, 24 Jun 2015 19:35:25 -0500
Message-ID: <558B4CCD.9070204@ieee.org>
References: <1435180719-12000-1-git-send-email-benoit.canet@nodalink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35345 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755323AbbFYAf1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Jun 2015 20:35:27 -0400
Received: by pactm7 with SMTP id tm7so38609276pac.2
        for <ceph-devel@vger.kernel.org>; Wed, 24 Jun 2015 17:35:26 -0700 (PDT)
In-Reply-To: <1435180719-12000-1-git-send-email-benoit.canet@nodalink.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?QmVub8OudCBDYW5ldA==?= <benoit.canet@nodalink.com>, ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com

On 06/24/2015 04:18 PM, Beno=C3=AEt Canet wrote:
> Spotted via visual inspection of the code.
>
> Beno=C3=AEt Canet (1):
>    libceph: Remove spurious kunmap() of the zero page
>
>   net/ceph/messenger.c | 1 -
>   1 file changed, 1 deletion(-)
>

I got no patch with this.  Is it just me?	-Alex
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
