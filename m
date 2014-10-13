From: Janne Grunau <j@jannau.net>
Subject: Re: NEON / SIMD
Date: Mon, 13 Oct 2014 12:06:51 +0200
Message-ID: <20141013100651.GI2532@jannau.net>
References: <54399D76.7090805@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from soltyk.jannau.net ([185.27.253.110]:52482 "EHLO
	soltyk.jannau.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752937AbaJMKG4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Oct 2014 06:06:56 -0400
Content-Disposition: inline
In-Reply-To: <54399D76.7090805@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

On 2014-10-11 23:13:26 +0200, Loic Dachary wrote:
> 
> I'd like to learn more about SIMD and NEON. What documents / web site 
> would you recommend to begin ? There are
> 
> http://projectne10.github.io/Ne10/
> http://www.arm.com/products/processors/technologies/neon.php
> 
> Are you using formal specifications / documentations ? Any hint would 
> be most appreciated :-)

I'm almost exclusively using ARM's Architecture Reference Manuals 
(available only after registration in ARM's inforcenter):

ARMv7-A:
http://infocenter.arm.com/help/topic/com.arm.doc.ddi0406c/index.html

ARMv8-A:
http://infocenter.arm.com/help/topic/com.arm.doc.ddi0487a.c/index.html


http://infocenter.arm.com/help/topic/com.arm.doc.dui0489h/DUI0489H_arm_assembler_reference.pdf
Seems to be available without registration and has similar descriptions
of neon and vfp instructions like the ARMv7-A ARM.

I don't know any more approachable source off-hand.

Janne

