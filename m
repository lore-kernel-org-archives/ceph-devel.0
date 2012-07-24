From: Smart Weblications GmbH - Florian Wiessner
	<f.wiessner@smart-weblications.de>
Subject: Re: monitor not starting
Date: Tue, 24 Jul 2012 17:14:42 +0200
Message-ID: <500EBBE2.5070406@smart-weblications.de>
References: <4FF42CD7.1060000@smart-weblications.de> <D2569975C9B14D6B974C162C58FA7401@inktank.com> <4FF47717.1030401@smart-weblications.de> <9A431747660F45EB8122D5A66F0DEF1A@inktank.com>
Reply-To: f.wiessner@smart-weblications.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx03.smart-weblications.de ([188.65.144.38]:56538 "EHLO
	mx03.smart-weblications.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753671Ab2GXPOj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Tue, 24 Jul 2012 11:14:39 -0400
In-Reply-To: <9A431747660F45EB8122D5A66F0DEF1A@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: ceph-devel@vger.kernel.org

Am 04.07.2012 21:05, schrieb Gregory Farnum:

>=20
> Yep, that line. This means the monitor's on-disk state is inconsisten=
t, but I can think of a number of scenarios which could have caused thi=
s, depending on how you upgraded your cluster (older monitors didn't ma=
rk on-disk whenever they deliberately went inconsistent on a catchup, w=
hich I bet is what happened here).
>  =20
>> ceph version 0.48argonaut-125-g4e774fb
>> (commit:4e774fbcb38fd6883232b72352512a5f8e4a66e8)
>> 1: /usr/bin/ceph-mon() [0x497317]
>> 2: (Monitor::init()+0xc5a) [0x4857fa]
>> 3: (main()+0x2789) [0x46ac79]
>> 4: (__libc_start_main()+0xfd) [0x7f423bcfbc8d]
>> 5: /usr/bin/ceph-mon() [0x468309]
>> NOTE: a copy of the executable, or `objdump -rdS <executable>` is ne=
eded to
>> interpret this.
>> =20

>=20
> No, that won't be necessary. Thanks though! =20

 ceph version 0.48argonaut-125-g4e774fb
(commit:4e774fbcb38fd6883232b72352512a5f8e4a66e8)
 1: /usr/bin/ceph-mon() [0x52f9c9]
 2: (()+0xeff0) [0x7fe93db6dff0]
 3: (gsignal()+0x35) [0x7fe93c3501b5]
 4: (abort()+0x180) [0x7fe93c352fc0]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7fe93cbe4dc5]
 6: (()+0xcb166) [0x7fe93cbe3166]
 7: (()+0xcb193) [0x7fe93cbe3193]
 8: (()+0xcb28e) [0x7fe93cbe328e]
 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char const=
*)+0x940)
[0x55b310]
 10: /usr/bin/ceph-mon() [0x497317]
 11: (Monitor::init()+0xc5a) [0x4857fa]
 12: (main()+0x2789) [0x46ac79]
 13: (__libc_start_main()+0xfd) [0x7fe93c33cc8d]
 14: /usr/bin/ceph-mon() [0x468309]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is need=
ed to
interpret this.

--- end dump of recent events ---
2012-07-24 17:03:22.791401 7fd3045af780  1 mon.1@-1(probing) e1 init fs=
id
4553d0f6-1b31-4ba5-9d97-edae55bcaab4
2012-07-24 17:03:22.791890 7fd3045af780 -1 mon/Paxos.cc: In function 'b=
ool
Paxos::is_consistent()' thread 7fd3045af780 time 2012-07-24 17:03:22.79=
1528
mon/Paxos.cc: 1031: FAILED assert(consistent || (slurping =3D=3D 1))

 ceph version 0.48argonaut-125-g4e774fb
(commit:4e774fbcb38fd6883232b72352512a5f8e4a66e8)
 1: /usr/bin/ceph-mon() [0x497317]
 2: (Monitor::init()+0xc5a) [0x4857fa]
 3: (main()+0x2789) [0x46ac79]
 4: (__libc_start_main()+0xfd) [0x7fd302967c8d]
 5: /usr/bin/ceph-mon() [0x468309]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is need=
ed to
interpret this.


Well, again my cluster rebootet and now only 1 of 4 monitors is willing=
 to start...

 ceph version 0.48argonaut-125-g4e774fb
