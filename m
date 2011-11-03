From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Cannot execute rados.py with sudoer
Date: Wed, 2 Nov 2011 21:48:56 -0700
Message-ID: <CAF3hT9DaMW8dCx=1BGnW1jjoK+AuDDBNe57tfV1S2P3rc-BPUw@mail.gmail.com>
References: <8512670932FB654F81AF0FEF1BE6D49D649E74@WHQBEMAIL1.whq.wistron>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62159 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116Ab1KCEs4 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Nov 2011 00:48:56 -0400
Received: by iage36 with SMTP id e36so905434iag.19
        for <ceph-devel@vger.kernel.org>; Wed, 02 Nov 2011 21:48:56 -0700 (PDT)
In-Reply-To: <8512670932FB654F81AF0FEF1BE6D49D649E74@WHQBEMAIL1.whq.wistron>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Eric_YH_Chen@wistron.com
Cc: ceph-devel@vger.kernel.org

This looks like your standard permissions issue to me. The keyring and
log were probably created by mkcephfs running under sudo? But if you
give your current user the ability to read/write from them everything
should work fine.
-Greg

On Wed, Nov 2, 2011 at 8:55 PM,  <Eric_YH_Chen@wistron.com> wrote:
> Hi, all:
>
> =C2=A0=C2=A0=C2=A0When I use raods.py, I met some problem even if the=
 user is in sudoer.
> =E3=80=80=E3=80=80I found it would access /etc/ceph/client.admin.keyr=
ing and /var/log/ceph/client.admin.log which is only available to root.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Do you have any suggestion=
? I cannot execute the python problem with =E2=80=9Croot=E2=80=9D accou=
nt. It would cause some security issue.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Thanks a lot!
>
> Here is the sample code.
>
>>>> import rados
>>>> cluster =3D rados.Rados()
>>>> cluster.conf_read_file()
> failed to open log file '/var/log/ceph/client.admin.log': error 13: P=
ermission denied
>>>> cluster.connect()
> 2011-11-03 11:49:20.937991 7f9fe5320720 monclient(hunting): MonClient=
::init(): Failed to create keyring
> 2011-11-03 11:49:50.938235 7f9fe5320720 monclient(hunting): authentic=
ate timed out after 30
> 2011-11-03 11:49:50.938283 7f9fe5320720 librados: client.admin authen=
tication error error 110: Connection timed out
> Traceback (most recent call last):
> =C2=A0 File "<stdin>", line 1, in <module>
> =C2=A0 File "/usr/lib/python2.7/rados.py", line 182, in connect
> =C2=A0=C2=A0=C2=A0 raise make_ex(ret, "error calling connect")
> rados.Error: error calling connect: error code 110
>
>
> -rw-------=C2=A0=C2=A0 1 root root=C2=A0=C2=A0=C2=A0 92 2011-11-02 18=
:13 client.admin.keyring
> -rw-------=C2=A0 1 root root=C2=A0=C2=A0=C2=A0=C2=A0 0 2011-11-03 07:=
47 client.admin.log
>
> regards,
>
> Eric/Pjack
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
