From: Bassam Tabbara <Bassam.Tabbara@quantum.com>
Subject: Re: enabling shared ccache dirs in default builds
Date: Wed, 7 Dec 2016 00:19:44 +0000
Message-ID: <EF2107A2-04C1-498E-9E33-0872E51AFA65@quantum.com>
References: <CAJ4mKGZSnN+RE7d5wrzghmtWZA1w1e7NT8JeW4nArwVdijggkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx05-000ceb01.pphosted.com ([67.231.144.126]:37574 "EHLO
        mx04-000ceb01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750960AbcLGAmr (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Dec 2016 19:42:47 -0500
In-Reply-To: <CAJ4mKGZSnN+RE7d5wrzghmtWZA1w1e7NT8JeW4nArwVdijggkQ@mail.gmail.com>
Content-Language: en-US
Content-ID: <A6EE8CA9733EE1409D63469DADC63E69@QUANTUM.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

> The default (or at least, ./do_cmake.sh-setup) Ceph build makes use of
> cmake. This is nice for speeding up builds, but as the amount of disk
> space increases it really explodes disk usage on dev boxes. As of
> today, a Ceph repo with build artifacts is ~30GB, and my ccache
> directory is ~32GB.
> 

One option is to limit the ccache size by creating a conf file as such:

> cat ~/.ccache/ccache.conf 
max_size = 10G


