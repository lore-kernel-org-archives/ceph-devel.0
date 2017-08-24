From: John Spray <jspray@redhat.com>
Subject: Re: Bug#19994
Date: Thu, 24 Aug 2017 14:47:36 +0100
Message-ID: <CALe9h7daOGSzH0JQPP9hDmrYugnE_qG+7AKPLFkKMntd-tym5A@mail.gmail.com>
References: <CAKRxpuvqL6ODrGEpd_Zt+Zi+t2tL92o0RjhzwKJGn6t=wVgHew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f182.google.com ([209.85.128.182]:33217 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752358AbdHXNr6 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Aug 2017 09:47:58 -0400
Received: by mail-wr0-f182.google.com with SMTP id r6so2644459wrg.0
        for <ceph-devel@vger.kernel.org>; Thu, 24 Aug 2017 06:47:57 -0700 (PDT)
In-Reply-To: <CAKRxpuvqL6ODrGEpd_Zt+Zi+t2tL92o0RjhzwKJGn6t=wVgHew@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Two Spirit <twospirit6905@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Aug 24, 2017 at 8:35 AM, Two Spirit <twospirit6905@gmail.com> wrote:
> Hi. I'm a newbie and haven't yet figured out how to comment into the
> tracker. I was playing with kraken and just switched over to luminous
> rc4, and I couldn't get the ceph-mgr started. I got an error similiar
> to bug #19994 with a HEALTH_WARN no active mgr. I can't seem to get
> the ceph-mgr started manually. the /var/lib/ceph/mgr/ directory is
> empty, yet I have the mgr keyring file available to my ceph-deploy
> directory. I'm running ubuntu 16.04.3 LTS. x64

So you're trying to deploy using "ceph-deploy mgr create" with latest
ceph-deploy code, correct?  And is that giving an error?

BTW, you have some kind of footer that is coming through as raw HTML
(http://imgur.com/a/jLcNf).

John

>
> not sure how to get past this problem.<div
> id="DAB4FAD8-2DD7-40BB-A1B8-4E2AA1F9FDF2"><br />
> <table style="border-top: 1px solid #D3D4DE;">
>         <tr>
>         <td style="width: 55px; padding-top: 13px;"><a
> href="http://www.avg.com/email-signature?utm_medium=email&utm_source=link&utm_campaign=sig-email&utm_content=webmail"
> target="_blank"><img
> src="https://ipmcdn.avast.com/images/icons/icon-envelope-tick-green-avg-v1.png"
> alt="" width="46" height="29" style="width: 46px; height: 29px;"
> /></a></td>
>                 <td style="width: 470px; padding-top: 12px; color: #41424e;
> font-size: 13px; font-family: Arial, Helvetica, sans-serif;
> line-height: 18px;">Virus-free. <a
> href="http://www.avg.com/email-signature?utm_medium=email&utm_source=link&utm_campaign=sig-email&utm_content=webmail"
> target="_blank" style="color: #4453ea;">www.avg.com</a>
>                 </td>
>         </tr>
> </table><a href="#DAB4FAD8-2DD7-40BB-A1B8-4E2AA1F9FDF2" width="1"
> height="1"></a></div>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
