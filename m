From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH 1/2] libceph: tcp_nodelay support
Date: Fri, 23 Jan 2015 15:25:14 +0300
Message-ID: <CALFYKtBLqsLWGYOE41W9Kpsh77AW=xvfJ6J9BdPX_1=NfKz5yg@mail.gmail.com>
References: <alpine.DEB.2.10.1501231639250.28090@Ubuntu-VirtualBox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f50.google.com ([209.85.216.50]:46456 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753396AbbAWMZQ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Jan 2015 07:25:16 -0500
Received: by mail-qa0-f50.google.com with SMTP id k15so5504879qaq.9
        for <ceph-devel@vger.kernel.org>; Fri, 23 Jan 2015 04:25:15 -0800 (PST)
In-Reply-To: <alpine.DEB.2.10.1501231639250.28090@Ubuntu-VirtualBox>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chaitanya Huilgol <chaitanya.huilgol@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Jan 23, 2015 at 2:11 PM, Chaitanya Huilgol
<chaitanya.huilgol@gmail.com> wrote:
> Chaitanya Huilgol <chaitanya.huilgol@sandisk.com>
>
> TCP_NODELAY socket option set on connection sockets,
> disables Nagle=E2=80=99s algorithm and improves latency characteristi=
cs.
> tcp_nodelay(default)/no_tcp_nodelay option flags provided to
> enable/disable setting the socket option.
>
> Signed-off-by: Chaitanya Huilgol <chaitanya.huilgol@sandisk.com>

My minor nit is the "NO_TCP_NODELAY" and the ensuing things like

        if (!con->msgr->no_tcp_nodelay) {

We should probably do no_tcp_nodelay -> nagle internally to avoid this.

Reviewed-by: Ilya Dryomov <idryomov@redhat.com>

Thanks,

                Ilya
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
