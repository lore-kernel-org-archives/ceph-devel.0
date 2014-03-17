From: John Spray <john.spray@inktank.com>
Subject: Re: Problem with MDS respawning (up:replay)
Date: Mon, 17 Mar 2014 16:58:37 +0000
Message-ID: <CAGd4Wr0s2kqKM=o1urTgphHds2EhLGgfrLkqcY+f6X5T5KkPyg@mail.gmail.com>
References: <E0E280CCE0E1A44898C992A9190D929A59E976@MBX02-TPM.mimos.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:61623 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756315AbaCQQ6i convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Mar 2014 12:58:38 -0400
Received: by mail-pa0-f53.google.com with SMTP id ld10so5931576pab.40
        for <ceph-devel@vger.kernel.org>; Mon, 17 Mar 2014 09:58:37 -0700 (PDT)
In-Reply-To: <E0E280CCE0E1A44898C992A9190D929A59E976@MBX02-TPM.mimos.local>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Luke Jing Yuan <jyluke@mimos.my>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Luke,

I've responded to your colleague on ceph-users (I'm assuming this is
the same issue).

John

On Mon, Mar 17, 2014 at 4:00 PM, Luke Jing Yuan <jyluke@mimos.my> wrote:
> Dear all,
>
> We had been running our cluster for at least 1.5 months without any issues but something really bad happened yesterday with the MDS and we really look forward for some guidance/pointer on how this may be resolved urgently.
>
> Anyway, we started to noticed the following messages repeating in MDS log:
> # cat /var/log/ceph/ceph-mds.mon01.log
> 2014-03-16 18:40:41.894404 7f0f2875c700  0 mds.0.server handle_client_file_setlock: start: 0, length: 0, client: 324186, pid: 30684, pid_ns: 18446612141968944256, type: 4
>
> 2014-03-16 18:49:09.993985 7f0f24645700  0 -- x.x.x.x:6801/3739 >> y.y.y.y:0/1662262473 pipe(0x728d2780 sd=26 :6801 s=0 pgs=0 cs=0 l=0 c=0x100adc6e0).accept peer addr is really y.y.y.y:0/1662262473 (socket is y.y.y.y:33592/0)
> 2014-03-16 18:49:10.000197 7f0f24645700  0 -- x.x.x.x:6801/3739 >> y.y.y.y:0/1662262473 pipe(0x728d2780 sd=26 :6801 s=0 pgs=0 cs=0 l=0 c=0x100adc6e0).accept connect_seq 0 vs existing 1 state standby
> 2014-03-16 18:49:10.000239 7f0f24645700  0 -- x.x.x.x:6801/3739 >> y.y.y.y:0/1662262473 pipe(0x728d2780 sd=26 :6801 s=0 pgs=0 cs=0 l=0 c=0x100adc6e0).accept peer reset, then tried to connect to us, replacing
> 2014-03-16 18:49:10.550726 7f4c34671780  0 ceph version 0.72.2 (a913ded2ff138aefb8cb84d347d72164099cfd60), process ceph-mds, pid 13282
> 2014-03-16 18:49:10.826713 7f4c2f6f8700  1 mds.-1.0 handle_mds_map standby
> 2014-03-16 18:49:10.984992 7f4c2f6f8700  1 mds.0.14 handle_mds_map i am now mds.0.14
> 2014-03-16 18:49:10.985010 7f4c2f6f8700  1 mds.0.14 handle_mds_map state change up:standby --> up:replay
> 2014-03-16 18:49:10.985017 7f4c2f6f8700  1 mds.0.14 replay_start
> 2014-03-16 18:49:10.985024 7f4c2f6f8700  1 mds.0.14  recovery set is
> 2014-03-16 18:49:10.985027 7f4c2f6f8700  1 mds.0.14  need osdmap epoch 3446, have 3445
> 2014-03-16 18:49:10.985030 7f4c2f6f8700  1 mds.0.14  waiting for osdmap 3446 (which blacklists prior instance)
> 2014-03-16 18:49:16.945500 7f4c2f6f8700  0 mds.0.cache creating system inode with ino:100
> 2014-03-16 18:49:16.945747 7f4c2f6f8700  0 mds.0.cache creating system inode with ino:1
> 2014-03-16 18:49:17.358681 7f4c2b5e1700 -1 mds/journal.cc: In function 'void EMetaBlob::replay(MDS*, LogSegment*, MDSlaveUpdate*)' thread 7f4c2b5e1700 time 2014-03-16 18:49:17.356336
> mds/journal.cc: 1316: FAILED assert(i == used_preallocated_ino)
>
> ceph version 0.72.2 (a913ded2ff138aefb8cb84d347d72164099cfd60)
> 1: (EMetaBlob::replay(MDS*, LogSegment*, MDSlaveUpdate*)+0x7587) [0x5af5e7]
> 2: (EUpdate::replay(MDS*)+0x3a) [0x5b67ea]
> 3: (MDLog::_replay_thread()+0x678) [0x79dbb8]
> 4: (MDLog::ReplayThread::entry()+0xd) [0x58bded]
> 5: (()+0x7e9a) [0x7f4c33a96e9a]
> 6: (clone()+0x6d) [0x7f4c3298b3fd]
>
> From ceph -s, we didn't notice any stuck PGs or what not but the following:
> # ceph -s
>     cluster xxxxxxxxxxxxxxxxxxxxxxxxxxxxx
>      health HEALTH_WARN mds cluster is degraded
>      monmap e1: 3 mons at {mon01=x.x.x.x:6789/0,mon02=x.x.x.y:6789/0,mon03=x.x.x.z:6789/0}, election epoch 1210, quorum 0,1,2 mon01,mon02,mon03
>      mdsmap e17020: 1/1/1 up {0=mon01=up:replay}, 2 up:standby
>      osdmap e20195: 24 osds: 24 up, 24 in
>       pgmap v1424671: 3300 pgs, 6 pools, 793 GB data, 3284 kobjects
>             1611 GB used, 87636 GB / 89248 GB avail
>                 3300 active+clean
>   client io 2750 kB/s rd, 0 op/s
>
> We also noticed in our syslog (dmesg actually) that the MDS services had been flapping:
> [5165030.941804] init: ceph-mds (ceph/mon01) main process (2264) killed by ABRT signal
> [5165030.941919] init: ceph-mds (ceph/mon01) main process ended, respawning
> [5165040.907291] init: ceph-mds (ceph/mon01) main process (2302) killed by ABRT signal
> [5165040.907363] init: ceph-mds (ceph/mon01) main process ended, respawning
> [5165050.860593] init: ceph-mds (ceph/mon01) main process (2346) killed by ABRT signal
> [5165050.860670] init: ceph-mds (ceph/mon01) main process ended, respawning
>
> More info from "ceph df":
> GLOBAL:
>     SIZE       AVAIL      RAW USED     %RAW USED
>     89248G     87636G     1611G        1.81
>
> POOLS:
>     NAME        ID      USED     %USED  OBJECTS
>     Data                0       9387M   0.01            2350
>     metadata    1        941M   0               547003
>     rbd         2       0       0               0
>     backuppc    4       783G    0.88            2813040
>     mysqlfs     5       114M    0               1278
>     mysqlrbd    6       0       0               0
>
> Appreciate if someone would able to enlighten us on a possible solution to this. Thanks in advance.
>
> Regards,
> Luke
>
>
> ________________________________
> DISCLAIMER:
>
>
> This e-mail (including any attachments) is for the addressee(s) only and may be confidential, especially as regards personal data. If you are not the intended recipient, please note that any dealing, review, distribution, printing, copying or use of this e-mail is strictly prohibited. If you have received this email in error, please notify the sender immediately and delete the original message (including any attachments).
>
>
> MIMOS Berhad is a research and development institution under the purview of the Malaysian Ministry of Science, Technology and Innovation. Opinions, conclusions and other information in this e-mail that do not relate to the official business of MIMOS Berhad and/or its subsidiaries shall be understood as neither given nor endorsed by MIMOS Berhad and/or its subsidiaries and neither MIMOS Berhad nor its subsidiaries accepts responsibility for the same. All liability arising from or in connection with computer viruses and/or corrupted e-mails is excluded to the fullest extent permitted by law.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
