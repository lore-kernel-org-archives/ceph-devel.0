From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: snapshot of rbd
Date: Wed, 15 Jun 2011 22:00:47 -0700
Message-ID: <BANLkTi=ePvRbp5h9kZKAU29VBXr4c+8+_A@mail.gmail.com>
References: <BANLkTimpfh-oMyhVJLj6Pry74kFEKJG7nA@mail.gmail.com>
	<BANLkTikF2rO2Ot8wV6pRNsMLHcJ3NucfTg@mail.gmail.com>
	<BANLkTin8UmqhWD4nyDfKb4feRATagFEwow@mail.gmail.com>
	<BANLkTim0a_vrdfg=W0kJAhvARj3BmY1AAQ@mail.gmail.com>
	<BANLkTik04D23tN9YZY-GJeJAy9gFB-z=eg@mail.gmail.com>
	<BANLkTikRCFCBoOm30eTCPUDq56dvm=ndVA@mail.gmail.com>
	<BANLkTi=yJ53-m5o9KnAG7YtZ7EpJoNOOvg@mail.gmail.com>
	<BANLkTim7fSBtaindCAFboNEGmOKamxOh4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49543 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761Ab1FPFAs convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Jun 2011 01:00:48 -0400
Received: by bwz15 with SMTP id 15so996857bwz.19
        for <ceph-devel@vger.kernel.org>; Wed, 15 Jun 2011 22:00:47 -0700 (PDT)
In-Reply-To: <BANLkTim7fSBtaindCAFboNEGmOKamxOh4w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Simon Tian <aixt2006@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Jun 14, 2011 at 6:55 PM, Simon Tian <aixt2006@gmail.com> wrote:
>
> Hmm, is vm need to be shutdown too when setting a snapshot, because o=
f
> the IO state
> ( like file description. etc ) in the vm memory.

Setting the snapshot is a runtime operation. Either you load it
originally with that snapshot, or you reset the vm state, in which
case you also set the snapshot. In both case there's no need to reset
the vm.

>
> For the snapshot rollback, a LAZYLOAD feature should be attractive:
> rollback is instant
> then vm could be boot soon with out waiting for going through the
> object, which may be
> a very long time. The objects needed at present were gone through at
> present, the rbd client
> go through other objects during the vm running. The disadvantage is
> that rbd client may need
> to query if LAZYLOAD is finished when creating a new snapshot?
> =A0snapshot

As I said earlier, on our roadmap we have rbd layering planned which
will give a solution to rollback.

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
