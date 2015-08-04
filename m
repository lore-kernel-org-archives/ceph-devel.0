From: Yehuda Sadeh-Weinraub <ysadehwe@redhat.com>
Subject: Re: Civetweb and mg_set_http_status
Date: Tue, 4 Aug 2015 16:25:22 -0700
Message-ID: <CADRKj5T=a=g-+2Lo=BJ1Q77hWL340L5Z83UQx-quRgWSimC5CQ@mail.gmail.com>
References: <20150804171107.171dec7c@guren.zaitcev.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:34119 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754289AbbHDXZX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Aug 2015 19:25:23 -0400
Received: by obre1 with SMTP id e1so19252822obr.1
        for <ceph-devel@vger.kernel.org>; Tue, 04 Aug 2015 16:25:22 -0700 (PDT)
In-Reply-To: <20150804171107.171dec7c@guren.zaitcev.lan>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

at the ceph root: git submodule init; git submodule update

Let me know if it fails to work.

On Tue, Aug 4, 2015 at 4:11 PM, Pete Zaitcev <zaitcev@redhat.com> wrote:
> I did a "git pull" today and now the build breaks like this:
>
>   CXX      rgw/libcivetweb_la-rgw_civetweb.lo
> rgw/rgw_civetweb.cc: In member function 'virtual int RGWMongoose::send_status(const char*, const char*)':
> rgw/rgw_civetweb.cc:147:38: error: 'mg_set_http_status' was not declared in this scope
>    mg_set_http_status(conn, status_num);
>                                       ^
> It comes from this:
>
> commit b8e28ab9f914bf48c9ba4f0def9a0deb9dbb93bc
> Author: Yehuda Sadeh <yehuda@redhat.com>
> Date:   Wed Jul 22 10:01:00 2015 -0700
>
>     rgw: set http status in civetweb
>
>     Need to set the http status in civetweb so that we report it correctly.
>     Fixes: #12432
>
>     Signed-off-by: Yehuda Sadeh <yehuda@redhat.com>
>
> I suspect my civetweb may be obsolete. The "cd src/civetweb && git tag -l"
> returns v1.5. Do I need a magic git incantation to refresh submodules?
>
> Thanks in advance,
> -- Pete
