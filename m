From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: RadosGW load balancing
Date: Thu, 24 Jan 2013 16:13:52 +0100
Message-ID: <CAF6-1L43GanOAZJ=CpzBEe_uJQ2Ctwc-XKu7C1+nafQxDZ9KVw@mail.gmail.com>
References: <CAJH6TXjmiySt5ieiUe0Xkg9LtGREm74i+6pOxbcd+SosQx3gKg@mail.gmail.com>
	<CAF6-1L7yppcsENR8=t7ZH1qKg7n2nBnnHTBx2ffE+x5tPPBFQQ@mail.gmail.com>
	<CAJH6TXg-gKKp2_dAL_wM4DLGGNh7OZOVoBZN8hHZgwd2JTS51A@mail.gmail.com>
	<CAJH6TXgTnADHDGZdpVhOD74GMQQmuKLuRh0VTu7OhP6_NFx3UA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:53512 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753445Ab3AXPNx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jan 2013 10:13:53 -0500
Received: by mail-ob0-f178.google.com with SMTP id eh20so9797919obb.9
        for <ceph-devel@vger.kernel.org>; Thu, 24 Jan 2013 07:13:52 -0800 (PST)
In-Reply-To: <CAJH6TXgTnADHDGZdpVhOD74GMQQmuKLuRh0VTu7OhP6_NFx3UA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: ceph-devel@vger.kernel.org

>> Awesome. In this case I can bring up an nginx load balancer that will
>> balance across 1,2 or 20 radosgw backend servers.
>
> what about the authentication token? Is this managed by ceph or by radosgw?
> If client will authenticate with radosgw1, are they also able to
> execute APIs with radosgw2 with the same auth token?

Mmm, AFAIK each S3 request is authenticated separately by a signature.

The users and their secret is stored in the cluster and available to
all gateways.

Cheers,

    Sylvain
