From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: journal alignment
Date: Fri, 20 Nov 2015 16:41:36 +0800
Message-ID: <CACJqLyYH5+URYE8PN1GR07jNf5fyz52BS4mRzS6Md1pr4J+FgA@mail.gmail.com>
References: <019801d1236e$206f12e0$614d38a0$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:36691 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757554AbbKTIlg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Nov 2015 03:41:36 -0500
Received: by obdgf3 with SMTP id gf3so82223633obd.3
        for <ceph-devel@vger.kernel.org>; Fri, 20 Nov 2015 00:41:36 -0800 (PST)
In-Reply-To: <019801d1236e$206f12e0$614d38a0$@com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: changtao381 <changtao381@163.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Nov 20, 2015 at 4:33 PM, changtao381 <changtao381@163.com> wrote:
> HI All,
>
> Why it is needed an entry of journal t is aligned  by  CEPH_PAGE_MASK ?  For
> it causes the data of journal write are amplified by 2X for small io
>

linux aio/dio required this

> For example write io size 4096 bytes, it may write 8192 bytes
>
> prepare_single_write 2 will write 98304 : seq 24 len 4324 -> 8192 (head 40
> pre_pad 0 ebl 4324 post_pad 3788 tail 40) (ebl alignment -1)
>
> Thanks!
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards,

Wheat
