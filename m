From: Yehuda Sadeh <yehuda@redhat.com>
Subject: Re: can I use librgw APIS?
Date: Mon, 24 Nov 2014 09:56:14 -0800
Message-ID: <CABBk=J98O8h6ST1O68DXL_pe=btw4KGkjmunmjGLjoTRf=7U6Q@mail.gmail.com>
References: <201411242315048227322@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:50127 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753335AbaKXR4P (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Nov 2014 12:56:15 -0500
Received: by mail-ig0-f172.google.com with SMTP id hl2so3535222igb.17
        for <ceph-devel@vger.kernel.org>; Mon, 24 Nov 2014 09:56:14 -0800 (PST)
In-Reply-To: <201411242315048227322@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "baijiaruo@gmail.com" <baijiaruo@gmail.com>
Cc: Ceph?Development <ceph-devel@vger.kernel.org>

On Mon, Nov 24, 2014 at 7:15 AM, baijiaruo@gmail.com
<baijiaruo@gmail.com> wrote:
>
> can I use librgw APIS like librados? if I can, how to do it?

At the moment we don't have an rgw library that is equivalent to
librados. It's something we have in mind for a very long time now, but
we didn't get to actually do it. It still is on our radar though.

Yehuda
