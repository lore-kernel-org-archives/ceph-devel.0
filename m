From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: firefly: librbd: reads contending for cache space can cause livelock
Date: Tue, 17 Feb 2015 11:28:09 +0100
Message-ID: <54E317B9.5050009@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:14173 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933636AbbBQK2L (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Feb 2015 05:28:11 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

is there any reason why this one is not merged into firefly yet?

http://tracker.ceph.com/issues/9854
librbd: reads contending for cache space can cause livelock

Stefan
