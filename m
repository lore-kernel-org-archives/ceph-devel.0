From: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Subject: Ceph-deploy refuses to create a named daemon
Date: Mon, 13 Apr 2015 15:33:13 +1200
Message-ID: <552B38F9.5020506@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:50463 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542AbbDMDdX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 12 Apr 2015 23:33:23 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 04816322A7
	for <ceph-devel@vger.kernel.org>; Mon, 13 Apr 2015 15:33:15 +1200 (NZST)
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qyt81NHQbKkW for <ceph-devel@vger.kernel.org>;
	Mon, 13 Apr 2015 15:33:13 +1200 (NZST)
Received: from [192.168.1.64] (122-61-167-52.jetstream.xtra.co.nz [122.61.167.52])
	(Authenticated sender: mark.kirkwood)
	by mail.catalyst.net.nz (Postfix) with ESMTPSA id BC395322A1
	for <ceph-devel@vger.kernel.org>; Mon, 13 Apr 2015 15:33:13 +1200 (NZST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

I've been experimenting with the new rgw creation in ceph-deploy, using 
version 1.5.23 together with ceph 0.94 (-948-gd77de49).

If simply run it without any args, then it works fine. e.g:


$ ceph-deploy  rgw create ceph1


However if I try to set a name for the daemon:


$ ceph-deploy  rgw create ceph1:radosgw.ceph1


then it fails to create and start a radosgw daemon at all. Poking 
through the logs I see:

$ tail ceph-client.radosgw.ceph1.log
2015-04-13 14:13:20.513860 7f7e36c04840  0 librados: 
client.radosgw.ceph1 authentication error (1) Operation not permitted


Not terribly informative. Looking at the audit log:

$ tail ceph.audit.log
015-04-13 15:10:37.880085 mon.0 192.168.122.21:6789/0 147 : audit [INF] 
from='client.? 192.168.122.22:0/1004669' entity='client.bootstrap-rgw' 
cmd=[{"prefix": "auth get-or-create", "entity": "client.radosgw.ceph2", 
"caps": ["osd", "allow rwx", "mon", "allow rw"]}]:  access denied


Looking at what ceph-deploy is doing I see that the failing command is:


$ sudo ceph --cluster ceph --name client.bootstrap-rgw --keyring 
/var/lib/ceph/bootstrap-rgw/ceph.keyring auth get-or-create 
client.radosgw.ceph2 osd 'allow rwx' mon 'allow rw' -o 
/var/lib/ceph/radosgw/ceph-radosgw.ceph2/keyring


This is failing whereas the equivalent command with radosgw replaced by 
rgw works. Looking at what privileges client.bootstrap-rgw has I see:

$ sudo ceph auth get client.bootstrap-rgw
[client.bootstrap-rgw]
	key = XXXXXXXXXXXXXXXXXX==
	caps mon = "allow profile bootstrap-rgw"

Ah, so need to look at how the profile bootstrap-rgw is setup:

$ more src/mon/MonCap.cc
...
   if (profile == "bootstrap-rgw") {
     profile_grants.push_back(MonCapGrant("mon", MON_CAP_R));  // read 
monmap
     profile_grants.push_back(MonCapGrant("osd", MON_CAP_R));  // read 
osdmap
     profile_grants.push_back(MonCapGrant("mon getmap"));
     profile_grants.push_back(MonCapGrant("auth get-or-create"));  // 
FIXME: this can expose other mds keys
     profile_grants.back().command_args["entity"] = StringConstraint("", 
"client.rgw.");           <======
     profile_grants.back().command_args["caps_mon"] = 
StringConstraint("allow rw", "");
     profile_grants.back().command_args["caps_osd"] = 
StringConstraint("allow rwx", "");
   }
...

I see - the ["entity"] check requires the name to match "client.rgw.". 
Double checking back on the deployed host (ceph1), I see that:


$ ceph --cluster ceph --name client.bootstrap-rgw --keyring 
/var/lib/ceph/bootstrap-rgw/ceph.keyring auth get-or-create 
client.rgw.ceph3 osd 'allow rwx' mon 'allow rw'
[client.rgw.ceph3]
	key = AQCrNytVp9bqFBAAgTJVQDVQFJqiSkFqD68XsQ==
$ ceph --cluster ceph --name client.bootstrap-rgw --keyring 
/var/lib/ceph/bootstrap-rgw/ceph.keyring auth get-or-create 
client.radosgw.ceph3 osd 'allow rwx' mon 'allow rw'
Error EACCES: access denied

Ok so that is definitely the problem.

Is this restriction intended? If so we really should make ceph-deploy 
aware of this...as it is a bit of a foot gun (and not as easy as I made 
it seem above to figure out *why* the deploy didn't work).

Cheers

Mark

