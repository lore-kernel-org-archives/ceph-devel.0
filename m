From: Simon Tian <aixt2006@gmail.com>
Subject: using librbd in my application
Date: Sat, 21 May 2011 01:22:15 +0800
Message-ID: <BANLkTimz7_cahNvxF4N7FVpW1hBs9N=rDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57926 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751956Ab1ETRWR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 May 2011 13:22:17 -0400
Received: by wya21 with SMTP id 21so2888976wya.19
        for <ceph-devel@vger.kernel.org>; Fri, 20 May 2011 10:22:16 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi Sage,

      I have two question about using librbd:
 1. There always two clients, Client A and B are both developed with
librbd, and running on different hosts.
Scenario (1): Client A open an image for read and write, Client B open
the same image for read.
Scenario (2): Client A and client B both open the same image for read and write.

For scenario (1), I did some test today, glad to tell that two client
are both working safely.
I didn't do a test for scenario (2).  I am not very familiar with the
librbd code yet.
I want to know, would clients in scenario (2) working safely? Will
data writing at the same object be serialized?
And reading delayed? Seem that the phd thesis mentioned that multi
client write will be serialized by rados.
Hope I got the right understanding.

2.  I need to use the callback of aio_write and aio_read in my client:
  typedef void (*callback_t)(completion_t cb, void *arg);
  At here, what is the completion_t cb mean? how to utilize it?
  I need to use the return value in the callback function other than
call get_return_value() after wait_for_complete(). How can I get the
value?
I guess maybe I can do this in the callback function:
callback_t my_cb(completion_t cb, void *arg)
{
  librbd::RBD::AioCompletion *comp = (librbd::RBD::AioCompletion *)c;
  int ret = comp->get_return_value();

}
Hmm, Is it right?


Thanks!
Simon
