From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH] libceph: sync osd op definitions in rados.h
Date: Wed, 8 Oct 2014 19:11:44 +0400
Message-ID: <CALFYKtDeJSqGrx_GOG7DVOt5K1d_wCQCoz-E4ZMCu6DSPr5XFg@mail.gmail.com>
References: <1412757405-6917-1-git-send-email-idryomov@redhat.com>
	<alpine.DEB.2.00.1410080756540.742@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:49047 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754700AbaJHPLp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Oct 2014 11:11:45 -0400
Received: by mail-qc0-f170.google.com with SMTP id m20so7753560qcx.15
        for <ceph-devel@vger.kernel.org>; Wed, 08 Oct 2014 08:11:44 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1410080756540.742@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Oct 8, 2014 at 6:57 PM, Sage Weil <sweil@redhat.com> wrote:
> I assume this is basically a cut and paste from the updated ceph.git code?
>
> Reviewed-by: Sage Weil <sage@redhat.com>
>
> On Wed, 8 Oct 2014, Ilya Dryomov wrote:
>
>> Bring in missing osd ops and strings, use macros to eliminate multiple
>> points of maintenance.

Yes.

Thanks,

                Ilya
