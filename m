From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: Some usability question
Date: Fri, 27 Feb 2015 02:35:02 +0000
Message-ID: <755F6B91B3BE364F9BCA11EA3F9E0C6F282BBCD6@SACMBXIP02.sdcorp.global.sandisk.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F282BB873@SACMBXIP02.sdcorp.global.sandisk.com>
 <mcobp9$d5i$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1on0077.outbound.protection.outlook.com ([157.56.110.77]:8472
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752001AbbB0CfO convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Feb 2015 21:35:14 -0500
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nigel Williams <nigel.williams@utas.edu.au>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,
One more issue I faced in case of Cache tiering.
I couldn't find any list/show command that will show the existing cache tiers in the cluster along with its backup pool.
Am I missing anything ?

-----Original Message-----
From: Somnath Roy
Sent: Thursday, February 26, 2015 4:07 PM
To: 'Nigel Williams'; ceph-devel@vger.kernel.org
Subject: RE: Some usability question

Hi Nigel,
Yes, but I didn't actually noticed that it is giving osd numbers as well. I probably always used it before installation to list the disks :-) Thanks, this is helpful.

Regards
Somnath

-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Nigel Williams
Sent: Thursday, February 26, 2015 3:55 PM
To: ceph-devel@vger.kernel.org
Subject: Re: Some usability question

On 27/02/2015 8:05 AM, Somnath Roy wrote:
> Is there any way to know which OSD to map to which drive of a host from an Admin node ?

still requires a ssh login, but I guess you know about ceph-disk list?


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html

________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

