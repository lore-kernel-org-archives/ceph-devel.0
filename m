From: Gregory Farnum <greg@inktank.com>
Subject: Re: Setting a big maxosd kills all mons
Date: Thu, 5 Jul 2012 10:49:02 -0700
Message-ID: <CAPYLRzhqbsKzR_TtAxKAV8t71aeHc29hSoqWUwi82bfXBcf_-A@mail.gmail.com>
References: <CAPUexz9EHLsEvSCrw40U6L9zP=yWA6S81GCoeoBwXutPzxm9Cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:44130 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753265Ab2GERtD convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Jul 2012 13:49:03 -0400
Received: by bkwj10 with SMTP id j10so3713899bkw.19
        for <ceph-devel@vger.kernel.org>; Thu, 05 Jul 2012 10:49:02 -0700 (PDT)
In-Reply-To: <CAPUexz9EHLsEvSCrw40U6L9zP=yWA6S81GCoeoBwXutPzxm9Cw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Florian Haas <florian@hastexo.com>
Cc: ceph-devel@vger.kernel.org

On Thu, Jul 5, 2012 at 10:39 AM, Florian Haas <florian@hastexo.com> wro=
te:
> Hi guys,
>
> Someone I worked with today pointed me to a quick and easy way to
> bring down an entire cluster, by making all mons kill themselves in
> mass suicide:
>
> ceph osd setmaxosd 2147483647
> 2012-07-05 16:29:41.893862 b5962b70 =A00 monclient: hunting for new m=
on
Ungh. Can you file a bug report? The problem here is that the monitor
is trying to allocate a number of maps and arrays with that many
entries; we probably need to put an artificial cap in place as a
config option.


> I don't know what the actual threshold is, but setting your maxosd to
> any sufficiently big number should do it. I had hoped 2^31-1 would be
> fine, but evidently it's not.
>
> This is what's in the mon log -- the first line is obviously only on
> the leader at the time of the command, the others are on all mons.
>
> =A0 =A0 -1> 2012-07-05 16:29:41.829470 b41a1b70 =A00 mon.daisy@0(lead=
er) e1
> handle_command mon_command(osd setmaxosd 2147483647 v 0) v1
> =A0 =A0 =A00> 2012-07-05 16:29:41.887590 b41a1b70 -1 *** Caught signa=
l (Aborted) **
> =A0in thread b41a1b70
>
> =A0ceph version 0.48argonaut (commit:c2b20ca74249892c8e5e40c12aa14446=
a2bf2030)
> =A01: /usr/bin/ceph-mon() [0x816f461]
> =A02: [0xb7738400]
> =A03: [0xb7738424]
> =A04: (gsignal()+0x51) [0xb731a781]
> =A05: (abort()+0x182) [0xb731dbb2]
> =A06: (__gnu_cxx::__verbose_terminate_handler()+0x14f) [0xb753b53f]
> =A07: (()+0xbd405) [0xb7539405]
> =A08: (()+0xbd442) [0xb7539442]
> =A09: (()+0xbd581) [0xb7539581]
> =A010: (()+0x11dea) [0xb7582dea]
> =A011: (tc_new()+0x26) [0xb75a1636]
> =A012: (std::vector<unsigned char, std::allocator<unsigned char>
>>::_M_fill_insert(__gnu_cxx::__normal_iterator<unsigned char*,
> std::vector<unsigned char, std::allocator<unsigned char> > >, unsigne=
d
> int, unsigned char const&)+0x79) [0x8185629]
> =A013: (OSDMap::set_max_osd(int)+0x497) [0x817c6b7]
>
> From src/mon/OSDMonitor.cc:
>
> =A0 =A0 =A0 int newmax =3D atoi(m->cmd[2].c_str());
> =A0 =A0 =A0 if (newmax < osdmap.crush->get_max_devices()) {
> =A0 =A0 =A0 =A0 err =3D -ERANGE;
> =A0 =A0 =A0 =A0 ss << "cannot set max_osd to " << newmax << " which i=
s < crush
> max_devices "
> =A0 =A0 =A0 =A0 =A0 =A0<< osdmap.crush->get_max_devices();
> =A0 =A0 =A0 =A0 goto out;
> =A0 =A0 =A0 }
>
> I think that counts as unchecked user input, or has cmd[2] been
> sanitized at any time before it gets here?

Yeah, there's all kinds of unsanitized user input in the monitor
command-parsing code.

> Also, is there a way to recover from this, short of reinitializing al=
l mons?
Hmm. We can do it by manipulating the disk format, but there's not any
programmatic way to do so. I *think* that if you turn off all the
monitors, and:
1) delete the latest osdmap and osdmap_full entries,
2) edit the osdmap and osdmap_full last_committed entries to be one
prior to what they are,
3) start the monitors
then you should be okay. But it's possible that the "latest" entry got
updated, in which case you'd also have to modify that to be an older
map.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
