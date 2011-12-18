From: Bill Hastings <bllhastings@gmail.com>
Subject: Re: Understanding Ceph
Date: Sun, 18 Dec 2011 09:37:41 -0800
Message-ID: <CAJMJAuOr0CvkX+Q3O_CGCjv2jvS1jPo1HCT0ibnd2iBAfUCsuQ@mail.gmail.com>
References: <CAJMJAuPK8c4YBx3HUXOwOVfJAQuN2m2BHPNfyhr4hmpa0f1+Mw@mail.gmail.com>
	<CAO47_-_Ur4SzuuCA0m5n1++gFSXtapw=xTy1vE5Os-n1uGhdXg@mail.gmail.com>
	<CAJMJAuMn94e3w=zh7ovn=+Poj6LzHbE45R8X7+jNiHrAVaer3A@mail.gmail.com>
	<CAC-hyiHjU5TVe7NgBWfsgS3Simgauz_URPzSgYN_fa55==SdMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:42325 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831Ab1LRRhm convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 18 Dec 2011 12:37:42 -0500
Received: by vbbfc26 with SMTP id fc26so3535579vbb.19
        for <ceph-devel@vger.kernel.org>; Sun, 18 Dec 2011 09:37:41 -0800 (PST)
In-Reply-To: <CAC-hyiHjU5TVe7NgBWfsgS3Simgauz_URPzSgYN_fa55==SdMw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehuda.sadeh@dreamhost.com>
Cc: chb@muc.de, ceph-devel@vger.kernel.org

These are perhaps very inane questions but I am trying to wrap my head
around this whole thing. So basically the primary OSD handling a
particular PG will make sure that the writes happen at all replicas. I
am assuming the client would timeout in case it doesn't get a
ack/commit within some time period. Is this true? If this is the case
the write is deemed a failure but subsequent read could read the value
of the failed write because there don't seem to be any rollback
semantics. Is my understanding correct?

Are these replicas fixed for a PG? If for a PG the replicas are A, B
and C and C happens to be down during the write will the write be
deemed a failure till C is back up or is another replica chosen in
place of C?

On Sun, Dec 18, 2011 at 9:17 AM, Yehuda Sadeh Weinraub
<yehuda.sadeh@dreamhost.com> wrote:
> On Sun, Dec 18, 2011 at 8:43 AM, Bill Hastings <bllhastings@gmail.com=
> wrote:
>> Thanks for the response. What if a write of 16 bytes was successful =
at
>> nodes A and B and failed at C, perhaps C had a momentarily unreachab=
le
>> via the network? How is the Ceph client prevented from performing th=
e
>> next read at C? Also what if the writes to OSD's were successful but
>
> In that case the client wouldn't have gotten a successful response in
> the first place. The client sends the writes to the primary osd
> handling that pg, and will get the following responses from it:
> =A0- ack message when the request is in the page/buffer cache on all =
replicas
> =A0- commit message when the request is on stable storage on all repl=
icas
>
> (depending on setup, in some cases it'll just get a commit message
> which implies ack anyway)
>
> The osd is responsible that data was written to all replicas, and the
> client wouldn't get the commit response until then. For rbd, clients
> wait for the commit message as an acknowledgment to write completion.
>
>> the metadata update fails? How is this managed if at all? How are
>
> What kind of metadata are you referring to? For rbd there is no metad=
ata update.
>
>> writes that straddle chunk boundaries handled from a transactional
>> perspective? I am just in the process of investigation so please
>> forgive me if the questions are very naive.
>
> Depending on which client we're talking about. The short answer is
> that the client will only get a response after all chunks were writte=
n
> and acknowledged.
>
> However, there are currently two different implementations; one is in
> the linux kernel and the other one is based on librbd. In the linux
> kernel, acknowledging the write is being done in byte order of the
> request. That is, only after the first chunk was acked, the second on=
e
> would be acked, even if the osds responded in different order.
> In librbd there's another complexity since we can cache the requests
> and respond with an early ack. Ignoring that, client will only get a
> response after all chunks were applied and acked.
>
>
> Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
