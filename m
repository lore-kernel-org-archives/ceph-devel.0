From: Sage Weil <sage@inktank.com>
Subject: Re: rbd command : is it possible to pass authkey in argument ?
Date: Wed, 30 May 2012 08:25:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1205300825230.4642@cobra.newdream.net>
References: <0a37bcdb-3791-4255-b403-1ca147cf02c0@mailpro> <4FC603E0.1080307@widodh.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35548 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752171Ab2E3PZe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 May 2012 11:25:34 -0400
In-Reply-To: <4FC603E0.1080307@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: Alexandre DERUMIER <aderumier@odiso.com>, ceph-devel@vger.kernel.org

On Wed, 30 May 2012, Wido den Hollander wrote:
> Hi,
> 
> On 05/30/2012 11:15 AM, Alexandre DERUMIER wrote:
> > Hi,
> > 
> > I'm writing rbd module for proxmox kvm distribution,
> > 
> > Is it possible to pass authkey as argument in rbd command line ? (I can do
> > in with qemu-rbd drive option)
> 
> I'm not sure yet, have you tried with they argument "--key" ?

Yep, --key is what you want.

sage

> 
> I tried and that failed and looking through the source-code it seems that it
> isn't possible yet.
> 
> Adding it seems rather simple however, so it could be added.
> 
> Wido
> 
> > 
> > Or does it need to use a keyring file ?
> > 
> > Regards,
> > 
> > Alexandre
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
