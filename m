From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: Request for ceph.conf environment extension
Date: Mon, 6 May 2013 14:36:39 +0200
Message-ID: <CAJH6TXgHoRocVNDvThbK6Wc65POD9E_bLSoOGuVJswGt7EqW=w@mail.gmail.com>
References: <20130506091822.GA26022@upset.ux.pdb.fsc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:51750 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753152Ab3EFMgl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 May 2013 08:36:41 -0400
Received: by mail-wg0-f51.google.com with SMTP id b13so3494245wgh.30
        for <ceph-devel@vger.kernel.org>; Mon, 06 May 2013 05:36:40 -0700 (PDT)
In-Reply-To: <20130506091822.GA26022@upset.ux.pdb.fsc.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Friedrich <andreas.friedrich@ts.fujitsu.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

2013/5/6 Andreas Friedrich <andreas.friedrich@ts.fujitsu.com>:
> To enable the LD_PRELOAD mechanism for the Ceph daemons only, a little
> generic extension in the global section of /etc/ceph/ceph.conf would
> be helpful, e.g.:
>
> [global]
>         environment = LD_PRELOAD=/usr/lib64/libsdp.so.1
>
> The appending patch adds 5 lines in the Bobtail (0.56.6) init script.
> The init script will then read the environment setting and - if present -
> call the Ceph daemons with the preceding environment string.

Cool! We are planning the same infrastructure with IB as networking.
Could you share more details about this?
 - which performance are you having and on which hardware?
 - any issue with IB and SDP?
 - are you able to use the newer rsockets and not SDP? It also has a
preloader library and is still developed (SDP is deprecated)
