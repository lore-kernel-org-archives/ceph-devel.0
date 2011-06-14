From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: snapshot of rbd
Date: Tue, 14 Jun 2011 16:35:25 -0700
Message-ID: <BANLkTi=yJ53-m5o9KnAG7YtZ7EpJoNOOvg@mail.gmail.com>
References: <BANLkTimpfh-oMyhVJLj6Pry74kFEKJG7nA@mail.gmail.com>
	<BANLkTikF2rO2Ot8wV6pRNsMLHcJ3NucfTg@mail.gmail.com>
	<BANLkTin8UmqhWD4nyDfKb4feRATagFEwow@mail.gmail.com>
	<BANLkTim0a_vrdfg=W0kJAhvARj3BmY1AAQ@mail.gmail.com>
	<BANLkTik04D23tN9YZY-GJeJAy9gFB-z=eg@mail.gmail.com>
	<BANLkTikRCFCBoOm30eTCPUDq56dvm=ndVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57181 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751624Ab1FNXf0 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Jun 2011 19:35:26 -0400
Received: by bwz15 with SMTP id 15so46861bwz.19
        for <ceph-devel@vger.kernel.org>; Tue, 14 Jun 2011 16:35:25 -0700 (PDT)
In-Reply-To: <BANLkTikRCFCBoOm30eTCPUDq56dvm=ndVA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Simon Tian <aixt2006@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Mon, Jun 13, 2011 at 7:35 PM, Simon Tian <aixt2006@gmail.com> wrote:
> Hi Yehuda,
>
> =A0 =A0So I list a table which describe the VM status and time needed
> during rbd snapshot operation:
>
> operation =A0| =A0 VM status =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 =A0time needed
> ---------------------------------------------------------------------=
--------------------------------------------------
> create =A0 =A0 =A0| =A0 could be running =A0 =A0 =A0 =A0 =A0| =A0 =A0=
instant
> delete =A0 =A0 =A0| =A0 could be running =A0 =A0 =A0 =A0 =A0| =A0 =A0=
instant
> rollback =A0 =A0| =A0 need to be shutdown =A0 | =A0 =A0needs to go th=
rough all the objects
> list =A0 =A0 =A0 =A0 =A0 | =A0 could be running =A0 =A0 =A0 =A0 =A0| =
=A0 =A0instant
> set =A0 =A0 =A0 =A0 =A0 | =A0 need to be shutdown =A0 =A0| =A0 =A0ins=
tant
>
> Could you check this table, hope to get your correction or supplement=
=2E
> Thx very much!

Basically ok, just note:
 - you can only rollback externally (through the rbd tool, or via
librbd), so you need to unmount the relevant device
 - setting of a snapshot can be done by setting the vm state, this can
be achieved when it's running

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
