From: Srikanth Madugundi <srikanth.madugundi@gmail.com>
Subject: Re: civetweb health check
Date: Thu, 6 Aug 2015 21:34:17 -0700
Message-ID: <CACAg-u9R4zjvteNyXN_LOv57J4VvAA5iZghi=zn==_u1k52gyQ@mail.gmail.com>
References: <CACAg-u9r6jXW7C5dWes3_AnkGkXvzS_vhmw044i4n0mAc31oUw@mail.gmail.com>
	<55C31A37.9050302@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:36676 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003AbbHGEeS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Aug 2015 00:34:18 -0400
Received: by igbij6 with SMTP id ij6so24377394igb.1
        for <ceph-devel@vger.kernel.org>; Thu, 06 Aug 2015 21:34:17 -0700 (PDT)
In-Reply-To: <55C31A37.9050302@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: ceph-devel@vger.kernel.org

hitting '/' endpoint worked.

Thanks
Srikanth

On Thu, Aug 6, 2015 at 1:26 AM, Wido den Hollander <wido@42on.com> wrote:
>
>
> On 05-08-15 18:37, Srikanth Madugundi wrote:
>> Hi,
>>
>> We are planning to move our radosgw setup from apache to civetweb. We
>> were successfully able to setup and run civetweb on a test cluster.
>>
>> The radosgw instances are fronted by a VIP with currently checks the
>> health by getting /status.html file, after moving to civetweb the vip
>> is unable to get the health of radosgw server using /status.html
>> endpoint and assumes the server is down.
>>
>> I looked at ceph radosgw documentation and did not find any
>> configuration to rewrite urls. What is the best approach for VIP to
>> get the health of radosgw?
>>
>
> You can simply query /
>
> This is what I use in Varnish to do a health check:
>
> backend rgw {
>     .host               = "127.0.0.1";
>     .port               = "7480";
>     .connect_timeout    = 1s;
>     .probe = {
>         .timeout   = 30s;
>         .interval  = 3s;
>         .window    = 10;
>         .threshold = 3;
>         .request =
>             "GET / HTTP/1.1"
>             "Host: localhost"
>             "User-Agent: Varnish-health-check"
>             "Connection: close";
>     }
> }
>
> Works fine, RGW will respond with a 200 OK in /
>
> Wido
>
>> Thanks
>> Srikanth
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
