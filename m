From: Loic Dachary <loic@dachary.org>
Subject: Re: tracking down failed eviction
Date: Tue, 11 Aug 2015 16:52:11 +0200
Message-ID: <55CA0C1B.7090600@dachary.org>
References: <55C9DD3C.8020607@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="HCJ3TqBVj8U7nlSu8x9geg02keFlN6ViC"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:36564 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964954AbbHKOwX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Aug 2015 10:52:23 -0400
In-Reply-To: <55C9DD3C.8020607@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Shylesh Kumar <shmohan@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HCJ3TqBVj8U7nlSu8x9geg02keFlN6ViC
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

In your cluster there is:

GLOBAL:
    SIZE      AVAIL     RAW USED     %RAW USED=20
    8334G     8333G        1280M          0.02=20
POOLS:
    NAME       ID     USED     %USED     MAX AVAIL     OBJECTS=20
    rbd        0         0         0         2777G           0=20
    mypool     1       135         0         2777G           2=20
    sample     2         0         0         1851G           0=20
    slow       3      295M         0         1851G          84=20
    fast       4       498         0         1851G           6=20

After running

rados -p fast cache-flush-evict-all

Then I do the following:

   rados -p slow put loic1 /etc/group

   ceph df
    fast       4      1371         0         1851G           8

I'm assuming the extra object (6 objects + 1 for loic1 + 1 other ) is an =
internal hit set.

   rados -p slow put loic2 /etc/group

   ceph df
    fast       4      1455         0         1851G           9

There I have 2 objects in the fast pool. I sleep 120 seconds and I see it=
 going back to 8

   ceph df
    fast       4       666         0         1851G           8=20

Which is consistent with the settings of the pool that only allow for one=
 object to stay in the fast pool as reported with ceph report:

            {
                "pool": 4,
                "pool_name": "fast",
                "flags": 9,
                "flags_names": "hashpspool,incomplete_clones",
                "type": 1,
                "size": 3,
                "min_size": 2,
                "crush_ruleset": 1,
                "object_hash": 2,
                "pg_num": 128,
                "pg_placement_num": 128,
                "crash_replay_interval": 0,
                "last_change": "79",
                "last_force_op_resend": "0",
                "auid": 0,
                "snap_mode": "selfmanaged",
                "snap_seq": 0,
                "snap_epoch": 67,
                "pool_snaps": [],
                "removed_snaps": "[]",
                "quota_max_bytes": 0,
                "quota_max_objects": 0,
                "tiers": [],
                "tier_of": 3,
                "read_tier": -1,
                "write_tier": -1,
                "cache_mode": "writeback",
                "target_max_bytes": 1000,
                "target_max_objects": 1,
                "cache_target_dirty_ratio_micro": 500000,
                "cache_target_full_ratio_micro": 800000,
                "cache_min_flush_age": 300,
                "cache_min_evict_age": 0,
                "erasure_code_profile": "cache",
                "hit_set_params": {
                    "type": "bloom",
                    "false_positive_probability": 0.050000,
                    "target_size": 0,
                    "seed": 0
                },
                "hit_set_period": 600,
                "hit_set_count": 1,
                "min_read_recency_for_promote": 0,
                "stripe_width": 0,
                "expected_num_objects": 0
            }

I'm not entirely sure the explanation for the remaining 6 objects (i.e. t=
hem being internal objects used to store the hit set) is right. Let say i=
t is right, is there more unexplained behavior ?

Cheers

For the record: https://github.com/ceph/ceph/blob/hammer/src/osd/Replicat=
edPG.cc#L10494  bool ReplicatedPG::agent_work

