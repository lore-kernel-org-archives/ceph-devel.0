From: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Subject: Problem with radosgw in 0.37
Date: Tue, 8 Nov 2011 09:13:41 +0100
Message-ID: <CAMwB3ThOq=z9ELN+dQkg2pif_Q_CXsJoU2D7wR4MMrnbwSVDYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60588 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753352Ab1KHINn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Nov 2011 03:13:43 -0500
Received: by faan17 with SMTP id n17so243319faa.19
        for <ceph-devel@vger.kernel.org>; Tue, 08 Nov 2011 00:13:41 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Maybe, i have forgot something, but there is no doc about that.

I create a configuration with nginx and radosgw for S3.

On top of radosgw standing nginx witch cache capability. Everything
was ok in version 0.32 of ceph. A have create a new filesystem with a
newest 0.37 version, and now i have some problems.

I run radosgw like this:

radosgw --rgw-socket-path=3D/var/run/radosgw.sock --conf=3D/etc/ceph/ce=
ph.conf

In nginx i talk to unix socket of radosgw. Everything looks good. In
Radosgw-admin i create user, and its ok.

{ "user_id": "0",
  "rados_uid": 0,
  "display_name": "ocd",
  "email": "",
  "suspended": 0,
  "subusers": [],
  "keys": [
        { "user": "0",
          "access_key": "CFLZFEPYUAZV4EZ1P8OJ",
          "secret_key": "HrWN8SNfjXPhUELPLIbRIA3nCfppQjJ5xV6EnhNM"}],

pool name       category                 KB      objects       clones
   degraded      unfound           rd        rd KB           wr
wr KB
=2Eintent-log     -                          1            1            =
0
           0           0            0            0            1
    1
=2Elog            -                         19           18            =
0
           0           0            0            0           39
   39
=2Ergw            -                         20           25            =
0
           0           0            1            0           49
   46
=2Ergw.buckets    -                         19           19            =
0
           0           0           32           15           45
   23
=2Eusers          -                          2            2            =
0
           0           0            0            0            2
    2
=2Eusers.email    -                          1            1            =
0
           0           0            0            0            1
    1
=2Eusers.uid      -                          4            4            =
0
           0           0            3            1            5
    5
data            -                          0            0            0
           0           0            0            0            0
    0
metadata        -                          0            0            0
           0           0            0            0            0
    0
rbd             -                          0            0            0
           0           0            0            0            0
    0
  total used          540000           71
  total avail      174920736
  total space      175460736

But when i testing this with a local s3lib its not working. In nginx ac=
ces log:

127.0.0.1 - - - [08/Nov/2011:09:03:48 +0100] "PUT /nodejs/test01
HTTP/1.1" rlength: 377 bsent: 270 rtime: 0.006 urtime: 0.004 status:
403 bbsent: 103 httpref: "-" useragent: "Mozilla/4.0 (Compatible; s3;
libs3 2.0; Linux x86_64)"
127.0.0.1 - - - [08/Nov/2011:09:03:55 +0100] "PUT /nodejs/test01
HTTP/1.1" rlength: 377 bsent: 270 rtime: 0.006 urtime: 0.004 status:
403 bbsent: 103 httpref: "-" useragent: "Mozilla/4.0 (Compatible; s3;
libs3 2.0; Linux x86_64)"

Request have code 100, waiting for something in radosgw.

s3 -u put nodejs/test01 < /usr/src/libs3-2.0/TODO

ERROR: ErrorAccessDenied

=46rom external s3 client, a have something like that. Somehow bucket
was created, but other operations not working with error access
denied.

<?xml version=3D'1.0' encoding=3D'UTF-8'?>
<Error>
 <Code>AccessDenied</Code>
</Error>

I have some data from s3lib, by a many tries:

                         Bucket                                 Created
--------------------------------------------------------  -------------=
-------
nodejs                                                    2011-11-07T13=
:11:42Z
root@vm-10-177-48-24:/usr/src# s3 -u getacl nodejs
OwnerID 0 ocd
 Type                                      User Identifier
                              Permission
