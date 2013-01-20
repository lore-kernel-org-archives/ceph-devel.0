From: Dimitri Maziuk <dmaziuk@bmrb.wisc.edu>
Subject: Re: Understanding Ceph
Date: Sun, 20 Jan 2013 10:39:43 -0600
Message-ID: <50FC1DCF.8010304@bmrb.wisc.edu>
References: <CAPrNTukzeSN8ZfO_Mhtx9LkHqe0M3tUxJuQG=gwwJD4w+-OGEg@mail.gmail.com> <50FAC92C.8030709@bmrb.wisc.edu> <alpine.DEB.2.00.1301190911470.29915@cobra.newdream.net> <CAPrNTukzfE0KNMG+Rww8FBOCFq_BZr29Kb0zQRCf0K40oX4enQ@mail.gmail.com> <alpine.DEB.2.00.1301190933000.29915@cobra.newdream.net> <50FAE116.2010504@gmail.com> <alpine.DEB.2.00.1301191012400.29915@cobra.newdream.net>
Reply-To: dmaziuk@bmrb.wisc.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cowfish.bmrb.wisc.edu ([144.92.167.220]:60429 "EHLO
	mail.bmrb.wisc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090Ab3ATQkJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 20 Jan 2013 11:40:09 -0500
Received: from [192.168.1.2] (71-90-100-249.dhcp.ftbg.wi.charter.com [71.90.100.249])
	(Authenticated sender: dmaziuk)
	by mail.bmrb.wisc.edu (Postfix) with ESMTPSA id C1EFA2C010D
	for <ceph-devel@vger.kernel.org>; Sun, 20 Jan 2013 10:40:08 -0600 (CST)
In-Reply-To: <alpine.DEB.2.00.1301191012400.29915@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On 1/19/2013 12:16 PM, Sage Weil wrote:

> We generally recommend the KVM+librbd route, as it is easier to manage the
> dependencies, and is well integrated with libvirt.  FWIW this is what
> OpenStack and CloudStack normally use.

OK, so is there a quick stat document for that configuration?

(Oh, and "form" in my other message is supposed to be "from": tyop)

Dima


