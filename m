From: Joao Eduardo Luis <joao.luis@inktank.com>
Subject: Re: Few questions about Ceph
Date: Mon, 10 Dec 2012 22:01:17 +0000
Message-ID: <50C65BAD.8090608@inktank.com>
References: <CAGBmBz-CWSZM_QB9k+MG71VZzLV94VG7xhBaemPZqfqj1F2L4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:49239 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474Ab2LJWB3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Dec 2012 17:01:29 -0500
Received: by mail-ea0-f174.google.com with SMTP id e13so1267314eaa.19
        for <ceph-devel@vger.kernel.org>; Mon, 10 Dec 2012 14:01:28 -0800 (PST)
In-Reply-To: <CAGBmBz-CWSZM_QB9k+MG71VZzLV94VG7xhBaemPZqfqj1F2L4g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?QWxleGFuZHJlIE1hdW1lbsOp?= <alexandre@maumene.org>
Cc: ceph-devel@vger.kernel.org

On 12/10/2012 07:17 PM, Alexandre Maumen=C3=A9 wrote:
> Hello all,
>
> I have a few questions about Ceph:
>
> 1) Is it possible to run a cluster with "some" lantecy between monito=
r
> nodes? Latency will be 30ms at worst.

=46or the monitor, yes, that latency is acceptable. In between them, th=
e=20
monitors are pretty permissive with the timeouts they establish, so 30m=
s=20
should be okay. If it goes much higher than that however, you may start=
=20
noticing some clock drifting related messages. Anyway, you should be fi=
ne.

   -Joao
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
