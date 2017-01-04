From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: What really happens when a connection race happens?
Date: Tue, 3 Jan 2017 18:29:19 -0800
Message-ID: <CAJ4mKGbgjCaWJcZOY4Won5-sofpwH=1bewBp9SjeZLGTrLUoeA@mail.gmail.com>
References: <7614c96b.3483.1593589146a.Coremail.xxhdx1985126@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f43.google.com ([209.85.214.43]:35509 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750846AbdADCaO (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Jan 2017 21:30:14 -0500
Received: by mail-it0-f43.google.com with SMTP id c20so297458527itb.0
        for <ceph-devel@vger.kernel.org>; Tue, 03 Jan 2017 18:29:20 -0800 (PST)
In-Reply-To: <7614c96b.3483.1593589146a.Coremail.xxhdx1985126@163.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: xxhdx1985126 <xxhdx1985126@163.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sun, Dec 25, 2016 at 2:31 AM, xxhdx1985126 <xxhdx1985126@163.com> wrote:
> Hi, everyone.
>
> I'm reading the source code of Pipe in ceph, and I'm confused about the code for connection race processing. Suppose that the policy the two Pipe involved is lossless_peer, one of them wins and send the other pipe a CEPH_MSGR_TAG_WAIT message which makes the other Pipe's writer to cond.wait(), and then the winning pipe goes back to waiting for a ceph_msg_connect message to come. But, under this circumstance, the writer of the other pipe is waiting, and as far as I know,  unless something happens it will never send ceph_msg_connect messages, so they will wait for each other for ever........  There must be some misunderstanding here, but I don't know where, please help me. Thank you:-)

The point is that we have racing connect attempts here — the "winner"
has already sent out a connection attempt which the loser will respond
to. So neither of them needs to do anything; when the loser processes
the winner's connection attempt, it will shut down its losing Pipe,
start up a Pipe with the incoming attempt, and send back an
acknowledgement to the winner.
-Greg
