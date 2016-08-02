From: Casey Bodley <cbodley@redhat.com>
Subject: Re: [rgw multisite] disable specified bucket data sync
Date: Tue, 2 Aug 2016 16:42:43 -0400
Message-ID: <dc36d124-bae3-9e42-9daa-4ff66a3d23e5@redhat.com>
References: <7BD28126D6935A4498AE6DE60B5D4CAB314C2E40@H3CMLB12-EX.srv.huawei-3com.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f180.google.com ([209.85.220.180]:34301 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755150AbcHBUmq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Aug 2016 16:42:46 -0400
Received: by mail-qk0-f180.google.com with SMTP id p186so60519201qkd.1
        for <ceph-devel@vger.kernel.org>; Tue, 02 Aug 2016 13:42:45 -0700 (PDT)
In-Reply-To: <7BD28126D6935A4498AE6DE60B5D4CAB314C2E40@H3CMLB12-EX.srv.huawei-3com.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zhangzengran <zhangzengran@h3c.com>
Cc: "yehuda@redhat.com" <yehuda@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


On 08/02/2016 03:34 AM, Zhangzengran wrote:
> Hi Casey:
>          Why don’t support stopping specified bucket data sync. Is there any difficulty in implementing the feature?
>          Or am I missing something?
>
>          Thank you !
> -------------------------------------------------------------------------------------------------------------------------------------
> 本邮件及其附件含有杭州华三通信技术有限公司的保密信息，仅限于发送给上面地址中列出
> 的个人或群组。禁止任何其他人以任何形式使用（包括但不限于全部或部分地泄露、复制、
> 或散发）本邮件中的信息。如果您错收了本邮件，请您立即电话或邮件通知发件人并删除本
> 邮件！
> This e-mail and its attachments contain confidential information from H3C, which is
> intended only for the person or entity whose address is listed above. Any use of the
> information contained herein in any way (including, but not limited to, total or partial
> disclosure, reproduction, or dissemination) by persons other than the intended
> recipient(s) is prohibited. If you receive this e-mail in error, please notify the sender
> by phone or email immediately and delete it!

Hi,

What would you like to get out of this feature? A way to disable sync on 
a given bucket temporarily, and turn it back on later? Or just a way to 
have a subset of buckets that don't ever participate in sync?

Do you have a use case for the first? That's not something we'd considered.

If you just want to have some buckets that never sync, you might 
consider serving those out of a separate gateway, in a zone that isn't 
part of a multisite configuration.

Thanks,
Casey
