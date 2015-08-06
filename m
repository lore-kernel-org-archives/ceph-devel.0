From: Wido den Hollander <wido@42on.com>
Subject: Re: civetweb health check
Date: Thu, 06 Aug 2015 10:26:31 +0200
Message-ID: <55C31A37.9050302@42on.com>
References: <CACAg-u9r6jXW7C5dWes3_AnkGkXvzS_vhmw044i4n0mAc31oUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:45982 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932137AbbHFI03 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 6 Aug 2015 04:26:29 -0400
In-Reply-To: <CACAg-u9r6jXW7C5dWes3_AnkGkXvzS_vhmw044i4n0mAc31oUw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Srikanth Madugundi <srikanth.madugundi@gmail.com>, ceph-devel@vger.kernel.org



On 05-08-15 18:37, Srikanth Madugundi wrote:
> Hi,
> 
> We are planning to move our radosgw setup from apache to civetweb. We
> were successfully able to setup and run civetweb on a test cluster.
> 
> The radosgw instances are fronted by a VIP with currently checks the
> health by getting /status.html file, after moving to civetweb the vip
> is unable to get the health of radosgw server using /status.html
> endpoint and assumes the server is down.
> 
> I looked at ceph radosgw documentation and did not find any
> configuration to rewrite urls. What is the best approach for VIP to
> get the health of radosgw?
> 

You can simply query /

This is what I use in Varnish to do a health check:

backend rgw {
    .host               = "127.0.0.1";
    .port               = "7480";
    .connect_timeout    = 1s;
    .probe = {
        .timeout   = 30s;
        .interval  = 3s;
        .window    = 10;
        .threshold = 3;
        .request =
            "GET / HTTP/1.1"
            "Host: localhost"
            "User-Agent: Varnish-health-check"
            "Connection: close";
    }
}

Works fine, RGW will respond with a 200 OK in /

Wido

> Thanks
> Srikanth
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
