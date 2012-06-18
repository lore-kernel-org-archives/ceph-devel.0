From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: stable 10GBE under 3.4.2 or 3.5.0-rc2
Date: Mon, 18 Jun 2012 09:40:47 +0200
Message-ID: <4FDEDB7F.4070600@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:48892 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185Ab2FRHku (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Jun 2012 03:40:50 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi list,

i've still problems with stable network speed under recent kernels. With 
3.0.32 i get stable 9.90 Gbit/s in both directions. With 3.4.2 or 
3.5.0-rc2 it drops sometimes down to around 1 Gbit/s. Sadly i've no idea 
when this happen? It works sometimes for minutes at 9.9Gbit/s and then 
suddently only with 3-4Gbit/s or even 1Gbit/s using recent kernels.

I'm using various tunings recommanded by intel (Improving Performance) 
=> http://downloadmirror.intel.com/5874/eng/README.txt

Has anybody a hint for me or additional settings intel does not mention?

Stefan
