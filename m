From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: chain_fsetxattr extra chunk removal
Date: Sun, 10 Feb 2013 21:13:22 -0800
Message-ID: <CAC-hyiFwyJ9mFKvhcOh0dzGMTM4bFXXphn3vzfJRNuZm90HGCA@mail.gmail.com>
References: <511415A4.5050203@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:51474 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750708Ab3BKFNX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Feb 2013 00:13:23 -0500
Received: by mail-ie0-f169.google.com with SMTP id 13so7264675iea.14
        for <ceph-devel@vger.kernel.org>; Sun, 10 Feb 2013 21:13:23 -0800 (PST)
In-Reply-To: <511415A4.5050203@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Samuel Just <sam.just@inktank.com>

On Thu, Feb 7, 2013 at 12:59 PM, Loic Dachary <loic@dachary.org> wrote:
> Hi,
>
> While writing unit tests for chain_xattr.cc I tried to understand how to create the conditions to trigger this part of the chain_fsetxattr function:
>
>   /* if we're exactly at a chunk size, remove the next one (if wasn't removed
>      before) */
>   if (ret >= 0 && chunk_size == CHAIN_XATTR_MAX_BLOCK_LEN) {
>     get_raw_xattr_name(name, i, raw_name, sizeof(raw_name));
>     int r = sys_fremovexattr(fd, raw_name);
>     if (r < 0 && r != -ENODATA)
>       ret = r;
>   }
>
> I suspect this cleans up extra empty attributes created as a side effect of a previous version of the function. Or I just don't understand the case it addresses.
>
> I'd very much appreciate a hint :-)
>

Well, the code has changed a bit, but originally when a chain was
overwritten we didn't bother to remove the xattrs tail. When we read
the chain we stop either when we got a short xattr, or when the next
xattr in the chain didn't exist.  So when writing an xattr that was
perfectly aligned with the block len we had to remove the next xattr
in order make sure that readers will not over-read. I'm not too sure
whether that still the case, Sam might have a better idea.
In any case, it might be a good idea to test the case where we have a
big xattr that spans across multiple blocks (e.g., > 3) and being
overwritten by a short xattr. Probably also need to test it with
different combinations of aligned and non-aligned block sizes.

Thanks,
Yehuda
