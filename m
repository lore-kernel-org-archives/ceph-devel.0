From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: radosgw
Date: Wed, 23 Jan 2013 13:17:27 -0800
Message-ID: <CAC-hyiEURkZ6-4TEk79-P5xHxkxqZvstAWQ01YCS917T_5FY6A@mail.gmail.com>
References: <CAJH6TXg+7Sp=3_B047OG+KGQK00X5ZtKXAT+UB2KROBDaqVruA@mail.gmail.com>
	<CAC-hyiHsL3j9MviM1B0_hhEkt8GeLjeqbWn-ApE82+M+EQYmUA@mail.gmail.com>
	<CAJH6TXgocN-yWD930i+o80ATLLj5sXo+CcDvE4-JuWses7yPmQ@mail.gmail.com>
	<CAC-hyiFfeZY9ELrwRCkH5roMTjYys=SEN2SRsyLyNvx0zUD5Pw@mail.gmail.com>
	<CAJVE5RVuDCXRZTKqs5oRH09+BrJ_nf8XZuuixS944U9-HURPvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:62462 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899Ab3AWVR2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Jan 2013 16:17:28 -0500
Received: by mail-ie0-f178.google.com with SMTP id c12so14232487ieb.23
        for <ceph-devel@vger.kernel.org>; Wed, 23 Jan 2013 13:17:28 -0800 (PST)
In-Reply-To: <CAJVE5RVuDCXRZTKqs5oRH09+BrJ_nf8XZuuixS944U9-HURPvA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Cesar Mello <cmello@gmail.com>
Cc: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>, ceph-devel@vger.kernel.org

On Wed, Jan 23, 2013 at 1:08 PM, Cesar Mello <cmello@gmail.com> wrote:
> Now that I built from the sources I think I got stuck in this too. The logs:
>
> root@l3:/etc/ceph# cat /var/log/ceph/radosgw.log
> 2013-01-23 19:05:42.233438 7ff3dae2c780  0 ceph version
> 0.56-395-g371e6fb (371e6fbed624ececb385663a59dad907e9153d6a), process
> radosgw, pid 3811
> 2013-01-23 19:05:43.937851 7ff3c9ffb700  2 garbage collection: start
> 2013-01-23 19:06:12.234511 7ff3d2bbe700 -1 Initialization timeout,
> failed to initialize

Either your ceph backend is not completely healthy, or it cannot
connect to it. Try add some logging info (debug ms = 1 in your
ceph.conf). Also, try to verify that the ceph cluster is healthy (ceph
health, ceph -s). Finally make sure that the client.radosgw.gateway
user is configured correctly and can access the backend:

# rados -n client.radosgw.gateway lspools
# rados -n client.radosgw.gateway ls -p <name one of the existing pools>

Yehuda
