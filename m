From: James Harper <james.harper@bendigoit.com.au>
Subject: RE: poor write performance
Date: Thu, 18 Apr 2013 23:11:58 +0000
Message-ID: <6035A0D088A63A46850C3988ED045A4B4D736900@BITCOM1.int.sbss.com.au>
References: <6035A0D088A63A46850C3988ED045A4B4D7359C9@BITCOM1.int.sbss.com.au>
 <516FE3CC.8080303@risc-software.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp2.bendigoit.com.au ([203.16.207.99]:54875 "EHLO
	smtp2.bendigoit.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753871Ab3DRXMM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Apr 2013 19:12:12 -0400
In-Reply-To: <516FE3CC.8080303@risc-software.at>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wolfgang Hennerbichler <wolfgang.hennerbichler@risc-software.at>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> 
> Hi James,
> 
> This is just pure speculation, but can you assure that the bonding works
> correctly? Maybe you have issues there. I have seen a lot of incorrectly
> configured bonding throughout my life as unix admin.
> 

The bonding gives me iperf performance consistent with 2 x 1GB links so I think it's okay.

James
