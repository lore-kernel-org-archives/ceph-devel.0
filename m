From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: "Radosgw installation and administration" docs
Date: Tue, 12 Jun 2012 09:47:50 -0700
Message-ID: <CAC-hyiEDLJTkDKXLgR64cPE5mcPvWUCs6kCCq+DiRaCtvDEEFQ@mail.gmail.com>
References: <4FD71854.6060503@hastexo.com>
	<CAPUexz-nq-rs3CdougTBpiiur__W0royUcaMdYfpfamwkh7jNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:34826 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753546Ab2FLQrw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Jun 2012 12:47:52 -0400
Received: by bkcji2 with SMTP id ji2so4694071bkc.19
        for <ceph-devel@vger.kernel.org>; Tue, 12 Jun 2012 09:47:51 -0700 (PDT)
In-Reply-To: <CAPUexz-nq-rs3CdougTBpiiur__W0royUcaMdYfpfamwkh7jNw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Florian Haas <florian@hastexo.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Jun 12, 2012 at 3:44 AM, Florian Haas <florian@hastexo.com> wro=
te:
> Hi everyone,
>
> I have a long flight ahead of me later this week and plan to be
> spending some time on http://ceph.com/docs/master/ops/radosgw/ -- whi=
ch
> currently happens to be a bit, ahem, sparse.
>
> There's currently not a lot of documentation on radosgw, and some of =
it
> is inconsistent, so if one of the devs could answer the following
> questions, I can put them in a more comprehensive document that shoul=
d
> make radosgw easier to set up and run.
>
> 1. Apache rewrite rule
>
> Is the Apache configuration example listed in the man page correct an=
d
> authoritative? Specifically, it seems unclear to me whether the
> rewrite engine rule:
>
> (RewriteRule ^/([a-zA-Z0-9-_.]*)([/]?.*)
> /s3gw.fcgi?page=3D$1&params=3D$2&%{QUERY_STRING}

We currently use a slightly different rule:

  RewriteRule             ^/(.*)
/radosgw.fcgi?params=3D$1&%{QUERY_STRING}
[E=3DHTTP_AUTHORIZATION:%{HTTP:Authorization},L]

> [E=3DHTTP_AUTHORIZATION:%{HTTP:Authorization},L])
>
> ... is expected to work only for compatibility with S3 clients, or
> whether this rewrite rule is also for Swift clients.

Not really needed for Swift. It's required for passing in the
HTTP_AUTHORIZATION env, however, Swift uses a different field which is
not filtered out by apache.
>
>
> 2. FastCGI wrapper
>
> The radosgw man page says it should be "exec /usr/bin/radosgw -c
> /etc/ceph/ceph.conf -n client.radosgw.gateway", whereas the Wiki
> (http://ceph.com/wiki/RADOS_Gateway) omits the -n option. I didn't ge=
t
> it to work without the -n option, so is it safe to say that it is req=
uired?

-n is required for specifying the ceph user that the gateway would
use. Without it it'd use client.admin is the default.

>
>
> 3. Apache/radosgw daemon/FastCGI wrapper interaction
>
> Is it safe to say that we always need all three of these? The man pag=
e indicates
> so, the Wiki makes no mention of the daemon started by the init scrip=
t.

The wrapper is not needed if not using apache for spawning the radosgw
processes. E.g.,  when using the FastCgiExternalServer param:

=46astCgiExternalServer /var/www/radosgw.fcgi -socket
/var/run/ceph/radosgw.client.radosgw


>
>
> 4. FastCGI configuration directives
>
> The man page mentions:
> FastCgiExternalServer /var/www/s3gw.fcgi -socket /tmp/radosgw.sock
>
> The Wiki says:
> FastCgiWrapper /var/www/s3gw.fcgi
> FastCgiServer /usr/bin/radosgw
>
> https://github.com/ceph/teuthology/blob/master/teuthology/task/apache=
=2Econf
> (which was mentioned as an additional reference on IRC at some point)=
 says:
> FastCgiIPCDir /tmp/cephtest/apache/tmp/fastcgi_sock
> FastCgiExternalServer /tmp/cephtest/apache/htdocs/rgw.fcgi -socket rg=
w_sock
>
> Which of these is required/preferred? -socket option or not? Wrapper,
> Server or ExternalServer? IPCDir?
>

Either one is required. We prefer using the external server option. We
found out that letting apache (or the fastcgi process manager)
managing was sub-optimal and was introducing high latencies.

>
> 5. Logging
>
> What's the preferred way of adding debug logging for radosgw?
>
> https://github.com/ceph/teuthology/blob/master/teuthology/task/apache=
=2Econf
> mentions:
>
> SetEnv RGW_LOG_LEVEL 20
> SetEnv RGW_PRINT_CONTINUE yes
> SetEnv RGW_SHOULD_LOG yes

All are obsolete and defunct, and have a corresponding ceph.conf conf:

debug rgw =3D 20
rgw print continue =3D true
rgw should log =3D true

the latter will be replaced soon by:

rgw enable usage log =3D true

Note that only the 'debug rgw' option is really related to debug logs.
The 'rgw print continue' option is a badly named option to control the
use of 100-continue (should the radosgw 'print' -- as in FCGX_FPrintF
-- the 100-continue when it should?). This can only work with a
modified mod_fastcgi that supports that.
The 'rgw should log' option sets whether we log each user operation to
the dedicated pool (so that it can be analyzed later on for billing,
etc.)

>
> ... but it's unclear to me whether this is still current (I found no
> trace of those envars in the source, but maybe I was looking in the
> wrong place).
>
> https://github.com/ceph/ceph/commit/452b1248a68f743ad55641722da80e3fd=
5ad2ae9
> touched the "debug rgw" option. If that is the preferred way of doing
> things now, where should you set this? In ceph.conf, in the
> [client.radosgw.<name>] section?

