From: Vasu Kulkarni <vakulkar@redhat.com>
Subject: Re: Bug#19994
Date: Thu, 24 Aug 2017 09:19:44 -0700
Message-ID: <CAKPXa=Zcf9n25GU24Gfx6UEM5YKVS+89nfRcb46g7stexokffg@mail.gmail.com>
References: <CAKRxpuvqL6ODrGEpd_Zt+Zi+t2tL92o0RjhzwKJGn6t=wVgHew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:36233 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751895AbdHXQTp (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Aug 2017 12:19:45 -0400
Received: by mail-oi0-f52.google.com with SMTP id t196so9775466oif.3
        for <ceph-devel@vger.kernel.org>; Thu, 24 Aug 2017 09:19:45 -0700 (PDT)
In-Reply-To: <CAKRxpuvqL6ODrGEpd_Zt+Zi+t2tL92o0RjhzwKJGn6t=wVgHew@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Two Spirit <twospirit6905@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Aug 24, 2017 at 12:35 AM, Two Spirit <twospirit6905@gmail.com> wrote:
> Hi. I'm a newbie and haven't yet figured out how to comment into the
> tracker. I was playing with kraken and just switched over to luminous
> rc4, and I couldn't get the ceph-mgr started. I got an error similiar
> to bug #19994 with a HEALTH_WARN no active mgr.

I will add a case to check if the issue still exits from Kraken ->
luminous upgrade, you could try the
below workaround if mgr key is corrupt (i,e key: AAAAAAAAAAAAAAAA )

"ceph auth del client.bootstrap-mgr ; ceph auth get-or-create
client.bootstrap-mgr mon "allow profile bootstrap-mgr" >
/var/lib/ceph/bootstrap-mgr"

If the key is not corrupt you could just rewrite new key on disk for
issue similar to
https://www.spinics.net/lists/ceph-devel/msg37911.html

sudo ceph auth get client.bootstrap-mgr > /var/lib/ceph/bootstrap-mgr


 I can't seem to get
> the ceph-mgr started manually. the /var/lib/ceph/mgr/ directory is
> empty, yet I have the mgr keyring file available to my ceph-deploy
> directory. I'm running ubuntu 16.04.3 LTS. x64
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
