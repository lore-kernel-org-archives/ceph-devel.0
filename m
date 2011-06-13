From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: snapshot of rbd
Date: Mon, 13 Jun 2011 09:30:26 -0700
Message-ID: <BANLkTik04D23tN9YZY-GJeJAy9gFB-z=eg@mail.gmail.com>
References: <BANLkTimpfh-oMyhVJLj6Pry74kFEKJG7nA@mail.gmail.com>
	<BANLkTikF2rO2Ot8wV6pRNsMLHcJ3NucfTg@mail.gmail.com>
	<BANLkTin8UmqhWD4nyDfKb4feRATagFEwow@mail.gmail.com>
	<BANLkTim0a_vrdfg=W0kJAhvARj3BmY1AAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41816 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751926Ab1FMQa2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Jun 2011 12:30:28 -0400
Received: by bwz15 with SMTP id 15so3833399bwz.19
        for <ceph-devel@vger.kernel.org>; Mon, 13 Jun 2011 09:30:27 -0700 (PDT)
In-Reply-To: <BANLkTim0a_vrdfg=W0kJAhvARj3BmY1AAQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Simon Tian <aixt2006@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Sun, Jun 12, 2011 at 10:43 PM, Simon Tian <aixt2006@gmail.com> wrote:
> 2011/6/13 Yehuda Sadeh Weinraub <yehuda.sadeh@dreamhost.com>:
>> Rollback is (currently) is in the order of the number of object of
>> that image. It needs to go through all the objects and execute an
>> explicit request of each. For very large images it can be quite long.
>
> When a VM is running based on rbd image, and need to rollback to S1.
> During rollback, seem like that data written by the VM is not allowed?
> Is there any way to rollback without affecting the user experience of the VM?
>
Data written by the vm to the image is not recommended as it'll most
likely corrupt it. It is recommended that you unmount any relevant
partition while doing it. Currently there's not much to do to avoid
the relatively long rollback. We do have on our roadmap the layering
feature that will allow having some sort of writable snapshots, but
we're not there yet.

Yehuda
