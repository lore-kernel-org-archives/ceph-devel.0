From: Xiaopong Tran <xiaopong.tran@gmail.com>
Subject: Very unbalanced storage
Date: Fri, 31 Aug 2012 19:11:24 +0800
Message-ID: <50409BDC.5010006@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010804010202010101080505"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52031 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752165Ab2HaLLL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 31 Aug 2012 07:11:11 -0400
Received: by pbbrr13 with SMTP id rr13so4666205pbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 31 Aug 2012 04:11:10 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is a multi-part message in MIME format.
--------------010804010202010101080505
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Ceph storage on each disk in the cluster is very unbalanced. On each
node, the data seems to go to one or two disks, while other disks
are almost empty.

I can't find anything wrong from the crush map, it's just the
default for now. Attached is the crush map.

Here is the current situation on node s100001:

Filesystem                                              Size  Used Avail 
Use% Mounted on
/dev/sdb1                                               932G  4.3G  927G 
   1% /disk1
/dev/sdc1                                               932G  4.3G  927G 
   1% /disk2
/dev/sdd1                                               932G  4.3G  927G 
   1% /disk3
/dev/sde1                                               932G  4.3G  927G 
   1% /disk4
/dev/sdf1                                               932G  4.3G  927G 
   1% /disk5
/dev/sdg1                                               932G  4.3G  927G 
   1% /disk6
/dev/sdh1                                               932G  4.3G  927G 
   1% /disk7
/dev/sdi1                                               932G  4.3G  927G 
   1% /disk8
/dev/sdj1                                               932G  4.3G  927G 
   1% /disk9
/dev/sdk1                                               932G  445G  487G 
  48% /disk10

Here, we can see that all data seem to go to one osd only, while others
are almost empty.

And here's the situation on node s200001:

Filesystem                                              Size  Used Avail 
Use% Mounted on
/dev/sdb1                                               932G  443G  489G 
  48% /disk1
/dev/sdc1                                               932G  4.3G  927G 
   1% /disk2
/dev/sdd1                                               932G  4.3G  927G 
   1% /disk3
/dev/sde1                                               932G  4.3G  927G 
   1% /disk4
/dev/sdf1                                               932G  4.3G  927G 
   1% /disk5
/dev/sdg1                                               932G  4.3G  927G 
   1% /disk6
/dev/sdh1                                               932G  4.3G  927G 
   1% /disk7
/dev/sdi1                                               932G  4.3G  927G 
   1% /disk8
/dev/sdj1                                               932G  449G  483G 
  49% /disk9
/dev/sdk1                                               932G  4.3G  927G 
   1% /disk10

The situation is a bit better, but not much, the data are stored on two
disks mainly.

Here is a better situation, on node s100002:

Filesystem                                              Size  Used Avail 
Use% Mounted on
/dev/sdb1                                               1.9T  453G  1.4T 
  25% /disk1
/dev/sdc1                                               1.9T  4.3G  1.9T 
   1% /disk2
/dev/sdd1                                               1.9T  4.4G  1.9T 
   1% /disk3
/dev/sde1                                               1.9T  4.3G  1.9T 
   1% /disk4
/dev/sdf1                                               1.9T  457G  1.4T 
  25% /disk5
/dev/sdg1                                               1.9T  443G  1.4T 
  24% /disk6
/dev/sdh1                                               1.9T  4.4G  1.9T 
   1% /disk7
/dev/sdi1                                               1.9T  4.4G  1.9T 
   1% /disk8
/dev/sdj1                                               1.9T  427G  1.5T 
  23% /disk9
/dev/sdk1                                               1.9T  4.4G  1.9T 
   1% /disk10

It's better than the other two, but still not what I expected. I
expected the data to be spread out according to the weight of each
osd, as defined in the crush map. Or at least, as close to that
as possible. It might be just some obviously stupid config error,
but I don't know. This can't be normal, can it?

Thanks for any hint.

Xiaopong

--------------010804010202010101080505
Content-Type: text/plain; charset=UTF-8;
 name="crush.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="crush.txt"

# begin crush map

# devices
device 0 osd.0
device 1 osd.1
device 2 osd.2
device 3 osd.3
device 4 osd.4
device 5 osd.5
device 6 osd.6
device 7 osd.7
device 8 osd.8
device 9 osd.9
device 10 osd.10
device 11 osd.11
device 12 osd.12
device 13 osd.13
device 14 osd.14
device 15 osd.15
device 16 osd.16
device 17 osd.17
device 18 osd.18
device 19 osd.19
device 20 osd.20
device 21 osd.21
device 22 osd.22
device 23 osd.23
device 24 osd.24
device 25 osd.25
device 26 osd.26
device 27 osd.27
device 28 osd.28
device 29 osd.29
device 30 osd.30
device 31 osd.31
device 32 osd.32
device 33 osd.33
device 34 osd.34
device 35 osd.35
device 36 osd.36
device 37 osd.37
device 38 osd.38
device 39 osd.39
device 40 osd.40
device 41 osd.41
device 42 osd.42
device 43 osd.43
device 44 osd.44
device 45 osd.45
device 46 osd.46
device 47 osd.47
device 48 osd.48
device 49 osd.49
device 50 osd.50
device 51 osd.51
device 52 osd.52
device 53 osd.53
device 54 osd.54
device 55 osd.55
device 56 osd.56
device 57 osd.57
device 58 osd.58
device 59 osd.59
device 60 osd.60
device 61 osd.61
device 62 osd.62
device 63 osd.63
device 64 osd.64
device 65 osd.65
device 66 osd.66
device 67 osd.67
device 68 osd.68
device 69 osd.69
device 70 osd.70
device 71 osd.71
device 72 osd.72
device 73 osd.73
device 74 osd.74
device 75 osd.75

