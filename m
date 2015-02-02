From: Alfredo Deza <adeza@redhat.com>
Subject: Re: radosgw-agent failed to parse
Date: Mon, 2 Feb 2015 09:17:53 -0500
Message-ID: <CANtztVx9RZs1h-vqLUNMWhq+PrWcAigzh7qb0dpzUeFXf6+Fgw@mail.gmail.com>
References: <31740_1422885416_54CF8227_31740_2351_1_B9C8EFBF13B1354DB5FA000660D66DD00C1F804F@PEXCVZYM14.corporate.adroot.infra.ftgroup>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yh0-f47.google.com ([209.85.213.47]:32786 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753098AbbBBORy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Feb 2015 09:17:54 -0500
Received: by mail-yh0-f47.google.com with SMTP id z6so15986389yhz.6
        for <ceph-devel@vger.kernel.org>; Mon, 02 Feb 2015 06:17:53 -0800 (PST)
In-Reply-To: <31740_1422885416_54CF8227_31740_2351_1_B9C8EFBF13B1354DB5FA000660D66DD00C1F804F@PEXCVZYM14.corporate.adroot.infra.ftgroup>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ghislain.chevalier@orange.com
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

What version of the agent are you using? And when it fails, how does
the log output look?

On Mon, Feb 2, 2015 at 8:56 AM,  <ghislain.chevalier@orange.com> wrote:
> Hi all,
>
> Context : Ubuntu 14.04 TLS firefly 0.80.8
>
> I sent this post in ceph-users (identical subject) because I recently encountered the same issue.
> Maybe I missed something between July and January...
>
> I found that the http request wasn't correctly formed by /usr/lib/python2.7/dist-packages/radosgw_agent/client.py
>
> I did the changes below
> #    url = '{protocol}://{host}{path}'.format(protocol=request.protocol,
> #                                             host=request.host,
> #                                             path=request.path)
>      url = '{path}'.format(protocol="", host="", path=request.path)
>
> The request is then correctly formed and sent.
>
> I still have problems setting the federation between 2 zones of 2 ceph clusters in 2 regions.
>
> I go on investigating.
>
> Best regards
>
>
> _________________________________________________________________________________________________________________________
>
> Ce message et ses pieces jointes peuvent contenir des informations confidentielles ou privilegiees et ne doivent donc
> pas etre diffuses, exploites ou copies sans autorisation. Si vous avez recu ce message par erreur, veuillez le signaler
> a l'expediteur et le detruire ainsi que les pieces jointes. Les messages electroniques etant susceptibles d'alteration,
> Orange decline toute responsabilite si ce message a ete altere, deforme ou falsifie. Merci.
>
> This message and its attachments may contain confidential or privileged information that may be protected by law;
> they should not be distributed, used or copied without authorisation.
> If you have received this email in error, please notify the sender and delete this message and its attachments.
> As emails may be altered, Orange is not liable for messages that have been modified, changed or falsified.
> Thank you.
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
