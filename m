From: "Deneau, Tom" <tom.deneau@amd.com>
Subject: RE: load-gen from an osd node
Date: Mon, 29 Jun 2015 22:27:24 +0000
Message-ID: <BC97738F8E7C8742BABED7F06FB9DF91669AEA37@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2on0132.outbound.protection.outlook.com ([207.46.100.132]:2287
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752633AbbF2W1h convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Jun 2015 18:27:37 -0400
Received: from satlvexedge02.amd.com (satlvexedge02.amd.com [10.177.96.29])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by atltwp02.amd.com (Axway MailGate 5.3.1) with ESMTPS id 24808D16031
	for <ceph-devel@vger.kernel.org>; Mon, 29 Jun 2015 18:27:23 -0400 (EDT)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Oh, I just noticed that the client nodes I spoke of where load-gen actually worked were
running 0.94, not 9.0.1.  And when I upgrade them to 9.0.1, load-gen no longer works.

So more likely this is just a problem with newer rados load-gens

-- Tom



> -----Original Message-----
> From: Deneau, Tom
> Sent: Friday, June 26, 2015 7:48 PM
> To: ceph-devel
> Subject: load-gen from an osd node
> 
> I am running 9.0.1 and I noticed when I run rados load-gen from one of the
> osd nodes, it creates the objects but then always reports a throughput of 0
> MB/sec.
> 
> But if I run it from a separate client node, it works fine.
> Why would this be?
> 
> I'm not sure but I thought in earlier versions load-gen could be run from an
> osd node.
> 
> -- Tom Deneau
