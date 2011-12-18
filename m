From: Yehuda Sadeh Weinraub <yehuda.sadeh@dreamhost.com>
Subject: Re: Understanding Ceph
Date: Sun, 18 Dec 2011 09:17:53 -0800
Message-ID: <CAC-hyiHjU5TVe7NgBWfsgS3Simgauz_URPzSgYN_fa55==SdMw@mail.gmail.com>
References: <CAJMJAuPK8c4YBx3HUXOwOVfJAQuN2m2BHPNfyhr4hmpa0f1+Mw@mail.gmail.com>
	<CAO47_-_Ur4SzuuCA0m5n1++gFSXtapw=xTy1vE5Os-n1uGhdXg@mail.gmail.com>
	<CAJMJAuMn94e3w=zh7ovn=+Poj6LzHbE45R8X7+jNiHrAVaer3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:53810 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831Ab1LRRRy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 18 Dec 2011 12:17:54 -0500
Received: by ggdk6 with SMTP id k6so3617183ggd.19
        for <ceph-devel@vger.kernel.org>; Sun, 18 Dec 2011 09:17:53 -0800 (PST)
In-Reply-To: <CAJMJAuMn94e3w=zh7ovn=+Poj6LzHbE45R8X7+jNiHrAVaer3A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Bill Hastings <bllhastings@gmail.com>
Cc: chb@muc.de, ceph-devel@vger.kernel.org

On Sun, Dec 18, 2011 at 8:43 AM, Bill Hastings <bllhastings@gmail.com> wrote:
> Thanks for the response. What if a write of 16 bytes was successful at
> nodes A and B and failed at C, perhaps C had a momentarily unreachable
> via the network? How is the Ceph client prevented from performing the
> next read at C? Also what if the writes to OSD's were successful but

In that case the client wouldn't have gotten a successful response in
the first place. The client sends the writes to the primary osd
handling that pg, and will get the following responses from it:
 - ack message when the request is in the page/buffer cache on all replicas
 - commit message when the request is on stable storage on all replicas

(depending on setup, in some cases it'll just get a commit message
which implies ack anyway)

The osd is responsible that data was written to all replicas, and the
client wouldn't get the commit response until then. For rbd, clients
wait for the commit message as an acknowledgment to write completion.

> the metadata update fails? How is this managed if at all? How are

What kind of metadata are you referring to? For rbd there is no metadata update.

> writes that straddle chunk boundaries handled from a transactional
> perspective? I am just in the process of investigation so please
> forgive me if the questions are very naive.

Depending on which client we're talking about. The short answer is
that the client will only get a response after all chunks were written
and acknowledged.

However, there are currently two different implementations; one is in
the linux kernel and the other one is based on librbd. In the linux
kernel, acknowledging the write is being done in byte order of the
request. That is, only after the first chunk was acked, the second one
would be acked, even if the osds responded in different order.
In librbd there's another complexity since we can cache the requests
and respond with an early ack. Ignoring that, client will only get a
response after all chunks were applied and acked.


Yehuda