------  ---------------------------------------------------------------=
---------------------------
 ------------
UserID  0 (ocd)
                            FULL_CONTROL
root@vm-10-177-48-24:/usr/src# s3 -u test nodejs
                         Bucket                                  Status
--------------------------------------------------------  -------------=
-------
nodejs                                                    USA
root@vm-10-177-48-24:/usr/src# s3 -u getacl nodejs
OwnerID 0 ocd
 Type                                      User Identifier
                              Permission
------  ---------------------------------------------------------------=
---------------------------
 ------------
UserID  0 (ocd)
                            FULL_CONTROL
root@vm-10-177-48-24:/usr/src# s3 -u list
                         Bucket                                 Created
--------------------------------------------------------  -------------=
-------
nodejs                                                    2011-11-07T13=
:11:42Z


Ceph.conf

; global
[global]
        ; enable secure authentication
        auth supported =3D cephx
        keyring =3D /etc/ceph/keyring.bin

; monitors
;  You need at least one.  You need at least three if you want to
;  tolerate any node failures.  Always create an odd number.
[mon]
        mon data =3D /vol0/data/mon.$id

        ; some minimal logging (just message traffic) to aid debugging

        debug ms =3D 1     ; see message traffic
        debug mon =3D 0   ; monitor
        debug paxos =3D 0 ; monitor replication
        debug auth =3D 0  ;

        mon allowed clock drift =3D 2

[mon.0]
        host =3D vm-10-177-48-24
        mon addr =3D 10.177.48.24:6789

; osd
;  You need at least one.  Two if you want data to be replicated.
;  Define as many as you like.
[osd]
        ; This is where the btrfs volume will be mounted.
        osd data =3D /vol0/data/osd.$id

        ; Ideally, make this a separate disk or partition.  A few GB
        ; is usually enough; more if you have fast disks.  You can use
        ; a file under the osd data dir if need be
        ; (e.g. /data/osd$id/journal), but it will be slower than a
        ; separate disk or partition.
        osd journal =3D /vol0/data/osd.$id/journal

        ; If the OSD journal is a file, you need to specify the size.
This is specified in MB.
        osd journal size =3D 512

        filestore journal writeahead =3D 1
        osd heartbeat grace =3D 5

        debug ms =3D 1         ; message traffic
        debug osd =3D 0
        debug filestore =3D 0 ; local object storage
        debug journal =3D 0   ; local journaling
        debug monc =3D 0
        debug rados =3D 0

[osd.0]
        host =3D vm-10-177-48-24
        osd data =3D /vol0/data/osd.0
        keyring =3D /vol0/data/osd.0/keyring

[osd.1]
        host =3D vm-10-177-48-24
        osd data =3D /vol0/data/osd.1
        keyring =3D /vol0/data/osd.1/keyring


radosgw-admin bucket stats --bucket=3Dnodejs
{ "bucket": "nodejs",
  "pool": ".rgw.buckets",
  "id": 10,
  "marker": "10",
  "owner": "0",
  "usage": { "rgw.main": { "size_kb": 4,
          "num_objects": 1},
      "rgw.shadow": { "size_kb": 4,
          "num_objects": 1}}}

ceph -s
2011-11-08 09:07:12.546715    pg v594: 460 pgs: 460 active+clean; 68
KB data, 527 MB used, 166 GB / 167 GB avail
2011-11-08 09:07:12.547555   mds e1: 0/0/1 up
2011-11-08 09:07:12.547573   osd e12: 2 osds: 2 up, 2 in
2011-11-08 09:07:12.547626   log 2011-11-08 08:31:46.761320 osd.0
10.177.48.24:6800/12063 244 : [INF] 10.3 scrub ok
2011-11-08 09:07:12.547709   mon e1: 1 mons at {0=3D10.177.48.24:6789/0=
}


--=20
-----
Pozdrawiam

S=C5=82awek "sZiBis" Skowron
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
