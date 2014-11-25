From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: [ceph-users] fiemap bug on giant
Date: Tue, 25 Nov 2014 09:57:58 +0800
Message-ID: <CACJqLyY05osh5N=OGau9UAwRUuomL9adD39n6S63LSs5Xmu40w@mail.gmail.com>
References: <CA+4uBUbDywTkuFfhY2uCBWcXRCYjcitDQE7SVZRVjm9NwuXOBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:43601 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983AbaKYB57 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Nov 2014 20:57:59 -0500
Received: by mail-wg0-f52.google.com with SMTP id a1so13857645wgh.39
        for <ceph-devel@vger.kernel.org>; Mon, 24 Nov 2014 17:57:58 -0800 (PST)
In-Reply-To: <CA+4uBUbDywTkuFfhY2uCBWcXRCYjcitDQE7SVZRVjm9NwuXOBA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sjust@redhat.com
Cc: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

It's surprised that the test machine run on a very new kernel but
occur this problem:

plana 47 is 12.04.5 with kernel 3.18.0-rc6-ceph-00024-geb0e5fd

plana 50 is 12.04.4 with kernel 3.17.0-rc6-ceph-00002-ge8acad6

Which local filesystem is ran on?

On Tue, Nov 25, 2014 at 5:03 AM, Samuel Just <sam.just@inktank.com> wrote:
> Bug #10166 (http://tracker.ceph.com/issues/10166) can cause recovery
> to result in incorrect object sizes on giant if the setting 'filestore
> fiemap' is set to true.  This setting is disabled by default.  This
> should be fixed in a future point release, though filestore fiemap
> will probably continue to default to false.
> -Sam
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com



-- 
Best Regards,

Wheat
