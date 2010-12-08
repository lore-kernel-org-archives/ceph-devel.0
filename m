From: Brian Chrisman <brchrisman@gmail.com>
Subject: installation: where do I start debugging this error?
Date: Tue, 7 Dec 2010 17:53:14 -0800
Message-ID: <AANLkTinfNC1fXqynJ8abp8Ms8GpkLN806MgpCvGaJiCe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:35250 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932068Ab0LHBxO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Dec 2010 20:53:14 -0500
Received: by qwa26 with SMTP id 26so638355qwa.19
        for <ceph-devel@vger.kernel.org>; Tue, 07 Dec 2010 17:53:14 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I've built and installed RPMs for ceph for RHEL6beta.
I've placed the below ceph.conf in /etc/ceph on both of my test nodes
(test10, test11).

I build a ceph filesystem and hide the key
mkcephfs -c /etc/ceph/ceph.conf -a --mkbtrfs -k /etc/ceph/keyring.bin
cauthtool --print-key /etc/ceph/keyring.bin > /etc/ceph/secret
chmod 600 /etc/ceph/secret
scp -p /etc/ceph/secret test11:/etc/ceph

Then I start the daemons on each node:
service ceph start

My daemons start up on both nodes with 'service ceph -a start'
root      3199     1  0 17:18 ?        00:00:00 /usr/local/bin/cmon -i
0 -c /tmp/ceph.conf.5365
root      3228     1  0 17:18 ?        00:00:00 /usr/local/bin/cmds -i
test10 -c /tmp/ceph.conf.5365
root      3285     1  0 17:18 ?        00:00:00 /usr/local/bin/cosd -i
0 -c /tmp/ceph.conf.5365
(similar output on other node)

I attempt to mount the ceph filesystem on test10 (using test11's IP):
mount -t ceph -o name=admin,secretfile=/etc/ceph/keyring.bin
10.200.98.111:/ /mnt/ceph
mount error 5 = Input/output error

/var/log/messages seems to show me what the problem is:
Dec  7 17:45:19 test10 kernel: libceph: mon0 10.200.98.111:6789
connection failed
(a few more of those before mount fails)
on test11, the daemon is up and listening on that port:
tcp        0      0 10.200.98.111:6789          10.200.98.111:56805
     ESTABLISHED 7781/cmon

And here's /var/log/ceph/mon.1.log on test11 (the .111 node)
2010-12-07 17:36:20.136921 --- 7780 opened log /var/log/ceph/mon.1.log ---
ceph version 0.24~rc (commit:378d13df9505e4ea9a32f42cb713cdcf7aaccda0)
2010-12-07 17:36:20.137164 7f80c51e3720 store(/data/mon1) mount
2010-12-07 17:36:20.138241 7f80c51e3720 mon.1@1(starting) e1 init fsid
1b4cabdb-30d2-752d-005f-517a7fa982f8
2010-12-07 17:36:20.165407 7f80c51e3720 log [INF] : mon.1 calling new
monitor election
2010-12-07 17:36:20.192343 7f80c51e1710 -- 10.200.98.111:6789/0 >>
10.200.98.110:6789/0 pipe(0x1cafd20 sd=6 pgs=0 cs=0 l=0).fault first
fault

And for test10 (the .110 node)
2010-12-07 17:36:49.183357 --- 5767 opened log /var/log/ceph/mon.0.log ---
ceph version 0.24~rc (commit:378d13df9505e4ea9a32f42cb713cdcf7aaccda0)
2010-12-07 17:36:49.183545 7ff24669c720 store(/data/mon0) mount
2010-12-07 17:36:49.184556 7ff24669c720 mon.0@0(starting) e1 init fsid
1b4cabdb-30d2-752d-005f-517a7fa982f8
2010-12-07 17:36:49.600650 7ff24669c720 log [INF] : mon.0 calling new
monitor election
2010-12-07 17:36:49.645875 7ff24669a710 -- 10.200.98.110:6789/0 >>
10.200.98.111:6789/0 pipe(0xac7d20 sd=6 pgs=0 cs=0 l=0).fault first
fault


Does this mean my cmon on 111 is getting into a state where it's not
receiving incoming connections?
Any suggestions on where to go from here?

thanks,
Brian Chrisman



----- ceph.conf in /etc/ceph -----
; From sample:
[global]
	auth supported = cephx

[mon]
	mon data = /data/mon$id

	; logging, for debugging monitor crashes, in order of
	; their likelihood of being helpful :)
	;debug ms = 1
	;debug mon = 20
	;debug paxos = 20
	;debug auth = 20

[mon0]
	host = test10
	mon addr = 10.200.98.110:6789

[mon1]
	host = test11
	mon addr = 10.200.98.111:6789

[mds]
	keyring = /data/keyring.$name
	;debug ms = 1
	;debug mds = 20

[mds.test10]
	host = test10

[mds.test11]
	host = test11

[osd]
	osd data = /data/osd$id
	osd journal = /data/osd$id/journal
	osd journal size = 1000 ; journal size, in megabytes
	;debug ms = 1
	;debug osd = 20
	;debug filestore = 20
	;debug journal = 20

[osd0]
	host = test10
	btrfs devs = /dev/sdd4

[osd1]
	host = test11
	btrfs devs = /dev/sdd4
