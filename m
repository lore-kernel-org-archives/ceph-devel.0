From: Dan Mick <dan.mick@inktank.com>
Subject: Re: How to write data to snapshot.
Date: Tue, 09 Oct 2012 10:37:55 -0700
Message-ID: <507460F3.10906@inktank.com>
References: <loom.20121007T070909-887@post.gmane.org> <CADvuQRHsA1peMugN4acw7o9SHDCtbP4wpXD_DXPsjZhCY7ZNfw@mail.gmail.com> <loom.20121009T085302-672@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:43439 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754998Ab2JIRh7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Oct 2012 13:37:59 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so5398447pad.19
        for <ceph-devel@vger.kernel.org>; Tue, 09 Oct 2012 10:37:58 -0700 (PDT)
In-Reply-To: <loom.20121009T085302-672@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ramu eppa <ramu.freesystems@gmail.com>
Cc: ceph-devel@vger.kernel.org

I'm not Tommi, but I'm not aware of a way to convert a snapshot into a 
writable image.  You can make a copy-on-write clone of a snapshot, which 
is writable, but the snapshot remains readonly.

I don't know what the rest of your sentence means.

Are you trying to accomplish something in particular?  Can you describe 
that without suggesting a mechanism, and maybe we can help?

On 10/08/2012 11:56 PM, ramu eppa wrote:
> Hi Tommi ,
>
>      If we convert snapshot into writable(mutable),we will copy data to that
> snapshot and getting data multiple times,is it possible.
> This will works on ceph-0.48 or any other version.
>
> Thanks,
> Ramu.
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