# types
type 0 osd
type 1 host
type 2 rack
type 3 row
type 4 room
type 5 datacenter
type 6 pool

# buckets
host s100001 {
	id -2		# do not change unnecessarily
	# weight 10.000
	alg straw
	hash 0	# rjenkins1
	item osd.0 weight 1.000
	item osd.1 weight 1.000
	item osd.2 weight 1.000
	item osd.3 weight 1.000
	item osd.4 weight 1.000
	item osd.5 weight 1.000
	item osd.6 weight 1.000
	item osd.7 weight 1.000
	item osd.8 weight 1.000
	item osd.9 weight 1.000
}
host s200001 {
	id -4		# do not change unnecessarily
	# weight 10.000
	alg straw
	hash 0	# rjenkins1
	item osd.10 weight 1.000
	item osd.11 weight 1.000
	item osd.12 weight 1.000
	item osd.13 weight 1.000
	item osd.14 weight 1.000
	item osd.15 weight 1.000
	item osd.16 weight 1.000
	item osd.17 weight 1.000
	item osd.18 weight 1.000
	item osd.19 weight 1.000
}
host s300001 {
	id -5		# do not change unnecessarily
	# weight 10.000
	alg straw
	hash 0	# rjenkins1
	item osd.20 weight 1.000
	item osd.21 weight 1.000
	item osd.22 weight 1.000
	item osd.23 weight 1.000
	item osd.24 weight 1.000
	item osd.25 weight 1.000
	item osd.26 weight 1.000
	item osd.27 weight 1.000
	item osd.28 weight 1.000
	item osd.29 weight 1.000
}
host s100002 {
	id -6		# do not change unnecessarily
	# weight 20.000
	alg straw
	hash 0	# rjenkins1
	item osd.30 weight 2.000
	item osd.31 weight 2.000
	item osd.32 weight 2.000
	item osd.33 weight 2.000
	item osd.34 weight 2.000
	item osd.35 weight 2.000
	item osd.36 weight 2.000
	item osd.37 weight 2.000
	item osd.38 weight 2.000
	item osd.39 weight 2.000
}
host s200002 {
	id -7		# do not change unnecessarily
	# weight 20.000
	alg straw
	hash 0	# rjenkins1
	item osd.40 weight 2.000
	item osd.41 weight 2.000
	item osd.42 weight 2.000
	item osd.43 weight 2.000
	item osd.44 weight 2.000
	item osd.45 weight 2.000
	item osd.46 weight 2.000
	item osd.47 weight 2.000
	item osd.48 weight 2.000
	item osd.49 weight 2.000
}
host s300002 {
	id -8		# do not change unnecessarily
	# weight 20.000
	alg straw
	hash 0	# rjenkins1
	item osd.50 weight 2.000
	item osd.51 weight 2.000
	item osd.52 weight 2.000
	item osd.53 weight 2.000
	item osd.54 weight 2.000
	item osd.55 weight 2.000
	item osd.56 weight 2.000
	item osd.57 weight 2.000
	item osd.58 weight 2.000
	item osd.59 weight 2.000
}
host s100003 {
	id -9		# do not change unnecessarily
	# weight 16.000
	alg straw
	hash 0	# rjenkins1
	item osd.60 weight 2.000
	item osd.61 weight 2.000
	item osd.62 weight 2.000
	item osd.63 weight 2.000
	item osd.64 weight 2.000
	item osd.65 weight 2.000
	item osd.66 weight 2.000
	item osd.67 weight 2.000
}
host s200003 {
	id -10		# do not change unnecessarily
	# weight 16.000
	alg straw
	hash 0	# rjenkins1
	item osd.68 weight 2.000
	item osd.69 weight 2.000
	item osd.70 weight 2.000
	item osd.71 weight 2.000
	item osd.72 weight 2.000
	item osd.73 weight 2.000
	item osd.74 weight 2.000
	item osd.75 weight 2.000
}
rack unknownrack {
	id -3		# do not change unnecessarily
	# weight 122.000
	alg straw
	hash 0	# rjenkins1
	item s100001 weight 10.000
	item s200001 weight 10.000
	item s300001 weight 10.000
	item s100002 weight 20.000
	item s200002 weight 20.000
	item s300002 weight 20.000
	item s100003 weight 16.000
	item s200003 weight 16.000
}
pool default {
	id -1		# do not change unnecessarily
	# weight 122.000
	alg straw
	hash 0	# rjenkins1
	item unknownrack weight 122.000
}

# rules
rule data {
	ruleset 0
	type replicated
	min_size 1
	max_size 10
	step take default
	step chooseleaf firstn 0 type host
	step emit
}
rule metadata {
	ruleset 1
	type replicated
	min_size 1
	max_size 10
	step take default
	step chooseleaf firstn 0 type host
	step emit
}
rule rbd {
	ruleset 2
	type replicated
	min_size 1
	max_size 10
	step take default
	step chooseleaf firstn 0 type host
	step emit
}

# end crush map

--------------010804010202010101080505--
