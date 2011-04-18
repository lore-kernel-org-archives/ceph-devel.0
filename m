From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: Logging
Date: Sun, 17 Apr 2011 17:53:41 -0700
Message-ID: <BANLkTinntanBQLag+8hC+FSfpxz8iib1uA@mail.gmail.com>
References: <4DAB77FD.4010804@provocation.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38991 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753534Ab1DRAxo convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 17 Apr 2011 20:53:44 -0400
Received: by fxm17 with SMTP id 17so2702818fxm.19
        for <ceph-devel@vger.kernel.org>; Sun, 17 Apr 2011 17:53:43 -0700 (PDT)
In-Reply-To: <4DAB77FD.4010804@provocation.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zenon Panoussis <oracle@provocation.net>
Cc: ceph-devel@vger.kernel.org

On Sun, Apr 17, 2011 at 4:30 PM, Zenon Panoussis <oracle@provocation.ne=
t> wrote:
>
> Question: what's the "do not log at all" syntax in ceph.conf? I tried
> putting everything on "debug xyz =3D 0", but ceph (osd in this case) =
is
> still logging plenty. According to this, I think it shouldn't:

Hi Zenon,

Messages that are output at log level 0 or -1 will always be
displayed. I'm not sure if this message belongs at that log level or
not-- I haven't dealt with the OSD repop code in a while.

In general, I don't think that anyone will ever want to turn off
logging completely. That would be a little bit like running your
server without syslog. It just doesn't happen in the real world. Also,
Ceph is not stable yet, and logs are the main (only?) diagnostic tool
we have for most problems. I guess sometimes there is a core file if
you've set up your system for that.

That being said, we do need to be a lot less verbose in some places.
If you find any log messages you think are mis-prioritized, patches
are welcome!

Colin


>
> # grep debug /etc/ceph/ceph.conf
> =A0 =A0 =A0 =A0; logging, for debugging monitor crashes, in order of
> =A0 =A0 =A0 =A0debug ms =3D 0
> =A0 =A0 =A0 =A0debug mon =3D 0
> =A0 =A0 =A0 =A0debug paxos =3D 0
> =A0 =A0 =A0 =A0debug auth =3D 0
> =A0 =A0 =A0 =A0; mds logging to debug issues.
> =A0 =A0 =A0 =A0debug ms =3D 0
> =A0 =A0 =A0 =A0debug mds =3D 0
> =A0 =A0 =A0 =A0debug mds balancer =3D 0
> =A0 =A0 =A0 =A0debug mds log =3D 0
> =A0 =A0 =A0 =A0debug mds_migrator =3D 0
> =A0 =A0 =A0 =A0debug monc =3D 0
> =A0 =A0 =A0 =A0; osd logging to debug osd issues, in order of likelih=
ood of being
> =A0 =A0 =A0 =A0debug ms =3D 0
> =A0 =A0 =A0 =A0debug osd =3D 0
> =A0 =A0 =A0 =A0debug filestore =3D 0
> =A0 =A0 =A0 =A0debug journal =3D 0
>
> Log example:
>
> 2011-04-18 01:28:56.787046 7f7976fd8700 osd0 5 pg[1.3d( v 5'186 (5'18=
4,5'186] n=3D1 ec=3D2 les=3D5 3/3/2) [0,1] r=3D0 mlcod 5'184 active+cle=
an] =A0sending commit on repgather(0x7f794827fb70 applying 5'186 rep_ti=
d=3D49196 wfack=3D0 wfdisk=3D op=3Dosd_op(mds0.1:27067 200.00000058 [wr=
ite 3241176~1615] 1.fbbd) v2) 0x7f794811b630
>
> Z
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
