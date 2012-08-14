From: "Senner, Talin" <senner@wildcardcorp.com>
Subject: Radosgw nginx config
Date: Tue, 14 Aug 2012 10:25:16 -0500
Message-ID: <CAJGA66vj5zNVfSff2m26ZYD7cauAqrqkximc0myzBN8oUUFtLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:57494 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752733Ab2HNPZx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Aug 2012 11:25:53 -0400
Received: by qcro28 with SMTP id o28so346441qcr.19
        for <ceph-devel@vger.kernel.org>; Tue, 14 Aug 2012 08:25:49 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

All,

I did not see this in the online wiki, but we prefer nginx in most all
deployments as wel like the ease of config a little better.  Below
find the minimal nginx configuration block for fascgi to the radosgw
socket.  Some clients S3/Swift require https  so you'll have to add
that in as well. This seems to be working okay for us, although we
haven't tested it significantly.

We hope this helps anybody that is looking for nginx/fastcgi and the
rados gw (and can be added to the online docs after some further
testing)

Thanks

Talin

http {
.....

#if you want caching add below and uncomment the sections in server block:


      fastcgi_cache_path   /tmp/cache  levels=1:2
                       keys_zone=NAME:10m
                       inactive=5m;

         fastcgi_cache_key "$scheme$request_method$host$request_uri";


...
}

server {
        listen   80; ## listen for ipv4; this line is default and implied
        #listen   [::]:80 default ipv6only=on; ## listen for ipv6

        root /usr/share/nginx/www;
        index index.html index.htm;

        server_name _ ;

        location / {

  fastcgi_param  QUERY_STRING     $query_string;
  fastcgi_param  REQUEST_METHOD   $request_method;
  fastcgi_param  CONTENT_TYPE     $content_type;
  fastcgi_param  CONTENT_LENGTH   $content_length;

#             fastcgi_cache   NAME;
#      fastcgi_cache_valid   200 302  1h;
#      fastcgi_cache_valid   301      1d;
#      fastcgi_cache_valid   any      1m;
#      fastcgi_cache_min_uses  1;
#      fastcgi_cache_use_stale error  timeout invalid_header http_500;

      fastcgi_pass_header Authorization;
      fastcgi_pass_request_headers on;

                fastcgi_pass unix:/tmp/radosgw.sock;
                include fastcgi_params;
        }

}




Talin Senner
Wildcard Corp.

http://cdig.me  -  http://www.wildcardcorp.com
Secure Web CMS Hosting - CDN - DNS - IPv6

Security.Technology.Solutions
*We do it all for you*