On 11/08/2015 13:32, Loic Dachary wrote:
> Hi Shylesh,
>=20
>=20
> I ran the following on a hammer compiled from sources.
>=20
>     ./stop.sh=20
>     rm -fr out dev ; MON=3D1 OSD=3D3 ./vstart.sh -X -d -n -l mon osd
>=20
>     ceph osd pool create slow  1 1
>     ceph osd pool create fast  1 1
>     ceph osd tier add slow fast
>     ceph osd tier cache-mode fast writeback
>     ceph osd tier set-overlay slow fast
>     ceph osd pool set fast hit_set_type bloom
>     ceph osd pool set fast cache_target_dirty_ratio 0.05
>     ceph osd pool set fast cache_min_flush_age 300
>     rados -p slow put obj1 /etc/group
>     ceph osd pool set fast cache_target_dirty_ratio .5
>     ceph osd pool set  fast cache_target_full_ratio .8
>     ceph osd pool set fast target_max_objects  1
>     rados -p slow put obj2 /etc/group
>     rados -p slow put obj3 /etc/group
>     ceph osd pool set fast hit_set_count 1
>     ceph osd pool set fast hit_set_period 5
>     ceph osd pool set fast hit_set_period 600
>=20
>     sleep 30
>=20
>     ceph df
>     ceph health detail
>=20
>=20
> and the output shows it works (see below). I'll try to figure out the d=
ifference with your cluster now that I have a baseline that does the righ=
t thing :-) If you can think of something else you did that may explain t=
he failure, please let me know.
>=20
> $ bash -x /tmp/bug.sh
> + ./stop.sh
> + rm -fr out dev
> + MON=3D1
> + OSD=3D3
> + ./vstart.sh -X -d -n -l mon osd
> ** going verbose **
> ip 127.0.0.1
> port=20
>=20
> NOTE: hostname resolves to loopback; remote hosts will not be able to
>   connect.  either adjust /etc/hosts, or edit this script to use your
>   machine's real IP.
>=20
> creating /home/loic/software/ceph/ceph/src/keyring
> ./monmaptool --create --clobber --add a 127.0.0.1:6789 --print /tmp/cep=
h_monmap.24142
> ./monmaptool: monmap file /tmp/ceph_monmap.24142
> ./monmaptool: generated fsid 1d4a5e92-e47c-4f79-9390-07614b8d261a
> epoch 0
> fsid 1d4a5e92-e47c-4f79-9390-07614b8d261a
> last_changed 2015-08-11 13:26:52.958438
> created 2015-08-11 13:26:52.958438
> 0: 127.0.0.1:6789/0 mon.a
> ./monmaptool: writing epoch 0 to /tmp/ceph_monmap.24142 (1 monitors)
> rm -rf /home/loic/software/ceph/ceph/src/dev/mon.a
> mkdir -p /home/loic/software/ceph/ceph/src/dev/mon.a
> ./ceph-mon --mkfs -c /home/loic/software/ceph/ceph/src/ceph.conf -i a -=
-monmap=3D/tmp/ceph_monmap.24142 --keyring=3D/home/loic/software/ceph/cep=
h/src/keyring
> ./ceph-mon: set fsid to 87413c55-5249-4969-a8fe-f2768e5c59ce
> ./ceph-mon: created monfs at /home/loic/software/ceph/ceph/src/dev/mon.=
a for mon.a
> ./ceph-mon -i a -c /home/loic/software/ceph/ceph/src/ceph.conf
> ERROR: error accessing '/home/loic/software/ceph/ceph/src/dev/osd0/*'
> add osd0 8c8ac2c0-2426-42dd-ac43-c7b1a54a14bc
> *** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***
> 0
> *** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***
> add item id 0 name 'osd.0' weight 1 at location {host=3Dfold,root=3Ddef=
ault} to crush map
> 2015-08-11 13:26:55.473416 7ff1bf4a07c0 -1 journal FileJournal::_open: =
disabling aio for non-block journal.  Use journal_force_aio to force use =
of aio anyway
> 2015-08-11 13:26:56.462509 7ff1bf4a07c0 -1 journal FileJournal::_open: =
disabling aio for non-block journal.  Use journal_force_aio to force use =
of aio anyway
> 2015-08-11 13:26:56.480075 7ff1bf4a07c0 -1 filestore(/home/loic/softwar=
e/ceph/ceph/src/dev/osd0) could not find 23c2fcde/osd_superblock/0//-1 in=
 index: (2) No such file or directory
> 2015-08-11 13:26:57.030312 7ff1bf4a07c0 -1 created object store /home/l=
oic/software/ceph/ceph/src/dev/osd0 journal /home/loic/software/ceph/ceph=
/src/dev/osd0.journal for osd.0 fsid 87413c55-5249-4969-a8fe-f2768e5c59ce=

