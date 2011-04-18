From: Zenon Panoussis <oracle@provocation.net>
Subject: Re: Logging
Date: Mon, 18 Apr 2011 22:56:30 +0200
Message-ID: <4DACA57E.2040609@provocation.net>
References: <4DAB77FD.4010804@provocation.net>	<BANLkTinntanBQLag+8hC+FSfpxz8iib1uA@mail.gmail.com>	<4DAC0EE7.4080001@provocation.net>	<BANLkTikCO-pgBfNtvpMVn5HEG2ujhsSgxQ@mail.gmail.com>	<4DAC8021.6000701@provocation.net> <BANLkTimPP2epqVTPwiXMubB_q_Rf+3Ro4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from host-88-80-6-138.cust.prq.se ([88.80.6.138]:48266 "EHLO
	mail.nettheatre.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751949Ab1DRU4f (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Apr 2011 16:56:35 -0400
In-Reply-To: <BANLkTimPP2epqVTPwiXMubB_q_Rf+3Ro4w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


On 04/18/2011 08:41 PM, Colin McCabe wrote:

> I added "Mount the partition you are logging to using noatime" as a
> "tip" on http://ceph.newdream.net/wiki/Cluster_configuration

Aha, and I had put a word about noatime for the OSD partition in
http://ceph.newdream.net/wiki/Mounting_the_file_system . Obviously it doesn't
make much of a difference on writes, but it makes a HUGE difference on reads.

Z





