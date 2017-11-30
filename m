From: Cary <dynamic.cary@gmail.com>
Subject: Re: Upgrade from Jewel to Luminous. REQUIRE_JEWEL OSDMap
Date: Thu, 30 Nov 2017 00:48:08 +0000
Message-ID: <CADfZm8dOAUnSJxHRvpNng9iOBHg1kyCauXY=VNt6z-kduSYtwg@mail.gmail.com>
References: <CADfZm8c9GKuedHA5x0n+2euhXbSqsFYxroimm-aw3Cc5Z00iXQ@mail.gmail.com>
 <alpine.DEB.2.11.1711280308100.19791@piezo.novalocal> <CADfZm8c1+OhDO36BjYSqLCe-US0Nmvhw87kyUWduc_5X3hL7Pg@mail.gmail.com>
 <alpine.DEB.2.11.1711281308100.19791@piezo.novalocal> <CADfZm8dYLvGOFhtCGp1twwJopz4rUDS1EKqLCxYE_or+RndCrg@mail.gmail.com>
 <alpine.DEB.2.11.1711281844430.19791@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot0-f172.google.com ([74.125.82.172]:39300 "EHLO
        mail-ot0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753694AbdK3AsJ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Nov 2017 19:48:09 -0500
Received: by mail-ot0-f172.google.com with SMTP id v21so4757361oth.6
        for <ceph-devel@vger.kernel.org>; Wed, 29 Nov 2017 16:48:09 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1711281844430.19791@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Hello,

 I have emerged a 9999 build of Luminous 2.2.1 on one of my monitor
nodes. I made sure only one Jewel OSD was being started. The log for
the OSD:
017-11-30 00:30:27.786793 7f9200a598c0  1
filestore(/var/lib/ceph/osd/ceph-1) upgrade
2017-11-30 00:30:27.786821 7f9200a598c0  2 osd.1 0 boot
2017-11-30 00:30:27.787101 7f9200a598c0 -1 osd.1 0 The disk uses
features unsupported by the executable.
2017-11-30 00:30:27.787110 7f9200a598c0 -1 osd.1 0  ondisk features
compat={},rocompat={},incompat={1=initial feature set(~v.18),2=pginfo
object,3=object
locator,4=last_epoch_clean,5=categories,6=hobjectpool,7=biginfo,8=leveldbinfo,9=leveldblog,10=snapmapper,12=transaction
hints,13=pg meta object,14=explicit missing set,15=fastinfo pg
attr,16=deletes in missing set}
2017-11-30 00:30:27.787120 7f9200a598c0 -1 osd.1 0  daemon features
compat={},rocompat={},incompat={1=initial feature set(~v.18),2=pginfo
object,3=object
locator,4=last_epoch_clean,5=categories,6=hobjectpool,7=biginfo,8=leveldbinfo,9=leveldblog,10=snapmapper,11=sharded
objects,12=transaction hints,13=pg meta object}
2017-11-30 00:30:27.787129 7f9200a598c0 -1 osd.1 0 Cannot write to
disk! Missing features: compat={},rocompat={},incompat={14=explicit
missing set,15=fastinfo pg attr,16=deletes in missing set}
2017-11-30 00:30:27.787355 7f9200a598c0  1 journal close
/dev/disk/by-partlabel/ceph-1
2017-11-30 00:30:27.795077 7f9200a598c0 -1  ** ERROR: osd init failed:
(95) Operation not supported

 The OSD is not starting because of missing features. So the next
command still fails.

 "ceph osd set require_jewel_osds --yes-i-really-really-mean-it"
returns the error

Invalid command:  unused arguments: [u'--yes-i-really-really-mean-it']

I guess ceph-dencoder may be needed tp change disk features. Does
anyone know what may need done here? Thank you,


Cary
-Dynamic

On Tue, Nov 28, 2017 at 6:45 PM, Sage Weil <sage@newdream.net> wrote:
> On Tue, 28 Nov 2017, Cary wrote:
>> Hello,
>>
>>  I am getting an error when I run "ceph osd set require_jewel_osds
>> --yes-i-really-mean-it".
>>
>> Error ENOENT: unknown feature '--yes-i-really-mean-it'
>
> I just tested on the latest luminous branch and this works.  Did you
> upgrade the mons to the latest luminous build and restart them?
> (ceph-deploy install --dev luminous HOST, then restart mon daemon(s)).
>
> sage
>
>
>  >
>>  So I ran, "ceph osd set require_jewel_osds", and got this error:
>>
>> Error EPERM: not all up OSDs have CEPH_FEATURE_SERVER_JEWEL feature
>>
>>  I verified all OSDs were stopped with "/etc/init.d/ceph-osd.N stop".
>> Then verified each was down with "ceph osd down N". When setting them
>> down, each replied "osd.N is already down".  I started one of the OSDs
>> on a host that was downgraded to 10.2.3-r2 I then attempted to set
>> "ceph osd set require_jewel_osds", and get the same error.
>>
>>
>>  The log for the OSD is showing this error:
>>
>> 2017-11-28 17:40:08.928446 7f47b082f940  1
>> filestore(/var/lib/ceph/osd/ceph-1) upgrade
>> 2017-11-28 17:40:08.928475 7f47b082f940  2 osd.1 0 boot
>> 2017-11-28 17:40:08.928788 7f47b082f940 -1 osd.1 0 The disk uses
>> features unsupported by the executable.
>> 2017-11-28 17:40:08.928810 7f47b082f940 -1 osd.1 0  ondisk features
>> compat={},rocompat={},incompat={1=initial feature set(~v.18),2=pginfo
>> object,3=object
>> locator,4=last_epoch_clean,5=categories,6=hobjectpool,7=biginfo,8=leveldbinfo,9=leveldblog,10=snapmapper,12=transaction
>> hints,13=pg meta object,14=explicit missing set,15=fastinfo pg
>> attr,16=deletes in missing set}
>> 2017-11-28 17:40:08.928818 7f47b082f940 -1 osd.1 0  daemon features
>> compat={},rocompat={},incompat={1=initial feature set(~v.18),2=pginfo
>> object,3=object
>> locator,4=last_epoch_clean,5=categories,6=hobjectpool,7=biginfo,8=leveldbinfo,9=leveldblog,10=snapmapper,11=sharded
>> objects,12=transaction hints,13=pg meta object}
>> 2017-11-28 17:40:08.928827 7f47b082f940 -1 osd.1 0 Cannot write to
>> disk! Missing features: compat={},rocompat={},incompat={14=explicit
>> missing set,15=fastinfo pg attr,16=deletes in missing set}
>> 2017-11-28 17:40:08.929353 7f47b082f940  1 journal close
>> /dev/disk/by-partlabel/ceph-1
>> 2017-11-28 17:40:08.930488 7f47b082f940 -1  ** ERROR: osd init failed:
>> (95) Operation not supported
>>
>> So the OSD is not starting because of missing features. It does not
>> show up in "ceph features" output.
>>
>>  Ceph features output:
>> ceph features
>> 2017-11-28 17:51:31.213636 7f6a2140a700 -1 WARNING: the following
>> dangerous and experimental features are enabled: btrfs
>> 2017-11-28 17:51:31.223068 7f6a2140a700 -1 WARNING: the following
>> dangerous and experimental features are enabled: btrfs
>>
>>     "mon": {
>>         "group": {
>>             "features": "0x1ffddff8eea4fffb",
>>             "release": "luminous",
>>             "num": 4
>>         }
>>     },
>>     "mds": {
>>         "group": {
>>             "features": "0x7fddff8ee84bffb",
>>             "release": "jewel",
>>             "num": 1
>>         }
>>     },
>>     "client": {
>>         "group": {
>>             "features": "0x1ffddff8eea4fffb",
>>             "release": "luminous",
>>             "num": 4
>>
>> I attempted to set require_jewel_osds with the MGRs stopped, and had
>> the same results.
>>
>>  Output from ceph tell osd.1 version. I get the same error from all OSDs.
>>
>> # ceph tell osd.1 versions
>> Error ENXIO: problem getting command descriptions from osd.1
>>
>> Any thoughts?
>>
>> Cary
>> -Dynamic
>>
>> On Tue, Nov 28, 2017 at 1:09 PM, Sage Weil <sage@newdream.net> wrote:
>> > On Tue, 28 Nov 2017, Cary wrote:
>> >> I get this error when I try to start the OSD that has been downgraded
>> >> to 10.2.3-r2.
>> >>
>> >> 2017-11-28 03:42:35.989754 7fa5e6429940  1
>> >> filestore(/var/lib/ceph/osd/ceph-3) upgrade
>> >> 2017-11-28 03:42:35.989788 7fa5e6429940  2 osd.3 0 boot
>> >> 2017-11-28 03:42:35.990132 7fa5e6429940 -1 osd.3 0 The disk uses
>> >> features unsupported by the executable.
>> >> 2017-11-28 03:42:35.990142 7fa5e6429940 -1 osd.3 0  ondisk features
>> >> compat={},rocompat={},incompat={1=initial feature set(~v.18),2=pginfo
>> >> object,3=object
>> >> locator,4=last_epoch_clean,5=categories,6=hobjectpool,7=biginfo,8=leveldbinfo,9=leveldblog,10=snapmapper,12=transaction
>> >> hints,13=pg meta object,14=explicit missing set,15=fastinfo pg
>> >> attr,16=deletes in missing set}
>> >> 2017-11-28 03:42:35.990150 7fa5e6429940 -1 osd.3 0  daemon features
>> >> compat={},rocompat={},incompat={1=initial feature set(~v.18),2=pginfo
>> >> object,3=object
>> >> locator,4=last_epoch_clean,5=categories,6=hobjectpool,7=biginfo,8=leveldbinfo,9=leveldblog,10=snapmapper,11=sharded
>> >> objects,12=transaction hints,13=pg meta object}
>> >> 2017-11-28 03:42:35.990160 7fa5e6429940 -1 osd.3 0 Cannot write to
>> >> disk! Missing features: compat={},rocompat={},incompat={14=explicit
>> >> missing set,15=fastinfo pg attr,16=deletes in missing set}
>> >> 2017-11-28 03:42:35.990775 7fa5e6429940  1 journal close
>> >> /dev/disk/by-partlabel/ceph-3
>> >> 2017-11-28 03:42:35.992960 7fa5e6429940 -1  ** ERROR: osd init failed:
>> >> (95) Operation not supported
>> >
>> > Oh, right.  In that case, install the 'luminous' branch[1] on the monitors
>> > (or just the primary monitor if you're being conservative), restrart it,
>> > and you'll be able to do
>> >
>> >  ceph osd set require_jewel_osds --yes-i-really-mean-it
>> >
>> > sage
>> >
>> >
>> > [1] ceph-deploy install --dev luminous HOST
>> >
>> >
>> >
>> >
>> >> Cary
>> >>
>> >> On Tue, Nov 28, 2017 at 3:09 AM, Sage Weil <sage@newdream.net> wrote:
>> >> > On Tue, 28 Nov 2017, Cary wrote:
>> >> >> Hello,
>> >> >>
>> >> >>  Could someone please help me complete my botched upgrade from Jewel
>> >> >> 10.2.3-r1 to Luminous 12.2.1. I have 9 Gentoo servers, 4 of which have
>> >> >> 2 OSDs each.
>> >> >>
>> >> >>  My OSD servers were accidentally rebooted before the monitor servers
>> >> >> causing them to be running Luminous before the monitors. All services
>> >> >> have been restarted and running ceph versions gives the following:
>> >> >>
>> >> >> # ceph versions
>> >> >> 2017-11-27 21:27:24.356940 7fed67efe700 -1 WARNING: the following
>> >> >> dangerous and experimental features are enabled: btrfs
>> >> >> 2017-11-27 21:27:24.368469 7fed67efe700 -1 WARNING: the following
>> >> >> dangerous and experimental features are enabled: btrfs
>> >> >>
>> >> >>     "mon": {
>> >> >>         "ceph version 12.2.1
>> >> >> (3e7492b9ada8bdc9a5cd0feafd42fbca27f9c38e) luminous (stable)": 4
>> >> >>     },
>> >> >>     "mgr": {
>> >> >>         "ceph version 12.2.1
>> >> >> (3e7492b9ada8bdc9a5cd0feafd42fbca27f9c38e) luminous (stable)": 3
>> >> >>     },
>> >> >>     "osd": {},
>> >> >>     "mds": {
>> >> >>         "ceph version 12.2.1
>> >> >> (3e7492b9ada8bdc9a5cd0feafd42fbca27f9c38e) luminous (stable)": 1
>> >> >>     },
>> >> >>     "overall": {
>> >> >>         "ceph version 12.2.1
>> >> >> (3e7492b9ada8bdc9a5cd0feafd42fbca27f9c38e) luminous (stable)": 8
>> >> >>
>> >> >>
>> >> >>
>> >> >> For some reason the OSDs do not show what version they are running,
>> >> >> and a ceph osd tree shows all of the OSD as being down.
>> >> >>
>> >> >>  # ceph osd tree
>> >> >> 2017-11-27 21:32:51.969335 7f483d9c2700 -1 WARNING: the following
>> >> >> dangerous and experimental features are enabled: btrfs
>> >> >> 2017-11-27 21:32:51.980976 7f483d9c2700 -1 WARNING: the following
>> >> >> dangerous and experimental features are enabled: btrfs
>> >> >> ID CLASS WEIGHT   TYPE NAME              STATUS REWEIGHT PRI-AFF
>> >> >> -1       27.77998 root default
>> >> >> -3       27.77998     datacenter DC1
>> >> >> -6       27.77998         rack 1B06
>> >> >> -5        6.48000             host ceph3
>> >> >>  1        1.84000                 osd.1    down        0 1.00000
>> >> >>  3        4.64000                 osd.3    down        0 1.00000
>> >> >> -2        5.53999             host ceph4
>> >> >>  5        4.64000                 osd.5    down        0 1.00000
>> >> >>  8        0.89999                 osd.8    down        0 1.00000
>> >> >> -4        9.28000             host ceph6
>> >> >>  0        4.64000                 osd.0    down        0 1.00000
>> >> >>  2        4.64000                 osd.2    down        0 1.00000
>> >> >> -7        6.48000             host ceph7
>> >> >>  6        4.64000                 osd.6    down        0 1.00000
>> >> >>  7        1.84000                 osd.7    down        0 1.00000
>> >> >>
>> >> >> The OSD logs all have this message:
>> >> >>
>> >> >> 20235 osdmap REQUIRE_JEWEL OSDMap flag is NOT set; please set it.
>> >> >
>> >> > THis is an annoying corner condition.  12.2.2 (out soon!)  will have a
>> >> > --force option to set the flag even tho no osds are up.  Until then, the
>> >> > workaround is to downgrade one host to jewel, start one jewel osd, then
>> >> > set the flag.  Then upgrade to luminous again and restart all osds.
>> >> >
>> >> > sage
>> >> >
>> >> >
>> >> >>
>> >> >> When I try to set it with "ceph osd set require_jewel_osds" I get this error:
>> >> >>
>> >> >> Error EPERM: not all up OSDs have CEPH_FEATURE_SERVER_JEWEL feature
>> >> >>
>> >> >>
>> >> >>
>> >> >> A "ceph features" returns:
>> >> >>
>> >> >>     "mon": {
>> >> >>         "group": {
>> >> >>             "features": "0x1ffddff8eea4fffb",
>> >> >>             "release": "luminous",
>> >> >>             "num": 4
>> >> >>         }
>> >> >>     },
>> >> >>     "mds": {
>> >> >>         "group": {
>> >> >>             "features": "0x1ffddff8eea4fffb",
>> >> >>             "release": "luminous",
>> >> >>             "num": 1
>> >> >>         }
>> >> >>     },
>> >> >>     "osd": {
>> >> >>         "group": {
>> >> >>             "features": "0x1ffddff8eea4fffb",
>> >> >>             "release": "luminous",
>> >> >>             "num": 8
>> >> >>         }
>> >> >>     },
>> >> >>     "client": {
>> >> >>         "group": {
>> >> >>             "features": "0x1ffddff8eea4fffb",
>> >> >>             "release": "luminous",
>> >> >>             "num": 3
>> >> >>
>> >> >>  # ceph tell osd.* versions
>> >> >> 2017-11-28 02:29:28.565943 7f99c6aee700 -1 WARNING: the following
>> >> >> dangerous and experimental features are enabled: btrfs
>> >> >> 2017-11-28 02:29:28.578956 7f99c6aee700 -1 WARNING: the following
>> >> >> dangerous and experimental features are enabled: btrfs
>> >> >> Error ENXIO: problem getting command descriptions from osd.0
>> >> >> osd.0: problem getting command descriptions from osd.0
>> >> >> Error ENXIO: problem getting command descriptions from osd.1
>> >> >> osd.1: problem getting command descriptions from osd.1
>> >> >> Error ENXIO: problem getting command descriptions from osd.2
>> >> >> osd.2: problem getting command descriptions from osd.2
>> >> >> Error ENXIO: problem getting command descriptions from osd.3
>> >> >> osd.3: problem getting command descriptions from osd.3
>> >> >> Error ENXIO: problem getting command descriptions from osd.5
>> >> >> osd.5: problem getting command descriptions from osd.5
>> >> >> Error ENXIO: problem getting command descriptions from osd.6
>> >> >> osd.6: problem getting command descriptions from osd.6
>> >> >> Error ENXIO: problem getting command descriptions from osd.7
>> >> >> osd.7: problem getting command descriptions from osd.7
>> >> >> Error ENXIO: problem getting command descriptions from osd.8
>> >> >> osd.8: problem getting command descriptions from osd.8
>> >> >>
>> >> >>  # ceph daemon osd.1 status
>> >> >>
>> >> >>     "cluster_fsid": "CENSORED",
>> >> >>     "osd_fsid": "CENSORED",
>> >> >>     "whoami": 1,
>> >> >>     "state": "preboot",
>> >> >>     "oldest_map": 19482,
>> >> >>     "newest_map": 20235,
>> >> >>     "num_pgs": 141
>> >> >>
>> >> >>  # ceph -s
>> >> >> 2017-11-27 22:04:10.372471 7f89a3935700 -1 WARNING: the following
>> >> >> dangerous and experimental features are enabled: btrfs
>> >> >> 2017-11-27 22:04:10.375709 7f89a3935700 -1 WARNING: the following
>> >> >> dangerous and experimental features are enabled: btrfs
>> >> >>   cluster:
>> >> >>     id:     CENSORED
>> >> >>     health: HEALTH_ERR
>> >> >>             513 pgs are stuck inactive for more than 60 seconds
>> >> >>             126 pgs backfill_wait
>> >> >>             52 pgs backfilling
>> >> >>             435 pgs degraded
>> >> >>             513 pgs stale
>> >> >>             435 pgs stuck degraded
>> >> >>             513 pgs stuck stale
>> >> >>             435 pgs stuck unclean
>> >> >>             435 pgs stuck undersized
>> >> >>             435 pgs undersized
>> >> >>             recovery 854719/3688140 objects degraded (23.175%)
>> >> >>             recovery 838607/3688140 objects misplaced (22.738%)
>> >> >>             mds cluster is degraded
>> >> >>             crush map has straw_calc_version=0
>> >> >>
>> >> >>   services:
>> >> >>     mon: 4 daemons, quorum 0,1,3,2
>> >> >>     mgr: 0(active), standbys: 1, 5
>> >> >>     mds: cephfs-1/1/1 up  {0=a=up:replay}, 1 up:standby
>> >> >>     osd: 8 osds: 0 up, 0 in
>> >> >>
>> >> >>   data:
>> >> >>     pools:   7 pools, 513 pgs
>> >> >>     objects: 1199k objects, 4510 GB
>> >> >>     usage:   13669 GB used, 15150 GB / 28876 GB avail
>> >> >>     pgs:     854719/3688140 objects degraded (23.175%)
>> >> >>              838607/3688140 objects misplaced (22.738%)
>> >> >>              257 stale+active+undersized+degraded
>> >> >>              126 stale+active+undersized+degraded+remapped+backfill_wait
>> >> >>              78  stale+active+clean
>> >> >>              52  stale+active+undersized+degraded+remapped+backfilling
>> >> >>
>> >> >>
>> >> >> I ran "ceph auth list", and client.admin has the following permissions.
>> >> >> auid: 0
>> >> >> caps: [mds] allow
>> >> >> caps: [mgr] allow *
>> >> >> caps: [mon] allow *
>> >> >> caps: [osd] allow *
>> >> >>
>> >> >> Thank you for your time.
>> >> >>
>> >> >> Is there any way I can get these OSDs to join the cluster now, or
>> >> >> recover my data?
>> >> >>
>> >> >> Cary
>> >> >> -Dynamic
>> >> >> --
>> >> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> >> >> the body of a message to majordomo@vger.kernel.org
>> >> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> >> >>
>> >> >>
>> >>
>> >>
>>
>>
