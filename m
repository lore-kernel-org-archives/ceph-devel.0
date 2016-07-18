From: "Deneau, Tom" <tom.deneau@amd.com>
Subject: verbose logging for mount -t ceph or ceph-fuse problems
Date: Mon, 18 Jul 2016 22:41:22 +0000
Message-ID: <DM3PR1201MB09250DDBE36361721995F79B9B360@DM3PR1201MB0925.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-cys01nam02on0075.outbound.protection.outlook.com ([104.47.37.75]:62019
	"EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751825AbcGRW4v convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Jul 2016 18:56:51 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

What debug option (from http://docs.ceph.com/docs/master/rados/troubleshooting/log-and-debug/) would be best to find errors coming from 
   * mount -t ceph ...
   * or ceph-fuse

My problems seem to be network-address-related because if I create the cluster with 1Gig addresses rather than 10Gig, both mount -t ceph and ceph-fuse work fine.

-- Tom Deneau