(commit:4e774fbcb38fd6883232b72352512a5f8e4a66e8)
 1: /usr/bin/ceph-mon() [0x497317]
 2: (Monitor::init()+0xc5a) [0x4857fa]
 3: (main()+0x2789) [0x46ac79]
 4: (__libc_start_main()+0xfd) [0x7fd302967c8d]
 5: /usr/bin/ceph-mon() [0x468309]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is need=
ed to
interpret this.

--- begin dump of recent events ---
    -3> 2012-07-24 17:03:22.729549 7fd3045af780  1 store(/data/ceph/mon=
) mount
    -2> 2012-07-24 17:03:22.729667 7fd3045af780  0 ceph version
0.48argonaut-125-g4e774fb (commit:4e774fbcb38fd6883232b72352512a5f8e4a6=
6e8),
process ceph-mon, pid 6962
    -1> 2012-07-24 17:03:22.791401 7fd3045af780  1 mon.1@-1(probing) e1=
 init
fsid 4553d0f6-1b31-4ba5-9d97-edae55bcaab4
     0> 2012-07-24 17:03:22.791890 7fd3045af780 -1 mon/Paxos.cc: In fun=
ction
'bool Paxos::is_consistent()' thread 7fd3045af780 time 2012-07-24 17:03=
:22.791528
mon/Paxos.cc: 1031: FAILED assert(consistent || (slurping =3D=3D 1))


--- end dump of recent events ---
2012-07-24 17:03:22.792461 7fd3045af780 -1 *** Caught signal (Aborted) =
**
 in thread 7fd3045af780

 ceph version 0.48argonaut-125-g4e774fb
(commit:4e774fbcb38fd6883232b72352512a5f8e4a66e8)
 1: /usr/bin/ceph-mon() [0x52f9c9]
 2: (()+0xeff0) [0x7fd304198ff0]
 3: (gsignal()+0x35) [0x7fd30297b1b5]
 4: (abort()+0x180) [0x7fd30297dfc0]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7fd30320fdc5]
 6: (()+0xcb166) [0x7fd30320e166]
 7: (()+0xcb193) [0x7fd30320e193]
 8: (()+0xcb28e) [0x7fd30320e28e]
 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char const=
*)+0x940)
[0x55b310]
 10: /usr/bin/ceph-mon() [0x497317]
 11: (Monitor::init()+0xc5a) [0x4857fa]
 12: (main()+0x2789) [0x46ac79]
 13: (__libc_start_main()+0xfd) [0x7fd302967c8d]
 14: /usr/bin/ceph-mon() [0x468309]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is need=
ed to
interpret this.

--- begin dump of recent events ---
     0> 2012-07-24 17:03:22.792461 7fd3045af780 -1 *** Caught signal (A=
borted) **
 in thread 7fd3045af780

 ceph version 0.48argonaut-125-g4e774fb
(commit:4e774fbcb38fd6883232b72352512a5f8e4a66e8)
 1: /usr/bin/ceph-mon() [0x52f9c9]
 2: (()+0xeff0) [0x7fd304198ff0]
 3: (gsignal()+0x35) [0x7fd30297b1b5]
 4: (abort()+0x180) [0x7fd30297dfc0]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7fd30320fdc5]
 6: (()+0xcb166) [0x7fd30320e166]
 7: (()+0xcb193) [0x7fd30320e193]
 8: (()+0xcb28e) [0x7fd30320e28e]
 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char const=
*)+0x940)
[0x55b310]
 10: /usr/bin/ceph-mon() [0x497317]
 11: (Monitor::init()+0xc5a) [0x4857fa]
 12: (main()+0x2789) [0x46ac79]
 13: (__libc_start_main()+0xfd) [0x7fd302967c8d]
 14: /usr/bin/ceph-mon() [0x468309]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is need=
ed to
interpret this.

--- end dump of recent events ---



How can i fix this or prevent this from happening?

--=20

Mit freundlichen Gr=C3=BC=C3=9Fen,

=46lorian Wiessner

Smart Weblications GmbH
Martinsberger Str. 1
D-95119 Naila

fon.: +49 9282 9638 200
fax.: +49 9282 9638 205
24/7: +49 900 144 000 00 - 0,99 EUR/Min*
http://www.smart-weblications.de

--
Sitz der Gesellschaft: Naila
Gesch=C3=A4ftsf=C3=BChrer: Florian Wiessner
HRB-Nr.: HRB 3840 Amtsgericht Hof
*aus dem dt. Festnetz, ggf. abweichende Preise aus dem Mobilfunknetz
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
