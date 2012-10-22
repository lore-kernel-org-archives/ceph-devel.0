From: Gregory Farnum <greg@inktank.com>
Subject: Re: rbd map error with new rbd format
Date: Mon, 22 Oct 2012 07:27:02 -0700
Message-ID: <CAPYLRzj+ezAcPEKNzOtWDy0kBNabuQHyVde+drFvYgjHQmzahw@mail.gmail.com>
References: <60E83269D669544E8069A09CB69135EA02DF21@GDC-CLDMBX-P02.whq.wistron>
	<60E83269D669544E8069A09CB69135EA03B0A2@GDC-CLDMBX-P02.whq.wistron>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:33357 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754956Ab2JVO1D convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Oct 2012 10:27:03 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so3641090iea.19
        for <ceph-devel@vger.kernel.org>; Mon, 22 Oct 2012 07:27:02 -0700 (PDT)
In-Reply-To: <60E83269D669544E8069A09CB69135EA03B0A2@GDC-CLDMBX-P02.whq.wistron>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Eric_YH_Chen@wiwynn.com
Cc: ceph-devel@vger.kernel.org, Chris_YT_Huang@wiwynn.com, Victor_CY_Chang@wiwynn.com

On Mon, Oct 22, 2012 at 2:04 AM,  <Eric_YH_Chen@wiwynn.com> wrote:
>
>> At this point format 2 is understood by the kernel, and the
>> infrastructure for opening parent images and the I/O path
>> for clones is in progress. We estimate about 4-8 weeks for this,
>> but you should check back then.
>> Kernel 3.6 was already released, so this would probably go into 3.8 =
or
>> 3.9.
>
> Hi Josh:
>
> Please let me clarify some point.
> If we want to map an RBD image to a kernel object, it may not ready u=
ntil kernel 3.8 or 3.9.
Right.

> But if we want to running qemu with RBD, it is ready in kernel 3.6, s=
ince QEMU can access it via librbd directly.
It doesn't even need to be kernel 3.6 =97 it just needs to be a
sufficiently new version of librbd. Hurray userspace! :)
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
