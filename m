From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: Re: XFS xattr limit and Ceph
Date: Thu, 15 Oct 2015 15:30:49 +0000
Message-ID: <13A528E0-09E9-49DB-97B0-B9C902E3DF4C@sandisk.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F31743F40@SACMBXIP02.sdcorp.global.sandisk.com>,<CACJqLyavBJpoPpiYgZ9ghLUT2d3_M7tNtFmFt_=pWMbeMuHOpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1on0090.outbound.protection.outlook.com ([157.56.110.90]:16608
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752205AbbJOPay convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Oct 2015 11:30:54 -0400
In-Reply-To: <CACJqLyavBJpoPpiYgZ9ghLUT2d3_M7tNtFmFt_=pWMbeMuHOpw@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Got it, thanks Haomai

Sent from my iPhone

> On Oct 15, 2015, at 8:08 AM, Haomai Wang <haomaiwang@gmail.com> wrote:
> 
> xfs has three store types for xattrs like inline, btree and extents.
> We only want to let xattr stored inline, so it won't need to hit disk.
> So we need to limit the number of xattrs
> 
>> On Thu, Oct 15, 2015 at 10:54 PM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
>> Sage,
>> Why we are using XFS max inline xattr value as 10 only ?
>> 
>> OPTION(filestore_max_inline_xattrs_xfs, OPT_U32, 10)
>> 
>> XFS is supporting 1k limit I guess. Is there any performance reason behind that ?
>> 
>> Thanks & Regards
>> Somnath
>> 
>> ________________________________
>> 
>> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 
> -- 
> Best Regards,
> 
> Wheat
