From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] mark rbd requiring stable pages
Date: Thu, 22 Oct 2015 18:52:57 +0200
Message-ID: <CAOi1vP_zx+Cz+tM07pZa_ciFhnJ8ddHX+dy35cqhOJ3BT4a8jw@mail.gmail.com>
References: <201510151850.48348.ronny.hegewald@online.de>
	<CAOi1vP_ZDHBfCDeH6gxCKRsqoGteWv+nn7EFTexf+qsUBMHvjA@mail.gmail.com>
	<CAOi1vP8nAfr1_dNmvhNspz6ANZo2onGExU7=-agKLNr5KPxrzw@mail.gmail.com>
	<CAOi1vP_0GoqXuHm5SjZHpS8g_mK_wFRs9t9_VE1N9JUMFvL3Gw@mail.gmail.com>
	<562860F2.8070208@cs.wisc.edu>
	<CAOi1vP_e1aY4zMyYgRLy=D+jBs44g9++0VKutRm7D6q0OALJ3Q@mail.gmail.com>
	<562902D3.7040501@cs.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:32840 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751178AbbJVQw6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Oct 2015 12:52:58 -0400
Received: by wijp11 with SMTP id p11so41400428wij.0
        for <ceph-devel@vger.kernel.org>; Thu, 22 Oct 2015 09:52:57 -0700 (PDT)
In-Reply-To: <562902D3.7040501@cs.wisc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mike Christie <michaelc@cs.wisc.edu>
Cc: Ronny Hegewald <ronny.hegewald@online.de>, Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sage@redhat.com>, Alex Elder <elder@kernel.org>

On Thu, Oct 22, 2015 at 5:37 PM, Mike Christie <michaelc@cs.wisc.edu> wrote:
> On 10/22/2015 06:20 AM, Ilya Dryomov wrote:
>>
>>> >
>>> > If we are just talking about if stable pages are not used, and someone
>>> > is re-writing data to a page after the page has already been submitted
>>> > to the block layer (I mean the page is on some bio which is on a request
>>> > which is on some request_queue scheduler list or basically anywhere in
>>> > the block layer), then I was saying this can occur with any block
>>> > driver. There is nothing that is preventing this from happening with a
>>> > FC driver or nvme or cciss or in dm or whatever. The app/user can
>>> > rewrite as late as when we are in the make_request_fn/request_fn.
>>> >
>>> > I think I am misunderstanding your question because I thought this is
>>> > expected behavior, and there is nothing drivers can do if the app is not
>>> > doing a flush/sync between these types of write sequences.
>> I don't see a problem with rewriting as late as when we are in
>> request_fn() (or in a wq after being put there by request_fn()).  Where
>> I thought there *might* be an issue is rewriting after sendpage(), if
>> sendpage() is used - perhaps some sneaky sequence similar to that
>> retransmit bug that would cause us to *transmit* incorrect bytes (as
>> opposed to *re*transmit) or something of that nature?
>
>
> Just to make sure we are on the same page.
>
> Are you concerned about the tcp/net layer retransmitting due to it
> detecting a issue as part of the tcp protocol, or are you concerned
> about rbd/libceph initiating a retry like with the nfs issue?

The former, tcp/net layer.  I'm just conjecturing though.

(We don't have the nfs issue, because even if the client sends such
a retransmit (which it won't), the primary OSD will reject it as
a dup.)

Thanks,

                Ilya
