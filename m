From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: OSD crashed today in os/JournalingObjectStore.cc
Date: Fri, 07 Dec 2012 08:49:35 +0100
Message-ID: <50C19F8F.10902@profihost.ag>
References: <50BF1A43.4060605@profihost.ag> <alpine.DEB.2.00.1212050639480.17270@cobra.newdream.net> <BC8B71E3-1BE1-49ED-B578-34A0CBACAB98@profihost.ag> <alpine.DEB.2.00.1212051534530.14332@cobra.newdream.net> <50C0677B.4090400@profihost.ag> <alpine.DEB.2.00.1212061634520.22833@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:44927 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755480Ab2LGHtq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Dec 2012 02:49:46 -0500
In-Reply-To: <alpine.DEB.2.00.1212061634520.22833@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Sage,

thanks for patching this. I'm not sure whether i can test this. I've 
moved my systems to first productional tests and i can't create a 
downtime or loss of data again ;-)

How stable are these fixes?

Am 07.12.2012 01:38, schrieb Sage Weil:
> Hi Stefan,
>
> I've pushed a few patches to wip-filestore2 that simplify and fix this
> code.  Can you give it a go?
>
> Thanks!
> sage

Greets,
Stefan
