From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: "rbd rm image" slow with big images ?
Date: Thu, 31 May 2012 09:12:33 +0200 (CEST)
Message-ID: <b4c574f6-49bf-4d36-b8f2-526bcccb4c71@mailpro>
References: <6bb4f478-37c9-460d-8a0d-698e32dcf08d@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:48212 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849Ab2EaHMz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 May 2012 03:12:55 -0400
Received: from localhost (localhost [127.0.0.1])
	by mailpro.odiso.net (Postfix) with ESMTP id A333918060CBB
	for <ceph-devel@vger.kernel.org>; Thu, 31 May 2012 09:12:38 +0200 (CEST)
Received: from mailpro.odiso.net ([127.0.0.1])
	by localhost (mailpro.odiso.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Luo5Ov9kdtcR for <ceph-devel@vger.kernel.org>;
	Thu, 31 May 2012 09:12:33 +0200 (CEST)
Received: from mailpro.odiso.net (mailpro.odiso.net [10.1.31.112])
	by mailpro.odiso.net (Postfix) with ESMTP id 62BE318024BFA
	for <ceph-devel@vger.kernel.org>; Thu, 31 May 2012 09:12:33 +0200 (CEST)
In-Reply-To: <6bb4f478-37c9-460d-8a0d-698e32dcf08d@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I trying to delete some rbd images with rbd rm,
and it seem to be "slow" with big images.



I'm testing it with just create a new image (1TB):

# time rbd -p pool1 create --size 1000000 image2

real    0m0.031s
user    0m0.015s
sys     0m0.010s


then just delete it, without having writed nothing in image


# time rbd -p pool1 rm image2
Removing image: 100% complete...done.

real    1m45.558s
user    0m14.683s
sys     0m17.363s



same test with 100GB

# time rbd -p pool1 create --size 100000 image2

real    0m0.032s
user    0m0.016s
sys     0m0.007s

# time rbd -p pool1 rm image2
Removing image: 100% complete...done.

real    0m10.499s
user    0m1.488s
sys     0m1.720s


I'm using journal in tmpfs, 3 servers, 15 osds with 1disk 15K (xfs)
network bandwith,diskio,cpu are low.

Is it the normal behaviour ? Maybe some xfs tuning could help ?
 
