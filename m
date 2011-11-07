From: Smart Weblications GmbH - Florian Wiessner
	<f.wiessner@smart-weblications.de>
Subject: bug when using ceph and keyring does not exist
Date: Mon, 07 Nov 2011 08:27:50 +0100
Message-ID: <4EB78876.10406@smart-weblications.de>
Reply-To: f.wiessner@smart-weblications.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx02.smart-weblications.de ([188.65.144.37]:50956 "EHLO
	mx02.smart-weblications.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750816Ab1KGHhV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Nov 2011 02:37:21 -0500
Received: from office.smart-weblications.net (office.smart-weblications.net [91.204.168.193])
	by mx02.smart-weblications.de (Postfix) with ESMTPA id 9AC3EC3233E
	for <ceph-devel@vger.kernel.org>; Mon,  7 Nov 2011 07:27:53 +0000 (UTC)
Received: from [192.168.200.13] (callosum.office.smart-weblications.net [192.168.200.13])
	by office.smart-weblications.net (Postfix) with ESMTP id CE8145A17AF
	for <ceph-devel@vger.kernel.org>; Mon,  7 Nov 2011 08:27:52 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi

i think i found a bug:

node02:/etc/ceph# ls
ceph.conf  keyring.mds.1  keyring.osd.1
node02:/etc/ceph# ceph
*** Caught signal (Segmentation fault) **
 in thread 7fb817589720
 ceph version 0.37-307-gae41f32 (commit:ae41f3232a39dbf33487ab02cbac292=
f58debea8)
 1: ceph() [0x470789]
 2: (()+0xef60) [0x7fb817170f60]
 3: (MonClient::_reopen_session()+0x5e4) [0x4845e4]
 4: (MonClient::authenticate(double)+0x1a1) [0x485281]
 5: (ceph_tool_common_init(ceph_tool_mode_t, bool)+0x55d) [0x452d2d]
 6: (main()+0x4fe) [0x44fa6e]
 7: (__libc_start_main()+0xfd) [0x7fb815b84c4d]
 8: ceph() [0x44e519]
Speicherzugriffsfehler
node02:/etc/ceph# scp root@node01:/etc/ceph/keyring .
keyring
                                            100%   92     0.1KB/s   00:=
00
node02:/etc/ceph# ceph
ceph> quit


so ceph seems to segfault when keyring file is missing...

a warning would be better :)
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
