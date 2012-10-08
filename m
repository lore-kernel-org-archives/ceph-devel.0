From: Tommi Virtanen <tv@inktank.com>
Subject: Re: How to write data to snapshot.
Date: Mon, 8 Oct 2012 10:30:24 -0700
Message-ID: <CADvuQRHsA1peMugN4acw7o9SHDCtbP4wpXD_DXPsjZhCY7ZNfw@mail.gmail.com>
References: <loom.20121007T070909-887@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:38173 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753024Ab2JHRap (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Oct 2012 13:30:45 -0400
Received: by mail-qa0-f46.google.com with SMTP id c26so2378785qad.19
        for <ceph-devel@vger.kernel.org>; Mon, 08 Oct 2012 10:30:45 -0700 (PDT)
In-Reply-To: <loom.20121007T070909-887@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ramu eppa <ramu.freesystems@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Sat, Oct 6, 2012 at 10:11 PM, ramu eppa <ramu.freesystems@gmail.com> wrote:
> Hi,
>   In rbd am creating snapshot and next time i copied data to that snapshot,
> it was not copying the data.Please help me to how to copy data to snapshot.

RBD snapshots are immutable by design. You can do a copy-on-write
clone of a snapshot to a writable image (in the latest Ceph version),
or just copy the contents into another image (in older Ceph versions).
