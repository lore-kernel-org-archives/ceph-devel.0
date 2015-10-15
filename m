From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: XFS xattr limit and Ceph
Date: Thu, 15 Oct 2015 23:08:25 +0800
Message-ID: <CACJqLyavBJpoPpiYgZ9ghLUT2d3_M7tNtFmFt_=pWMbeMuHOpw@mail.gmail.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F31743F40@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f44.google.com ([209.85.213.44]:33565 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752289AbbJOPI1 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Oct 2015 11:08:27 -0400
Received: by vkaw128 with SMTP id w128so51038404vka.0
        for <ceph-devel@vger.kernel.org>; Thu, 15 Oct 2015 08:08:26 -0700 (PDT)
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F31743F40@SACMBXIP02.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

xfs has three store types for xattrs like inline, btree and extents.
We only want to let xattr stored inline, so it won't need to hit disk.
So we need to limit the number of xattrs

On Thu, Oct 15, 2015 at 10:54 PM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
> Sage,
> Why we are using XFS max inline xattr value as 10 only ?
>
> OPTION(filestore_max_inline_xattrs_xfs, OPT_U32, 10)
>
> XFS is supporting 1k limit I guess. Is there any performance reason behind that ?
>
> Thanks & Regards
> Somnath
>
> ________________________________
>
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards,

Wheat
