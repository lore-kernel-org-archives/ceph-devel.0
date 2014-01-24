From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: creation of the puppet-ceph repository
Date: Fri, 24 Jan 2014 18:38:23 +0100
Message-ID: <CAJH6TXiHaqn7M7UF2EV_Py+D_pbQrOQQ78KrSLENGWuev6jx2Q@mail.gmail.com>
References: <52AC97E2.8080907@dachary.org>
	<CAJH6TXjCRiomcpt=QoSrdCsn8KSKUwW4hf9MHQtfk5yv7n_CUw@mail.gmail.com>
	<52E29EC0.4030405@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:56078 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997AbaAXRiY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Jan 2014 12:38:24 -0500
Received: by mail-we0-f177.google.com with SMTP id x55so2897627wes.8
        for <ceph-devel@vger.kernel.org>; Fri, 24 Jan 2014 09:38:23 -0800 (PST)
In-Reply-To: <52E29EC0.4030405@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

2014/1/24 Loic Dachary <loic@dachary.org>:
> Hi,
>
> At the moment the module can only be used to deploy mons. It's making slow progress but a number of patches went in Ceph and should significantly simplify writing the puppet module, starting in Firefly.


Based on docs, OSD seems to be deployable from puppet.
