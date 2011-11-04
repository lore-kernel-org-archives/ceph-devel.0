From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Cannot execute rados.py with sudoer
Date: Fri, 4 Nov 2011 09:34:12 -0700
Message-ID: <CAORUGqCn8EEAP9AXTkFQaCoWAsFU3smNbGR6RjjtG97djVCepw@mail.gmail.com>
References: <8512670932FB654F81AF0FEF1BE6D49D649E74@WHQBEMAIL1.whq.wistron>
 <CAF3hT9DaMW8dCx=1BGnW1jjoK+AuDDBNe57tfV1S2P3rc-BPUw@mail.gmail.com>
 <8512670932FB654F81AF0FEF1BE6D49D649F29@WHQBEMAIL1.whq.wistron>
 <CAORUGqDMuU0CoRU8c-kTH+MqA3wKqaYe05on769zhFEY3DNK2A@mail.gmail.com> <8512670932FB654F81AF0FEF1BE6D49D64A442@WHQBEMAIL1.whq.wistron>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:59028 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755954Ab1KDQee convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Nov 2011 12:34:34 -0400
Received: by wwi36 with SMTP id 36so3738834wwi.1
        for <ceph-devel@vger.kernel.org>; Fri, 04 Nov 2011 09:34:33 -0700 (PDT)
In-Reply-To: <8512670932FB654F81AF0FEF1BE6D49D64A442@WHQBEMAIL1.whq.wistron>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Eric_YH_Chen@wistron.com
Cc: gregory.farnum@dreamhost.com, ceph-devel@vger.kernel.org

On Thu, Nov 3, 2011 at 18:45,  <Eric_YH_Chen@wistron.com> wrote:
> Hi, Tommi,
>
> Here is my ceph.conf. The "/var/log/ceph" folder is created by myself=
=2E

> [global]
=2E..
> =C2=A0 =C2=A0 =C2=A0 =C2=A0log file =3D /var/log/ceph/$name.log
> =C2=A0 =C2=A0 =C2=A0 =C2=A0pid file =3D /var/run/ceph/$name.pid

That's your problem. You told even clients to write to that log file,
yet they don't have permissions to write to it.

You can add

[client]
  log file =3D ""

to set it back to no logging to file for clients. Other alternatives
are log to stderr, log to syslog, no logging.

=46or more, see http://ceph.newdream.net/wiki/Cluster_configuration#Deb=
ug_Logging_Configuration
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
