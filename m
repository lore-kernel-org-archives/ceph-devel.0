From: Sage Weil <sage@newdream.net>
Subject: Re: krbd blk-mq support ?
Date: Wed, 29 Oct 2014 08:00:56 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1410290800080.13498@cobra.newdream.net>
References: <670b829a-8568-44fa-97a1-1ced59d408ad@mailpro>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36489 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933114AbaJ2PA5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Oct 2014 11:00:57 -0400
In-Reply-To: <670b829a-8568-44fa-97a1-1ced59d408ad@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: Christoph Hellwig <hch@infradead.org>, Ceph Devel <ceph-devel@vger.kernel.org>

On Wed, 29 Oct 2014, Alexandre DERUMIER wrote:
> >>Oh, that's without the blk-mq patch?
> 
> Yes, sorry, I don't how to use perf with a custom compiled kernel.
> (Usualy I'm using perf from debian, with linux-tools package provided with the debian kernel package)
> 
> >>Either way the profile doesn't really sum up to a fully used up cpu.
> 
> But I see mostly same behaviour with or without blk-mq patch, I have always 1 kworker at around 97-100%cpu (1core) for 50000iops.
> 
> I had also tried to map the rbd volume with nocrc, it's going to 60000iops with same kworker at around 97-100%cpu

Hmm, this is probably the messenger.c worker then that is feeding messages 
to the network.  How many OSDs do you have?  It should be able to scale 
with the number of OSDs.

sage


> 
> 
> 
> ----- Mail original ----- 
> 
> De: "Christoph Hellwig" <hch@infradead.org> 
> ?: "Alexandre DERUMIER" <aderumier@odiso.com> 
> Cc: "Ceph Devel" <ceph-devel@vger.kernel.org> 
> Envoy?: Mardi 28 Octobre 2014 19:07:25 
> Objet: Re: krbd blk-mq support ? 
> 
> On Mon, Oct 27, 2014 at 11:00:46AM +0100, Alexandre DERUMIER wrote: 
> > >>Can you do a perf report -ag and then a perf report to see where these 
> > >>cycles are spent? 
> > 
> > Yes, sure. 
> > 
> > I have attached the perf report to this mail. 
> > (This is with kernel 3.14, don't have access to my 3.18 host for now) 
> 
> Oh, that's without the blk-mq patch? 
> 
> Either way the profile doesn't really sum up to a fully used up 
> cpu. Sage, Alex - are there any ordring constraints in the rbd client? 
> If not we could probably aim for per-cpu queues using blk-mq and a 
> socket per cpu or similar. 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
