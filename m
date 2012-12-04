From: Christopher Kunz <chrislist@de-punkt.de>
Subject: Re: Best practice with 0.48.2 to take a node into maintenance
Date: Tue, 04 Dec 2012 11:35:03 +0100
Message-ID: <50BDD1D7.3030904@de-punkt.de>
References: <0F892E7E-CF04-49A2-9ABA-5EAF25E6D645@filoo.de> <50BCFA2F.9070603@inktank.com> <50BD0243.2050109@de-punkt.de> <50BD0E16.8090901@catalyst.net.nz> <50BD10A1.5020904@smart-weblications.de> <50BD12CB.3030506@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-6.de-punkt.de ([93.190.64.36]:47332 "EHLO
	mail-6.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388Ab2LDKfA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Dec 2012 05:35:00 -0500
In-Reply-To: <50BD12CB.3030506@catalyst.net.nz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hey,
> That has to be old information - we're using it in anger on 64 bit x86
> machines, from both Intel
> and AMD.  I have no idea about ARM etc, however.
just to make absolutely sure: Are you using kexec "in anger" to switch
Ceph nodes to new kernels? I'm very doubtful that the approach will work
seamlessly with Ceph, as it is rather picky regarding kernel state...

Regards,

--ck
