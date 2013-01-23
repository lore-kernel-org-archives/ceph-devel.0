From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: MDS placement
Date: Wed, 23 Jan 2013 10:44:35 +0100
Message-ID: <CAJH6TXjdnrDYi0Zk+_OFSfLixCz4jsAE7X-0-SeyBiuNHtNXKA@mail.gmail.com>
References: <CAJH6TXhux_1-LMDrnUVZWFm2eUCkypwrh6_3czauCANE+RaC2g@mail.gmail.com>
	<50FF9A5F.4090801@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:41402 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754321Ab3AWJog (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Jan 2013 04:44:36 -0500
Received: by mail-we0-f175.google.com with SMTP id z53so2392589wey.6
        for <ceph-devel@vger.kernel.org>; Wed, 23 Jan 2013 01:44:35 -0800 (PST)
In-Reply-To: <50FF9A5F.4090801@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

2013/1/23 Wido den Hollander <wido@widodh.nl>:
> It should be located in the public network since clients need to be able to
> interact with it.

Ok.
Cluster network is only needed by OSDs ? No other devices should be
able to access it ?
