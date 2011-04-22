From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: [PATCH] config: Update sample config with more examples
Date: Fri, 22 Apr 2011 10:42:22 -0700
Message-ID: <BANLkTimJHK=J+Arf4jg_JatogfY4sHeTCw@mail.gmail.com>
References: <1303416459-29471-1-git-send-email-wido@widodh.nl>
	<BANLkTimWpd6b9+74FTtkOihLbdVPuNu73w@mail.gmail.com>
	<1303468755.5322.291.camel@wido-laptop.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51791 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756407Ab1DVRmY convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Apr 2011 13:42:24 -0400
Received: by fxm17 with SMTP id 17so435004fxm.19
        for <ceph-devel@vger.kernel.org>; Fri, 22 Apr 2011 10:42:23 -0700 (PDT)
In-Reply-To: <1303468755.5322.291.camel@wido-laptop.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

On Fri, Apr 22, 2011 at 3:39 AM, Wido den Hollander <wido@widodh.nl> wr=
ote:
> Hi,
>
> On Thu, 2011-04-21 at 14:14 -0700, Colin McCabe wrote:
>> Looks good. I would leave out the "log dir" stuff, though. That thin=
g
>> has been deprecated since forever in favor of "log file".
>
> Is it really deprecated? A quick search through the code shows it is
> still there.
>
> DoutStreamBuff shows:
>
> // If conf->log_file was specified, that takes the highest priority
> if (!conf->log_file.empty()) {
> =A0 =A0string log_file(normalize_relative(conf->log_file.c_str()));
> =A0 =A0if (conf->log_per_instance) {
>
> But why is log_dir still there?
>
> But you're right, for regular logging log file should be used. Still,
> why is log dir still there?

Mainly because of a desire not to break old configuration files. At
some point we should try to get rid of it, though. Maybe the first
step is to have a phase where we issue a warning about it.

sincerely,
Colin


>
>>
>> cheers,
>> Colin
>>
>>
>> On Thu, Apr 21, 2011 at 1:07 PM, Wido den Hollander <wido@widodh.nl>=
 wrote:
>> >
>> > Signed-off-by: Wido den Hollander <wido@widodh.nl>
>> > ---
>> > =A0src/sample.ceph.conf | =A0 77 +++++++++++++++++++++++++++++++++=
+++++++++--------
>> > =A01 files changed, 65 insertions(+), 12 deletions(-)
>> >
>> > diff --git a/src/sample.ceph.conf b/src/sample.ceph.conf
>> > index 473114b..67cb5ae 100644
>> > --- a/src/sample.ceph.conf
>> > +++ b/src/sample.ceph.conf
>> > @@ -10,6 +10,22 @@
>> > =A0; the current host (e.g., in a setup with a startup.conf on eac=
h
>> > =A0; node).
>> >
>> > +; The variables $type, $id and $name are available to use in path=
s
>> > +; $type =3D The type of daemon, possible values: mon, mds and osd
>> > +; $id =3D The ID of the daemon, for mon.alpha, $id will be alpha
>> > +; $name =3D $type.$id
>> > +
>> > +; For example:
>> > +; osd.0
>> > +; =A0$type =3D osd
>> > +; =A0$id =3D 0
>> > +; =A0$name =3D osd.0
>> > +
>> > +; mon.beta
>> > +; =A0$type =3D mon
>> > +; =A0$id =3D beta
>> > +; =A0$name =3D mon.beta
>> > +
>> > =A0; global
>> > =A0[global]
>> > =A0 =A0 =A0 =A0; enable secure authentication
>> > @@ -18,17 +34,42 @@
>> > =A0 =A0 =A0 =A0 ; allow ourselves to open a lot of files
>> > =A0 =A0 =A0 =A0 max open files =3D 131072
>> >
>> > - =A0 =A0 =A0 =A0; set up logging
>> > - =A0 =A0 =A0 =A0log file =3D /var/log/ceph/$name.log
>> > + =A0 =A0 =A0 =A0; You can change the default log location if you =
want to
>> > + =A0 =A0 =A0 =A0;log dir =3D /var/log/ceph
>> > + =A0 =A0 =A0 =A0;log file =3D $name.log
>> > +
>> > + =A0 =A0 =A0 =A0; Logging to syslog is also possible
>> > + =A0 =A0 =A0 =A0; If you want to disable logging to files, you sh=
ould empty log dir and file
>> > + =A0 =A0 =A0 =A0;log to syslog =3D true
>> > + =A0 =A0 =A0 =A0;log dir =3D
>> > + =A0 =A0 =A0 =A0;log file =3D
>> > +
>> > + =A0 =A0 =A0 =A0; This is the default pid file location
>> > + =A0 =A0 =A0 =A0;pid file =3D /var/run/ceph/$name.pid
>> >
>> > - =A0 =A0 =A0 =A0; set up pid files
>> > - =A0 =A0 =A0 =A0pid file =3D /var/run/ceph/$name.pid
>> > + =A0 =A0 =A0 =A0; If you want to run a IPv6 cluster, set this to =
true. Dual-stack isn't possible
>> > + =A0 =A0 =A0 =A0;ms bind ipv6 =3D true
>> >
>> > =A0; monitors
>> > =A0; =A0You need at least one. =A0You need at least three if you w=
ant to
>> > =A0; =A0tolerate any node failures. =A0Always create an odd number=
=2E
>> > =A0[mon]
>> > - =A0 =A0 =A0 mon data =3D /data/mon$id
>> > + =A0 =A0 =A0 mon data =3D /data/$name
>> > +
>> > + =A0 =A0 =A0 =A0; If you are using for example the RADOS Gateway =
and want to have your newly created
>> > + =A0 =A0 =A0 =A0; pools a higher replication level, you can set a=
 default
>> > + =A0 =A0 =A0 =A0;osd pool default size =3D 3
>> > +
>> > + =A0 =A0 =A0 =A0; You can also specify a CRUSH rule for new pools
>> > + =A0 =A0 =A0 =A0; Wiki: http://ceph.newdream.net/wiki/Custom_data=
_placement_with_CRUSH
>> > + =A0 =A0 =A0 =A0;osd pool default crush rule =3D 0
>> > +
>> > + =A0 =A0 =A0 =A0; Timing is critical for monitors, but if you wan=
t to allow the clocks to drift a
>> > + =A0 =A0 =A0 =A0; bit more, you can specify the max drift.
>> > + =A0 =A0 =A0 =A0;mon clock drift allowed =3D 1
>> > +
>> > + =A0 =A0 =A0 =A0; Tell the monitor to backoff from this warning f=
or 30 seconds
>> > + =A0 =A0 =A0 =A0;mon clock drift warn backoff =3D 30
>> >
>> > =A0 =A0 =A0 =A0; logging, for debugging monitor crashes, in order =
of
>> > =A0 =A0 =A0 =A0; their likelihood of being helpful :)
>> > @@ -37,15 +78,15 @@
>> > =A0 =A0 =A0 =A0;debug paxos =3D 20
>> > =A0 =A0 =A0 =A0;debug auth =3D 20
>> >
>> > -[mon.0]
>> > +[mon.alpha]
>> > =A0 =A0 =A0 =A0host =3D alpha
>> > =A0 =A0 =A0 =A0mon addr =3D 192.168.0.10:6789
>> >
>> > -[mon.1]
>> > +[mon.beta]
>> > =A0 =A0 =A0 =A0host =3D beta
>> > =A0 =A0 =A0 =A0mon addr =3D 192.168.0.11:6789
>> >
>> > -[mon.2]
>> > +[mon.gamma]
>> > =A0 =A0 =A0 =A0host =3D gamma
>> > =A0 =A0 =A0 =A0mon addr =3D 192.168.0.12:6789
>> >
>> > @@ -70,17 +111,25 @@
>> > =A0; =A0Define as many as you like.
>> > =A0[osd]
>> > =A0 =A0 =A0 =A0; This is where the btrfs volume will be mounted.
>> > - =A0 =A0 =A0 osd data =3D /data/osd$id
>> > + =A0 =A0 =A0 osd data =3D /data/$name
>> >
>> > =A0 =A0 =A0 =A0; Ideally, make this a separate disk or partition. =
=A0A few
>> > =A0 =A0 =A0 =A0; hundred MB should be enough; more if you have fas=
t or many
>> > =A0 =A0 =A0 =A0; disks. =A0You can use a file under the osd data d=
ir if need be
>> > - =A0 =A0 =A0 ; (e.g. /data/osd$id/journal), but it will be slower=
 than a
>> > + =A0 =A0 =A0 ; (e.g. /data/$name/journal), but it will be slower =
than a
>> > =A0 =A0 =A0 =A0; separate disk or partition.
>> >
>> > =A0 =A0 =A0 =A0 ; This is an example of a file-based journal.
>> > - =A0 =A0 =A0 osd journal =3D /data/osd$id/journal
>> > - =A0 =A0 =A0 osd journal size =3D 1000 ; journal size, in megabyt=
es
>> > + =A0 =A0 =A0 osd journal =3D /data/$name/journal
>> > + =A0 =A0 =A0 =A0; Journal size, in megabytes
>> > + =A0 =A0 =A0 osd journal size =3D 1000
>> > +
>> > + =A0 =A0 =A0 =A0; If you want to run the journal on a tmpfs, disa=
ble DirectIO
>> > + =A0 =A0 =A0 =A0;journal dio =3D false
>> > +
>> > + =A0 =A0 =A0 =A0; You can change the number of recovery operation=
s to speed up recovery
>> > + =A0 =A0 =A0 =A0; or slow it down if your machines can't handle i=
t
>> > + =A0 =A0 =A0 =A0;osd recovery max active =3D 3
>> >
>> > =A0 =A0 =A0 =A0; osd logging to debug osd issues, in order of like=
lihood of being
>> > =A0 =A0 =A0 =A0; helpful
>> > @@ -98,6 +147,10 @@
>> > =A0 =A0 =A0 =A0; usually fine for basic testing).
>> > =A0 =A0 =A0 =A0btrfs devs =3D /dev/sdx
>> >
>> > + =A0 =A0 =A0 =A0; If you want to specify some other mount options=
, you can do so.
>> > + =A0 =A0 =A0 =A0; The default values are rw,noatime
>> > + =A0 =A0 =A0 =A0;btrfs options =3D rw,noatime
>> > +
>> > =A0[osd.1]
>> > =A0 =A0 =A0 =A0host =3D epsilon
>> > =A0 =A0 =A0 =A0btrfs devs =3D /dev/sdy
>> > --
>> > 1.7.0.4
>> >
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.ht=
ml
>> >
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
