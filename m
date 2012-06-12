From: Florian Haas <florian@hastexo.com>
Subject: "Radosgw installation and administration" docs
Date: Tue, 12 Jun 2012 12:44:56 +0200
Message-ID: <CAPUexz-nq-rs3CdougTBpiiur__W0royUcaMdYfpfamwkh7jNw@mail.gmail.com>
References: <4FD71854.6060503@hastexo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49]:64031 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752256Ab2FLKo5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Jun 2012 06:44:57 -0400
Received: by qabj40 with SMTP id j40so375340qab.1
        for <ceph-devel@vger.kernel.org>; Tue, 12 Jun 2012 03:44:56 -0700 (PDT)
In-Reply-To: <4FD71854.6060503@hastexo.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi everyone,

I have a long flight ahead of me later this week and plan to be
spending some time on http://ceph.com/docs/master/ops/radosgw/ -- which
currently happens to be a bit, ahem, sparse.

There's currently not a lot of documentation on radosgw, and some of it
is inconsistent, so if one of the devs could answer the following
questions, I can put them in a more comprehensive document that should
make radosgw easier to set up and run.

1. Apache rewrite rule

Is the Apache configuration example listed in the man page correct and
authoritative? Specifically, it seems unclear to me whether the
rewrite engine rule:

(RewriteRule ^/([a-zA-Z0-9-_.]*)([/]?.*)
/s3gw.fcgi?page=$1&params=$2&%{QUERY_STRING}
[E=HTTP_AUTHORIZATION:%{HTTP:Authorization},L])

... is expected to work only for compatibility with S3 clients, or
whether this rewrite rule is also for Swift clients.


2. FastCGI wrapper

The radosgw man page says it should be "exec /usr/bin/radosgw -c
/etc/ceph/ceph.conf -n client.radosgw.gateway", whereas the Wiki
(http://ceph.com/wiki/RADOS_Gateway) omits the -n option. I didn't get
it to work without the -n option, so is it safe to say that it is required?


3. Apache/radosgw daemon/FastCGI wrapper interaction

Is it safe to say that we always need all three of these? The man page indicates
so, the Wiki makes no mention of the daemon started by the init script.


4. FastCGI configuration directives

The man page mentions:
FastCgiExternalServer /var/www/s3gw.fcgi -socket /tmp/radosgw.sock

The Wiki says:
FastCgiWrapper /var/www/s3gw.fcgi
FastCgiServer /usr/bin/radosgw

https://github.com/ceph/teuthology/blob/master/teuthology/task/apache.conf
(which was mentioned as an additional reference on IRC at some point) says:
FastCgiIPCDir /tmp/cephtest/apache/tmp/fastcgi_sock
FastCgiExternalServer /tmp/cephtest/apache/htdocs/rgw.fcgi -socket rgw_sock

Which of these is required/preferred? -socket option or not? Wrapper,
Server or ExternalServer? IPCDir?


5. Logging

What's the preferred way of adding debug logging for radosgw?

https://github.com/ceph/teuthology/blob/master/teuthology/task/apache.conf
mentions:

SetEnv RGW_LOG_LEVEL 20
SetEnv RGW_PRINT_CONTINUE yes
SetEnv RGW_SHOULD_LOG yes

... but it's unclear to me whether this is still current (I found no
trace of those envars in the source, but maybe I was looking in the
wrong place).

https://github.com/ceph/ceph/commit/452b1248a68f743ad55641722da80e3fd5ad2ae9
touched the "debug rgw" option. If that is the preferred way of doing
things now, where should you set this? In ceph.conf, in the
[client.radosgw.<name>] section?

Also, for each of these, where would the logging output end up?
/var/log/ceph? Apache error log? If so, only if the Apache LogLevel is
more verbose than info? Syslog?


6. Swift API: Keys

Is it correct to assume that for any Swift client to work, we must set a
Swift key for the user, like so?

radosgw-admin key create --key-type=swift --uid=<user>

If so, is the secret_key that that creates for the user:

  "swift_keys": [
        { "user": "<user>",
          "secret_key": "<longbase64hash>"}]}


... the same key that the swift command line client expects to be set
with th -K option?


7. Swift API: swift user name

When we call "swift -U <user>", is that the verbatim user_id that we've
defined with "radosgw-admin user create --uid=<user_id>"? Or do we need
to set a prefix? Or define a separate Swift user ID?


8. Swift API: authentication version

When radosgw acts as the auth server for a Swift request, is it correct
to say that only v1.0 Swift authentication is supported, not v2.0?


9. Swift API: authentication URL

What's the correct Swift authentication URL for "swift -A <url>"? It
seems like it's "http://<rgw hostname>:<port>/auth", but confirmation
would help.

10. radosgw "OpenStack user" information

From the radosgw-admin man page:
       --os-user=group:name
              The OpenStack user (only needed for use with OpenStack)
       --os-secret=key
              The OpenStack key

What's this meant to be used for? Keystone authentication? If so, is
there anything else that needs to be done for Keystone to work with
this, such as add an endpoint URI?

Please feel free to point me to existing documentation where it
exists. Your help is much appreciated. Thanks!

Cheers,
Florian
