From: xinxin shu <xinxin.shu5040@gmail.com>
Subject: Re: ceph osd start process
Date: Fri, 7 Nov 2014 08:38:42 +0800
Message-ID: <CAF7cUg1GG_CLy_AN6ztDFpMYtWGhwg9r1O-2J0DuA221ZJcP=A@mail.gmail.com>
References: <CAF7cUg1A_k1rtR41Ps27TftGHd7dLDrQ-QqEg+1T1Xagaa7FsQ@mail.gmail.com>
 <085BC98701B92B4C86AE7696562D284D0B993353@SACMBXIP03.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yh0-f41.google.com ([209.85.213.41]:52684 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846AbaKGAjE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Nov 2014 19:39:04 -0500
Received: by mail-yh0-f41.google.com with SMTP id i57so760902yha.28
        for <ceph-devel@vger.kernel.org>; Thu, 06 Nov 2014 16:39:02 -0800 (PST)
In-Reply-To: <085BC98701B92B4C86AE7696562D284D0B993353@SACMBXIP03.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vijayendra Shamanna <Vijayendra.Shamanna@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

thanks for your reply , but there are some records in leveldb , such
as pglog info , pg epoch and so on , i also want to when and where
ceph gererates these records?

2014-11-06 15:47 GMT+08:00 Vijayendra Shamanna
<Vijayendra.Shamanna@sandisk.com>:
> Hi,
>
> You can refer to "_create_collection", which is invoked from  OP_MKCOLL transaction opcode (FileStore.cc) context for the file store backend.
>
> Thanks,
> Viju
>
>
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of xinxin shu
> Sent: Thursday, November 06, 2014 12:39 PM
> To: ceph-devel@vger.kernel.org
> Subject: ceph osd start process
>
> hi all ,
>
> i want to find out how ceph osd daemon start , first i use "mkcephfs"
> to initialize the osd data directory , i found that there are some files and directories (commit_op_seq  meta  nosnap  omap) in current directory ,  but no pg directories , then i start ceph osd daemon , pg directories are created , but i do not know when and where these pg directories are created , can someone tell more details about how these pg are created and where i can locate the code of pg creation?
> any tips will be appreciated.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> ________________________________
>
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
>
