From: Stefan Priebe <s.priebe@profihost.ag>
Subject: osd recovery extremely slow with current master
Date: Tue, 13 Nov 2012 21:33:22 +0100
Message-ID: <50A2AE92.1010205@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:54007 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755695Ab2KMUdU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Nov 2012 15:33:20 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi list,

osd recovery seems to be really slow with current master.

I see only 1-8 active+recovering out of 1200. Even there's no load on 
ceph cluster.

Greets,
Stefan
