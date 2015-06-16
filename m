From: Gregory Farnum <greg@gregs42.com>
Subject: Re: firefly v0.80.10 QE validation status 6/15/2015
Date: Tue, 16 Jun 2015 03:02:34 -0700
Message-ID: <CAC6JEv-9YuoQuO6AJDAgPipVTCfx9-Yf+1i1M8C1D90RNFPU0A@mail.gmail.com>
References: <515457523.22063779.1434385426136.JavaMail.zimbra@redhat.com>
	<887573759.22073065.1434386240075.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:36513 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932995AbbFPKCf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Jun 2015 06:02:35 -0400
Received: by iecrd14 with SMTP id rd14so9403568iec.3
        for <ceph-devel@vger.kernel.org>; Tue, 16 Jun 2015 03:02:34 -0700 (PDT)
Received: from mail-ig0-f179.google.com (mail-ig0-f179.google.com. [209.85.213.179])
        by mx.google.com with ESMTPSA id e69sm263714ioe.11.2015.06.16.03.02.34
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jun 2015 03:02:34 -0700 (PDT)
Received: by igboe5 with SMTP id oe5so50916674igb.1
        for <ceph-devel@vger.kernel.org>; Tue, 16 Jun 2015 03:02:34 -0700 (PDT)
In-Reply-To: <887573759.22073065.1434386240075.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Loic Dachary <ldachary@redhat.com>, Xinxin Shu <xinxin.shu@intel.com>

On Mon, Jun 15, 2015 at 9:37 AM, Yuri Weinstein <yweinste@redhat.com> wrote:
> QE validation is almost completed (there are a couple of jobs that are still running)
>
> All statis details were summarized in http://tracker.ceph.com/issues/11090
>
> Highlights (by suite/issue):
>
> rados #11914 needs Sam's approval
> kcephfs n/a needs Greg's approval

It's probably fine, but I'd prefer if you ran it through again. The
kcephfs suite isn't too large and I think the kernel tree should be in
better shape now. :)

> samba #6613 needs Greg's approval

That's not a problem.

>
> Nice to have fixes (no blockers):
> upgrade/firefly(distros) #11957 (env noise)
>
>
> Thx
> YuriW
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
