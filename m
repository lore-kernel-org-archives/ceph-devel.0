From: Luke Jing Yuan <jyluke@mimos.my>
Subject: Issues with ceph-deploy/deph-disk
Date: Fri, 14 Jun 2013 09:57:29 +0000
Message-ID: <E0E280CCE0E1A44898C992A9190D929A49E50C@MBX01-TPM.mimos.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from imperial.mimos.my ([192.228.137.109]:53348 "EHLO
	IMPERIAL.MIMOS.MY" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752009Ab3FNJ5b convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Jun 2013 05:57:31 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Dear developers,

I had tried asking similar question in ceph-users but had not had any reply so please forgive me for posting here.

I had a slight issue with ceph-deploy (aside from the bug #4984) specifically during osd prepare and activate. I am trying to build cluster using some old HP servers and Ubuntu Precise, but unfortunately the devices in these HP came out as /dev/cciss/c0d0 and so on (or /dev/cciss/c0d0p1 if with partitions). So is there any possible workaround or where I can make changes since the ceph-deploy/ceph-disk is expecting something like /dev/sda instead? 

Thanks in advance.

Regards,
Luke


------------------------------------------------------------------
-
-
DISCLAIMER: 

This e-mail (including any attachments) is for the addressee(s) 
only and may contain confidential information. If you are not the 
intended recipient, please note that any dealing, review, 
distribution, printing, copying or use of this e-mail is strictly 
prohibited. If you have received this email in error, please notify 
the sender  immediately and delete the original message. 
MIMOS Berhad is a research and development institution under 
the purview of the Malaysian Ministry of Science, Technology and 
Innovation. Opinions, conclusions and other information in this e-
mail that do not relate to the official business of MIMOS Berhad 
and/or its subsidiaries shall be understood as neither given nor 
endorsed by MIMOS Berhad and/or its subsidiaries and neither 
MIMOS Berhad nor its subsidiaries accepts responsibility for the 
same. All liability arising from or in connection with computer 
viruses and/or corrupted e-mails is excluded to the fullest extent 
permitted by law.


