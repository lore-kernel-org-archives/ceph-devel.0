From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: Issue with radosgw in Ubuntu 13.10/emperor/fcgid
Date: Thu, 13 Mar 2014 08:19:04 -0700
Message-ID: <CABBk=J8BEfo0JomU1Km00_nz+T6JtXSj3DaM+t4FYj7O5BG89g@mail.gmail.com>
References: <29593_1394708284_53218F3C_29593_6617_1_B9C8EFBF13B1354DB5FA000660D66DD00C0D51E5@PEXCVZYM14.corporate.adroot.infra.ftgroup>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f169.google.com ([209.85.220.169]:52995 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754407AbaCMPTF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Mar 2014 11:19:05 -0400
Received: by mail-vc0-f169.google.com with SMTP id ik5so1291409vcb.28
        for <ceph-devel@vger.kernel.org>; Thu, 13 Mar 2014 08:19:04 -0700 (PDT)
In-Reply-To: <29593_1394708284_53218F3C_29593_6617_1_B9C8EFBF13B1354DB5FA000660D66DD00C0D51E5@PEXCVZYM14.corporate.adroot.infra.ftgroup>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ghislain.chevalier@orange.com
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Mar 13, 2014 at 3:58 AM,  <ghislain.chevalier@orange.com> wrote:
>
> Hi All,
>
> I currently try to install a radosgw/emperor on a dedicated server under Ubuntu 13.10
> This server is an exception in the cluster which is in Emperor under Ubuntu 12.04 LTS
>
> The apache2 and radosgw installation seem to be correct; I created a S3 user with a swift subuser but I get an error 500 trying to use it.
> I use fcgid module instead of fastcgi and so the configuration is quite different.
> FYI : I installed a radosgw/dumpling/fastcgi on another platform and it works well !!
>
> In radosgw log, I got no errors.
> In apache2 error log, I got
> [Thu Mar 13 11:38:15.584859 2014] [fcgid:warn] [pid 15279:tid 140016017676032] (104)Connection reset by peer: [client 10.194.182.60:43871] mod_fcgid: error reading data from FastCGI server
> [Thu Mar 13 11:38:15.584953 2014] [core:error] [pid 15279:tid 140016017676032] [client 10.194.182.60:43871] End of script output before headers: radosgw.fcgi
>
> I noticed that a radosgw script is launched at every http request...

Yeah, that  could be one of the issues with fcgid, not sure if there's
a way to tell it to just be static (as we do with mod_fastcgi), any
reason why you're using fcgid?

A 500 response usually means that apache was not able to communicate
with the radosgw backend. Not sure what the issue with your config, it
has been a while since I configured fcgid. Try bumping up the radosgw
logs (debug rgw = 20) to see if the requests do get there or not.


Yehuda

> I hope someone will find what is wrong in my configuration!!!
>
> Here are my configuration files.
>
> rgw.conf:
> <VirtualHost *:88>
> ServerName  r-cephrgw01
> DocumentRoot /var/www
> <IfModule mod_rewrite.c>
> RewriteEngine On
> RewriteRule ^/([a-zA-Z0-9-_.]*)([/]?.*) /radosgw.fcgi?page=$1&params=$2&%{QUERY_STRING} [E=HTTP_AUTHORIZATION:%{HTTP:Authorization},L]
> </IfModule>
> <IfModule mod_fcgid.c>
> <Directory /var/www>
> Options +ExecCGI
> AllowOverride All
> SetHandler fcgid-script
> FcgidWrapper "/usr/local/bin/radosgw -n client.radosgw.r-cephrgw01" .fcgi virtual
> Order allow,deny
> Allow from all
> AuthBasicAuthoritative Off
> </Directory>
> </IfModule>
> AllowEncodedSlashes On
> ServerSignature Off
> </VirtualHost>
>
>
> ceph.conf:
> [client.radosgw.r-cephrgw01]
> host = r-cephrgw01
> rgw_socket_path = /var/run/ceph/radosgw.sock
> keyring = /etc/ceph/keyring.radosgw.r-cephrgw01
> rgw_dns_name = r-cephrgw01
> log_file = /var/log/ceph/radosgw.log
> rgw_port = 88
> rgw_print_continue = false
> user = www-data
>
> radosgw.fcgi:
> #!/bin/sh
> exec /usr/local/bin/radosgw -c /etc/ceph/ceph.conf -n client.radosgw.r-cephrgw01
>
>
> User johndoe in radosgw:
> radosgw-admin user info --uid=johndoe
> { "user_id": "johndoe",
>   "display_name": "John Doe",
>   "email": "john@example.com",
>   "suspended": 0,
>   "max_buckets": 1000,
>   "auid": 0,
>   "subusers": [
>         { "id": "johndoe:swift",
>           "permissions": "full-control"}],
>   "keys": [
>         { "user": "johndoe",
>           "access_key": "s3johndoe",
>           "secret_key": "s3secret"}],
>   "swift_keys": [
>         { "user": "johndoe:swift",
>           "secret_key": "swsecret"}],
>   "caps": [],
>   "op_mask": "read, write, delete",
>   "default_placement": "",
>   "placement_tags": [],
>   "bucket_quota": { "enabled": false,
>       "max_size_kb": -1,
>       "max_objects": -1}}
>
>
> ceph auth list for radosgw client
> client.radosgw.r-cephrgw01
>         key: AQAvdwdTwMSvGxAAsctezTxARKVVq9sWsUmAPg==
>         caps: [mon] allow rw
>         caps: [osd] allow rwx
>
> - - - - - - - - - - - - - - - - -
> Ghislain Chevalier
> ORANGE/OLNC/OLPS/ASE/DAPI/CSE
> Storage Service Architect
>  +33299124432
> ghislain.chevalier@orange.com
>
> _________________________________________________________________________________________________________________________
>
> Ce message et ses pieces jointes peuvent contenir des informations confidentielles ou privilegiees et ne doivent donc
> pas etre diffuses, exploites ou copies sans autorisation. Si vous avez recu ce message par erreur, veuillez le signaler
> a l'expediteur et le detruire ainsi que les pieces jointes. Les messages electroniques etant susceptibles d'alteration,
> Orange decline toute responsabilite si ce message a ete altere, deforme ou falsifie. Merci.
>
> This message and its attachments may contain confidential or privileged information that may be protected by law;
> they should not be distributed, used or copied without authorisation.
> If you have received this email in error, please notify the sender and delete this message and its attachments.
> As emails may be altered, Orange is not liable for messages that have been modified, changed or falsified.
> Thank you.
>
