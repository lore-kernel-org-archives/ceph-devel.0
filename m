From: Yoann Moulin <yoann.moulin@epfl.ch>
Subject: Rclone crashed with infernalis radosgw because of malformed data
Date: Fri, 29 Apr 2016 13:28:28 +0200
Message-ID: <5723455C.1050309@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp4.epfl.ch ([128.178.224.219]:37119 "EHLO smtp4.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752176AbcD2Lfy (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 29 Apr 2016 07:35:54 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

I have reported a bug on rclone here :

https://github.com/ncw/rclone/issues/459

while I was trying to sync 2 buckets between 2 infernalis ceph cluster.

the dev reported that must be a bug in Ceph by sending malformed data :

https://github.com/aws/aws-sdk-go/pull/665

They have fixed the rclone crash but I guess the malformed data should be fixed
in ceph too.

-- 
Yoann Moulin
EPFL IC-IT
