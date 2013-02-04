From: Joao Eduardo Luis <joao.luis@inktank.com>
Subject: Re: CEPH HEALTH NOT OK ceph version 0.56.2.!!!
Date: Mon, 04 Feb 2013 13:29:41 +0000
Message-ID: <510FB7C5.6020106@inktank.com>
References: <CAPhYxPy=HqwYgZ9RfW0a9-LtDB2nTMOB33Hc6KhGcJ+zYfEmxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f49.google.com ([74.125.83.49]:38520 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754143Ab3BDNaT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Feb 2013 08:30:19 -0500
Received: by mail-ee0-f49.google.com with SMTP id d4so3090050eek.22
        for <ceph-devel@vger.kernel.org>; Mon, 04 Feb 2013 05:30:18 -0800 (PST)
In-Reply-To: <CAPhYxPy=HqwYgZ9RfW0a9-LtDB2nTMOB33Hc6KhGcJ+zYfEmxA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: femi anjorin <femi.anjorin@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 02/04/2013 12:21 PM, femi anjorin wrote:
> The mon is ok
> The mds is ok
> The osds were properly mount by mkcephfs -mkfs
>
> But "ceph health" wont respond  ok !!!

'ceph health detail' should provide further insight to what's happening.

   -Joao

