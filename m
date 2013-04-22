From: James Harper <james.harper@bendigoit.com.au>
Subject: RE: poor write performance
Date: Mon, 22 Apr 2013 11:40:26 +0000
Message-ID: <6035A0D088A63A46850C3988ED045A4B4F363739@BITCOM1.int.sbss.com.au>
References: <6035A0D088A63A46850C3988ED045A4B4D7359C9@BITCOM1.int.sbss.com.au>
 <516FF893.1030309@inktank.com>
 <6035A0D088A63A46850C3988ED045A4B4D73695A@BITCOM1.int.sbss.com.au>
 <6035A0D088A63A46850C3988ED045A4B4D7386A4@BITCOM1.int.sbss.com.au>
 <6035A0D088A63A46850C3988ED045A4B4D7386F7@BITCOM1.int.sbss.com.au>
 <6035A0D088A63A46850C3988ED045A4B4D739E99@BITCOM1.int.sbss.com.au>
 <517159C3.5030100@inktank.com>
 <6035A0D088A63A46850C3988ED045A4B4D73B052@BITCOM1.int.sbss.com.au>
 <6035A0D088A63A46850C3988ED045A4B4D73B75D@BITCOM1.int.sbss.com.au>
 <5173EF05.9000404@inktank.com>
 <6035A0D088A63A46850C3988ED045A4B4F362FEA@BITCOM1.int.sbss.com.au>
 <51752031.2060704@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.bendigoit.com.au ([203.16.224.4]:55170 "EHLO
	smtp1.bendigoit.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003Ab3DVLkw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Apr 2013 07:40:52 -0400
In-Reply-To: <51752031.2060704@inktank.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> > I upgraded to 0.60 and that seems to have made a big difference. If I kill off
> > one of my OSD's I get around 20MB/second throughput in live testing (test
> > restore of Xen Windows VM from USB backup), which is pretty much the
> > limit of the USB disk. If I reactivate the second OSD throughput drops back to
> > ~10MB/second which isn't as good but is much better than I was getting.
> >
> 
> Ah, are these disks both connected through USB(2?)?
> 

I guess I was a bit brief :)

Both my OSD disks are SATA attached. Inside a VM I have attached another disk which is attached to the host via USB. This disk contains a backup of a server (using Windows Server Backup) and am doing a test restore of it, with ceph holding the C: drive of the virtual server (eg the write target). What I was saying is that I would never expect more than about 20-30MB/s write speed in this test because that is going to be approximately the limit of the USB interface that the data is coming from. This is more a production test than a benchmark, and I was just iostat to monitor the throughput of the /dev/rbdX interfaces while doing the restore.

James

