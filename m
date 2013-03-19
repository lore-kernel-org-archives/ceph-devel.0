From: Wolfgang Hennerbichler <wolfgang.hennerbichler@risc-software.at>
Subject: Re: Ceph availability test & recovering question
Date: Tue, 19 Mar 2013 06:17:44 +0100
Message-ID: <5147F4F8.40505@risc-software.at>
References: <86F425174C7E4F418CCF4E62056152E593906F@GDC-CLDMBX-P01.whq.wistron>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from email.edvz.uni-linz.ac.at ([140.78.3.65]:34811 "EHLO
	email.uni-linz.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756533Ab3CSFRq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Mar 2013 01:17:46 -0400
In-Reply-To: <86F425174C7E4F418CCF4E62056152E593906F@GDC-CLDMBX-P01.whq.wistron>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kelvin_Huang@wiwynn.com
Cc: ceph-devel@vger.kernel.org, Eric_YH_Chen@wiwynn.com



On 03/17/2013 05:18 AM, Kelvin_Huang@wiwynn.com wrote:
> Hi, all

Hi,
> ...
> My question is:
> 1.The state of I/O pause is normal when ceph recovering ?

I have experienced the same issue. This works as designed, and is
probably because of the heartbeat-timeout in "osd heartbeat grace"
period set to 20 secs - see:
http://ceph.com/docs/master/rados/configuration/mon-osd-interaction/

> 2.The pause time of I/O that can not be avoided when ceph recovering ?

You can always lower the grace period and heartbeat time, though I don't
know if this is a wise idea. Short networking interruptions might mark
your OSD out very quickly then.

> 3.How to reduce the I/O pause time ?

see the link above, or this link here:
http://ceph.com/docs/master/rados/configuration/osd-config-ref/#monitor-osd-interaction

> 
> Thanks!!
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
