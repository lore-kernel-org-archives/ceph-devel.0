From: Dietmar Maurer <dietmar@proxmox.com>
Subject: ceph cli delay when one mon is down
Date: Wed, 15 Jan 2014 07:10:10 +0000
Message-ID: <24E144B8C0207547AD09C467A8259F75592E9F78@lisa.maurer-it.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.maurer-it.com ([94.136.31.133]:51533 "EHLO
	proxmox.maurer-it.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703AbaAOHKO convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Jan 2014 02:10:14 -0500
Received: from proxmox.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox.maurer-it.com (Proxmox) with ESMTP id 14C4429C023A
	for <ceph-devel@vger.kernel.org>; Wed, 15 Jan 2014 08:10:11 +0100 (CET)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi all,

I use a few helper scripts to automate things, and those scripts call 'ceph' command
multiple times, like

------------
#/bin/sh

ceph do something
...
ceph do something else
...
---------------

I get a delay when one monitor is down, until a working mon is found.
That is OK so far.

But I get that delay each times when I run a 'ceph' command. It would
be great if ceph remembers the last successful mon connection, so that such 
delays are avoided. 


