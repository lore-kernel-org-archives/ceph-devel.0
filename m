From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: RadosGW load balancing
Date: Thu, 24 Jan 2013 15:45:12 +0100
Message-ID: <CAF6-1L7yppcsENR8=t7ZH1qKg7n2nBnnHTBx2ffE+x5tPPBFQQ@mail.gmail.com>
References: <CAJH6TXjmiySt5ieiUe0Xkg9LtGREm74i+6pOxbcd+SosQx3gKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:56649 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753483Ab3AXOpN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jan 2013 09:45:13 -0500
Received: by mail-ob0-f171.google.com with SMTP id lz20so4099565obb.2
        for <ceph-devel@vger.kernel.org>; Thu, 24 Jan 2013 06:45:12 -0800 (PST)
In-Reply-To: <CAJH6TXjmiySt5ieiUe0Xkg9LtGREm74i+6pOxbcd+SosQx3gKg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi,

> Is possible to load balance multiple radosgw servers?

Yes, Just use a http load balancer to redirect to several backend servers.


> Which kind of datas should be shared between each machine or is it
> fully stateless?

The radosgw process doesn't have any state of its own. Every important thing
is stored in the ceph cluster itself.

Cheers,

     Sylvain
