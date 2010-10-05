From: "Aneesh Kumar K. V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] ceph: Fix return value of encode_fh function
Date: Tue, 05 Oct 2010 23:15:17 +0530
Message-ID: <m3d3rojzyq.fsf@linux.vnet.ibm.com>
References: <1286274822-27738-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com> <Pine.LNX.4.64.1010051001480.21681@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from e23smtp05.au.ibm.com ([202.81.31.147]:42228 "EHLO
	e23smtp05.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753292Ab0JERp1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Oct 2010 13:45:27 -0400
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp05.au.ibm.com (8.14.4/8.13.1) with ESMTP id o95HehIK016733
	for <ceph-devel@vger.kernel.org>; Wed, 6 Oct 2010 04:40:43 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id o95HjPcQ2961442
	for <ceph-devel@vger.kernel.org>; Wed, 6 Oct 2010 04:45:25 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id o95HjPiH016253
	for <ceph-devel@vger.kernel.org>; Wed, 6 Oct 2010 04:45:25 +1100
In-Reply-To: <Pine.LNX.4.64.1010051001480.21681@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On Tue, 5 Oct 2010 10:02:34 -0700 (PDT), Sage Weil <sage@newdream.net> wrote:
> Aneesh,
> 
> I'll add these to my tree (unless you want to send them separately?).
> 

They can go via your tree.

-aneesh
