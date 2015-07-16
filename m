From: Sage Weil <sage@newdream.net>
Subject: Re: CephX key/secret generation
Date: Thu, 16 Jul 2015 07:46:40 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1507160745010.8878@cobra.newdream.net>
References: <CACEfbZhXSNp0_WxyX2mwSeg2rdEdYSfVbGDZsrHKqPvAGa7oBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53773 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752174AbbGPOqn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Jul 2015 10:46:43 -0400
In-Reply-To: <CACEfbZhXSNp0_WxyX2mwSeg2rdEdYSfVbGDZsrHKqPvAGa7oBQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrew Woodward <xarses@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Andrew,

On Wed, 15 Jul 2015, Andrew Woodward wrote:
> Hi, I'm looking for help understanding how the cephx auth keys are
> generated. I want to pre-create the keys for the cluster within my
> deployment engine. It appears that we can use `ceph-athtool
> --gen-print-key` in order to generate the keys and use them, however
> the application runs inside a container and it seems silly to 150mb of
> deps to get access to ceph-authtool.
> 
> Looking through the code at a basic level, I see that it's calling
> some AES functions, however it quickly goes over my ability to read C.
> 
> Can some one go over the key construction requirements? Can we use any
> string encoded with base64? Is the AES encoding needed? What is the
> correct formula for the AES generation? It looks like the have the
> same seed but I'm having problems reading it out of the code.

Here's a bit of python to do it:

	https://github.com/ceph/ceph-deploy/blob/master/ceph_deploy/new.py#L21

Hope that helps!
sage

