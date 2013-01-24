From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: radosgw: "MethodNotAllowed" response for AWS C# Sample
Date: Wed, 23 Jan 2013 18:26:55 -0800
Message-ID: <CAC-hyiFH43_15vqXgJv3gq7zMgUTqv=UpCOhgEWUZGFq8Htixw@mail.gmail.com>
References: <CAJVE5RWMk8sbeLt52OuV+18aZeDa4J5x48x1bLyjSqT8RE4apw@mail.gmail.com>
	<CAC-hyiF5j_V4_Oou_6JSkDTBJzWLxWb+W=w_7YWhrEuv5WO8BQ@mail.gmail.com>
	<CAJVE5RWoK_v7vFS=V60FtZsd_Z9EfCsFkqrwpSygJXG9qk8uig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:52108 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752987Ab3AXC05 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Jan 2013 21:26:57 -0500
Received: by mail-la0-f52.google.com with SMTP id fs12so2503248lab.25
        for <ceph-devel@vger.kernel.org>; Wed, 23 Jan 2013 18:26:56 -0800 (PST)
In-Reply-To: <CAJVE5RWoK_v7vFS=V60FtZsd_Z9EfCsFkqrwpSygJXG9qk8uig@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Cesar Mello <cmello@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Jan 23, 2013 at 6:13 PM, Cesar Mello <cmello@gmail.com> wrote:
> Yes the radosgw log shows the request. The handler->get_op call is
> returning null at rgw/rgw_main.cc (RGWProcess::handle_request).
>
> I've confirmed putting this log:
>
>   if (!op) {
>
>     req->log(s, "get_op failed!");
>     abort_early(s, -ERR_METHOD_NOT_ALLOWED);
>     goto done;
>   }
>
> I'm pasting a copy of the log below. Any suggestion for helping me
> debug this by myself is appreciated.
>
> Thanks for the attention!
>
> Best regards
> Mello
>
> 2013-01-24 00:06:32.935275 7f2ec1c28780 20 enqueued request req=0x194c9c0
> 2013-01-24 00:06:32.935317 7f2ec1c28780 20 RGWWQ:
> 2013-01-24 00:06:32.935327 7f2ec1c28780 20 req: 0x194c9c0
> 2013-01-24 00:06:32.935344 7f2ec1c28780 10 allocated request req=0x1951ef0
> 2013-01-24 00:06:32.935357 7f2e5a79c700 20 dequeued request req=0x194c9c0
> 2013-01-24 00:06:32.935379 7f2e5a79c700 20 RGWWQ: empty
> 2013-01-24 00:06:32.935387 7f2e5a79c700  1 ====== starting new request
> req=0x194c9c0 =====
> 2013-01-24 00:06:32.935458 7f2e5a79c700  2 req 1:0.000071::::initializing
> 2013-01-24 00:06:32.935470 7f2e5a79c700  2 req
> 1:0.000084::::initializing do MELLO
> 2013-01-24 00:06:32.935500 7f2e5a79c700 10 meta>> HTTP_X_AMZ_DATE=Thu,
> 24 Jan 2013 02:06:35 GMT
> 2013-01-24 00:06:32.935521 7f2e5a79c700 10 x>> x-amz-date:Thu, 24 Jan
> 2013 02:06:35 GMT
> 2013-01-24 00:06:32.935569 7f2e5a79c700 10 s->object=<NULL> s->bucket=<NULL>
> 2013-01-24 00:06:32.935583 7f2e5a79c700 20 FCGI_ROLE=RESPONDER
> 2013-01-24 00:06:32.935584 7f2e5a79c700 20 SCRIPT_URL=/
> 2013-01-24 00:06:32.935585 7f2e5a79c700 20 SCRIPT_URI=http://my-new-bucket.l3/
> 2013-01-24 00:06:32.935586 7f2e5a79c700 20 HTTP_AUTHORIZATION=AWS
> JJABVJ3AWBS1ZOCML7NS:iASHPmV0rFQH5/zPslZDs4Wa+A8=
> 2013-01-24 00:06:32.935587 7f2e5a79c700 20
> HTTP_USER_AGENT=aws-sdk-dotnet/1.5.10.0 .NET Runtime/4.0 .NET
> Framework/4.0 OS/6.0.6002.131072 S3Sync
> 2013-01-24 00:06:32.935590 7f2e5a79c700 20 HTTP_X_AMZ_DATE=Thu, 24 Jan
> 2013 02:06:35 GMT
> 2013-01-24 00:06:32.935591 7f2e5a79c700 20 HTTP_HOST=my-new-bucket.l3
> 2013-01-24 00:06:32.935592 7f2e5a79c700 20 CONTENT_LENGTH=0
> 2013-01-24 00:06:32.935593 7f2e5a79c700 20 HTTP_CONNECTION=Keep-Alive
> 2013-01-24 00:06:32.935594 7f2e5a79c700 20 PATH=/usr/local/bin:/usr/bin:/bin
> 2013-01-24 00:06:32.935595 7f2e5a79c700 20 SERVER_SIGNATURE=
> 2013-01-24 00:06:32.935596 7f2e5a79c700 20
> SERVER_SOFTWARE=Apache/2.2.22 (Ubuntu)
> 2013-01-24 00:06:32.935597 7f2e5a79c700 20 SERVER_NAME=my-new-bucket.l3
> 2013-01-24 00:06:32.935598 7f2e5a79c700 20 SERVER_ADDR=192.168.25.2
> 2013-01-24 00:06:32.935601 7f2e5a79c700 20 SERVER_PORT=80
> 2013-01-24 00:06:32.935602 7f2e5a79c700 20 REMOTE_ADDR=192.168.25.3
> 2013-01-24 00:06:32.935603 7f2e5a79c700 20 DOCUMENT_ROOT=/var/www
> 2013-01-24 00:06:32.935604 7f2e5a79c700 20 SERVER_ADMIN=cmello@gmail.com
> 2013-01-24 00:06:32.935605 7f2e5a79c700 20 SCRIPT_FILENAME=/var/www/s3gw.fcgi
> 2013-01-24 00:06:32.935606 7f2e5a79c700 20 REMOTE_PORT=50190
> 2013-01-24 00:06:32.935606 7f2e5a79c700 20 GATEWAY_INTERFACE=CGI/1.1
> 2013-01-24 00:06:32.935607 7f2e5a79c700 20 SERVER_PROTOCOL=HTTP/1.1
> 2013-01-24 00:06:32.935608 7f2e5a79c700 20 REQUEST_METHOD=PUT
> 2013-01-24 00:06:32.935609 7f2e5a79c700 20 QUERY_STRING=page=&params=
> 2013-01-24 00:06:32.935610 7f2e5a79c700 20 REQUEST_URI=/
> 2013-01-24 00:06:32.935611 7f2e5a79c700 20 SCRIPT_NAME=/
> 2013-01-24 00:06:32.935619 7f2e5a79c700  2 req 1:0.000233:s3:PUT /::getting op
> 2013-01-24 00:06:32.935625 7f2e5a79c700  2 req 1:0.000239:s3:PUT
> /::get_op failed!
> 2013-01-24 00:06:32.935687 7f2e5a79c700  2 req 1:0.000301:s3:PUT
> /::http status=405
> 2013-01-24 00:06:32.935781 7f2e5a79c700  1 ====== req done
> req=0x194c9c0 http_status=405 ======
> 2013-01-24 00:06:33.056517 7f2d5e7fc700  1 -- 127.0.0.1:0/1008137 <==
> osd.1 127.0.0.1:6804/5559 49 ==== osd_op_reply(77 gc.31 [call] ack =
> 0) v4 ==== 104+0+0 (4138896711 0 0) 0x7f2d3c000d40 con 0x7f2d48002260
>
>

It's using the bucket virtual subdomain calling convention, but you
haven't set up 'rgw dns name'.

Yehuda
