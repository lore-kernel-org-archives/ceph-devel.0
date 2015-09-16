From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] libceph: advertise support for keepalive2
Date: Wed, 16 Sep 2015 10:39:54 +0300
Message-ID: <CAOi1vP_o8rKjcOf7mNoyiOm5JAFw55A=zwmXznx5QqAaO+XZ4A@mail.gmail.com>
References: <1442238695-13809-1-git-send-email-idryomov@gmail.com>
	<CAAM7YAkDeRXOjtX4KGJzcftadZ0tRvhzfLL3rbqfLSGv6_qQMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:35887 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751904AbbIPHjz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Sep 2015 03:39:55 -0400
Received: by wicgb1 with SMTP id gb1so60660577wic.1
        for <ceph-devel@vger.kernel.org>; Wed, 16 Sep 2015 00:39:54 -0700 (PDT)
In-Reply-To: <CAAM7YAkDeRXOjtX4KGJzcftadZ0tRvhzfLL3rbqfLSGv6_qQMw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Sep 16, 2015 at 9:28 AM, Yan, Zheng <ukernel@gmail.com> wrote:
> On Mon, Sep 14, 2015 at 9:51 PM, Ilya Dryomov <idryomov@gmail.com> wrote:
>> We are the client, but advertise keepalive2 anyway - for consistency,
>> if nothing else.  In the future the server might want to know whether
>> its clients support keepalive2.
>
> the kernel code still does fully support KEEPALIVE2 (it does not
> recognize CEPH_MSGR_TAG_KEEPALIVE2 tag). I think it's better to not
> advertise support for keepalive2.

I guess by "does not recognize" you mean the kernel client knows how to
write TAG_KEEPALIVE2, but not how to read it?  The same is true about
TAG_KEEPALIVE tag and the reverse (we can read, but can't write) is
true about TAG_KEEPALIVE2_ACK.

What I'm getting at is the kernel client is the client, and so it
doesn't need to know how to read keepalive bytes or write keepalive
acks.  The server however might want to know if its clients can send
keepalive2 bytes and handle keepalive2 acks.  Does this make sense?

Thanks,

                Ilya
