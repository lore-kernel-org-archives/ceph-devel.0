From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: chaning pg_num / pgp_num after adding more osds
Date: Mon, 05 Nov 2012 15:14:53 +0100
Message-ID: <5097C9DD.3030600@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:49415 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753217Ab2KEOO4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Nov 2012 09:14:56 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello list,

Is there a way to change the number of pg_num / pgp_num after adding 
more osds?

I mean i would like to start with 16 OSDs but i think i'll expand over 
time to up to 100 OSDs. So i think i need to tune pg_num / pgp_num.

Greets,
Stefan
