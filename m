From: Yehuda Sadeh Weinraub <yehuda.sadeh@dreamhost.com>
Subject: Re: rados callbacks
Date: Mon, 1 Aug 2011 08:23:29 -0700
Message-ID: <CAC-hyiH8QWYNNbxb6d8CDr3dkFVHX=VwdcijJjRHLfv+pV=QEw@mail.gmail.com>
References: <CAO47_-9LwTQFfzZko=8oKz+nM5OKrcfW6ch0A9ZX6hqedhieTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:59623 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752831Ab1HAPXa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Aug 2011 11:23:30 -0400
Received: by ewy4 with SMTP id 4so2827081ewy.19
        for <ceph-devel@vger.kernel.org>; Mon, 01 Aug 2011 08:23:29 -0700 (PDT)
In-Reply-To: <CAO47_-9LwTQFfzZko=8oKz+nM5OKrcfW6ch0A9ZX6hqedhieTw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: chb@muc.de
Cc: ceph-devel@vger.kernel.org

On Mon, Aug 1, 2011 at 2:03 AM, Christian Brunner <chb@muc.de> wrote:
> I'm not sure if I have asked for this already, but I can't remember
> and google is not my friend either.
>
> Librados has two different callback types for an async write:
>
> - ack
> - safe
>
> What is the difference between these two types? Is ack faster than safe?
>
The osd first sends the ack when it receives the request, and it later
sends the safe when the request is "safe", that is, committed to disk.

Yehuda
