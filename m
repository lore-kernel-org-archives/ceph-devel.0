From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: using librbd in my application
Date: Tue, 24 May 2011 16:44:00 -0700
Message-ID: <4DDC42C0.7050802@dreamhost.com>
References: <BANLkTimz7_cahNvxF4N7FVpW1hBs9N=rDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:37368 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757577Ab1EXXoB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 May 2011 19:44:01 -0400
In-Reply-To: <BANLkTimz7_cahNvxF4N7FVpW1hBs9N=rDQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Simon Tian <aixt2006@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 05/20/2011 10:22 AM, Simon Tian wrote:
> Hi Sage,
>
>        I have two question about using librbd:
>   1. There always two clients, Client A and B are both developed with
> librbd, and running on different hosts.
> Scenario (1): Client A open an image for read and write, Client B open
> the same image for read.
> Scenario (2): Client A and client B both open the same image for read and write.
>
> For scenario (1), I did some test today, glad to tell that two client
> are both working safely.
> I didn't do a test for scenario (2).  I am not very familiar with the
> librbd code yet.
> I want to know, would clients in scenario (2) working safely? Will
> data writing at the same object be serialized?
> And reading delayed? Seem that the phd thesis mentioned that multi
> client write will be serialized by rados.
> Hope I got the right understanding.

Scenario 1 should be safe.

Scenario 2 is generally unsafe, depending on the needs of your
application. Writes to each object are serialized, but if a write
spans an object boundary, librbd will do more than one
independent I/O to rados, so you may get undesired results with
more than one client.  If you're interested in writing to single
objects with multiple clients, you're better off using librados
directly.

> 2.  I need to use the callback of aio_write and aio_read in my client:
>    typedef void (*callback_t)(completion_t cb, void *arg);
>    At here, what is the completion_t cb mean? how to utilize it?
>    I need to use the return value in the callback function other than
> call get_return_value() after wait_for_complete(). How can I get the
> value?
> I guess maybe I can do this in the callback function:
> callback_t my_cb(completion_t cb, void *arg)
> {
>    librbd::RBD::AioCompletion *comp = (librbd::RBD::AioCompletion *)c;
>    int ret = comp->get_return_value();
>
> }
> Hmm, Is it right?

That's right. In the callback you can get the return value and
release the completion:

    librbd::RBD::AioCompletion *comp = (librbd::RBD::AioCompletion *)c;
    ssize_t ret = comp->get_return_value();
    comp->release();

You probably want to keep track of the aios in flight in your
application, and then call wait_for_complete() on them when you
want to guarantee they are finished.

Josh
