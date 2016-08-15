From: Victor Denisov <vdenisov@mirantis.com>
Subject: Snapshots of consistency groups
Date: Mon, 15 Aug 2016 16:46:05 -0700
Message-ID: <CA+hcxJS8sbBUjYieM3+86XG5KX9ouP8dO+9iFwtsHoO+v=9KWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f177.google.com ([209.85.217.177]:35517 "EHLO
	mail-ua0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752316AbcHOXqH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Aug 2016 19:46:07 -0400
Received: by mail-ua0-f177.google.com with SMTP id n59so96671275uan.2
        for <ceph-devel@vger.kernel.org>; Mon, 15 Aug 2016 16:46:07 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, Jason Dillaman <dillaman@redhat.com>, Josh Durgin <jdurgin@redhat.com>, Mykola Golub <mgolub@mirantis.com>

Gentlemen,

I'm writing to you to ask for your opinion regarding quiescing writes.

Here is the situation. In order to take snapshots of all images in a
consistency group,
we first need to quiesce all the image writers in the consistency group.
Let me call
group client - a client which requests a consistency group to take a snapshot.
Image client - the client that writes to an image.
Let's say group client starts sending notify_quiesce to all image
clients that write to the images in the group. After quiescing half of
the image clients the group client can die.

It presents us with a dilemma - what should we do with those quiesced
image clients.

Option 1 - is to wait till someone manually runs recover for that
consistency group.
We can show warning next to those unfinished groups when user runs
group list command.
There will be a command like group recover, which allows users to
rollback unsuccessful snapshots
or continue them using create snapshot command.

Option 2 - is to establish some heart beats between group client and
image client. If group client fails to heart beat then image client
unquiesces itself and continues normal operation.

Option 3 - is to have a timeout for each image client. If group client
fails to make a group snapshot within this timeout then we resume our
normal operation informing group client of the fact.

Which of these options do you prefer? Probably there are other options
that I miss.

Thanks,
Victor.
