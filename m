From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: Source for python-rbd,rados packages
Date: Mon, 5 Oct 2015 17:06:31 -0600
Message-ID: <CALqRxCy9x6=iDVuXK7HTBpnZMXz4ADG8-wdnfmKa76_xBTRrhg@mail.gmail.com>
References: <loom.20151006T003758-577@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:38576 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbbJEXGd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Oct 2015 19:06:33 -0400
Received: by wiclk2 with SMTP id lk2so135367302wic.1
        for <ceph-devel@vger.kernel.org>; Mon, 05 Oct 2015 16:06:32 -0700 (PDT)
In-Reply-To: <loom.20151006T003758-577@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: shiva <shiva.rkreddy@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Oct 5, 2015 at 4:40 PM, shiva <shiva.rkreddy@gmail.com> wrote:
> Trying to find the source files used to build hammer v0.94.3 of python-rbd and
>  python-rados packages.
>  I'm mainly interested in rbd.py and rados.py of these packages.
>
> The source files at : https://github.com/ceph/ceph/tree/master/src/pybind,
> are different from what is shipped for v0.94.3

On that web page, there's a drop-down that says "Branch: master".
Change that to "Tag: v0.94.3"

- Ken
