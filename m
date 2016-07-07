From: Sage Weil <sage@newdream.net>
Subject: Re: DIF/DIX support
Date: Thu, 7 Jul 2016 15:18:32 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1607071515540.11303@piezo.us.to>
References: <loom.20160707T153606-596@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60843 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752643AbcGGPSg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Jul 2016 11:18:36 -0400
In-Reply-To: <loom.20160707T153606-596@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Srikar <srikar.kumar@gmail.com>
Cc: ceph-devel@vger.kernel.org, dmick@redhat.com

On Thu, 7 Jul 2016, Srikar wrote:
> Hi all,
>          I am new to  CEPH environment.For the past two weeks I have been
> going through CEPH related documents as well as code(Jewel)  and have some
> queries. Can anyone tell me whether there is support for DIF/DIX(Protection
> Information) in CEPH.

There is no DIF/DIX support.  I'm not sure it's worth adding. We want 
checksums on all devices (not just enterprise SAS drives) so we have to 
implement in anyway, and once we do I'm not sure there is much value in 
using DIF/DIX too.

> Also I believe FDE is not present in CEPH . Is FDE compatible on CEPH 
> environment?

Currently we do encryption with dm-crypt.  Using the FDE feature on the 
drives themselves would be great since there is no performance cost, 
although many users will choose not to use it for lack of trust in the 
disk firmware.  I'm not sure what the path forward there is in order to 
get it turned on and configured on the device.  Probably some magic in 
ceph-disk, but I'm not sure.  Do you have more information?

sage
