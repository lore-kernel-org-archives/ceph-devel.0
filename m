From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH] Avoid holding the zero page on slab init failure
Date: Thu, 25 Jun 2015 09:10:52 -0500
Message-ID: <558C0BEC.3050309@ieee.org>
References: <1435195676-2873-1-git-send-email-benoit.canet@nodalink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:34961 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786AbbFYOKy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Jun 2015 10:10:54 -0400
Received: by pdbci14 with SMTP id ci14so54257935pdb.2
        for <ceph-devel@vger.kernel.org>; Thu, 25 Jun 2015 07:10:54 -0700 (PDT)
In-Reply-To: <1435195676-2873-1-git-send-email-benoit.canet@nodalink.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?QmVub8OudCBDYW5ldA==?= <benoit.canet@nodalink.com>, ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com

On 06/24/2015 08:27 PM, Beno=C3=AEt Canet wrote:
> Spotted by visual inspection.
>
> Applies on libceph: Remove spurious kunmap() of the zero page.
>
> Beno=C3=AEt Canet (1):
>    libceph: Avoid holding the zero page on ceph_msgr_slab_init errors
>
>   net/ceph/messenger.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>

Benoit, in cases where you have just a single patch, there is
no need to include an additional mail message like this one.

If you have a series, that's when you'll supply a PATCH 0/N
message.

					-Alex
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
