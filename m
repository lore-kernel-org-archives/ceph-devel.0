From: huang jun <hjwsm1989@gmail.com>
Subject: Re: ceph authenticate problem
Date: Tue, 24 May 2011 12:51:12 +0800
Message-ID: <BANLkTikJ70WUFtrLWNr8=-=MY8hZWPsu3Q@mail.gmail.com>
References: <BANLkTinpu+Gq4CeXzpbZ-V8t8UzOH2trhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48278 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303Ab1EXEvN convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 May 2011 00:51:13 -0400
Received: by wwa36 with SMTP id 36so6898302wwa.1
        for <ceph-devel@vger.kernel.org>; Mon, 23 May 2011 21:51:12 -0700 (PDT)
In-Reply-To: <BANLkTinpu+Gq4CeXzpbZ-V8t8UzOH2trhQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: biyan chen <riby.chen@gmail.com>
Cc: ceph-devel@vger.kernel.org

 hi
 there are two [global] sections in your ceph.conf
 i do not know why you didn't have admin_keyring.bin in you /data/mon0,
maybe you should restart the whole cluster after you assured configure
file is right

=D4=DA 2011=C4=EA5=D4=C223=C8=D5 =CF=C2=CE=E73:48=A3=ACbiyan chen <riby=
=2Echen@gmail.com> =D0=B4=B5=C0=A3=BA
> ;
> ; Sample ceph ceph.conf file.
> ;
> ; This file defines cluster membership, the various locations
> ; that Ceph stores data, and any other runtime options.
>
> ; If a 'host' is defined for a daemon, the start/stop script will
> ; verify that it matches the hostname (or else ignore it).  If it is
> ; not defined, it is assumed that the daemon is intended to start on
> ; the current host (e.g., in a setup with a startup.conf on each
> ; node).
>
> ; global
> [global]
>        ; enable secure authentication
>        auth supported =3D cephx
>        keyring =3D /use/local/etc/ceph/keyring.bin
>
>
>        ; allow ourselves to open a lot of files
>        max open files =3D 131072
>
>        ; set up logging
> "/usr/local/etc/ceph/ceph.conf" 98L, 2601C
> ;
> ; Sample ceph ceph.conf file.
> ;
> ; This file defines cluster membership, the various locations
> ; that Ceph stores data, and any other runtime options.
>
> ; If a 'host' is defined for a daemon, the start/stop script will
> ; verify that it matches the hostname (or else ignore it).  If it is
> ; not defined, it is assumed that the daemon is intended to start on
> ; the current host (e.g., in a setup with a startup.conf on each
> ; node).
>
> ; global
> [global]
>        ; enable secure authentication
>        auth supported =3D cephx
>        keyring =3D /use/local/etc/ceph/keyring.bin
>
>
>        ; allow ourselves to open a lot of files
>        max open files =3D 131072
>
>        ; set up logging
>        log file =3D /var/log/ceph/$name.log
>
>        ; set up pid files
>        pid file =3D /var/run/ceph/$name.pid
>
> ; monitors
> ;  You need at least one.  You need at least three if you want to
> ;  tolerate any node failures.  Always create an odd number.
> [mon]
>        mon data =3D /data/mon$id
>
>        ; logging, for debugging monitor crashes, in order of
>        ; their likelihood of being helpful :)
>        ;debug ms =3D 1
>        ;debug mon =3D 20
>        ;debug paxos =3D 20
>        ;debug auth =3D 20
>
> [mon.0]
>        host =3D ceph_mon0
>        mon addr =3D 192.168.0.211:6789
>
> ; mds
> ;  You need at least one.  Define two to get a standby.
> [mds]
>        ; where the mds keeps it's secret encryption keys
>        keyring =3D /usr/local/etc/ceph/keyring.$name
>
>        ; mds logging to debug issues.
>        ;debug ms =3D 1
>        ;debug mds =3D 20
>
> [mds.alpha]
>        host =3D ceph_mds0
>
> ; osd
> ;  You need at least one.  Two if you want data to be replicated.
> ;  Define as many as you like.
> [osd]
>        ; This is where the btrfs volume will be mounted.
>        osd data =3D /data/osd$id
>        keyring =3D /usr/local/etc/ceph/keyring.$name
>
>
>        ; Ideally, make this a separate disk or partition.  A few
>        ; hundred MB should be enough; more if you have fast or many
>        ; disks.  You can use a file under the osd data dir if need be
>        ; (e.g. /data/osd$id/journal), but it will be slower than a
>        ; separate disk or partition.
>
>        ; This is an example of a file-based journal.
>        osd journal =3D /data/osd$id/journal
>        osd journal size =3D 1000 ; journal size, in megabytes
>
>        ; osd logging to debug osd issues, in order of likelihood of b=
eing
>        ; helpful
>        ;debug ms =3D 1
>        ;debug osd =3D 20
>        ;debug filestore =3D 20
>        ;debug journal =3D 20
>
> [osd.0]
>        host =3D ceph_osd0
>
>        ; if 'btrfs devs' is not specified, you're responsible for
>        ; setting up the 'osd data' dir.  if it is not btrfs, things
>        ; will behave up until you try to recover from a crash (which
>        ; usually fine for basic testing).
>        btrfs devs =3D /dev/sda7
>
>
> [osd.1]
>        host =3D ceph_osd1
>        btrfs devs =3D /dev/sda7
>
>
>
> log:
> [root@ceph_mon0 ~]# ceph mon stat -c /usr/local/etc/ceph/ceph.conf
> 2011-05-23 11:44:47.078662 7fb266bf8720 unable to authenticate as cli=
ent.admin
> 2011-05-23 11:44:47.079037 7fb266bf8720 ceph_tool_common_init failed.
>
> [root@ceph_mds0 ~]# tail /var/log/ceph/mds.alpha.log -f
> 2011-05-23 23:44:53.464262 7fb0ce956710 -- 192.168.0.207:6800/29302 >=
>
> 192.168.0.211:6789/0 pipe(0x26c1a00 sd=3D5 pgs=3D0 cs=3D0 l=3D0).faul=
t first
> fault
> 2011-05-23 23:44:56.464402 7fb0ce855710 -- 192.168.0.207:6800/29302 >=
>
> 192.168.0.211:6789/0 pipe(0x26d3280 sd=3D5 pgs=3D0 cs=3D0 l=3D0).faul=
t first
> fault
> 2011-05-23 23:44:59.464492 7fb0ce956710 -- 192.168.0.207:6800/29302 >=
>
> 192.168.0.211:6789/0 pipe(0x26c3c80 sd=3D5 pgs=3D0 cs=3D0 l=3D0).faul=
t first
> fault
> 2011-05-23 23:45:02.464787 7fb0ce855710 -- 192.168.0.207:6800/29302 >=
>
> 192.168.0.211:6789/0 pipe(0x26cec80 sd=3D6 pgs=3D0 cs=3D0 l=3D0).faul=
t first
> fault
> 2011-05-23 23:45:05.464941 7fb0cfd58710 mds-1.0 ms_handle_connect on
> 192.168.0.211:6789/0
> 2011-05-23 23:45:05.465405 7fb0cfd58710 cannot convert AES key for NS=
S: -8023
> 2011-05-23 23:45:05.465946 7fb0cfd58710 cannot convert AES key for NS=
S: -8023
> 2011-05-23 23:45:05.465969 7fb0cfd58710 error from decrypt -22
> 2011-05-23 23:45:05.465998 7fb0cfd58710 cephx:
> verify_service_ticket_reply failed decode_decrypt with secret
> AQB4R9pNEJ/lFRAAdsRa+EFMA00acC28x9Fj7A=3D=3D
> 2011-05-23 23:45:05.466010 7fb0cfd58710 cephx client: could not verif=
y
> service_ticket reply
>
> [root@ceph_osd0 ~]# tail /var/log/ceph/osd.0.log -f
> 2011-05-23 23:43:45.583183 7f5b2f383710 -- 192.168.0.208:6800/30745 >=
>
> 192.168.0.211:6789/0 pipe(0xf79280 sd=3D12 pgs=3D0 cs=3D0 l=3D0).faul=
t first
> fault
> 2011-05-23 23:43:48.583357 7f5b32689710 -- 192.168.0.208:6800/30745 >=
>
> 192.168.0.211:6789/0 pipe(0xf79000 sd=3D12 pgs=3D0 cs=3D0 l=3D0).faul=
t first
> fault
> 2011-05-23 23:43:51.583412 7f5b2f383710 -- 192.168.0.208:6800/30745 >=
>
> 192.168.0.211:6789/0 pipe(0xf79280 sd=3D13 pgs=3D0 cs=3D0 l=3D0).faul=
t first
> fault
> 2011-05-23 23:43:54.583548 7f5b32689710 -- 192.168.0.208:6800/30745 >=
>
> 192.168.0.211:6789/0 pipe(0xf79000 sd=3D12 pgs=3D0 cs=3D0 l=3D0).faul=
t first
> fault
> 2011-05-23 23:43:57.583842 7f5b2f383710 -- 192.168.0.208:6800/30745 >=
>
> 192.168.0.211:6789/0 pipe(0xf79280 sd=3D12 pgs=3D0 cs=3D0 l=3D0).faul=
t first
> fault
> 2011-05-23 23:44:00.584629 7f5b34f8e710 cannot convert AES key for NS=
S: -8023
> 2011-05-23 23:44:00.585262 7f5b34f8e710 cannot convert AES key for NS=
S: -8023
> 2011-05-23 23:44:00.585290 7f5b34f8e710 error from decrypt -22
> 2011-05-23 23:44:00.585312 7f5b34f8e710 cephx:
> verify_service_ticket_reply failed decode_decrypt with secret
> AQAqR9pNUNJ2IBAAp16KszdsZHCwEf5IOcoSdw=3D=3D
> 2011-05-23 23:44:00.585322 7f5b34f8e710 cephx client: could not verif=
y
> service_ticket reply
>
> Do we have such problems? If you give me some help,
>
> thank you=A3=A1
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
