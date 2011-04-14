From: Zenon Panoussis <oracle@provocation.net>
Subject: Mounting
Date: Fri, 15 Apr 2011 01:44:39 +0200
Message-ID: <4DA786E7.9060305@provocation.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from host-88-80-6-138.cust.prq.se ([88.80.6.138]:50880 "EHLO
	mail.nettheatre.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487Ab1DNXon (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Apr 2011 19:44:43 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


I'm facing yet another one of "those problems", more likely caused by
lack of knowledge and/or documentation than by anything else.

# mount.ceph 192.168.178.100:6789:/ /vol
mount error 22 = Invalid argument

# dmesg -c
libceph: no secret set (for auth_x protocol)
libceph: error -22 on auth protocol 2 init

It looks very much like http://marc.info/?l=ceph-devel&m=130072087704874&w=2 .
Yes, I have enabled cephx, but I have no clue how to tell the client what key
to use. I tried

# cauthtool -l /etc/ceph/admin.keyring
# mount.ceph 192.168.178.100:6789:/ /vol -v -o name=<auid>,secret=<key>

but all I got was

ceph: Unknown mount option name
ceph: Unknown mount option secret
mount error 1 = Operation not permitted

Yet, 'man mount.ceph' says

name	string, used with authx, Default: guest
secret	string, used with authx

Commenting out "auth supported = cephx" gets rid of the problem and
lets the store be mounted, but it's a workaround, not a solution.

Any ideas? This is ceph-0.26 with vanilla kernel 2.6.38.2.

Z


