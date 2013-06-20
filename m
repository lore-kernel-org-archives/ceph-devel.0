From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: [PATCH] rgw: Added an encoder for time_t to fix compilation
Date: Thu, 20 Jun 2013 13:44:02 -0700
Message-ID: <CABBk=J8J_tKY-Wy-sWb2=GREauqN0GfaJaHk14jzRVM0fx59Bg@mail.gmail.com>
References: <CAA8043gcmGmpNba7OEbh8Vo7-SgUN_R_CcGpsi_Vt9pgmmhirw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f172.google.com ([209.85.128.172]:36025 "EHLO
	mail-ve0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161213Ab3FTUoE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Jun 2013 16:44:04 -0400
Received: by mail-ve0-f172.google.com with SMTP id jz10so5560024veb.3
        for <ceph-devel@vger.kernel.org>; Thu, 20 Jun 2013 13:44:03 -0700 (PDT)
In-Reply-To: <CAA8043gcmGmpNba7OEbh8Vo7-SgUN_R_CcGpsi_Vt9pgmmhirw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: christophe courtaut <christophe.courtaut@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Jun 20, 2013 at 6:57 AM, christophe courtaut
<christophe.courtaut@gmail.com> wrote:
> On the rgw-wip-geo-2 branch, the encode decode function are called
> with time_t now,
> but there is no encode/decode function created for time_t type.
>
> http://tracker.ceph.com/issues/5402 refs #5402
>
> This patch adds a WRITE_RAW_ENCODER to support this type.
>
> --
> Christophe Courtaut


The problem here is that we can't use the generic encoder / decoder as
time_t may have different size on different architectures. We should
just have a fixed size encoding for it (probably 64 bit albeit the
waste).

Thanks,
Yehuda
