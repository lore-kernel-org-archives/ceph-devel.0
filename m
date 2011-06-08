From: biyan chen <riby.chen@gmail.com>
Subject: Ceph write large files
Date: Wed, 8 Jun 2011 12:48:52 +0800
Message-ID: <BANLkTins_SvqwmJ3vKBpWTpwcSeNKB8bAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:51085 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060Ab1FHEsw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Jun 2011 00:48:52 -0400
Received: by ywe9 with SMTP id 9so48679ywe.19
        for <ceph-devel@vger.kernel.org>; Tue, 07 Jun 2011 21:48:52 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

command in client:

time dd if=3D/dev/zero bs=3D5k count=3D5120 of=3Dfile


The file system is dead,Cannot use command =93ls -al=94

I have two osd

=46ound in a osd error log :

2011-06-08 08:24:33.035240 7f5bd786d710 -- 0.0.0.0:6801/2697 >>
192.168.0.208:6801/2887 pipe(0x1217280 sd=3D13 pgs=3D1 cs=3D1 l=3D0).fa=
ult
with nothing to send, going to standby


Thanks
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
