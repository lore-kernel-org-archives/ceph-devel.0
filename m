From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: RadosGW load balancing
Date: Thu, 24 Jan 2013 15:53:50 +0100
Message-ID: <CAJH6TXgTnADHDGZdpVhOD74GMQQmuKLuRh0VTu7OhP6_NFx3UA@mail.gmail.com>
References: <CAJH6TXjmiySt5ieiUe0Xkg9LtGREm74i+6pOxbcd+SosQx3gKg@mail.gmail.com>
	<CAF6-1L7yppcsENR8=t7ZH1qKg7n2nBnnHTBx2ffE+x5tPPBFQQ@mail.gmail.com>
	<CAJH6TXg-gKKp2_dAL_wM4DLGGNh7OZOVoBZN8hHZgwd2JTS51A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:43125 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753890Ab3AXOxv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jan 2013 09:53:51 -0500
Received: by mail-wi0-f180.google.com with SMTP id hj13so518839wib.7
        for <ceph-devel@vger.kernel.org>; Thu, 24 Jan 2013 06:53:50 -0800 (PST)
In-Reply-To: <CAJH6TXg-gKKp2_dAL_wM4DLGGNh7OZOVoBZN8hHZgwd2JTS51A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: ceph-devel@vger.kernel.org

2013/1/24 Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>:
> Awesome. In this case I can bring up an nginx load balancer that will
> balance across 1,2 or 20 radosgw backend servers.

what about the authentication token? Is this managed by ceph or by radosgw?
If client will authenticate with radosgw1, are they also able to
execute APIs with radosgw2 with the same auth token?
