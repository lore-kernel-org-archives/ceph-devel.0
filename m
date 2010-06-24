From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: crushmap rule issue: choose vs. chooseleaf
Date: Thu, 24 Jun 2010 13:44:20 -0600
Message-ID: <1277408660.29400.54.camel@sale659.sandia.gov>
References: <1277320801.29400.26.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1006231327140.21486@cobra.newdream.net>
 <1277330264.29400.34.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1006241059570.30180@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:53297 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751760Ab0FXTod (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jun 2010 15:44:33 -0400
In-Reply-To: <Pine.LNX.4.64.1006241059570.30180@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


On Thu, 2010-06-24 at 12:20 -0600, Sage Weil wrote:
> Hi Jim,
> 
> Okay, I fixed another bug and am now able to use your map without 
> problems.  The fix is pushed to the unstable branch in ceph.git.

Great, thanks!  I really appreciate you being
able to take a look so quickly.

> 
> I'm surprised we didn't run into this before.. it looks like it's been 
> broken for a while.  I'm adding a tracker item to set up some unit tests 
> for this stuff so we can avoid this sort of regression.. the crush code 
> should be really easy to check.

That sounds great.

I'm still having a little trouble, though.

My map works for me now, in the sense that I can mount
the file system from a client.

But when I try to write to it, vmstat on the server shows
I get a little burst of I/O on the servers, and then nothing.

The same ceph config but using the default map works
great - vmstat on the server shows 200-300 MB/s.

FWIW, here's my custom map again, queried 
via ceph osd getcrushmap:

# begin crush map

# devices
device 0 device0
device 1 device1
device 2 device2
device 3 device3

# types
type 0 device
type 1 disk
type 2 controller
type 3 host
type 4 root

# buckets
disk disk0 {
	id -1		# do not change unnecessarily
	alg uniform	# do not change bucket size (1) unnecessarily
	hash 0	# rjenkins1
	item device0 weight 1.000 pos 0
}
disk disk1 {
	id -2		# do not change unnecessarily
	alg uniform	# do not change bucket size (1) unnecessarily
	hash 0	# rjenkins1
	item device1 weight 1.000 pos 0
}
disk disk2 {
	id -3		# do not change unnecessarily
	alg uniform	# do not change bucket size (1) unnecessarily
	hash 0	# rjenkins1
	item device2 weight 1.000 pos 0
}
disk disk3 {
	id -4		# do not change unnecessarily
	alg uniform	# do not change bucket size (1) unnecessarily
	hash 0	# rjenkins1
	item device3 weight 1.000 pos 0
}
controller controller0 {
	id -5		# do not change unnecessarily
	alg uniform	# do not change bucket size (2) unnecessarily
	hash 0	# rjenkins1
	item disk0 weight 1.000 pos 0
	item disk1 weight 1.000 pos 1
}
controller controller1 {
	id -6		# do not change unnecessarily
	alg uniform	# do not change bucket size (2) unnecessarily
	hash 0	# rjenkins1
	item disk2 weight 1.000 pos 0
	item disk3 weight 1.000 pos 1
}
host host0 {
	id -7		# do not change unnecessarily
	alg uniform	# do not change bucket size (2) unnecessarily
	hash 0	# rjenkins1
	item controller0 weight 2.000 pos 0
	item controller1 weight 2.000 pos 1
}
root root {
	id -8		# do not change unnecessarily
	alg straw
	hash 0	# rjenkins1
	item host0 weight 4.000
}

# rules
rule data {
	ruleset 0
	type replicated
	min_size 2
	max_size 2
	step take root
	step chooseleaf firstn 0 type controller
	step emit
}
rule metadata {
	ruleset 1
	type replicated
	min_size 2
	max_size 2
	step take root
	step chooseleaf firstn 0 type controller
	step emit
}
rule casdata {
	ruleset 2
	type replicated
	min_size 2
	max_size 2
	step take root
	step chooseleaf firstn 0 type controller
	step emit
}
rule rbd {
	ruleset 3
	type replicated
	min_size 2
	max_size 2
	step take root
	step chooseleaf firstn 0 type controller
	step emit
}

# end crush map


and for completeness, here's the default map, also via query:

# begin crush map

# devices
device 0 device0
device 1 device1
device 2 device2
device 3 device3

# types
type 0 device
type 1 domain
type 2 pool

# buckets
domain root {
	id -1		# do not change unnecessarily
	alg straw
	hash 0	# rjenkins1
	item device0 weight 1.000
	item device1 weight 1.000
	item device2 weight 1.000
	item device3 weight 1.000
}

# rules
rule data {
	ruleset 0
	type replicated
	min_size 1
	max_size 10
	step take root
	step choose firstn 0 type device
	step emit
}
rule metadata {
	ruleset 1
	type replicated
	min_size 1
	max_size 10
	step take root
	step choose firstn 0 type device
	step emit
}
rule casdata {
	ruleset 2
	type replicated
	min_size 1
	max_size 10
	step take root
	step choose firstn 0 type device
	step emit
}
rule rbd {
	ruleset 3
	type replicated
	min_size 1
	max_size 10
	step take root
	step choose firstn 0 type device
	step emit
}

# end crush map

Here's the ceph.conf I use for both tests.  Note
that for the default map case I just make sure the 
crush map file I configured doesn't exist; mkcepfs -v
output suggests that the right thing happens in both
cases.

; global

[global]
	pid file = /var/run/ceph/$name.pid

	; some minimal logging (just message traffic) to aid debugging
	debug ms = 4

; monitor daemon common options
[mon]
	crush map = /mnt/projects/ceph/root/crushmap
	debug mon = 10

; monitor daemon options per instance
; need an odd number of instances
[mon0]
	host = sasa008
	mon addr = 192.168.204.111:6788
	mon data = /mnt/disk/disk.00p1/mon

; mds daemon common options

[mds]
	debug mds = 10

; mds daemon options per instance
[mds0]
	host = sasa008
	mds addr = 192.168.204.111
	keyring = /mnt/disk/disk.00p1/mds/keyring.$name

; osd daemon common options

[osd]
	; osd client message size cap = 67108864
	debug osd = 10

; osd options per instance; i.e. per crushmap device.

[osd0]
	host = sasa008
	osd addr = 192.168.204.111
	keyring     = /mnt/disk/disk.00p1/osd/keyring.$name
	osd journal = /dev/sdb2
	; btrfs devs  = /dev/sdb5
	; btrfs path  = /mnt/disk/disk.00p5
	osd data    = /mnt/disk/disk.00p5
[osd1]
	host = sasa008
	osd addr = 192.168.204.111
	keyring     = /mnt/disk/disk.01p1/osd/keyring.$name
	osd journal = /dev/sdc2
	; btrfs devs  = /dev/sdc5
	; btrfs path  = /mnt/disk/disk.01p5
	osd data    = /mnt/disk/disk.01p5
[osd2]
	host = sasa008
	osd addr = 192.168.204.111
	keyring     = /mnt/disk/disk.02p1/osd/keyring.$name
	osd journal = /dev/sdj2
	; btrfs devs  = /dev/sdj5
	; btrfs path  = /mnt/disk/disk.02p5
	osd data    = /mnt/disk/disk.02p5
[osd3]
	host = sasa008
	osd addr = 192.168.204.111
	keyring     = /mnt/disk/disk.03p1/osd/keyring.$name
	osd journal = /dev/sdk2
	; btrfs devs  = /dev/sdk5
	; btrfs path  = /mnt/disk/disk.03p5
	osd data    = /mnt/disk/disk.03p5

Maybe I'm still missing something?

Thanks -- Jim

> 
> sage
> 



