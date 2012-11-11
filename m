From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Disabling journal
Date: Sun, 11 Nov 2012 15:29:02 +0100
Message-ID: <F905E0C9-46B6-4DD7-A57D-072CD4ADDFEE@profihost.ag>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:53115 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752Ab2KKO3J convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 11 Nov 2012 09:29:09 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi list,

is there a way to disable journal completely? For fast ssd storage it doesn't make sense and I want to test how speed changes.

Greets
Stefan