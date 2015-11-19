From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: OSD Recovery Delay Start
Date: Wed, 18 Nov 2015 18:27:05 -0700
Message-ID: <CAANLjFpnMWcje4KXR21z0_SAWzQfkMk-_L3SfOg=TrEJ3bgczw@mail.gmail.com>
References: <CAANLjFohRE4JBjdZMB_0fm+AOvYR5YgC7_0t7J-ZnnHiVONzCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f51.google.com ([209.85.213.51]:33089 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756462AbbKSB1H (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Nov 2015 20:27:07 -0500
Received: by vkbs1 with SMTP id s1so7633022vkb.0
        for <ceph-devel@vger.kernel.org>; Wed, 18 Nov 2015 17:27:05 -0800 (PST)
In-Reply-To: <CAANLjFohRE4JBjdZMB_0fm+AOvYR5YgC7_0t7J-ZnnHiVONzCg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>

I initially did
https://github.com/ceph/ceph/compare/hammer...rldleblanc:delay-start
but looking at the logs deeper the problem isn't here. I think what is
happening is that the OSD is "in" the cluster to start the peering
process with the OSDs, but the clients also see that and start sending
OPs to the OSD, but it hasn't even peered the PGs with other OSDs and
done the necessary housekeeping to even start servicing I/O. Here is
some snippets of the log:

2015-11-18 17:29:40.654255 7fcdc935a900  0 ceph version
0.94.1-116-g63832d4 (63832d4039889b6b704b88b86eaba4aadcfceb2e),
process ceph-osd, pid 16295
2015-11-18 17:29:59.426589 7fcdb2eb8700 10 osd.6 54 boot_epoch is 54
2015-11-18 17:29:59.426599 7fcdb2eb8700  1 osd.6 54 state: booting -> active
2015-11-18 17:29:59.426605 7fcdb2eb8700 10 osd.6 54 write_superblock
sb(050309fd-723e-42aa-9624-3b3e033ab359 osd.6
29e903eb-e9b3-4d4b-b2d1-c366e8ccf362 e54 [1,54] lci=[54,54])
2015-11-18 17:29:59.426735 7fcdb2eb8700  7 osd.6 54 consume_map version 54
2015-11-18 17:29:59.426981 7fcdb2eb8700 20 osd.6 54 should_share_map
client.4347 192.168.55.14:0/7026841 54
2015-11-18 17:29:59.427037 7fcdb2eb8700 15 osd.6 54 enqueue_op
0x3cf5300 prio 63 cost 4096 latency 0.017082
osd_op(client.4347.0:13687 rbd_data.107a2ae8944a.00000000000012a8
[set-alloc-hint object_size 4194304 write_size 4194304,write
2363392~4096] 1.51f699d1 RETRY=1
ack+ondisk+retry+write+known_if_redirected e54) v5
2015-11-18 17:29:59.427094 7fcdb2eb8700 20 osd.6 54 should_share_map
client.4347 192.168.55.14:0/7026841 54
2015-11-18 17:29:59.427121 7fcdb2eb8700 15 osd.6 54 enqueue_op
0x3cf5a00 prio 63 cost 4096 latency 0.011447
osd_op(client.4347.0:13690 rbd_data.107a2ae8944a.0000000000002d8b
[set-alloc-hint object_size 4194304 write_size 4194304,write
2494464~4096] 1.fb89a886 ack+ondisk+write+known_if_redirected e54) v5

many more client ops come in, then it looks like it starts working on
getting PGs online

2015-11-18 17:29:59.429284 7fcdb2eb8700 10 osd.6 pg_epoch: 51 pg[1.d2(
v 51'2239 (0'0,51'2239] local-les=51 n=299 ec=18 les/c 51/51 50/50/45)
[9,10,6] r=2 lpr=51 pi=18-49/10 crt=51'2237 lcod 0'0 inactive NOTIFY]
null
2015-11-18 17:29:59.429333 7fcdb2eb8700 10 osd.6 pg_epoch: 51 pg[1.c(
v 51'2063 (0'0,51'2063] local-les=51 n=291 ec=18 les/c 51/51 50/50/45)
[10,9,6] r=2 lpr=51 pi=18-49/10 crt=51'2061 lcod 0'0 inactive NOTIFY]
null
2015-11-18 17:29:59.429344 7fcd9d360700 10 osd.6 54  new session
0x1386c780 con=0x13895080 addr=192.168.55.16:0/7001172
2015-11-18 17:29:59.429336 7fcd9cf5c700 15 osd.6 54 enqueue_op
0x13a00000 prio 63 cost 4096 latency 0.000201
osd_op(client.4348.0:14205 rbd_data.107a2ae8944a.0000000000000cf0
[set-alloc-hint object_size 4194304 write_size 4194304,write
3944448~4096] 1.ef22991c ack+ondisk+write+known_if_redirected e54) v5
2015-11-18 17:29:59.429408 7fcd9d360700 10 osd.6 54  session
0x1386c780 client.admin has caps osdcap[grant(*)] 'allow *'
2015-11-18 17:29:59.429398 7fcdb2eb8700 10 osd.6 pg_epoch: 51 pg[1.f(
v 51'2758 (0'0,51'2758] local-les=51 n=326 ec=18 les/c 51/51 50/50/45)
[9,6,10] r=1 lpr=51 pi=18-49/10 crt=51'2756 lcod 0'0 inactive NOTIFY]
null
2015-11-18 17:29:59.429409 7fcdaaea8700 10 osd.6 pg_epoch: 51 pg[1.d2(
v 51'2239 (0'0,51'2239] local-les=51 n=299 ec=18 les/c 51/51 50/50/45)
[9,10,6] r=2 lpr=51 pi=18-49/10 crt=51'2237 lcod 0'0 inactive NOTIFY]
handle_advance_map [9,10]/[9,10] -- 9/9
2015-11-18 17:29:59.429445 7fcdaaea8700 20 PGPool::update
cached_removed_snaps [] newly_removed_snaps [] snapc 0=[] (no change)

and later on the slow requests show up

2015-11-18 17:30:29.566726 7fcdbe65e700  0 log_channel(cluster) log
[WRN] : 3 slow requests, 3 included below; oldest blocked for >
30.158141 secs
2015-11-18 17:30:29.566744 7fcdbe65e700  0 log_channel(cluster) log
[WRN] : slow request 30.150919 seconds old, received at 2015-11-18
17:29:59.415673: osd_op(client.4347.0:13690
rbd_data.107a2ae8944a.0000000000002d8b [set-alloc-hint object_size
4194304 write_size 4194304,write 2494464~4096] 1.fb89a886
ack+ondisk+write+known_if_redirected e54) currently waiting for
missing object
2015-11-18 17:30:29.566761 7fcdbe65e700  0 log_channel(cluster) log
[WRN] : slow request 30.095438 seconds old, received at 2015-11-18
17:29:59.471155: osd_op(client.4343.0:13509
rbd_data.10782ae8944a.0000000000002d53 [set-alloc-hint object_size
4194304 write_size 4194304,write 1511424~32768] 1.48a92b9c
ack+ondisk+write+known_if_redirected e54) currently commit_sent
2015-11-18 17:30:29.566772 7fcdbe65e700  0 log_channel(cluster) log
[WRN] : slow request 30.158141 seconds old, received at 2015-11-18
17:29:59.408451: osd_op(client.4356.0:13163
rbd_data.107b2ae8944a.000000000000304a [set-alloc-hint object_size
4194304 write_size 4194304,write 126976~32768] 1.faac176d RETRY=1
ack+ondisk+retry+write+known_if_redirected e54) currently waiting for
degraded object

It seems that there needs to be something to either let the OSDs know
that it is ok to peer with the new OSD, but that clients should not
use it yet. One thought is a new state (up -> in -> active), but that
sounds like a lot of work. The other option would be to send back a
response to the client to use the previous primary because it is not
ready, then have it check again on the next pgmap update or until the
old primary sends back a message that it is no longer the primary. I'm
not sure how complicated that might be.

I like the additional state because we can make sure that all the
housekeeping is done and it reduces the impact of trying to do too
many things at the same time at boot. The second option is more
granular so that is nice too.

I think it would be perfectly ok to wait to do recovery/backfill until
in the active state. I'm not sure of the details of the recovery, but
a combination of the two could allow the recover/backfill to happen to
the newly started primary and once in sync, the I/O can transfer to
the new primary without the delay of having to wait for the object to
be replicated to it.
----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1


On Tue, Nov 17, 2015 at 6:15 PM, Robert LeBlanc <robert@leblancnet.us> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>
> We are having a lot of trouble with the SSD OSDs for our cache tier
> when they reboot. It causes massive blocked I/O when booting the OSD
> and the entire cluster I/O nearly stalls even when the OSD is only
> down for 60 seconds.
>
> I have noticed that when the OSD starts it uses massive amounts of
> RAM, for  the one minute test it used almost 8 GB, another one earlier
> this morning used 14 GB, some last night were in the 10GB range.
> During this time the process is not using much CPU, but the disks are
> very busy writing a good 120-250 MB/s and hundreds to low thousand
> IOPs. Once the memory usage gets down to about 1.5 GB blocked I/O
> starts clearing slowly. At first I thought this was due to preloading
> jemalloc, but it also happens without it.
>
> Looking through [1] I thought osd recovery delay start set to 60
> seconds or longer would allow the OSD to come up, join the cluster, do
> any housekeeping before being in and trying to service I/O requests.
> However, setting the value to 60 does nothing, we see recovery
> operations start less than 30 seconds after the monitor shows the boot
> message. The osd log does not show any kind of delay either.
>
> Is there a bug here or am I understanding this option incorrectly?
>
> What I'm looking for is something to delay any I/O until the peering
> is completed, the PGs have been scanned, all of the house keeping is
> done so that the only load on the OSD/disk is client/recovery I/O. I
> don't want it to try to do both at the same time.
>
> Once the OSD finally comes in and the blocked I/O clears, we can
> manage backfilling and recovery without much impact to the cluster, it
> is just the initial minutes of terror (dozens of blocked I/O > 500
> seconds) that we can't figure out how to get rid of. I understand that
> there will be some impact for recovery, but on our cluster that on
> average does about 10K IOPs, we have less than 5K for 5 minutes (for a
> single OSD that was down for 60 seconds). A host with two SSDs brought
> our cluster to less than 2K IOPs for 15 minutes and took ten minutes
> to get back to normal performance.
>
> [1] http://docs.ceph.com/docs/v0.94/rados/configuration/osd-config-ref/#recovery
>
> Thanks,
> - ----------------
> Robert LeBlanc
> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
> -----BEGIN PGP SIGNATURE-----
> Version: Mailvelope v1.2.3
> Comment: https://www.mailvelope.com
>
> wsFcBAEBCAAQBQJWS9EvCRDmVDuy+mK58QAAzE0P/3jQt3RkDUetTyuu/E3v
> wVwBtcxONs7RQHIEtamNk/eIoGsSS+PevsBK2hSvnIJWNZkhQ3U13HQQ7Hz1
> awkVD3+nw72You09kC772MtAXOIcHDEQgzJHQGoxevLlJSRwIarzyMlkJqrP
> g+WdAx+O3BjtOoPG+6SG1HMDqUjTw46yHkCC2iybjT9y7PBp6PZ8EN1GD+00
> k2+FferROKg/VxKxwQmgWVlXIvnrSF2/bHuZeTOUybw7TWNt1q6ZSXr4ZZuY
> 1e0yUnj8lNMus3SC6Itdj9wBp6Ke1J4tdUZkWiTgMkK5Xykw6iAJCADPIrni
> zck3SfI2XB8XXrNwvuEvuKyAleXAodPf/AbWQ9sfO88MoWFYZ3ibNbbIfAp4
> SEKeZpipzxlvNCm/W2NiDD08jbcaYDqn6dj6fHSHvIelysRItLlojTXuAioZ
> ORQ4JAxPnEfNCUtn/eAq46oVIjrmSPiHs2p2hMYjhANLNYz5tyAt/HNSHXzR
> hnYH9y4TFIOyrB7JcAypkIKwiuGjmoMbR8RvF1hDEJRXAzj7rpePQ9FoNbU/
> /uGIJlwSPEJ8UxK1TuqDJ13XvXfLbR+S1aPjt+Y5LOMYO0pFo4fsdtt8NakM
> ayRsUysGM9n7hBRTWHV5zPg7MB3wjcFv2kaE5NZfwfMNbM2xXkdClYHJ53Zr
> kbpr
> =BJTH
> -----END PGP SIGNATURE-----
