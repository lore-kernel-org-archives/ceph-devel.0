From: Wido den Hollander <wido@pcextreme.nl>
Subject: Re: service ceph vs. /etc/init.d/ceph
Date: Thu, 08 Jul 2010 17:13:58 +0200
Message-ID: <1278602038.2253.24.camel@wido-laptop.pcextreme.nl>
References: <i14p03$hn$5@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from support.pcextreme.nl ([89.18.190.50]:39459 "EHLO
	support.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754442Ab0GHPOA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Jul 2010 11:14:00 -0400
In-Reply-To: <i14p03$hn$5@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: ceph-devel@vger.kernel.org

Hi Thomas,

About Debian, your right, the service command is not installed by
default.

RHEL, CentOS and Ubuntu all support the "service" command, which makes
the Wiki usefull for those three distributions.

I'm not sure what Debian's plan is with the service command, they also
might install it.

As far as i know the service command is a part of the Linux Standard
Base (LSB), so using that would be a good idea.

I'll change back the Debian specific page.

-- 
Met vriendelijke groet,

Wido den Hollander
CTO
Contact: http://www.pcextreme.nl/contact


On Thu, 2010-07-08 at 14:57 +0000, Thomas Mueller wrote:
> hi wido
> 
> i see you replacing "/etc/init.d/ceph" with  "service ceph" .
> 
> The service thing does not exist on debian. IMHO /etc/init.d/ceph working 
> for all - so may we have it called /etc/init.d/ceph instead of "service 
> ceph"?
> 
> Or at least on debian specific pages please do not change it.
> 
> - Thomas
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

