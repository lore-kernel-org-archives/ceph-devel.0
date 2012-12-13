From: David McBride <dwm37@cam.ac.uk>
Subject: Re: mds =?UTF-8?B?ZG9uwrR0IHN0YXJ0IGFmdGVyIHVwZ3JhZGUgdG8gMC41NQ==?=
Date: Thu, 13 Dec 2012 12:43:16 +0000
Message-ID: <50C9CD64.4060206@cam.ac.uk>
References: <50C9C81F.5010807@astranetwork.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:38466 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753376Ab2LMNCA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Dec 2012 08:02:00 -0500
Received: from angleton.csi.cam.ac.uk ([131.111.10.146]:57857)
	by ppsw-51.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.158]:587)
	with esmtpsa (PLAIN:dwm37) (TLSv1:DHE-RSA-CAMELLIA256-SHA:256)
	id 1Tj88C-0007Vh-Z8 (Exim 4.72) for ceph-devel@vger.kernel.org
	(return-path <dwm37@cam.ac.uk>); Thu, 13 Dec 2012 12:43:16 +0000
In-Reply-To: <50C9C81F.5010807@astranetwork.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On 13/12/12 12:20, Soporte wrote:
>      -1> 2012-12-13 09:04:00.745484 7f0944848700 10 monclient(hunting): none of our auth protocols are supported by the server

This suggests that the change in 0.55 that enabled cephx authentication 
by default has caught you out.

See: http://ceph.com/releases/v0-55-released/

Cheers,
David
-- 
David McBride <dwm37@cam.ac.uk>
Unix Specialist, University Computing Service
