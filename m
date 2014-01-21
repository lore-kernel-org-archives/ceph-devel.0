From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: CEPH_FEATURE_OSD_CACHEPOOL always required when osd cache pool
 exist ?
Date: Tue, 21 Jan 2014 11:46:15 +0200
Message-ID: <CALFYKtD8pTFXogm5-Uo50vpxN2fVKdOfKovo44TdLFCH8zQ+XA@mail.gmail.com>
References: <52DE2F90.9030201@ksperis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f180.google.com ([74.125.82.180]:61239 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754091AbaAUJqQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Jan 2014 04:46:16 -0500
Received: by mail-we0-f180.google.com with SMTP id q59so7714268wes.25
        for <ceph-devel@vger.kernel.org>; Tue, 21 Jan 2014 01:46:15 -0800 (PST)
In-Reply-To: <52DE2F90.9030201@ksperis.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Laurent Barbe <laurent@ksperis.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Jan 21, 2014 at 10:28 AM, Laurent Barbe <laurent@ksperis.com> wrote:
> Hi all,
>
> About 0.75, when I created cache pool, kernel client like rbd or cephfs make
> error "feature set mismatch". (Even if the device is not on the cached pool)
>
> $ rbd map rbd/myrbd    => OK
>
> $ ceph osd pool create otherpool1 100 100
> $ ceph osd pool create otherpool2 100 100
> $ ceph osd tier add otherpool1 otherpool2
> $ ceph osd tier cache-mode otherpool2 writeback
>
> $ rbd map rbd/myrbd
> kern log >> libceph: mon2 10.2.0.90:6789 feature set mismatch, my 4a042a42 <
> server's 84a042a42, missing 800000000
>
> Does the commit
> https://github.com/ceph/ceph/commit/431a13eb370310a383abceeb509fe204a519e087
> fix this ?

No, I don't think so.  I might be wrong, but I think the idea is to
require OSD_CACHEPOOL feature if any tiering relationships are present.
Work on the kernel client is on-going, tiering support should arrive in
3.14.

Thanks,

                Ilya
