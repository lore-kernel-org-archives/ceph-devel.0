From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: RadosGW load balancing
Date: Thu, 24 Jan 2013 15:52:55 +0100
Message-ID: <CAJH6TXg-gKKp2_dAL_wM4DLGGNh7OZOVoBZN8hHZgwd2JTS51A@mail.gmail.com>
References: <CAJH6TXjmiySt5ieiUe0Xkg9LtGREm74i+6pOxbcd+SosQx3gKg@mail.gmail.com>
	<CAF6-1L7yppcsENR8=t7ZH1qKg7n2nBnnHTBx2ffE+x5tPPBFQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:33735 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754159Ab3AXOw4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jan 2013 09:52:56 -0500
Received: by mail-wg0-f44.google.com with SMTP id dr12so5859780wgb.11
        for <ceph-devel@vger.kernel.org>; Thu, 24 Jan 2013 06:52:55 -0800 (PST)
In-Reply-To: <CAF6-1L7yppcsENR8=t7ZH1qKg7n2nBnnHTBx2ffE+x5tPPBFQQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: ceph-devel@vger.kernel.org

2013/1/24 Sylvain Munaut <s.munaut@whatever-company.com>:
> The radosgw process doesn't have any state of its own. Every important thing
> is stored in the ceph cluster itself.

Awesome. In this case I can bring up an nginx load balancer that will
balance across 1,2 or 20 radosgw backend servers.
