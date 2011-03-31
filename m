From: "Colin P. McCabe" <colinm@hq.newdream.net>
Subject: Re: question of ceph
Date: Thu, 31 Mar 2011 09:35:35 -0700
Message-ID: <AANLkTin=_FouBAKjepHmD5VkR14JyU54-oL9S+dABKb2@mail.gmail.com>
References: <20110331140853.czyta0mtc0c480co@mail.cs2c.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55209 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753085Ab1CaQfg convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Mar 2011 12:35:36 -0400
Received: by fxm17 with SMTP id 17so2006631fxm.19
        for <ceph-devel@vger.kernel.org>; Thu, 31 Mar 2011 09:35:35 -0700 (PDT)
In-Reply-To: <20110331140853.czyta0mtc0c480co@mail.cs2c.com.cn>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: li.li@cs2c.com.cn, ceph-devel@vger.kernel.org

Hi,

You can enable debug options by putting them in your ceph.conf.

=46or example, this will turn on debugging for the filestore:

[global]
    debug filestore =3D 10

You can also pass an argument on the command line, like this:
<program-name> --debug-filestore=3D10

regards,
Colin


On Wed, Mar 30, 2011 at 11:08 PM,  <li.li@cs2c.com.cn> wrote:
> hi , colinm !
>
>
> I would like=A0 to be enable debug swith=A0 of=A0 /ceph/src/config.cc=
=A0 , however .
> i don't kown how to be enable as follows.
>
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 OPTION(debug, 0, OPT_IN=
T, 20),
> =A0=A0=A0=A0=A0=A0 =A0 =A0 =A0 =A0=A0 OPTION(debug_lockdep, 0, OPT_IN=
T, 20),
> =A0=A0=A0=A0=A0 =A0 =A0 =A0 =A0 =A0 OPTION(debug_mds, 0, OPT_INT, 20)=
,
> =A0=A0=A0=A0=A0 =A0 =A0 =A0 =A0 =A0 OPTION(debug_mds_balancer, 0, OPT=
_INT, 20),
> =A0=A0=A0=A0 =A0 =A0 =A0 =A0 =A0 OPTION(debug_mds_log, 0, OPT_INT, 20=
),
> =A0=A0=A0=A0=A0 =A0 =A0 =A0=A0 =A0 OPTION(debug_mds_log_expire, 0, OP=
T_INT, 20),
> =A0=A0 =A0 =A0 =A0 =A0 =A0=A0=A0 OPTION(debug_mds_migrator, 0, OPT_IN=
T, 20),
> =A0=A0=A0 =A0 =A0 =A0 =A0 =A0=A0 OPTION(debug_buffer, 0, OPT_INT, 20)=
,
> =A0=A0=A0=A0=A0 =A0 =A0 =A0=A0 =A0 OPTION(debug_timer, 0, OPT_INT, 20=
),
> =A0 =A0 =A0 =A0=A0 =A0=A0=A0=A0 OPTION(debug_filer, 0, OPT_INT, 20),
> =A0=A0=A0=A0=A0=A0 =A0 =A0 =A0=A0 OPTION(debug_objecter, 0, OPT_INT, =
20),
> =A0=A0=A0=A0=A0=A0=A0 =A0 =A0 =A0 OPTION(debug_rados, 0, OPT_INT, 20)=
,
> =A0=A0=A0=A0=A0 =A0 =A0 =A0 =A0 OPTION(debug_journaler, 0, OPT_INT, 2=
0),
> =A0=A0=A0=A0 =A0 =A0 =A0 =A0=A0 OPTION(debug_objectcacher, 0, OPT_INT=
, 20),
> =A0=A0=A0=A0 =A0 =A0 =A0 =A0=A0 OPTION(debug_client, 0, OPT_INT, 20),
> =A0=A0=A0=A0=A0 =A0 =A0=A0 =A0 OPTION(debug_osd, 0, OPT_INT, 20),
> =A0=A0=A0=A0=A0=A0 =A0 =A0=A0 OPTION(debug_ebofs, 0, OPT_INT, 20),
> =A0=A0=A0=A0=A0 =A0 =A0 =A0 OPTION(debug_filestore, 0, OPT_INT, 20),
> =A0=A0=A0=A0=A0=A0 =A0=A0 =A0 OPTION(debug_journal, 0, OPT_INT, 20),
> =A0=A0=A0=A0=A0 =A0=A0 =A0 OPTION(debug_bdev, 0, OPT_INT, 20),=A0=A0=A0=
=A0=A0=A0=A0=A0 // block device
> =A0=A0=A0=A0=A0=A0 =A0 =A0=A0 OPTION(debug_ns, 0, OPT_INT, 20),
> =A0=A0=A0=A0=A0 =A0 =A0 =A0 OPTION(debug_ms, 0, OPT_INT, 20),
> =A0=A0=A0=A0 =A0 =A0 =A0 OPTION(debug_mon, 0, OPT_INT, 20),
> =A0=A0=A0=A0=A0 =A0=A0 =A0 OPTION(debug_monc, 0, OPT_INT, 20),
> =A0=A0=A0=A0=A0=A0=A0 =A0=A0 OPTION(debug_paxos, 0, OPT_INT, 20),
> =A0=A0=A0=A0=A0=A0=A0=A0=A0 OPTION(debug_tp, 0, OPT_INT, 20),
> =A0=A0=A0=A0=A0 =A0=A0 =A0 OPTION(debug_auth, 0, OPT_INT, 20),
> =A0=A0=A0=A0=A0=A0 =A0 =A0 OPTION(debug_finisher, 0, OPT_INT, 20),
>
> Beside,=A0 I don't know thar args of dout( ) fuctions . args is 0, 1,=
 2,3,4,5,
> -5,7,-7 ,12,-12 ,10 ,20,14,25,30 =A0 ????????
>
>
> Thanks , best wish .beside
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
