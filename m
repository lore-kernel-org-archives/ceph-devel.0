From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: how to free space from rados bench comman?
Date: Thu, 24 May 2012 09:01:02 +0200
Message-ID: <4FBDDCAE.7040709@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:49251 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013Ab2EXHAv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 May 2012 03:00:51 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

every rados bench write uses disk space and my space fills up. How to
free this space again?

Used command?
rados -p data bench 60 write -t 16

Stefan
