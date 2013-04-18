From: Wolfgang Hennerbichler <wolfgang.hennerbichler@risc-software.at>
Subject: Re: poor write performance
Date: Thu, 18 Apr 2013 14:15:08 +0200
Message-ID: <516FE3CC.8080303@risc-software.at>
References: <6035A0D088A63A46850C3988ED045A4B4D7359C9@BITCOM1.int.sbss.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from email.edvz.uni-linz.ac.at ([140.78.3.65]:20905 "EHLO
	email.uni-linz.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967090Ab3DRMPJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Apr 2013 08:15:09 -0400
In-Reply-To: <6035A0D088A63A46850C3988ED045A4B4D7359C9@BITCOM1.int.sbss.com.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Harper <james.harper@bendigoit.com.au>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi James,

This is just pure speculation, but can you assure that the bonding works
correctly? Maybe you have issues there. I have seen a lot of incorrectly
configured bonding throughout my life as unix admin.

Maybe this could help you a little:
http://www.wogri.at/Port-Channeling-802-3ad.338.0.html

On 04/18/2013 01:46 PM, James Harper wrote:
> I'm doing some basic testing so I'm not really fussed about poor performance, but my write performance appears to be so bad I think I'm doing something wrong.
> 
> Using dd to test gives me kbytes/second for write performance for 4kb block sizes, while read performance is acceptable (for testing at least). For dd I'm using iflag=direct for read and oflag=direct for write testing.
> 
> My setup, approximately, is:
> 
> Two OSD's
> . 1 x 7200RPM SATA disk each
> . 2 x gigabit cluster network interfaces each in a bonded configuration directly attached (osd to osd, no switch)
> . 1 x gigabit public network
> . journal on another spindle
> 
> Three MON's
> . 1 each on the OSD's
> . 1 on another server, which is also the one used for testing performance
> 
> I'm using debian packages from ceph which are version 0.56.4
> 
> For comparison, my existing production storage is 2 servers running DRBD with iSCSI to the initiators which run Xen on top of a (C)LVM volumes on top of the iSCSI. Performance not spectacular but acceptable. The servers in question are the same specs as the servers I'm testing on.
> 
> Where should I start looking for performance problems? I've tried running some of the benchmark stuff in the documentation but I haven't gotten very far...
> 
> Thanks
> 
> James
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
DI (FH) Wolfgang Hennerbichler
Software Development
Unit Advanced Computing Technologies
RISC Software GmbH
A company of the Johannes Kepler University Linz

IT-Center
Softwarepark 35
4232 Hagenberg
Austria

Phone: +43 7236 3343 245
Fax: +43 7236 3343 250
wolfgang.hennerbichler@risc-software.at
http://www.risc-software.at
