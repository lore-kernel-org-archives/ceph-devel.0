From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: [PATCH] libceph: advertise support for keepalive2
Date: Wed, 16 Sep 2015 15:51:00 +0800
Message-ID: <CAAM7YAn1Yh4UJZ8hBrHvRwLBQgN6kc5CwyZr=NntcYc+b_0FXQ@mail.gmail.com>
References: <1442238695-13809-1-git-send-email-idryomov@gmail.com>
	<CAAM7YAkDeRXOjtX4KGJzcftadZ0tRvhzfLL3rbqfLSGv6_qQMw@mail.gmail.com>
	<CAOi1vP_o8rKjcOf7mNoyiOm5JAFw55A=zwmXznx5QqAaO+XZ4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:33951 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751904AbbIPHvC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Sep 2015 03:51:02 -0400
Received: by lahg1 with SMTP id g1so94114784lah.1
        for <ceph-devel@vger.kernel.org>; Wed, 16 Sep 2015 00:51:00 -0700 (PDT)
In-Reply-To: <CAOi1vP_o8rKjcOf7mNoyiOm5JAFw55A=zwmXznx5QqAaO+XZ4A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Sep 16, 2015 at 3:39 PM, Ilya Dryomov <idryomov@gmail.com> wrote:
> On Wed, Sep 16, 2015 at 9:28 AM, Yan, Zheng <ukernel@gmail.com> wrote:
>> On Mon, Sep 14, 2015 at 9:51 PM, Ilya Dryomov <idryomov@gmail.com> wrote:
>>> We are the client, but advertise keepalive2 anyway - for consistency,
>>> if nothing else.  In the future the server might want to know whether
>>> its clients support keepalive2.
>>
>> the kernel code still does fully support KEEPALIVE2 (it does not
>> recognize CEPH_MSGR_TAG_KEEPALIVE2 tag). I think it's better to not
>> advertise support for keepalive2.
>
> I guess by "does not recognize" you mean the kernel client knows how to
> write TAG_KEEPALIVE2, but not how to read it?  The same is true about
> TAG_KEEPALIVE tag and the reverse (we can read, but can't write) is
> true about TAG_KEEPALIVE2_ACK.
>
> What I'm getting at is the kernel client is the client, and so it
> doesn't need to know how to read keepalive bytes or write keepalive
> acks.  The server however might want to know if its clients can send
> keepalive2 bytes and handle keepalive2 acks.  Does this make sense?
>

Ok, it makes sense. thank you for explaination

Reviewed-by: Yan, Zheng <zyan@redhat.com>

> Thanks,
>
>                 Ilya
