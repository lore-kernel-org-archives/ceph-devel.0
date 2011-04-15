From: Zenon Panoussis <oracle@provocation.net>
Subject: Re: Mounting
Date: Fri, 15 Apr 2011 02:43:30 +0200
Message-ID: <4DA794B2.2010302@provocation.net>
References: <4DA786E7.9060305@provocation.net> <20110415000027.GG30604@dreamer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from host-88-80-6-138.cust.prq.se ([88.80.6.138]:56028 "EHLO
	mail.nettheatre.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754838Ab1DOAnd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Apr 2011 20:43:33 -0400
In-Reply-To: <20110415000027.GG30604@dreamer>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org



On 04/15/2011 02:00 AM, Tommi Virtanen wrote:

> It looks like you're passing in the key the right way, but it's hard
> to tell as you've obscured the actual key. The error you are seeing
> is exactly what you would get if the key was invalid, or didn't have
> the capabilities needed for mounting Ceph.

> Perhaps you could share the ceph.conf, keyring and exact mount command
> you are using, and once you get it going regenerate the keys to get
> back your security.

I tried them all:

# cauthtool -l /etc/ceph/admin.keyring
[client.admin]
	key = AQATSKdNGBnwLhAAnNDKnH65FmVKpXZJVasUeQ==
	auid = 18446744073709551615
# mount.ceph 192.168.178.100:6789:/ /vol -v -o name=18446744073709551615,secret=AQATSKdNGBnwLhAAnNDKnH65FmVKpXZJVasUeQ==
parsing options: name=18446744073709551615,secret=AQATSKdNGBnwLhAAnNDKnH65FmVKpXZJVasUeQ==
ceph: Unknown mount option name
ceph: Unknown mount option secret
mount error 1 = Operation not permitted

# cauthtool -l /etc/ceph/<tab>
admin.keyring       ceph.conf           keyring.mds.node01  keyring.mds.node02  keyring.osd.0       keyring.osd.1       sample.ceph.conf

# cauthtool -l /etc/ceph/keyring.mds.node01
[mds.node01]
	key = AQASSKdNkI4MKhAAkBzdcxP+GBaiceeYXTCaGQ==
	auid = 18446744073709551615

# mount.ceph 192.168.178.100:6789:/ /vol -v -o name=18446744073709551615,secret=AQASSKdNkI4MKhAAkBzdcxP+GBaiceeYXTCaGQ==
parsing options: name=18446744073709551615,secret=AQASSKdNkI4MKhAAkBzdcxP+GBaiceeYXTCaGQ==
ceph: Unknown mount option name
ceph: Unknown mount option secret
mount error 1 = Operation not permitted

# cauthtool -l /etc/ceph/keyring.osd.0
[osd.0]
	key = AQARSKdNYDP3EBAASb7bPEtf0v7XUued0Yzorg==
	auid = 18446744073709551615

# mount.ceph 192.168.178.100:6789:/ /vol -v -o name=18446744073709551615,secret=AQARSKdNYDP3EBAASb7bPEtf0v7XUued0Yzorg==
parsing options: name=18446744073709551615,secret=AQARSKdNYDP3EBAASb7bPEtf0v7XUued0Yzorg==
ceph: Unknown mount option name
ceph: Unknown mount option secret
mount error 1 = Operation not permitted

# cat /etc/ceph/ceph.conf
[global]
	auth supported = cephx
	keyring = /etc/ceph/admin.keyring
        max open files = 131072

; monitors
;  You need at least one.  You need at least three if you want to
;  tolerate any node failures.  Always create an odd number.
[mon]
	mon data = /var/ceph/data/mon$id

	; logging, for debugging monitor crashes, in order of
	; their likelihood of being helpful :)
	;debug ms = 1
	;debug mon = 20
	;debug paxos = 20
	;debug auth = 20

[mon0]
	host = node01
	mon addr = 192.168.178.100:6789

;[mon1]
;	host = node02
;	mon addr = 192.168.178.101:6789

;[mon2]
;	host = node03
;	mon addr = 192.168.0.102:6789


; mds
;  You need at least one.  Define two to get a standby.
[mds]
	; where the mds keeps it's secret encryption keys
	keyring = /etc/ceph/keyring.$name

	; mds logging to debug issues.
	;debug ms = 1
	;debug mds = 20

[mds.node01]
	host = node01

[mds.node02]
	host = node02

[osd]
	osd data = /mnt/osd
	keyring = /etc/ceph/keyring.$name
	osd journal = /var/ceph/data/osd$id/journal
	osd journal size = 1000 ; journal size, in megabytes

	; osd logging to debug osd issues, in order of likelihood of being
	; helpful
	debug ms = 1
	debug osd = 20
	debug filestore = 20
	debug journal = 20

[osd0]
	host = node01
;	btrfs devs = /dev/mapper/sda6

[osd1]
	host = node02
;	btrfs devs = /dev/mapper/md4

;[osd2]
;	host = node03
;	btrfs devs = /dev/mapper/sda6


Z


