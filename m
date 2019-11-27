From: Vincent Godin <vince.mlist-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: mimic 13.2.6 too much broken connexions
Date: Wed, 27 Nov 2019 16:31:14 +0100
Message-ID: <CAL2-6b+A2tQd=pMoXRewK2KeakDpy0X40vDg0OTWk-ZAm5RfmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-a8pt6IJUokc@public.gmane.org>
List-Archive: <https://lists.ceph.io/hyperkitty/list/ceph-users-a8pt6IJUokc@public.gmane.org/>
List-Help: <mailto:ceph-users-request-a8pt6IJUokc@public.gmane.org?subject=help>
List-Post: <mailto:ceph-users-a8pt6IJUokc@public.gmane.org>
List-Subscribe: <mailto:ceph-users-join-a8pt6IJUokc@public.gmane.org>
List-Unsubscribe: <mailto:ceph-users-leave-a8pt6IJUokc@public.gmane.org>
To: ceph-users-a8pt6IJUokc@public.gmane.org, Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Till i submit the mail below few days ago, we found some clues
We observed a lot of lossy connexion like :
ceph-osd.9.log:2019-11-27 11:03:49.369 7f6bb77d0700  0 --
192.168.4.181:6818/2281415 >> 192.168.4.41:0/1962809518
conn(0x563979a9f600 :6818   s=STATE_ACCEPTING_WAIT_CONNECT_MSG_AUTH
pgs=0 cs=0 l=1).handle_connect_msg accept replacing existing (lossy)
channel (new one lossy=1)
We raised the log of the messenger to 5/5 and observed for the whole
cluster more than 80 000 lossy connexion per minute !!!
We adjusted  the "ms_tcp_read_timeout" from 900 to 60 sec then no more
lossy connexion in logs nor health check failed
It's just a workaround but there is a real problem with these broken
sessions and it leads to two
assertions :
- Ceph take too much time to detect broken session and should recycle quicker !
- The reasons for these broken sessions ?

We have a other mimic cluster on different hardware and observed the
same behavior : lot of lossy sessions, slow ops and co.
Symptoms are the same :
- some OSDs on one host have no response from an other osd on a different hosts
- after some time, slow ops are detected
- sometime it leads to ioblocked
- after about 15mn the problem vanish

-----------

Help on diag needed : heartbeat_failed

We encounter a strange behavior on our Mimic 13.2.6 cluster. A any
time, and without any load, some OSDs become unreachable from only
some hosts. It last 10 mn and then the problem vanish.
It 's not always the same OSDs and the same hosts. There is no network
failure on any of the host (because only some OSDs become unreachable)
nor disk freeze as we can see in our grafana dashboard. Logs message
are :
first msg :
2019-11-24 09:19:43.292 7fa9980fc700 -1 osd.596 146481
heartbeat_check: no reply from 192.168.6.112:6817 osd.394 since back
2019-11-24 09:19:22.761142 front 2019-11-24 09:19:39.769138 (cutoff
2019-11-24 09:19:23.293436)
last msg:
2019-11-24 09:30:33.735 7f632354f700 -1 osd.591 146481
heartbeat_check: no reply from 192.168.6.123:6828 osd.600 since back
2019-11-24 09:27:05.269330 front 2019-11-24 09:30:33.214874 (cutoff
2019-11-24 09:30:13.736517)
During this time, 3 hosts were involved : host-18, host-20 and host-30 :
host-30 is the only one who can't see osds 346,356,and 352 on host-18
host-30 is the only one who can't see osds 387 and 394 on host-20
host-18 is the only one who can't see osds 583, 585, 591 and 597 on host-30
We can't see any strange behavior on hosts 18, 20 and 30 in our node
exporter data during this time
Any ideas or advices ?
_______________________________________________
ceph-users mailing list -- ceph-users-a8pt6IJUokc@public.gmane.org
To unsubscribe send an email to ceph-users-leave-a8pt6IJUokc@public.gmane.org
