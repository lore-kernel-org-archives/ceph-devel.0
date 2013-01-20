From: Dimitri Maziuk <dmaziuk@bmrb.wisc.edu>
Subject: Re: Understanding Ceph
Date: Sun, 20 Jan 2013 10:32:15 -0600
Message-ID: <50FC1C0F.9090706@bmrb.wisc.edu>
References: <CAPrNTukzeSN8ZfO_Mhtx9LkHqe0M3tUxJuQG=gwwJD4w+-OGEg@mail.gmail.com> <50FAC92C.8030709@bmrb.wisc.edu> <alpine.DEB.2.00.1301190911470.29915@cobra.newdream.net>
Reply-To: dmaziuk@bmrb.wisc.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cowfish.bmrb.wisc.edu ([144.92.167.220]:60405 "EHLO
	mail.bmrb.wisc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752309Ab3ATQcr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 20 Jan 2013 11:32:47 -0500
Received: from [192.168.1.2] (71-90-100-249.dhcp.ftbg.wi.charter.com [71.90.100.249])
	(Authenticated sender: dmaziuk)
	by mail.bmrb.wisc.edu (Postfix) with ESMTPSA id A7EE12C010D
	for <ceph-devel@vger.kernel.org>; Sun, 20 Jan 2013 10:32:46 -0600 (CST)
In-Reply-To: <alpine.DEB.2.00.1301190911470.29915@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On 1/19/2013 11:13 AM, Sage Weil wrote:

> If you want to use the kernel client(s), that is true: there are no plans
> to backport the client code to the ancient RHEL kernels.  Nothing prevents
> you from running the server side, though, or the userland clients
> (ceph-fuse, librbd, qemu/KVM, radosgw, etc.)

mkcephfs form 5-minute start fails without rbd.ko. I already reported that.

Dima


