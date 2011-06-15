From: Simon Tian <aixt2006@gmail.com>
Subject: Re: snapshot of rbd
Date: Wed, 15 Jun 2011 09:55:16 +0800
Message-ID: <BANLkTim7fSBtaindCAFboNEGmOKamxOh4w@mail.gmail.com>
References: <BANLkTimpfh-oMyhVJLj6Pry74kFEKJG7nA@mail.gmail.com>
	<BANLkTikF2rO2Ot8wV6pRNsMLHcJ3NucfTg@mail.gmail.com>
	<BANLkTin8UmqhWD4nyDfKb4feRATagFEwow@mail.gmail.com>
	<BANLkTim0a_vrdfg=W0kJAhvARj3BmY1AAQ@mail.gmail.com>
	<BANLkTik04D23tN9YZY-GJeJAy9gFB-z=eg@mail.gmail.com>
	<BANLkTikRCFCBoOm30eTCPUDq56dvm=ndVA@mail.gmail.com>
	<BANLkTi=yJ53-m5o9KnAG7YtZ7EpJoNOOvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:64982 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751624Ab1FOBzR convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Jun 2011 21:55:17 -0400
Received: by wya21 with SMTP id 21so4295619wya.19
        for <ceph-devel@vger.kernel.org>; Tue, 14 Jun 2011 18:55:16 -0700 (PDT)
In-Reply-To: <BANLkTi=yJ53-m5o9KnAG7YtZ7EpJoNOOvg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: ceph-devel@vger.kernel.org

2011/6/15 Yehuda Sadeh Weinraub <yehudasa@gmail.com>:
> On Mon, Jun 13, 2011 at 7:35 PM, Simon Tian <aixt2006@gmail.com> wrot=
e:
>> Hi Yehuda,
>>
>> =C2=A0 =C2=A0So I list a table which describe the VM status and time=
 needed
>> during rbd snapshot operation:
>>
>> operation =C2=A0| =C2=A0 VM status =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A0time needed
>> --------------------------------------------------------------------=
---------------------------------------------------
>> create =C2=A0 =C2=A0 =C2=A0| =C2=A0 could be running =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A0instant
>> delete =C2=A0 =C2=A0 =C2=A0| =C2=A0 could be running =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A0instant
>> rollback =C2=A0 =C2=A0| =C2=A0 need to be shutdown =C2=A0 | =C2=A0 =C2=
=A0needs to go through all the objects
>> list =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 could be running =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A0instant
>> set =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 need to be shutdown =
=C2=A0 =C2=A0| =C2=A0 =C2=A0instant
>>
>> Could you check this table, hope to get your correction or supplemen=
t.
>> Thx very much!
>
> Basically ok, just note:
> =C2=A0- you can only rollback externally (through the rbd tool, or vi=
a
> librbd), so you need to unmount the relevant device
> =C2=A0- setting of a snapshot can be done by setting the vm state, th=
is can
> be achieved when it's running

Hmm, is vm need to be shutdown too when setting a snapshot, because of
the IO state
( like file description. etc ) in the vm memory.

=46or the snapshot rollback, a LAZYLOAD feature should be attractive:
rollback is instant
then vm could be boot soon with out waiting for going through the
object, which may be
a very long time. The objects needed at present were gone through at
present, the rbd client
go through other objects during the vm running. The disadvantage is
that rbd client may need
to query if LAZYLOAD is finished when creating a new snapshot?
 snapshot

Thx
Simon
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
