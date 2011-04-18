From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: Logging
Date: Mon, 18 Apr 2011 10:16:20 -0700
Message-ID: <BANLkTikCO-pgBfNtvpMVn5HEG2ujhsSgxQ@mail.gmail.com>
References: <4DAB77FD.4010804@provocation.net>
	<BANLkTinntanBQLag+8hC+FSfpxz8iib1uA@mail.gmail.com>
	<4DAC0EE7.4080001@provocation.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41743 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754667Ab1DRRQa convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Apr 2011 13:16:30 -0400
Received: by bwz15 with SMTP id 15so4004865bwz.19
        for <ceph-devel@vger.kernel.org>; Mon, 18 Apr 2011 10:16:29 -0700 (PDT)
In-Reply-To: <4DAC0EE7.4080001@provocation.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zenon Panoussis <oracle@provocation.net>
Cc: ceph-devel@vger.kernel.org

On Mon, Apr 18, 2011 at 3:13 AM, Zenon Panoussis <oracle@provocation.ne=
t> wrote:
>
>
> On 04/18/2011 02:53 AM, Colin McCabe wrote:
>
> Hi
>
>>> Question: what's the "do not log at all" syntax in ceph.conf? I tri=
ed
>>> putting everything on "debug xyz =3D 0", but ceph (osd in this case=
) is
>>> still logging plenty. According to this, I think it shouldn't:
>
>> Messages that are output at log level 0 or -1 will always be
>> displayed. I'm not sure if this message belongs at that log level or
>> not-- I haven't dealt with the OSD repop code in a while.
>
> Wido mentioned "log file =3D " in a recent posting; I'll try it.
>
>> In general, I don't think that anyone will ever want to turn off
>> logging completely. That would be a little bit like running your
>> server without syslog. It just doesn't happen in the real world.
>
> Of course you're right in general, but right now I'm trying to figure=
 why
> my cluster is sluggy and logging is one potential cause that I'd like=
 to
> test eliminating. I've seen something like this once before (in openl=
dap),
> inexplicable slowness that I spent a long time trying to understand b=
y
> reading logs, until I found out that it went away completely as soon =
as
> I switched off logging.

Hi Zenon,

If you'd like to measure performance without logging, first set all
the debug levels to 0. You should be able to do this, at least in
head-of-line, with this:

debug mds =3D 0
debug mds balancer =3D 0
debug mds log =3D 0
debug mds log expire =3D 0
debug mds migrator =3D 0
debug filestore =3D 0
debug journal =3D 0
debug bdev =3D 0
debug mon =3D 0
debug auth =3D 0
debug finisher =3D 0

Then disable all the log sinks with this:

log file =3D
log to stderr =3D 0
log to syslog =3D false
clog to monitors =3D false
clog to syslog =3D false

cheers,
Colin

>
> Z
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
