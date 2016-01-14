From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: cephfs (hammer) flips directory access bits
Date: Thu, 14 Jan 2016 11:24:06 +0800
Message-ID: <CAAM7YA=CTrfFAnR7ci51ZH66tVpJS+BfougOB9ruzmx_Ee5org@mail.gmail.com>
References: <n6l67c$hu$1@ger.gmane.org>
	<CAAM7YA=9RR5KS9dgU9o4viN+-sqf=ij6a6Cg-6J=kjSskFz=dg@mail.gmail.com>
	<56963214.3000505@fu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35191 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753177AbcANDYH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Jan 2016 22:24:07 -0500
Received: by mail-wm0-f48.google.com with SMTP id f206so320137125wmf.0
        for <ceph-devel@vger.kernel.org>; Wed, 13 Jan 2016 19:24:06 -0800 (PST)
In-Reply-To: <56963214.3000505@fu-berlin.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Salzmann <Christian.Salzmann@fu-berlin.de>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Jan 13, 2016 at 7:16 PM, Christian Salzmann
<Christian.Salzmann@fu-berlin.de> wrote:
> On 08.01.2016 09:54, Yan, Zheng wrote:
>
>> do you use kernel client? I remember an ACL related bug in old kernel
>> can cause this. mount cephfs with '-o noacl' option can avoid this
>> issue.
>
> yes, we use the kernel client (in Debian stable) and yes, mounting with 'noacl' avoids this issue.
> Good catch!
>
> Do you eventually have a pointer to the patch fixing this bug?
> I am convinced the patch could be backported to the kernel in Debian Jessie (as long as it's not too intrusive).
>

https://github.com/ceph/ceph-client/commit/f5f186474335ac385def69564542e6e4c6a3a8bd

Regards
Yan, Zheng
