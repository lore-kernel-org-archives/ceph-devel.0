From: Dietmar Maurer <dietmar@proxmox.com>
Subject: RE: v0.67 Dumpling released
Date: Wed, 14 Aug 2013 07:37:17 +0000
Message-ID: <24E144B8C0207547AD09C467A8259F75590569E1@lisa.maurer-it.com>
References: <alpine.DEB.2.00.1308132222350.18836@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.maurer-it.com ([94.136.31.133]:47493 "EHLO
	proxmox.maurer-it.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759382Ab3HNHoa convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Aug 2013 03:44:30 -0400
In-Reply-To: <alpine.DEB.2.00.1308132222350.18836@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> Another three months have gone by, and the next stable release of Ceph is
> ready: Dumpling!  Thank you to everyone who has contributed to this release!

Seem there is a new dependency in the ceph-common debian package: python-ceph

Is that really required (previous release does not depend on that)?

