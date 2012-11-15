From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: ceph-osd cpu usage
Date: Thu, 15 Nov 2012 20:44:17 +0100
Message-ID: <50A54611.5070107@profihost.ag>
References: <7840e3d1-17b2-4618-ae1f-ff3dbdff71f6@mailpro> <50A4DDE8.8040506@profihost.ag> <50A50640.1040103@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:54093 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423636Ab2KOToQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Nov 2012 14:44:16 -0500
In-Reply-To: <50A50640.1040103@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Alexandre DERUMIER <aderumier@odiso.com>, ceph-devel@vger.kernel.org

Hi Mark,

Am 15.11.2012 16:12, schrieb Mark Nelson:
> Out of curiosity, does it help much if you disable crc32c calculations?
> Use the "nocrc" option in your ceph.conf file.  I've had my eye on
> crcutil as an alternative to how we do crc32c now.
>
> http://code.google.com/p/crcutil/
>
> Mark
This changes nothing. CPU Load doesn't change on osds. This was a bit 
tricky ;-) i had to set nocrc on kvm host as well otherwise kvm wasn't 
starting due to bad crc.

Greets,
Stefan
