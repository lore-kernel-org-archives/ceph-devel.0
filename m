From: =?ISO-8859-1?Q?Sz=E9kelyi?= Szabolcs <szekelyi@niif.hu>
Subject: Keys & caps
Date: Mon, 09 Jul 2012 18:07:48 +0200
Message-ID: <4183318.yLl07ggMzS@mranderson>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.ki.iif.hu ([193.6.222.244]:51427 "EHLO strudel.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751389Ab2GIQH6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 9 Jul 2012 12:07:58 -0400
Received: from bolha.lvs.iif.hu (bolha.lvs.iif.hu [193.225.14.181])
	by strudel.ki.iif.hu (Postfix) with ESMTP id 20CBD3E8
	for <ceph-devel@vger.kernel.org>; Mon,  9 Jul 2012 18:07:57 +0200 (CEST)
Received: from strudel.ki.iif.hu ([IPv6:::ffff:193.6.222.244])
	by bolha.lvs.iif.hu (bolha.lvs.iif.hu [::ffff:193.225.14.72]) (amavisd-new, port 10024)
	with ESMTP id hZOw1PWO806z for <ceph-devel@vger.kernel.org>;
	Mon,  9 Jul 2012 18:07:50 +0200 (CEST)
Received: from mranderson.localnet (unknown [IPv6:2001:738:0:410:7506:f08e:836e:869b])
	by strudel.ki.iif.hu (Postfix) with ESMTPSA id E007F3BE
	for <ceph-devel@vger.kernel.org>; Mon,  9 Jul 2012 18:07:49 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

this far I accessed my Ceph (0.48) FS with the client.admin key, but I'd like 
to change that since I don't want to allow clients to control the cluster.

I thought I should create a new key, give it some caps (don't exactly know 
which ones), and distribute it to clients. Here are some things I don't 
know/understand:

* What do the r, w, x, and * caps ("permissions"?) mean on a mon, mds, or osd?

* What's the difference between (for example) 'allow rw' and 'rw' caps? `ceph 
auth` seems to understand (and display as specified) both forms.

Not to run into issues with caps, I've created a key with the same caps as the 
current client.admin, but with a different key, called client.access_fs. I 
planned to narrow down the caps after I made the mount work with the new key.

$ sudo ceph auth list
installed auth entries: 
[...]
client.access_fs
        key: AQ...==
        caps: [mds] allow
        caps: [mon] allow *
        caps: [osd] allow *
[...]

I've copied the key to the client as /etc/ceph/keyring:

[client.access_fs]
        key = AQ...==

I have 'keyring = /etc/ceph/keyring' in my ceph.conf [global] section on the 
client. Now trying to mount the filesystem fails with

$ sudo mount /mnt/ceph
ceph-fuse[1784]: starting ceph client
ceph-fuse[1784]: ceph mount failed with (1) Operation not permitted
ceph-fuse[1782]: mount failed: (1) Operation not permitted

Adding '-o name=client.access_fs' to the command line yields the same result. 
If I copy the client.admin key into the keyring file, it works. (However, 
adding the same mount option again (so the name= parameter and the key name in 
the file do not match), I get an error (which seems okay to me, not sure about 
the correctness):

$ sudo mount /cloud/ -o name=client.access_fs
ceph-fuse[1835]: starting ceph client
ceph-fuse[1835]: starting fuse
fuse: unknown option `name=client.access_fs'
2012-07-09 16:03:18.343793 7fb0e7b8b780 -1 fuse_lowlevel_new failed
ceph-fuse[1835]: fuse finished with error 33
ceph-fuse[1833]: mount failed: (33) Numerical argument out of domain

Could you clear up the confusion in my head? :)

Thanks,
-- 
cc


