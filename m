From: Sage Weil <sage@inktank.com>
Subject: Re: Issues with ceph-deploy/deph-disk
Date: Fri, 14 Jun 2013 08:37:46 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1306140836001.26467@cobra.newdream.net>
References: <E0E280CCE0E1A44898C992A9190D929A49E50C@MBX01-TPM.mimos.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50453 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753403Ab3FNPhr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Jun 2013 11:37:47 -0400
In-Reply-To: <E0E280CCE0E1A44898C992A9190D929A49E50C@MBX01-TPM.mimos.local>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Luke Jing Yuan <jyluke@mimos.my>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Luke,

On Fri, 14 Jun 2013, Luke Jing Yuan wrote:
> Dear developers,
> 
> I had tried asking similar question in ceph-users but had not had any 
> reply so please forgive me for posting here.
> 
> I had a slight issue with ceph-deploy (aside from the bug #4984) 
> specifically during osd prepare and activate. I am trying to build 
> cluster using some old HP servers and Ubuntu Precise, but unfortunately 
> the devices in these HP came out as /dev/cciss/c0d0 and so on (or 
> /dev/cciss/c0d0p1 if with partitions). So is there any possible 
> workaround or where I can make changes since the ceph-deploy/ceph-disk 
> is expecting something like /dev/sda instead?

I opened http://tracker.ceph.com/issues/5345 to track this.  To help us 
out, can you comment on that bug and include the output from 

 find /dev/disk -ls
 find /dev/cciss -ls

The code that determines whether a given device is a partition or 
what partitions belong to which devices is currently using the device 
names to do it, but that clearly isn't a robust approach.

Thanks!
sage


> 
> Thanks in advance.
> 
> Regards,
> Luke
> 
> 
> ------------------------------------------------------------------
> -
> -
> DISCLAIMER: 
> 
> This e-mail (including any attachments) is for the addressee(s) 
> only and may contain confidential information. If you are not the 
> intended recipient, please note that any dealing, review, 
> distribution, printing, copying or use of this e-mail is strictly 
> prohibited. If you have received this email in error, please notify 
> the sender  immediately and delete the original message. 
> MIMOS Berhad is a research and development institution under 
> the purview of the Malaysian Ministry of Science, Technology and 
> Innovation. Opinions, conclusions and other information in this e-
> mail that do not relate to the official business of MIMOS Berhad 
> and/or its subsidiaries shall be understood as neither given nor 
> endorsed by MIMOS Berhad and/or its subsidiaries and neither 
> MIMOS Berhad nor its subsidiaries accepts responsibility for the 
> same. All liability arising from or in connection with computer 
> viruses and/or corrupted e-mails is excluded to the fullest extent 
> permitted by law.
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