> 2015-08-11 13:26:57.030372 7ff1bf4a07c0 -1 auth: error reading file: /h=
ome/loic/software/ceph/ceph/src/dev/osd0/keyring: can't open /home/loic/s=
oftware/ceph/ceph/src/dev/osd0/keyring: (2) No such file or directory
> 2015-08-11 13:26:57.030471 7ff1bf4a07c0 -1 created new key in keyring /=
home/loic/software/ceph/ceph/src/dev/osd0/keyring
> adding osd0 key to auth repository
> *** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***
> added key for osd.0
> start osd0
> ./ceph-osd -i 0 -c /home/loic/software/ceph/ceph/src/ceph.conf
> starting osd.0 at :/0 osd_data /home/loic/software/ceph/ceph/src/dev/os=
d0 /home/loic/software/ceph/ceph/src/dev/osd0.journal
> ERROR: error accessing '/home/loic/software/ceph/ceph/src/dev/osd1/*'
> add osd1 a57e7891-c8ca-4a59-92fa-6f65f681a560
> *** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***
> 1
> *** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***
> add item id 1 name 'osd.1' weight 1 at location {host=3Dfold,root=3Ddef=
ault} to crush map
> 2015-08-11 13:27:00.350457 7fc4aa2507c0 -1 journal FileJournal::_open: =
disabling aio for non-block journal.  Use journal_force_aio to force use =
of aio anyway
> 2015-08-11 13:27:01.104445 7fc4aa2507c0 -1 journal FileJournal::_open: =
disabling aio for non-block journal.  Use journal_force_aio to force use =
of aio anyway
> 2015-08-11 13:27:01.117456 7fc4aa2507c0 -1 filestore(/home/loic/softwar=
e/ceph/ceph/src/dev/osd1) could not find 23c2fcde/osd_superblock/0//-1 in=
 index: (2) No such file or directory
> 2015-08-11 13:27:01.826145 7fc4aa2507c0 -1 created object store /home/l=
oic/software/ceph/ceph/src/dev/osd1 journal /home/loic/software/ceph/ceph=
/src/dev/osd1.journal for osd.1 fsid 87413c55-5249-4969-a8fe-f2768e5c59ce=

> 2015-08-11 13:27:01.826194 7fc4aa2507c0 -1 auth: error reading file: /h=
ome/loic/software/ceph/ceph/src/dev/osd1/keyring: can't open /home/loic/s=
oftware/ceph/ceph/src/dev/osd1/keyring: (2) No such file or directory
> 2015-08-11 13:27:01.826277 7fc4aa2507c0 -1 created new key in keyring /=
home/loic/software/ceph/ceph/src/dev/osd1/keyring
> adding osd1 key to auth repository
> *** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***
> added key for osd.1
> start osd1
> ./ceph-osd -i 1 -c /home/loic/software/ceph/ceph/src/ceph.conf
> starting osd.1 at :/0 osd_data /home/loic/software/ceph/ceph/src/dev/os=
d1 /home/loic/software/ceph/ceph/src/dev/osd1.journal
> ERROR: error accessing '/home/loic/software/ceph/ceph/src/dev/osd2/*'
> add osd2 f88f90e0-5796-479c-ac2b-9406f91e55cd
> *** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***
> 2
> *** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***
> add item id 2 name 'osd.2' weight 1 at location {host=3Dfold,root=3Ddef=
ault} to crush map
> 2015-08-11 13:27:05.397800 7f4462e1b7c0 -1 journal FileJournal::_open: =
disabling aio for non-block journal.  Use journal_force_aio to force use =
of aio anyway
> 2015-08-11 13:27:06.808009 7f4462e1b7c0 -1 journal FileJournal::_open: =
disabling aio for non-block journal.  Use journal_force_aio to force use =
of aio anyway
> 2015-08-11 13:27:06.827479 7f4462e1b7c0 -1 filestore(/home/loic/softwar=
e/ceph/ceph/src/dev/osd2) could not find 23c2fcde/osd_superblock/0//-1 in=
 index: (2) No such file or directory
