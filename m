From: Dietmar Maurer <dietmar@proxmox.com>
Subject: RE: incremental rbd export / sparse files?
Date: Fri, 23 Nov 2012 06:23:56 +0000
Message-ID: <24E144B8C0207547AD09C467A8259F755782F690@lisa.maurer-it.com>
References: <50AE062E.5020301@profihost.ag>
 <alpine.DEB.2.00.1211221357480.9963@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www.maurer-it.com ([213.129.239.114]:39515 "EHLO
	proxmox.maurer-it.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932153Ab2KWGYC convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Nov 2012 01:24:02 -0500
In-Reply-To: <alpine.DEB.2.00.1211221357480.9963@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>, Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> Step 2 is to export the incremental changes.  The hangup there is figuring out
> a generic and portable file format to represent those incremental changes;
> we'd rather not invent something ourselves that is ceph-specific.
> Suggestions welcome!

AFAIK, both 'zfs' and 'btrfs' already have such format. 

