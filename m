From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: Debug kvm exit / stops
Date: Sat, 03 Nov 2012 19:46:37 +0100
Message-ID: <5095668D.5080005@profihost.ag>
References: <F948A2C5-458A-4625-9140-7C07E027EFC5@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:51931 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752020Ab2KCSqf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 3 Nov 2012 14:46:35 -0400
In-Reply-To: <F948A2C5-458A-4625-9140-7C07E027EFC5@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Am 03.11.2012 19:21, schrieb Stefan Priebe - Profihost AG:
> Hello List,
>
> while benchmarking striped rbd format v2 my KVM process exits at the read tests. No segfault it just seems to finish.
>
> Any idea how to debug?

This happens only with a client running vanilla kernel 3.7-rc3 so i'll 
test again with 3.6.5.

Greets,
Stefan
