From: Victor Denisov <vdenisov@mirantis.com>
Subject: Re: Unfound objects and inconsistent reports
Date: Wed, 11 May 2016 15:47:35 -0700
Message-ID: <CA+hcxJQTXs+zFgz1sy4E6Y8uTXQ9h2xKZXynJp-485zt9rhULw@mail.gmail.com>
References: <5733379F.5080800@greenhost.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f173.google.com ([209.85.161.173]:33617 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751769AbcEKWrg convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 May 2016 18:47:36 -0400
Received: by mail-yw0-f173.google.com with SMTP id t10so64451176ywa.0
        for <ceph-devel@vger.kernel.org>; Wed, 11 May 2016 15:47:35 -0700 (PDT)
In-Reply-To: <5733379F.5080800@greenhost.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ana Aviles <ana@greenhost.nl>
Cc: ceph-users@ceph.com, ceph-devel <ceph-devel@vger.kernel.org>

Thank you Ana for sharing this.
Please don't hesitate to share if you happen to have more cases and sol=
utions).

On Wed, May 11, 2016 at 6:46 AM, Ana Aviles <ana@greenhost.nl> wrote:
> Hello everyone,
>
> We experienced a strange scenario last week of unfound objects and
> inconsistent reports from ceph tools. We solved it with the help from
> Sage, and we wanted to share our experience and to see if it can be o=
f
> any use for developers too.
>
> After OSDs segfaulting randomly, our cluster ended up with one OSD do=
wn
> and unfound objects, probably due to a combination of inopportune
> crashes. We tried to start that OSD again, but it crashed when readin=
g a
> specific PG from the log. here: http://pastebin.com/u9WFJnMR
>
> Sage pointed that it looked like some metadata was corrupted. Funny
> thing is that, that PG didn't belong to that OSD anymore. Once we mad=
e
> sure it didn't belong to that OSD, we removed the PG from that OSD.
>
> ceph-objectstore-tool --data-path /var/lib/ceph/osd/ceph-51/ --pgid
> 2.1fd --op remove --journal-path /var/lib/ceph/osd/ceph-51/journal
>
> We had to repeat this procedure for other PGs on that same OSD, as it
> kept on crashing on startup. Finally the OSD was up and in, but the
> recovery process was stuck with 10 unfound objects. We deleted markin=
g
> them as lost in their PGs doing:
>
> ceph pg 2.481 mark_unfound_lost delete
>
> Right after that, recovery was successfully completed but ceph report=
s
> were a bit inconsistent. ceph -s was reporting 7 unfound objects, whi=
le
> ceph health detail didn't report which PGs those unfound objects
> belonged to. Sage pointed us to ceph pg dump, that indeed showed whic=
h
> PGs owned those objects (in all PGs, the crashed OSD was a member).
> However, when we listed missing objects on those PGs, they reported n=
one:
>
> {
>     "offset": {
>         "oid": "",
>         "key": "",
>         "snapid": 0,
>         "hash": 0,
>         "max": 0,
>         "pool": -9223372036854775808,
>         "namespace": ""
>     },
>     "num_missing": 0,
>     "num_unfound": 0,
>     "objects": [],
>     "more": 0
> }
>
> Then we decided to restart the OSDs on those PGs, and the unfound
> objects disappear from ceph -s report.
>
> It may be important to mention that we had four nodes running the OSD=
s.
> Two nodes with v9.2.0 and another with v9.2.1. Our OSDs were crashing
> apparently because of an issue on v9.2.1. We shared this on the
> ceph-devel list, that were very helpful solving this
> (http://comments.gmane.org/gmane.comp.file-systems.ceph.devel/31123).
>
> Greetings,
>
> --
> Ana Avil=C3=A9s
> Greenhost - sustainable hosting & digital security
> E: ana@greenhost.nl
> T: +31 20 4890444
> W: https://greenhost.nl
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
