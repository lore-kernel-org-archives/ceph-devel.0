From: Nigel Williams <nigel.williams@utas.edu.au>
Subject: Re: Some usability question
Date: Fri, 27 Feb 2015 10:55:19 +1100
Message-ID: <mcobp9$d5i$1@ger.gmane.org>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F282BB873@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:54047 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752169AbbBZXze (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 26 Feb 2015 18:55:34 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1YR8H8-0004GT-Nz
	for ceph-devel@vger.kernel.org; Fri, 27 Feb 2015 00:55:27 +0100
Received: from fjzmd2s-nigelw.its.utas.edu.au ([131.217.4.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 27 Feb 2015 00:55:26 +0100
Received: from nigel.williams by fjzmd2s-nigelw.its.utas.edu.au with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 27 Feb 2015 00:55:26 +0100
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F282BB873@SACMBXIP02.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On 27/02/2015 8:05 AM, Somnath Roy wrote:
> Is there any way to know which OSD to map to which drive of a host from an Admin node ?

still requires a ssh login, but I guess you know about ceph-disk list?


