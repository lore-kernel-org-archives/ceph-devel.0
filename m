From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: stable 10GBE under 3.4.2 or 3.5.0-rc2
Date: Mon, 18 Jun 2012 11:11:16 +0200
Message-ID: <4FDEF0B4.208@profihost.ag>
References: <12a25ef8-317d-4f47-bfea-8bded75bd233@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:50453 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752455Ab2FRJLS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Jun 2012 05:11:18 -0400
In-Reply-To: <12a25ef8-317d-4f47-bfea-8bded75bd233@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: ceph-devel@vger.kernel.org

Am 18.06.2012 10:11, schrieb Alexandre DERUMIER:
> maybe try to play with net.ipv4.tcp_congestion_control ?
The default on my machines and even under RHEL6 is cubic. But i've now 
alos tried, reno, bic and highspeed. But it doesn't change anything.

Everything is fine under 3.0.32 and pretty bad under 3.4.X or 3.5rc2.

Stefan