> 2015-08-11 13:27:08.451691 7f4462e1b7c0 -1 created object store /home/l=
oic/software/ceph/ceph/src/dev/osd2 journal /home/loic/software/ceph/ceph=
/src/dev/osd2.journal for osd.2 fsid 87413c55-5249-4969-a8fe-f2768e5c59ce=

> 2015-08-11 13:27:08.451731 7f4462e1b7c0 -1 auth: error reading file: /h=
ome/loic/software/ceph/ceph/src/dev/osd2/keyring: can't open /home/loic/s=
oftware/ceph/ceph/src/dev/osd2/keyring: (2) No such file or directory
> 2015-08-11 13:27:08.454963 7f4462e1b7c0 -1 created new key in keyring /=
home/loic/software/ceph/ceph/src/dev/osd2/keyring
> adding osd2 key to auth repository
> *** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***
> added key for osd.2
> start osd2
> ./ceph-osd -i 2 -c /home/loic/software/ceph/ceph/src/ceph.conf
> starting osd.2 at :/0 osd_data /home/loic/software/ceph/ceph/src/dev/os=
d2 /home/loic/software/ceph/ceph/src/dev/osd2.journal
> started.  stop.sh to stop.  see out/* (e.g. 'tail -f out/????') for deb=
ug output.
>=20
> export PYTHONPATH=3D./pybind
> export LD_LIBRARY_PATH=3D.libs
> + ceph osd pool create slow 1 1
> *** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***
> pool 'slow' created
> + ceph osd pool create fast 1 1
> *** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***
> pool 'fast' created
> + ceph osd tier add slow fast
> *** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***
> pool 'fast' is now (or already was) a tier of 'slow'
> + ceph osd tier cache-mode fast writeback
> *** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***
> set cache-mode for pool 'fast' to writeback
> + ceph osd tier set-overlay slow fast
> *** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***
> overlay for 'slow' is now (or already was) 'fast'
> + ceph osd pool set fast hit_set_type bloom
> *** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***
> set pool 2 hit_set_type to bloom
> + ceph osd pool set fast cache_target_dirty_ratio 0.05
> *** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***
> set pool 2 cache_target_dirty_ratio to 0.05
> + ceph osd pool set fast cache_min_flush_age 300
> *** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***
> set pool 2 cache_min_flush_age to 300
> + rados -p slow put obj1 /etc/group
> + ceph osd pool set fast cache_target_dirty_ratio .5
> *** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***
> set pool 2 cache_target_dirty_ratio to .5
> + ceph osd pool set fast cache_target_full_ratio .8
> *** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***
> set pool 2 cache_target_full_ratio to .8
> + ceph osd pool set fast target_max_objects 1
> *** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***
> set pool 2 target_max_objects to 1
> + rados -p slow put obj2 /etc/group
> + rados -p slow put obj3 /etc/group
> + ceph osd pool set fast hit_set_count 1
> *** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***
> set pool 2 hit_set_count to 1
> + ceph osd pool set fast hit_set_period 5
> *** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***
> set pool 2 hit_set_period to 5
> + ceph osd pool set fast hit_set_period 600
> *** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***
> set pool 2 hit_set_period to 600
> + sleep 30
> + ceph df
> *** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***
> GLOBAL:
>     SIZE     AVAIL      RAW USED     %RAW USED=20
>     547G     56407M         491G         89.92=20
> POOLS:
>     NAME     ID     USED     %USED     MAX AVAIL     OBJECTS=20
>     rbd      0         0         0        18801M           0=20
>     slow     1      3834         0        18801M           3=20
>     fast     2         0         0        18801M           0=20
> + ceph health detail
> *** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***
> HEALTH_WARN 3 near full osd(s); mon.a low disk space
> osd.0 is near full at 89%
> osd.1 is near full at 89%
> osd.2 is near full at 89%
> mon.a low disk space -- 10% avail
>=20
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--HCJ3TqBVj8U7nlSu8x9geg02keFlN6ViC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXKDBsACgkQ8dLMyEl6F22TsACdGpbNZbSVUJ79nW3aYkZRdbZL
Zl8AoLEgNNFlA5FXp3FFqcXYbQXN1a2v
=9vu9
-----END PGP SIGNATURE-----

--HCJ3TqBVj8U7nlSu8x9geg02keFlN6ViC--