Either under the global section, or [client], or
[client.radosgw.<name>]. Depends on how you organize your conf.

>
> Also, for each of these, where would the logging output end up?
> /var/log/ceph? Apache error log? If so, only if the Apache LogLevel i=
s
> more verbose than info? Syslog?


The debug log would end up wherever you specified in the 'log file'
config option.


>
>
> 6. Swift API: Keys
>
> Is it correct to assume that for any Swift client to work, we must se=
t a
> Swift key for the user, like so?
>
> radosgw-admin key create --key-type=3Dswift --uid=3D<user>
>
> If so, is the secret_key that that creates for the user:
>
> =A0"swift_keys": [
> =A0 =A0 =A0 =A0{ "user": "<user>",
> =A0 =A0 =A0 =A0 =A0"secret_key": "<longbase64hash>"}]}
>
>
> ... the same key that the swift command line client expects to be set
> with th -K option?

Yes.

>
>
> 7. Swift API: swift user name
>
> When we call "swift -U <user>", is that the verbatim user_id that we'=
ve
> defined with "radosgw-admin user create --uid=3D<user_id>"? Or do we =
need
> to set a prefix? Or define a separate Swift user ID?
>

In swift the terminology is a bit different. There is the account and
under that there is the user. Since we already have a 'user' (which is
actually the swift account), we created a 'subuser'. So a one liner
user and swift-subuser creation would be as follows:

# radosgw-admin user create --subuser=3Dyehuda:yehuda1
--display-name=3DYehuda --key-type=3Dswift --access=3Dfull
{ "user_id": "yehuda",
  "rados_uid": 0,
  "display_name": "Yehuda",
  "email": "",
  "suspended": 0,
  "max_buckets": 1000,
  "subusers": [
        { "id": "yehuda:yehuda1",
          "permissions": "full-control"}],
  "keys": [],
  "swift_keys": [
        { "user": "yehuda:yehuda1",
          "secret_key": "7TD5f2QrwxkCnhthwowC4d9uEJ4mnX8nGsXjmnW8"}]}

The --access=3Dfull will give the subuser a full access to the account;
other options would be read, write, readwrite.


>
> 8. Swift API: authentication version
>
> When radosgw acts as the auth server for a Swift request, is it corre=
ct
> to say that only v1.0 Swift authentication is supported, not v2.0?

Yeah. Currently radosgw serves as v1.0 authenticator.
>
>
> 9. Swift API: authentication URL
>
> What's the correct Swift authentication URL for "swift -A <url>"? It
> seems like it's "http://<rgw hostname>:<port>/auth", but confirmation
> would help.

Confirmed.

>
> 10. radosgw "OpenStack user" information
>
> From the radosgw-admin man page:
> =A0 =A0 =A0 --os-user=3Dgroup:name
> =A0 =A0 =A0 =A0 =A0 =A0 =A0The OpenStack user (only needed for use wi=
th OpenStack)
> =A0 =A0 =A0 --os-secret=3Dkey
> =A0 =A0 =A0 =A0 =A0 =A0 =A0The OpenStack key

Obsolete. That was the old way to configure swift users.

>
> What's this meant to be used for? Keystone authentication? If so, is
> there anything else that needs to be done for Keystone to work with
> this, such as add an endpoint URI?

iirc, the swift protocol provides the endpoint URI in the HTTP header,
so if the token was generated by another swift authenticator, we'd try
to authenticate against it. I'm not familiar with keystone, and
whether it's supposed to work with it.

>
> Please feel free to point me to existing documentation where it
> exists. Your help is much appreciated. Thanks!
>

That's my radosgw ceph.conf that I'm using in my test environment.

[client]
        admin socket =3D /tmp/radosgw.adsock
        debug ms =3D 1
        rgw socket path =3D /tmp/.radosgw.sock
        auth supported =3D none
        log file =3D /var/log/radosgw/radosgw.log
        debug rgw =3D 20
        rgw cache enabled =3D 1
;       rgw swift url =3D http://skinny
;       rgw swift url prefix =3D swift
        rgw dns name =3D skinny
        rgw cache lru size =3D 1000
        rgw enable ops log =3D false
;       rgw print continue =3D false

[mon.a]
        host =3D swab
        mon addr =3D 192.168.106.223:14090

That's my apache site conf:

=46astCgiExternalServer /var/www/web1/web/radosgw.fcgi -socket /tmp/.ra=
dosgw.sock

<VirtualHost *:80>
  ServerName skinny.ops.newdream.net
  ServerAlias skinny
  ServerAdmin webmaster@example1.com
  DocumentRoot /var/www/web1/web/

  #turn engine on
  RewriteEngine On

  #following is important for S3/rados
  RewriteRule             ^/(.*)
/radosgw.fcgi?params=3D$1&%{QUERY_STRING}
[E=3DHTTP_AUTHORIZATION:%{HTTP:Authorization},L]

  <IfModule mod_fastcgi.c>
    SuexecUserGroup web1 web1
    # PHP_Fix_Pathinfo_Enable 1
    <Directory /var/www/web1/web/>
      Options +ExecCGI
      AllowOverride None
      SetHandler fastcgi-script
      Order allow,deny
      Allow from all
      AuthBasicAuthoritative Off
    </Directory>
  </IfModule>

  AllowEncodedSlashes On

  ErrorLog /var/log/apache2/error.log
  CustomLog /var/log/apache2/access.log combined
  ServerSignature Off

#  DumpIOInput On
#  DumpIOOutput On

</VirtualHost>


Thanks,
Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
