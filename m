From: Alfredo Deza <alfredo.deza@inktank.com>
Subject: Re: [ceph-users] Missing Dependency for ceph-deploy 1.2.7
Date: Wed, 16 Oct 2013 10:38:21 -0400
Message-ID: <CANtztVzgqbtByx_cnxSq=V5QBKrK3hb0=cE9rnQz1u=VZeMi3w@mail.gmail.com>
References: <E0E280CCE0E1A44898C992A9190D929A53D4B7@MBX01-TPM.mimos.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:62844 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755790Ab3JPOiW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Oct 2013 10:38:22 -0400
Received: by mail-ob0-f174.google.com with SMTP id wm4so649778obc.33
        for <ceph-devel@vger.kernel.org>; Wed, 16 Oct 2013 07:38:22 -0700 (PDT)
In-Reply-To: <E0E280CCE0E1A44898C992A9190D929A53D4B7@MBX01-TPM.mimos.local>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Luke Jing Yuan <jyluke@mimos.my>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

On Tue, Oct 15, 2013 at 9:54 PM, Luke Jing Yuan <jyluke@mimos.my> wrote:
> Hi,
>
> I am trying to install/upgrade to 1.2.7 but Ubuntu (Precise) is complaining about unmet dependency which seemed to be python-pushy 0.5.3 which seemed to be missing. Am I correct to assume so?

That is odd, we still have pushy packages available for the version
that you are having issues with, see:
http://ceph.com/debian-dumpling/pool/main/p/python-pushy/

It might be that you need to update your repos?
>
> Regards,
> Luke
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
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
