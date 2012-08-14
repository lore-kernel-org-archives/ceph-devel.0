From: John Axel Eriksson <john@insane.se>
Subject: Re: Radosgw nginx config
Date: Tue, 14 Aug 2012 18:37:38 +0200
Message-ID: <CAMmJxtLWLRrkFq_Z+NqAaqHkMY5+iOX1tOZMBfDuDptxNpxPHg@mail.gmail.com>
References: <CAJGA66vj5zNVfSff2m26ZYD7cauAqrqkximc0myzBN8oUUFtLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:51566 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752551Ab2HNQhj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Aug 2012 12:37:39 -0400
Received: by vcbfk26 with SMTP id fk26so529558vcb.19
        for <ceph-devel@vger.kernel.org>; Tue, 14 Aug 2012 09:37:38 -0700 (PDT)
In-Reply-To: <CAJGA66vj5zNVfSff2m26ZYD7cauAqrqkximc0myzBN8oUUFtLA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Senner, Talin" <senner@wildcardcorp.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

We too really prefer nginx but have chosen Apache for RadosGW. The
reason is that we don't like how Nginx does fastcgi. Basically what
happens, for example, when you PUT something to radosgw through nginx
is that nginx buffers the data until you've sent it all then it starts
sending it to radosgw so:
client -> nginx (wait until nginx received it)
then nginx -> radosgw (client still waiting for response until done).

PUTing 1 GB of data is nicer through Apache really and more
responsive. If you find a way to make nginx NOT buffer fastcgi, please
do tell.

John

On Tue, Aug 14, 2012 at 5:25 PM, Senner, Talin <senner@wildcardcorp.com> wrote:
> All,
>
> I did not see this in the online wiki, but we prefer nginx in most all
> deployments as wel like the ease of config a little better.  Below
> find the minimal nginx configuration block for fascgi to the radosgw
> socket.  Some clients S3/Swift require https  so you'll have to add
> that in as well. This seems to be working okay for us, although we
> haven't tested it significantly.
>
> We hope this helps anybody that is looking for nginx/fastcgi and the
> rados gw (and can be added to the online docs after some further
> testing)
>
> Thanks
>
> Talin
>
> http {
> .....
>
> #if you want caching add below and uncomment the sections in server block:
>
>
>       fastcgi_cache_path   /tmp/cache  levels=1:2
>                        keys_zone=NAME:10m
>                        inactive=5m;
>
>          fastcgi_cache_key "$scheme$request_method$host$request_uri";
>
>
> ...
> }
>
> server {
>         listen   80; ## listen for ipv4; this line is default and implied
>         #listen   [::]:80 default ipv6only=on; ## listen for ipv6
>
>         root /usr/share/nginx/www;
>         index index.html index.htm;
>
>         server_name _ ;
>
>         location / {
>
>   fastcgi_param  QUERY_STRING     $query_string;
>   fastcgi_param  REQUEST_METHOD   $request_method;
>   fastcgi_param  CONTENT_TYPE     $content_type;
>   fastcgi_param  CONTENT_LENGTH   $content_length;
>
> #             fastcgi_cache   NAME;
> #      fastcgi_cache_valid   200 302  1h;
> #      fastcgi_cache_valid   301      1d;
> #      fastcgi_cache_valid   any      1m;
> #      fastcgi_cache_min_uses  1;
> #      fastcgi_cache_use_stale error  timeout invalid_header http_500;
>
>       fastcgi_pass_header Authorization;
>       fastcgi_pass_request_headers on;
>
>                 fastcgi_pass unix:/tmp/radosgw.sock;
>                 include fastcgi_params;
>         }
>
> }
>
>
>
>
> Talin Senner
> Wildcard Corp.
>
> http://cdig.me  -  http://www.wildcardcorp.com
> Secure Web CMS Hosting - CDN - DNS - IPv6
>
> Security.Technology.Solutions
> *We do it all for you*
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
