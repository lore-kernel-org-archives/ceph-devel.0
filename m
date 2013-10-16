From: Ian Colle <ian.colle@inktank.com>
Subject: Re: [ceph-users] Missing Dependency for ceph-deploy 1.2.7
Date: Tue, 15 Oct 2013 21:15:53 -0600
Message-ID: <CE8360DA.19E19%ian.colle@inktank.com>
References: <E0E280CCE0E1A44898C992A9190D929A53D4B7@MBX01-TPM.mimos.local>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:55708 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384Ab3JPDQA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Oct 2013 23:16:00 -0400
Received: by mail-ie0-f179.google.com with SMTP id aq17so302727iec.10
        for <ceph-devel@vger.kernel.org>; Tue, 15 Oct 2013 20:15:59 -0700 (PDT)
In-Reply-To: <E0E280CCE0E1A44898C992A9190D929A53D4B7@MBX01-TPM.mimos.local>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Luke Jing Yuan <jyluke@mimos.my>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>



On 10/15/13 7:54 PM, "Luke Jing Yuan" <jyluke@mimos.my> wrote:

>Hi,
>
>I am trying to install/upgrade to 1.2.7 but Ubuntu (Precise) is
>complaining about unmet dependency which seemed to be python-pushy 0.5.3
>which seemed to be missing. Am I correct to assume so?

Yes - we've removed that dependency upon pushy and are in the process of
testing the refactored code. The next release of ceph-deploy will no
longer be dependent upon pushy.

>
>Regards,
>Luke
>
>------------------------------------------------------------------
>-
>-
>DISCLAIMER: 
>
>This e-mail (including any attachments) is for the addressee(s)
>only and may contain confidential information. If you are not the
>intended recipient, please note that any dealing, review,
>distribution, printing, copying or use of this e-mail is strictly
>prohibited. If you have received this email in error, please notify
>the sender  immediately and delete the original message.
>MIMOS Berhad is a research and development institution under
>the purview of the Malaysian Ministry of Science, Technology and
>Innovation. Opinions, conclusions and other information in this e-
>mail that do not relate to the official business of MIMOS Berhad
>and/or its subsidiaries shall be understood as neither given nor
>endorsed by MIMOS Berhad and/or its subsidiaries and neither
>MIMOS Berhad nor its subsidiaries accepts responsibility for the
>same. All liability arising from or in connection with computer
>viruses and/or corrupted e-mails is excluded to the fullest extent
>permitted by law.
>
>
>_______________________________________________
>ceph-users mailing list
>ceph-users@lists.ceph.com
>http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com


