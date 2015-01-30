From: Yehuda Sadeh <yehuda@redhat.com>
Subject: Re: radosgw: bad content length
Date: Fri, 30 Jan 2015 08:39:23 -0800
Message-ID: <CABBk=J9G-pQauPiaiixmbZ6U=aLgb16i99WS5Ck0QcZ7ZcGdig@mail.gmail.com>
References: <loom.20150130T152219-712@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34434 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754679AbbA3QjX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Jan 2015 11:39:23 -0500
Received: by mail-pa0-f46.google.com with SMTP id lj1so54159762pab.5
        for <ceph-devel@vger.kernel.org>; Fri, 30 Jan 2015 08:39:23 -0800 (PST)
In-Reply-To: <loom.20150130T152219-712@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Axel Dunkel <ad@dunkel.de>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Jan 30, 2015 at 8:22 AM, Axel Dunkel <ad@dunkel.de> wrote:
> Hi,
>
> there are issues with radosgw and large file transfers without using
> multiparts (like with "s3cmd --disable-multipart put") which seem to be
> somehow known, but unsolved.
>
> Things run fine if the request takes no longer than 180sec. If it takes
> longer, rgw_rest.cc (line 1236) gives the error "bad content length,
> aborting" AFTER the request has been fully completed (so no timeout
> issue). If the s3cmd runs less than 180sec things go through fine, if it
> takes longer, the same command fails.
>
> This error is given if the variable Content-Length can not be parsed - is
> it possible that some timer causes this variable to get corrupted? I did
> not find any 180sec timer, though...
>
> This is with ceph version 0.87 (c51c8f9d80fa4e0168aa52685b8de40e42758578),
> Ubuntu 14.04.
>
That would happen if the connection is shut down for some reason
(either client to apache tcp connection, or apache module to radosgw
connection). This may very well be due to inactivity. At that point,
rgw will get some kind of EOF status, and will verify that total
received content is equal to the Content-Length field. If it's not
equal you'd get that response. Are you, by any chance, using mod_fcgid
as the fastcgi module (as opposed to mod_fastcgi, or mod_proxy_fcgi)?

Yehuda
