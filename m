From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: Rados gateway 0.58 crash in RGWProcess::_clear
Date: Sun, 10 Mar 2013 15:57:30 -0700
Message-ID: <CAC-hyiGuaH0j+QyAy6BP+UQK3wKb6hx+YU3pZpovqrcxoQTbUA@mail.gmail.com>
References: <367CC0B0FC02EE47BF7482398BD623C55D3C74FE@DB3PRD0311MB416.eurprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:56066 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752995Ab3CJW5b (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 10 Mar 2013 18:57:31 -0400
Received: by mail-ie0-f180.google.com with SMTP id bn7so3967485ieb.39
        for <ceph-devel@vger.kernel.org>; Sun, 10 Mar 2013 15:57:30 -0700 (PDT)
In-Reply-To: <367CC0B0FC02EE47BF7482398BD623C55D3C74FE@DB3PRD0311MB416.eurprd03.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yann ROBIN <yann.robin@youscribe.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sun, Mar 10, 2013 at 3:48 PM, Yann ROBIN <yann.robin@youscribe.com> wrote:
> Hi,
>
> We recently setup a cluster using version 0.58. We did massive parallel upload to the gateway and saw the radosgw restarted every 5 to 10 minutes.
> Here are the debug log :
> https://gist.github.com/kYann/5130775
>
> Small version :
> -2> 2013-03-10 23:20:02.916521 7fc1376ee700  1 ====== req done req=0x237fc10 http_status=200 ======
>     -1> 2013-03-10 23:20:02.916546 7fc1376ee700  1 RGWProcess::m_tp worker finish
>      0> 2013-03-10 23:20:02.931847 7fc1efa5b780 -1 rgw/rgw_main.cc: In function 'virtual void RGWProcess::RGWWQ::_clear()' thread 7fc1efa5b780 time 2013-03-10 23:20:02.922020
> rgw/rgw_main.cc: 175: FAILED assert(process->m_req_queue.empty())
>
> ceph version 0.58 (ba3f91e7504867a52a83399d60917e3414e8c3e2)
> 1: (RGWRESTMgr_Admin::~RGWRESTMgr_Admin()+0) [0x474910]
> 2: (ThreadPool::stop(bool)+0x1ed) [0x4909bd]
> 3: (RGWProcess::run()+0x3c7) [0x473367]
> 4: (main()+0x8b6) [0x447276]
> 5: (__libc_start_main()+0xed) [0x7fc1ec92276d]
> 6: /usr/bin/radosgw() [0x448871]
>
>

This obviously shouldn't happen. Just note that this code should only
be reached either when trying to bring the gateway down, or when
there's some error on the fastcgi socket. Which web server are you
using? Which fastcgi module? How did you set up fastcgi?

Thanks,
Yehuda
