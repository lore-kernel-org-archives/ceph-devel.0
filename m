From: Smart Weblications GmbH - Florian Wiessner
	<f.wiessner@smart-weblications.de>
Subject: monitor not starting
Date: Wed, 04 Jul 2012 13:45:27 +0200
Message-ID: <4FF42CD7.1060000@smart-weblications.de>
Reply-To: f.wiessner@smart-weblications.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx03.smart-weblications.de ([188.65.144.38]:52276 "EHLO
	mx03.smart-weblications.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752119Ab2GDNWU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Jul 2012 09:22:20 -0400
Received: from office.smart-weblications.net (office.smart-weblications.net [91.204.168.193])
	by mx03.smart-weblications.de (Postfix) with ESMTPA id A355CD6A001
	for <ceph-devel@vger.kernel.org>; Wed,  4 Jul 2012 13:14:13 +0000 (UTC)
Received: from [192.168.200.13] (callosum.office.smart-weblications.net [192.168.200.13])
	by office.smart-weblications.net (Postfix) with ESMTP id 8D6C79991FF
	for <ceph-devel@vger.kernel.org>; Wed,  4 Jul 2012 13:45:13 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi List,


i today upgraded from 0.43 to 0.48 and now i have one monitor which doe=
s not
want to start up anymore:

 ceph version 0.48argonaut-125-g4e774fb
(commit:4e774fbcb38fd6883232b72352512a5f8e4a66e8)
 1: /usr/bin/ceph-mon() [0x52f9c9]
 2: (()+0xeff0) [0x7fb08dd11ff0]
 3: (gsignal()+0x35) [0x7fb08c4f41b5]
 4: (abort()+0x180) [0x7fb08c4f6fc0]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7fb08cd88dc5]
 6: (()+0xcb166) [0x7fb08cd87166]
 7: (()+0xcb193) [0x7fb08cd87193]
 8: (()+0xcb28e) [0x7fb08cd8728e]
 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char const=
*)+0x940)
[0x55b310]
 10: /usr/bin/ceph-mon() [0x497317]
 11: (Monitor::init()+0xc5a) [0x4857fa]
 12: (main()+0x2789) [0x46ac79]
 13: (__libc_start_main()+0xfd) [0x7fb08c4e0c8d]
 14: /usr/bin/ceph-mon() [0x468309]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is need=
ed to
interpret this.

--- end dump of recent events ---


How can i find out why it does not startup anymore? osd and mds is runn=
ing fine..
--=20

Mit freundlichen Gr=FC=DFen,

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
Gesch=E4ftsf=FChrer: Florian Wiessner
HRB-Nr.: HRB 3840 Amtsgericht Hof
*aus dem dt. Festnetz, ggf. abweichende Preise aus dem Mobilfunknetz

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
