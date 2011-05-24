From: huang jun <hjwsm1989@gmail.com>
Subject: Re: ceph authenticate problem
Date: Tue, 24 May 2011 10:30:50 +0800
Message-ID: <BANLkTinsrPxZrwbe9rEYpLOKtAvKaOfRGg@mail.gmail.com>
References: <BANLkTinpu+Gq4CeXzpbZ-V8t8UzOH2trhQ@mail.gmail.com>
	<20110523155631.GA7495@dreamer>
	<BANLkTimzNEbURVnjHFN_NmoBu_tJDi4aFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:35459 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754256Ab1EXCaw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 May 2011 22:30:52 -0400
Received: by wwa36 with SMTP id 36so6817175wwa.1
        for <ceph-devel@vger.kernel.org>; Mon, 23 May 2011 19:30:51 -0700 (PDT)
In-Reply-To: <BANLkTimzNEbURVnjHFN_NmoBu_tJDi4aFA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: biyan chen <riby.chen@gmail.com>
Cc: Tommi Virtanen <tommi.virtanen@dreamhost.com>, ceph-devel@vger.kernel.org

try "cp /data/mon0/admin_keyring.bin /usr/local/etc/ceph/keyring.bin"

=D4=DA 2011=C4=EA5=D4=C224=C8=D5 =C9=CF=CE=E79:50=A3=ACbiyan chen <riby=
=2Echen@gmail.com> =D0=B4=B5=C0=A3=BA
> My steps =A3=BA
> mkcephfs -c /usr/local/etc/ceph/ceph.conf --allhosts --mkbtrfs -k
> /usr/local/etc/ceph/keyring.bin
> /etc/init.d/ceph -a start
>
> Can give me a little more information?
>
>
> 2011/5/23 Tommi Virtanen <tommi.virtanen@dreamhost.com>:
>> On Mon, May 23, 2011 at 03:48:41PM +0800, biyan chen wrote:
>>>         keyring =3D /use/local/etc/ceph/keyring.bin
>>
>> This might be your problem..
>>
>> --
>> :(){ :|:&};:
>>
>
>
>
> --
> name:Riby
> mobile:+86 15280267642
> company: =B0=D9=B4=F3=C1=FA=D2=BB
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
