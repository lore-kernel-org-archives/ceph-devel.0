From: Casey Bodley <cbodley@redhat.com>
Subject: Re: [rgw multisite] issue of sync large file
Date: Mon, 10 Oct 2016 11:45:45 -0400
Message-ID: <506f479a-2138-80bc-0a24-0b43be9991c5@redhat.com>
References: <7BD28126D6935A4498AE6DE60B5D4CAB314E61EE@H3CMLB12-EX.srv.huawei-3com.com>
 <7BD28126D6935A4498AE6DE60B5D4CAB314E6254@H3CMLB12-EX.srv.huawei-3com.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f180.google.com ([209.85.220.180]:32993 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752464AbcJJPqC (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Oct 2016 11:46:02 -0400
Received: by mail-qk0-f180.google.com with SMTP id n189so117584346qke.0
        for <ceph-devel@vger.kernel.org>; Mon, 10 Oct 2016 08:46:02 -0700 (PDT)
In-Reply-To: <7BD28126D6935A4498AE6DE60B5D4CAB314E6254@H3CMLB12-EX.srv.huawei-3com.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zhangzengran <zhangzengran@h3c.com>, "yehuda@redhat.com" <yehuda@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

What exactly has you worried about large transfers for sync?

Breaking them up and sending the parts in parallel could certainly help 
to reduce the latency of data sync between zones, as long as there's 
bandwidth available. But without some careful throttling and i/o 
scheduling (which we don't currently do at all for data sync), I'd worry 
about saturating the network with sync i/o and starving clients. Our 
civetweb frontend is also imposing a limit on the number of threads for 
incoming connections, so I'd be wary about tying up more of those for 
sync. A strategy for i/o scheduling, along with a replacement for 
civetweb, are both on our long-term roadmap - we'd love your input on those.

Thanks,
Casey


On 10/10/2016 06:12 AM, Zhangzengran wrote:
> Hi Casey:
>    We realized an issue recently when testing rgw multisite. when we put a large file(T scale)
> using multipart into master zone, the slave zone will sync it with atomic processor. This means
> it will get the whole file in a single request,so we worry about the sync process in this situation.
>
> Maybe we could rewrite a new function for RGWAsyncFetchRemoteObj. It could download the
> orign file with byte-range, and restore it with multi-part?
>
> Regards, thank you!
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

