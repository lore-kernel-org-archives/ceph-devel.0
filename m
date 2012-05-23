From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: RGW, future directions
Date: Wed, 23 May 2012 14:57:20 -0700
Message-ID: <CAC-hyiEmhhwSKhHVQGe2FkSeB4No=XLkvL9X7rVKDaGKrSCAUg@mail.gmail.com>
References: <CAC-hyiHQ1oy6cyB-sQHd5b6XQhCgQxHrLDcvzWO0OOwGWfFsRQ@mail.gmail.com>
	<CANT588skKYuwE2sGvkNs_7W0i=X5Ts=mr_Z+4iQXE4BUpqQcmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:56450 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754473Ab2EWV5V convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 May 2012 17:57:21 -0400
Received: by bkcji2 with SMTP id ji2so6408420bkc.19
        for <ceph-devel@vger.kernel.org>; Wed, 23 May 2012 14:57:20 -0700 (PDT)
In-Reply-To: <CANT588skKYuwE2sGvkNs_7W0i=X5Ts=mr_Z+4iQXE4BUpqQcmg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kiran Patil <kirantpatil@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, May 23, 2012 at 3:17 AM, Kiran Patil <kirantpatil@gmail.com> wr=
ote:
> Hello,
>
> How about this CloudFS=A0management=A0system ?
>
> The=A0CloudFS=A0management=A0system=A0consists=A0of=A0two=A0parts:=A0=
a=A0very=A0simple
> web-based management=A0daemon=A0called=A0cloudfsd,=A0and=A0scripts=A0=
to=A0perform
> various=A0discrete functions.
>
> http://git.fedorahosted.org/git/?p=3DCloudFS.git;a=3Dsummary
>
> http://git.fedorahosted.org/git/?p=3DCloudFS.git;a=3Dblob;f=3Dscripts=
/README.ssl;h=3D3547f6b354d8b3455359ea019f6db9ce74862d2e;hb=3Dcloudfsd
>
> I am not sure, whether it can be reused for ceph.
>

Not sure either. However, the idea of having management API may ease
any such integration.

Thanks,
Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
