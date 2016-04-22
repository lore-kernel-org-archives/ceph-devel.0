From: kefu chai <tchaikov@gmail.com>
Subject: Re: why there is not a status bit for CEPH_OSD_DOWN?
Date: Fri, 22 Apr 2016 15:40:46 +0800
Message-ID: <CAJE9aONrdEXUDh=iWk1WEsJNiqPbRCLxdbk1MHBOJn7pnTFfTA@mail.gmail.com>
References: <CAKZcxgcdkwJbo8wgKan4o8YZZRz+hwD4CLcKhj2fx-RLHX4Xig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f174.google.com ([209.85.161.174]:35462 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761AbcDVHkr convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Apr 2016 03:40:47 -0400
Received: by mail-yw0-f174.google.com with SMTP id g133so100724274ywb.2
        for <ceph-devel@vger.kernel.org>; Fri, 22 Apr 2016 00:40:47 -0700 (PDT)
In-Reply-To: <CAKZcxgcdkwJbo8wgKan4o8YZZRz+hwD4CLcKhj2fx-RLHX4Xig@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jaze Lee <jazeltq@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Apr 21, 2016 at 12:11 PM, Jaze Lee <jazeltq@gmail.com> wrote:
> hi all
>   I found when osds report a target osd failure, the monitor encode
> CEPH_OSD_UP in
>   the pend_inc. Why not put CEPH_OSD_DOWN there?
>    The code is here
>    https://github.com/ceph/ceph/blob/master/src/mon/OSDMonitor.cc#L17=
77
>
>   May be i miss something? Or my understanding is wrong? Can someone
> who know that
>   explain a little more?

you might want to check
https://github.com/ceph/ceph/blob/master/src/osd/OSDMap.cc#L1348,
so the new state is xor(old_state, pending_state), the same applies to
CEPH_OSD_EXISTS.

>
> Thanks a lot....
>
>
>
>
>
> --
> =E8=B0=A6=E8=B0=A6=E5=90=9B=E5=AD=90
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Regards
Kefu Chai
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
