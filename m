From: Martin Wilderoth <martin.wilderoth@linserv.se>
Subject: Re: ceph
Date: Sat, 25 Jun 2011 06:43:27 +0200 (CEST)
Message-ID: <97354099.17762.1308977007541.JavaMail.root@mail.linserv.se>
References: <1476695993.17760.1308976740201.JavaMail.root@mail.linserv.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 194-17-14-101.customer.telia.com ([194.17.14.101]:47549 "EHLO
	mail.linserv.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838Ab1FYEwL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 25 Jun 2011 00:52:11 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.linserv.se (Postfix) with ESMTP id 7B80412002C
	for <ceph-devel@vger.kernel.org>; Sat, 25 Jun 2011 06:43:32 +0200 (CEST)
Received: from mail.linserv.se ([127.0.0.1])
	by localhost (mail.linserv.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Jd58oMicNlUs for <ceph-devel@vger.kernel.org>;
	Sat, 25 Jun 2011 06:43:27 +0200 (CEST)
Received: from mail.linserv.se (mail.linserv.se [194.17.14.101])
	by mail.linserv.se (Postfix) with ESMTP id 9EE9F12002B
	for <ceph-devel@vger.kernel.org>; Sat, 25 Jun 2011 06:43:27 +0200 (CEST)
In-Reply-To: <1476695993.17760.1308976740201.JavaMail.root@mail.linserv.se>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

----- Ursprungligt meddelande -----=20
=46r=C3=A5n: "Yehuda Sadeh Weinraub" <yehudasa@gmail.com>=20
Till: "Martin Wilderoth" <martin.wilderoth@linserv.se>=20
Kopia: "ceph-devel" <ceph-devel@vger.kernel.org>=20
Skickat: fredag, 24 jun 2011 20:39:30=20
=C3=84mne: Re: ceph=20
Hello=20

I have just installed all the system with the latest debian testing
and then installed ceph. The ceph-client-tools are reported
to be on latest version with apt-get install.

I just get Segmentation fault on the command line not sure how to backt=
race.

I have managed to get a core dump not sure how to read that.

in the logfile I get the following messages

Jun 25 06:46:20 ceph1 kernel: [86215.823759] ceph[9395]: segfault at 32=
8 ip 0000000000467f6f sp 00007fffa47e7580 error 4 in ceph[400000+169000=
]
Jun 25 06:48:25 ceph1 kernel: [86341.263661] ceph[9409]: segfault at 32=
8 ip 0000000000467f6f sp 00007fff0b11a3a0 error 4 in ceph[400000+169000=
]


On Fri, Jun 24, 2011 at 12:41 AM, Martin Wilderoth=20
<martin.wilderoth@linserv.se> wrote:=20
> Hello,=20
>=20
> I get Segmentation fault when running the command ceph to check the s=
tatus. I'm uning the deb packages deb http://ceph.newdream.net/debian/ =
sid main=20
>=20
> I have installed the testing distribution of Debian.=20
> The other parts seems fine. The version of ceph is 0.29.1-1=20
>=20
Do you have a backtrace for that segfault? Did you update all the=20
packages (including ceph-client-tools)?=20

Yehuda=20
--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
