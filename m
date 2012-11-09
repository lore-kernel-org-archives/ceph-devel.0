From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: less cores more iops / speed
Date: Fri, 09 Nov 2012 09:43:40 +0100
Message-ID: <509CC23C.6060104@profihost.ag>
References: <021c4865-424b-41bd-b81d-62b6771dabc3@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:55599 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133Ab2KIInv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Nov 2012 03:43:51 -0500
In-Reply-To: <021c4865-424b-41bd-b81d-62b6771dabc3@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: Joao Eduardo Luis <joao.luis@inktank.com>, ceph-devel@vger.kernel.org, Mark Nelson <mark.nelson@inktank.com>, "pve-devel@pve.proxmox.com" <pve-devel@pve.proxmox.com>


Am 08.11.2012 16:53, schrieb Alexandre DERUMIER:
>>> So it is a problem of KVM which let's the processes jump between cores a
>>> lot.
>
> maybe numad from redhat can help ?
> http://fedoraproject.org/wiki/Features/numad
>
> It's try to keep process on same numa node and I think it's also doing some dynamic pinning.

numad doesn't help but libvirt seems to support pinning of kvm 
instances. Maybe pve should support pinning too?

Greets
Stefan
