From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH 4/5] libceph: validate blob_struct_v in process_one_ticket()
Date: Tue, 23 May 2017 20:40:43 +0200
Message-ID: <CAOi1vP9StiPi6ThbC68KUymNgLx1JorQ2OmqLGKtnAQBk+pfNw@mail.gmail.com>
References: <1495557238-1077-1-git-send-email-idryomov@gmail.com>
 <1495557238-1077-5-git-send-email-idryomov@gmail.com> <acf57851-8c0e-ca92-d7c4-13ae945983c0@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f67.google.com ([209.85.213.67]:34423 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761746AbdEWSko (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 23 May 2017 14:40:44 -0400
Received: by mail-vk0-f67.google.com with SMTP id w1so7979228vkd.1
        for <ceph-devel@vger.kernel.org>; Tue, 23 May 2017 11:40:44 -0700 (PDT)
In-Reply-To: <acf57851-8c0e-ca92-d7c4-13ae945983c0@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, May 23, 2017 at 7:44 PM, Alex Elder <elder@ieee.org> wrote:
> On 05/23/2017 11:33 AM, Ilya Dryomov wrote:
>> None of these are validated in userspace, but since we do validate
>> reply_struct_v in ceph_x_proc_ticket_reply(), tkt_struct_v (first) and
>> CephXServiceTicket struct_v (second) in process_one_ticket(), validate
>> CephXTicketBlob struct_v as well.
>>
>> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
>
> Looks good.  (I don't know what's valid but I know you do.)

All those auth structs are v1.  Thanks for the review!

                Ilya
