From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: [ceph-users] Potential OSD deadlock?
Date: Tue, 6 Oct 2015 12:03:00 -0600
Message-ID: <CAANLjFosPfynahiTmC2r=wPGWKg8YQAak58XGt0MfVXC9bmXuw@mail.gmail.com>
References: <CAANLjFpAXaDWQzumg1hCs=SC_0YvdYDd6vyodz5_ZBNvGWdkSw@mail.gmail.com>
	<CAANLjFrDqHhAtWPqBV+QEDcFU6xNum37puO6XHZE0zhNp9reSQ@mail.gmail.com>
	<CAJ4mKGYdJJfFERrOrdN7T8SzhdcyKhSDqJ69wOiee2aVj8vpEA@mail.gmail.com>
	<CAANLjFqbt0y-Ri=q6hXuuS06Sgi1S6phRdb1MJTgR6LTyHPtvw@mail.gmail.com>
	<CAN=+7FVo6D2AoufELCP_qeiJ23i0XEOqQs_yYLrFNXwiiQSthw@mail.gmail.com>
	<alpine.DEB.2.00.1509221450490.11876@cobra.newdream.net>
	<CAANLjFoK4O-3GB_1b40xp-5RtbZhdSXJT5+ydUDX+dq=dBHR8w@mail.gmail.com>
	<CAANLjFrrAyhJ=JR0+K3SX6G1ZsdcUyhTqFzUn_A0+bSh0D=bkA@mail.gmail.com>
	<5602F921.3010204@redhat.com>
	<CAANLjFqTW3750rw6zCnNfcD41GjYxer05m--JAWx-YLnaxcg-Q@mail.gmail.com>
	<CAANLjFrw0AtqvHu5ioRPH7yKjV5ZqfnGKou+fKLTZukLTnLbgw@mail.gmail.com>
	<CAANLjFoafHQ1X8U7LUrvhh2h8fu3WgNpUsMDR+QkSWpfW8ad0g@mail.gmail.com>
	<alpine.DEB.2.00.1510040646020.5233@cobra.newdream.net>
	<CAANLjFqgJbLEsBYEW=bk0h+Lmop-MLX=eA7qx98h-3Z6M1x7_Q@mail.gmail.com>
	<CAANLjFruw-1yySqO=aY05c0bzuqdkBH0-WcKmyP_+JtSyA1kpQ@mail.gmail.com>
	<alpine.DEB.2.00.1510060534010.32037@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f50.google.com ([209.85.213.50]:35955 "EHLO
	mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752193AbbJFSDC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Oct 2015 14:03:02 -0400
Received: by vkfp126 with SMTP id p126so122472258vkf.3
        for <ceph-devel@vger.kernel.org>; Tue, 06 Oct 2015 11:03:00 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1510060534010.32037@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

OK, an interesting point. Running ceph version 9.0.3-2036-g4f54a0d
(4f54a0dd7c4a5c8bdc788c8b7f58048b2a28b9be) looks a lot better. I got
messages when the OSD was marked out:

2015-10-06 11:52:46.961040 osd.13 192.168.55.12:6800/20870 81 :
cluster [WRN] 17 slow requests, 3 included below; oldest blocked for >
34.476006 secs
2015-10-06 11:52:46.961056 osd.13 192.168.55.12:6800/20870 82 :
cluster [WRN] slow request 32.913474 seconds old, received at
2015-10-06 11:52:14.047475: osd_op(client.600962.0:474
rbd_data.338102ae8944a.0000000000005270 [read 3302912~4096] 8.c74a4538
ack+read+known_if_redirected e58744) currently waiting for peered
2015-10-06 11:52:46.961066 osd.13 192.168.55.12:6800/20870 83 :
cluster [WRN] slow request 32.697545 seconds old, received at
2015-10-06 11:52:14.263403: osd_op(client.600960.0:583
rbd_data.3380f74b0dc51.000000000001ee75 [read 1016832~4096] 8.778d1be3
ack+read+known_if_redirected e58744) currently waiting for peered
2015-10-06 11:52:46.961074 osd.13 192.168.55.12:6800/20870 84 :
cluster [WRN] slow request 32.668006 seconds old, received at
2015-10-06 11:52:14.292942: osd_op(client.600955.0:571
rbd_data.3380f74b0dc51.0000000000019b09 [read 1034240~4096] 8.e87a6f58
ack+read+known_if_redirected e58744) currently waiting for peered

But I'm not seeing the blocked messages when the OSD came back in. The
OSD spindles have been running at 100% during this test. I have seen
slowed I/O from the clients as expected from the extra load, but so
far no blocked messages. I'm going to run some more tests.

-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v1.2.0
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJWFAzRCRDmVDuy+mK58QAASRYP/jrbKy5mptq/cSqJvB47
F/gEatsqU4/TwyIJg137DQTkONbHKnLgCZqsJLnCZRH8fFqtvY6g/Q/AA7Ks
ouo5gvbjKM7pOm/uUn8kU44Xe15f/bkVHvWBECZzg8YJwinPAisp5R0m1HBC
HLvsbeqV00m72TyfsZX4aj7lHdyvcdcIH2EVgX/db092VVXczK4q2gRoNr0Y
77BEr2Y/gPj5LM4b/aDG5AWY8dJZRlNz+B1CyLS+kIDXSaAbzul2UbAG6jNE
KJEVxndMPfHLIdwg55+q8VTMIjqXcCM47cQhWFrKChgVD8byJxpc6E0TqOxs
1gtNE8AILoCSYKnwQZan+TBDGxki7rQxzMdNI+NLfhy1Mwd3lSCPsDtD7W/i
tzNTr6aGz+wr+OPDQV5zrzLaPZYF3FLWN4n6RYNfnDramYzD76v+7kjdW4dE
5UVCtE7KGLCZ21fu6sln1b9q6lYXNtohAmAunIdqpo3FmHusRySyZzYKu1+9
zg/LHiArD/ddjkPxVWCTFBS17g/bESRcv2MsA30GS8J6k1zlQaLX5KeGg6Ql
WJSmW8gFfEbXj/7JTrVtQWTdgjsegaySFnDisTWUR/hEM/NuKii4xfjI32M/
luUMXHZ8lTHk9C8MfZcpyPGvwp2FliD9LqaWOVPWtWZJcerEWcZVlEApg4qb
fo5a
=ahEi
-----END PGP SIGNATURE-----
----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1


On Tue, Oct 6, 2015 at 6:37 AM, Sage Weil <sweil@redhat.com> wrote:
> On Mon, 5 Oct 2015, Robert LeBlanc wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA256
>>
>> With some off-list help, we have adjusted
>> osd_client_message_cap=10000. This seems to have helped a bit and we
>> have seen some OSDs have a value up to 4,000 for client messages. But
>> it does not solve the problem with the blocked I/O.
>>
>> One thing that I have noticed is that almost exactly 30 seconds elapse
>> between an OSD boots and the first blocked I/O message. I don't know
>> if the OSD doesn't have time to get it's brain right about a PG before
>> it starts servicing it or what exactly.
>
> I'm downloading the logs from yesterday now; sorry it's taking so long.
>
>> On another note, I tried upgrading our CentOS dev cluster from Hammer
>> to master and things didn't go so well. The OSDs would not start
>> because /var/lib/ceph was not owned by ceph. I chowned the directory
>> and all OSDs and the OSD then started, but never became active in the
>> cluster. It just sat there after reading all the PGs. There were
>> sockets open to the monitor, but no OSD to OSD sockets. I tried
>> downgrading to the Infernalis branch and still no luck getting the
>> OSDs to come up. The OSD processes were idle after the initial boot.
>> All packages were installed from gitbuilder.
>
> Did you chown -R ?
>
>         https://github.com/ceph/ceph/blob/infernalis/doc/release-notes.rst#upgrading-from-hammer
>
> My guess is you only chowned the root dir, and the OSD didn't throw
> an error when it encountered the other files?  If you can generate a debug
> osd = 20 log, that would be helpful.. thanks!
>
> sage
>
>
>>
>> Thanks,
>> -----BEGIN PGP SIGNATURE-----
>> Version: Mailvelope v1.2.0
>> Comment: https://www.mailvelope.com
>>
>> wsFcBAEBCAAQBQJWE0F5CRDmVDuy+mK58QAAaCYQAJuFcCvRUJ46k0rYrMcc
>> YlrSrGwS57GJS/JjaFHsvBV7KTobEMNeMkSv4PTGpwylNV9Dx4Ad74DDqX4g
>> 6hZDe0rE+uEI7tW9Lqp+MN7eaU2lDuwLt/pOzZI14jTskUYTlNi3HjlN67mQ
>> aiX1rbrJL6FFkuMOn/YqHpMbxI5ZOUZc1s7RDhASOPIs4z/CxpDfluW6fZA/
>> y8C+pW6zzS9U/6jZwtGhBq4dvDBO41Lxb9WOehD8Aa/Qt6XNDzGw2KEkEkw7
>> 8dBc7UFa2Wx3Tnzy238a/nKhtz6O6OrHsroA+HGWwCoxPWjOsz/xOoOmfwp+
>> ALkY3id+t2uJEqzbL8/MgJ2RV1A+AZ7W1VWIJUOkDz0wR+KxQsxduHoD6rQy
>> zg0fj2KSAlmVusYOPM1s1+jBsqNF3wcNxpbRoVuFqk0xMgGPrIdUNdZHg6bs
>> D5sfkjNKexFe0ifFJ0cfv6UaGIKv4dK2eq3jUKgXHfh/qZmJbEB+zHaqJNyg
>> CN6w6xu1FHLeVobKAWe5ZzKY5lxw6b8YG+ce/E2dvW73gSASPTvtv68gaT04
>> 2SPF9Ql0fERL5EDY9Pc4MHpQVcS0XxxJA69CgnWgaG6fzq2eY7fALeMBVWlB
>> fRj3zQwqJls/X8JZ3c4P4G0R6DP9bmMwGr++oYc3gWGrvgzxw3N7+ornd0jd
>> GdXC
>> =Aigq
>> -----END PGP SIGNATURE-----
>> ----------------
>> Robert LeBlanc
>> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
>>
>>
>> On Sun, Oct 4, 2015 at 3:04 PM, Robert LeBlanc <robert@leblancnet.us> wrote:
>> > -----BEGIN PGP SIGNED MESSAGE-----
>> > Hash: SHA256
>> >
>> > I have eight nodes running the fio job rbd_test_real to different RBD
>> > volumes. I've included the CRUSH map in the tarball.
>> >
>> > I stopped one OSD process and marked it out. I let it recover for a
>> > few minutes and then I started the process again and marked it in. I
>> > started getting block I/O messages during the recovery.
>> >
>> > The logs are located at http://162.144.87.113/files/ushou1.tar.xz
>> >
>> > Thanks,
>> > -----BEGIN PGP SIGNATURE-----
>> > Version: Mailvelope v1.2.0
>> > Comment: https://www.mailvelope.com
>> >
>> > wsFcBAEBCAAQBQJWEZRcCRDmVDuy+mK58QAALbEQAK5pFiixJarUdLm50zp/
>> > 3AGgGBPrieExKmoZZLCoMGfOLfxZDbN2ybtopKDQDfrTqndE/6Xi9UXqTOdW
>> > jDc9U1wusgG0CKPsY1SMYnB9akvaDwtdh5q5k4VpN2zsG9R6lRojHeNQR3Nf
>> > 56QevJL4/e5lC3sLhVnxXXi2XKnHCVOHT+PYgNour2ZWt6OTLoFFxuSU3zLN
>> > OtfXgrFiiNF0mrDpm0gg2l8a8N5SwP9mM233S2U/JiGAqsqoqkfd0okjDenC
>> > ksesU/n7zordFpfLN3yjL6+X9pQ4YA6otZrq4wWtjWKO/H0b+6iIsf/AE131
>> > R6a4Vufndpd3Ce+FNfM+iu3FmKk0KVfDAaF/tIP6S6XUzGVMAbpvpmqNL17o
>> > boh3wPZEyK+7KiF4Qlt2KoI/FV24Yj8XiyMnKin3MbMYbammb4ER977VH7iI
>> > sZyelNPSsYmmw/MF+AkA5KVgzQ4DAPflaejIgC5uw3dYKrn2AQE5CE9nN8Gz
>> > GVVaGItu1Bvrz21QoT9o5v0dZ85zttFvtrKIYgSi4mdpC6XkzUbg9s9EB1/T
>> > SEY+fau7W7TtiLpzCAIQ3zDvgsvkx2P6tKg5U8e93LVv9B+YI8i8mUxxv1j5
>> > PHFi7KTgRUPm1FPMJDSyzvOgqyMj9AzaESl1Na6k529ILFIcyfko0niTT1oZ
>> > 3EPx
>> > =UDIV
>> > -----END PGP SIGNATURE-----
>> >
>> > ----------------
>> > Robert LeBlanc
>> > PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
>> >
>> >
>> > On Sun, Oct 4, 2015 at 7:48 AM, Sage Weil <sweil@redhat.com> wrote:
>> >> On Sat, 3 Oct 2015, Robert LeBlanc wrote:
>> >>> -----BEGIN PGP SIGNED MESSAGE-----
>> >>> Hash: SHA256
>> >>>
>> >>> We are still struggling with this and have tried a lot of different
>> >>> things. Unfortunately, Inktank (now Red Hat) no longer provides
>> >>> consulting services for non-Red Hat systems. If there are some
>> >>> certified Ceph consultants in the US that we can do both remote and
>> >>> on-site engagements, please let us know.
>> >>>
>> >>> This certainly seems to be network related, but somewhere in the
>> >>> kernel. We have tried increasing the network and TCP buffers, number
>> >>> of TCP sockets, reduced the FIN_WAIT2 state. There is about 25% idle
>> >>> on the boxes, the disks are busy, but not constantly at 100% (they
>> >>> cycle from <10% up to 100%, but not 100% for more than a few seconds
>> >>> at a time). There seems to be no reasonable explanation why I/O is
>> >>> blocked pretty frequently longer than 30 seconds. We have verified
>> >>> Jumbo frames by pinging from/to each node with 9000 byte packets. The
>> >>> network admins have verified that packets are not being dropped in the
>> >>> switches for these nodes. We have tried different kernels including
>> >>> the recent Google patch to cubic. This is showing up on three cluster
>> >>> (two Ethernet and one IPoIB). I booted one cluster into Debian Jessie
>> >>> (from CentOS 7.1) with similar results.
>> >>>
>> >>> The messages seem slightly different:
>> >>> 2015-10-03 14:38:23.193082 osd.134 10.208.16.25:6800/1425 439 :
>> >>> cluster [WRN] 14 slow requests, 1 included below; oldest blocked for >
>> >>> 100.087155 secs
>> >>> 2015-10-03 14:38:23.193090 osd.134 10.208.16.25:6800/1425 440 :
>> >>> cluster [WRN] slow request 30.041999 seconds old, received at
>> >>> 2015-10-03 14:37:53.151014: osd_op(client.1328605.0:7082862
>> >>> rbd_data.13fdcb2ae8944a.000000000001264f [read 975360~4096]
>> >>> 11.6d19c36f ack+read+known_if_redirected e10249) currently no flag
>> >>> points reached
>> >>>
>> >>> I don't know what "no flag points reached" means.
>> >>
>> >> Just that the op hasn't been marked as reaching any interesting points
>> >> (op->mark_*() calls).
>> >>
>> >> Is it possible to gather a lot with debug ms = 20 and debug osd = 20?
>> >> It's extremely verbose but it'll let us see where the op is getting
>> >> blocked.  If you see the "slow request" message it means the op in
>> >> received by ceph (that's when the clock starts), so I suspect it's not
>> >> something we can blame on the network stack.
>> >>
>> >> sage
>> >>
>> >>
>> >>>
>> >>> The problem is most pronounced when we have to reboot an OSD node (1
>> >>> of 13), we will have hundreds of I/O blocked for some times up to 300
>> >>> seconds. It takes a good 15 minutes for things to settle down. The
>> >>> production cluster is very busy doing normally 8,000 I/O and peaking
>> >>> at 15,000. This is all 4TB spindles with SSD journals and the disks
>> >>> are between 25-50% full. We are currently splitting PGs to distribute
>> >>> the load better across the disks, but we are having to do this 10 PGs
>> >>> at a time as we get blocked I/O. We have max_backfills and
>> >>> max_recovery set to 1, client op priority is set higher than recovery
>> >>> priority. We tried increasing the number of op threads but this didn't
>> >>> seem to help. It seems as soon as PGs are finished being checked, they
>> >>> become active and could be the cause for slow I/O while the other PGs
>> >>> are being checked.
>> >>>
>> >>> What I don't understand is that the messages are delayed. As soon as
>> >>> the message is received by Ceph OSD process, it is very quickly
>> >>> committed to the journal and a response is sent back to the primary
>> >>> OSD which is received very quickly as well. I've adjust
>> >>> min_free_kbytes and it seems to keep the OSDs from crashing, but
>> >>> doesn't solve the main problem. We don't have swap and there is 64 GB
>> >>> of RAM per nodes for 10 OSDs.
>> >>>
>> >>> Is there something that could cause the kernel to get a packet but not
>> >>> be able to dispatch it to Ceph such that it could be explaining why we
>> >>> are seeing these blocked I/O for 30+ seconds. Is there some pointers
>> >>> to tracing Ceph messages from the network buffer through the kernel to
>> >>> the Ceph process?
>> >>>
>> >>> We can really use some pointers no matter how outrageous. We've have
>> >>> over 6 people looking into this for weeks now and just can't think of
>> >>> anything else.
>> >>>
>> >>> Thanks,
>> >>> -----BEGIN PGP SIGNATURE-----
>> >>> Version: Mailvelope v1.1.0
>> >>> Comment: https://www.mailvelope.com
>> >>>
>> >>> wsFcBAEBCAAQBQJWEDY1CRDmVDuy+mK58QAARgoP/RcoL1qVmg7qbQrzStar
>> >>> NK80bqYGeYHb26xHbt1fZVgnZhXU0nN0Dv4ew0e/cYJLELSO2KCeXNfXN6F1
>> >>> prZuzYagYEyj1Q1TOo+4h/nOQRYsTwQDdFzbHb/OUDN55C0QGZ29DjEvrqP6
>> >>> K5l6sAQzvQDpUEEIiOCkS6pH59ira740nSmnYkEWhr1lxF/hMjb6fFlfCFe2
>> >>> h1djM0GfY7vBHFGgI3jkw0BL5AQnWe+SCcCiKZmxY6xiR70FWl3XqK5M+nxm
>> >>> iq74y7Dv6cpenit6boMr6qtOeIt+8ko85hVMh09Hkaqz/m2FzxAKLcahzkGF
>> >>> Fh/M6YBzgnX7QBURTC4YQT/FVyDTW3JMuT3RKQdaX6c0iiOsVdkE+iyidWyY
>> >>> Hr1KzWU23Ur9yBfZ39Y43jrsSiAEwHnKjSqMowSGljdTysNEAAZQhlqZIoHb
>> >>> JlgpB39ugkHI1H5fZ5b2SIDz32/d5ywG4Gay9Rk6hp8VanvIrBbev+JYEoYT
>> >>> 8/WX+fhueHt4dqUYWIl3HZ0CEzbXbug0xmFvhrbmL2f3t9XOkDZRbAjlYrGm
>> >>> lswiJMDueY8JkxSnPvCQrHXqjbCcy9rMG7nTnLFz98rTcHNCwtpv0qVYhheg
>> >>> 4YRNRVMbfNP/6xsJvG1wVOSQPwxZSPqJh42pDqMRePJl3Zn66MTx5wvdNDpk
>> >>> l7OF
>> >>> =OI++
>> >>> -----END PGP SIGNATURE-----
>> >>> ----------------
>> >>> Robert LeBlanc
>> >>> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
>> >>>
>> >>>
>> >>> On Fri, Sep 25, 2015 at 2:40 PM, Robert LeBlanc <robert@leblancnet.us> wrote:
>> >>> > We dropped the replication on our cluster from 4 to 3 and it looks
>> >>> > like all the blocked I/O has stopped (no entries in the log for the
>> >>> > last 12 hours). This makes me believe that there is some issue with
>> >>> > the number of sockets or some other TCP issue. We have not messed with
>> >>> > Ephemeral ports and TIME_WAIT at this point. There are 130 OSDs, 8 KVM
>> >>> > hosts hosting about 150 VMs. Open files is set at 32K for the OSD
>> >>> > processes and 16K system wide.
>> >>> >
>> >>> > Does this seem like the right spot to be looking? What are some
>> >>> > configuration items we should be looking at?
>> >>> >
>> >>> > Thanks,
>> >>> > ----------------
>> >>> > Robert LeBlanc
>> >>> > PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
>> >>> >
>> >>> >
>> >>> > On Wed, Sep 23, 2015 at 1:30 PM, Robert LeBlanc <robert@leblancnet.us> wrote:
>> >>> >> -----BEGIN PGP SIGNED MESSAGE-----
>> >>> >> Hash: SHA256
>> >>> >>
>> >>> >> We were able to only get ~17Gb out of the XL710 (heavily tweaked)
>> >>> >> until we went to the 4.x kernel where we got ~36Gb (no tweaking). It
>> >>> >> seems that there were some major reworks in the network handling in
>> >>> >> the kernel to efficiently handle that network rate. If I remember
>> >>> >> right we also saw a drop in CPU utilization. I'm starting to think
>> >>> >> that we did see packet loss while congesting our ISLs in our initial
>> >>> >> testing, but we could not tell where the dropping was happening. We
>> >>> >> saw some on the switches, but it didn't seem to be bad if we weren't
>> >>> >> trying to congest things. We probably already saw this issue, just
>> >>> >> didn't know it.
>> >>> >> - ----------------
>> >>> >> Robert LeBlanc
>> >>> >> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
>> >>> >>
>> >>> >>
>> >>> >> On Wed, Sep 23, 2015 at 1:10 PM, Mark Nelson  wrote:
>> >>> >>> FWIW, we've got some 40GbE Intel cards in the community performance cluster
>> >>> >>> on a Mellanox 40GbE switch that appear (knock on wood) to be running fine
>> >>> >>> with 3.10.0-229.7.2.el7.x86_64.  We did get feedback from Intel that older
>> >>> >>> drivers might cause problems though.
>> >>> >>>
>> >>> >>> Here's ifconfig from one of the nodes:
>> >>> >>>
>> >>> >>> ens513f1: flags=4163  mtu 1500
>> >>> >>>         inet 10.0.10.101  netmask 255.255.255.0  broadcast 10.0.10.255
>> >>> >>>         inet6 fe80::6a05:caff:fe2b:7ea1  prefixlen 64  scopeid 0x20
>> >>> >>>         ether 68:05:ca:2b:7e:a1  txqueuelen 1000  (Ethernet)
>> >>> >>>         RX packets 169232242875  bytes 229346261232279 (208.5 TiB)
>> >>> >>>         RX errors 0  dropped 0  overruns 0  frame 0
>> >>> >>>         TX packets 153491686361  bytes 203976410836881 (185.5 TiB)
>> >>> >>>         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
>> >>> >>>
>> >>> >>> Mark
>> >>> >>>
>> >>> >>>
>> >>> >>> On 09/23/2015 01:48 PM, Robert LeBlanc wrote:
>> >>> >>>>
>> >>> >>>> -----BEGIN PGP SIGNED MESSAGE-----
>> >>> >>>> Hash: SHA256
>> >>> >>>>
>> >>> >>>> OK, here is the update on the saga...
>> >>> >>>>
>> >>> >>>> I traced some more of blocked I/Os and it seems that communication
>> >>> >>>> between two hosts seemed worse than others. I did a two way ping flood
>> >>> >>>> between the two hosts using max packet sizes (1500). After 1.5M
>> >>> >>>> packets, no lost pings. Then then had the ping flood running while I
>> >>> >>>> put Ceph load on the cluster and the dropped pings started increasing
>> >>> >>>> after stopping the Ceph workload the pings stopped dropping.
>> >>> >>>>
>> >>> >>>> I then ran iperf between all the nodes with the same results, so that
>> >>> >>>> ruled out Ceph to a large degree. I then booted in the the
>> >>> >>>> 3.10.0-229.14.1.el7.x86_64 kernel and with an hour test so far there
>> >>> >>>> hasn't been any dropped pings or blocked I/O. Our 40 Gb NICs really
>> >>> >>>> need the network enhancements in the 4.x series to work well.
>> >>> >>>>
>> >>> >>>> Does this sound familiar to anyone? I'll probably start bisecting the
>> >>> >>>> kernel to see where this issue in introduced. Both of the clusters
>> >>> >>>> with this issue are running 4.x, other than that, they are pretty
>> >>> >>>> differing hardware and network configs.
>> >>> >>>>
>> >>> >>>> Thanks,
>> >>> >>>> -----BEGIN PGP SIGNATURE-----
>> >>> >>>> Version: Mailvelope v1.1.0
>> >>> >>>> Comment: https://www.mailvelope.com
>> >>> >>>>
>> >>> >>>> wsFcBAEBCAAQBQJWAvOzCRDmVDuy+mK58QAApOMP/1xmCtW++G11qcE8y/sr
>> >>> >>>> RkXguqZJLc4czdOwV/tjUvhVsm5qOl4wvQCtABFZpc6t4+m5nzE3LkA1rl2l
>> >>> >>>> AnARPOjh61TO6cV0CT8O0DlqtHmSd2y0ElgAUl0594eInEn7eI7crz8R543V
>> >>> >>>> 7I68XU5zL/vNJ9IIx38UqdhtSzXQQL664DGq3DLINK0Yb9XRVBlFip+Slt+j
>> >>> >>>> cB64TuWjOPLSH09pv7SUyksodqrTq3K7p6sQkq0MOzBkFQM1FHfOipbo/LYv
>> >>> >>>> F42iiQbCvFizArMu20WeOSQ4dmrXT/iecgTfEag/Zxvor2gOi/J6d2XS9ckW
>> >>> >>>> byEC5/rbm4yDBua2ZugeNxQLWq0Oa7spZnx7usLsu/6YzeDNI6kmtGURajdE
>> >>> >>>> /XC8bESWKveBzmGDzjff5oaMs9A1PZURYnlYADEODGAt6byoaoQEGN6dlFGe
>> >>> >>>> LwQ5nOdQYuUrWpJzTJBN3aduOxursoFY8S0eR0uXm0l1CHcp22RWBDvRinok
>> >>> >>>> UWk5xRBgjDCD2gIwc+wpImZbCtiTdf0vad1uLvdxGL29iFta4THzJgUGrp98
>> >>> >>>> sUqM3RaTRdJYjFcNP293H7/DC0mqpnmo0Clx3jkdHX+x1EXpJUtocSeI44LX
>> >>> >>>> KWIMhe9wXtKAoHQFEcJ0o0+wrXWMevvx33HPC4q1ULrFX0ILNx5Mo0Rp944X
>> >>> >>>> 4OEo
>> >>> >>>> =P33I
>> >>> >>>> -----END PGP SIGNATURE-----
>> >>> >>>> ----------------
>> >>> >>>> Robert LeBlanc
>> >>> >>>> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
>> >>> >>>>
>> >>> >>>>
>> >>> >>>> On Tue, Sep 22, 2015 at 4:15 PM, Robert LeBlanc
>> >>> >>>> wrote:
>> >>> >>>>>
>> >>> >>>>> -----BEGIN PGP SIGNED MESSAGE-----
>> >>> >>>>> Hash: SHA256
>> >>> >>>>>
>> >>> >>>>> This is IPoIB and we have the MTU set to 64K. There was some issues
>> >>> >>>>> pinging hosts with "No buffer space available" (hosts are currently
>> >>> >>>>> configured for 4GB to test SSD caching rather than page cache). I
>> >>> >>>>> found that MTU under 32K worked reliable for ping, but still had the
>> >>> >>>>> blocked I/O.
>> >>> >>>>>
>> >>> >>>>> I reduced the MTU to 1500 and checked pings (OK), but I'm still seeing
>> >>> >>>>> the blocked I/O.
>> >>> >>>>> - ----------------
>> >>> >>>>> Robert LeBlanc
>> >>> >>>>> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
>> >>> >>>>>
>> >>> >>>>>
>> >>> >>>>> On Tue, Sep 22, 2015 at 3:52 PM, Sage Weil  wrote:
>> >>> >>>>>>
>> >>> >>>>>> On Tue, 22 Sep 2015, Samuel Just wrote:
>> >>> >>>>>>>
>> >>> >>>>>>> I looked at the logs, it looks like there was a 53 second delay
>> >>> >>>>>>> between when osd.17 started sending the osd_repop message and when
>> >>> >>>>>>> osd.13 started reading it, which is pretty weird.  Sage, didn't we
>> >>> >>>>>>> once see a kernel issue which caused some messages to be mysteriously
>> >>> >>>>>>> delayed for many 10s of seconds?
>> >>> >>>>>>
>> >>> >>>>>>
>> >>> >>>>>> Every time we have seen this behavior and diagnosed it in the wild it
>> >>> >>>>>> has
>> >>> >>>>>> been a network misconfiguration.  Usually related to jumbo frames.
>> >>> >>>>>>
>> >>> >>>>>> sage
>> >>> >>>>>>
>> >>> >>>>>>
>> >>> >>>>>>>
>> >>> >>>>>>> What kernel are you running?
>> >>> >>>>>>> -Sam
>> >>> >>>>>>>
>> >>> >>>>>>> On Tue, Sep 22, 2015 at 2:22 PM, Robert LeBlanc  wrote:
>> >>> >>>>>>>>
>> >>> >>>>>>>> -----BEGIN PGP SIGNED MESSAGE-----
>> >>> >>>>>>>> Hash: SHA256
>> >>> >>>>>>>>
>> >>> >>>>>>>> OK, looping in ceph-devel to see if I can get some more eyes. I've
>> >>> >>>>>>>> extracted what I think are important entries from the logs for the
>> >>> >>>>>>>> first blocked request. NTP is running all the servers so the logs
>> >>> >>>>>>>> should be close in terms of time. Logs for 12:50 to 13:00 are
>> >>> >>>>>>>> available at http://162.144.87.113/files/ceph_block_io.logs.tar.xz
>> >>> >>>>>>>>
>> >>> >>>>>>>> 2015-09-22 12:55:06.500374 - osd.17 gets I/O from client
>> >>> >>>>>>>> 2015-09-22 12:55:06.557160 - osd.17 submits I/O to osd.13
>> >>> >>>>>>>> 2015-09-22 12:55:06.557305 - osd.17 submits I/O to osd.16
>> >>> >>>>>>>> 2015-09-22 12:55:06.573711 - osd.16 gets I/O from osd.17
>> >>> >>>>>>>> 2015-09-22 12:55:06.595716 - osd.17 gets ondisk result=0 from osd.16
>> >>> >>>>>>>> 2015-09-22 12:55:06.640631 - osd.16 reports to osd.17 ondisk result=0
>> >>> >>>>>>>> 2015-09-22 12:55:36.926691 - osd.17 reports slow I/O > 30.439150 sec
>> >>> >>>>>>>> 2015-09-22 12:55:59.790591 - osd.13 gets I/O from osd.17
>> >>> >>>>>>>> 2015-09-22 12:55:59.812405 - osd.17 gets ondisk result=0 from osd.13
>> >>> >>>>>>>> 2015-09-22 12:56:02.941602 - osd.13 reports to osd.17 ondisk result=0
>> >>> >>>>>>>>
>> >>> >>>>>>>> In the logs I can see that osd.17 dispatches the I/O to osd.13 and
>> >>> >>>>>>>> osd.16 almost silmutaniously. osd.16 seems to get the I/O right away,
>> >>> >>>>>>>> but for some reason osd.13 doesn't get the message until 53 seconds
>> >>> >>>>>>>> later. osd.17 seems happy to just wait and doesn't resend the data
>> >>> >>>>>>>> (well, I'm not 100% sure how to tell which entries are the actual data
>> >>> >>>>>>>> transfer).
>> >>> >>>>>>>>
>> >>> >>>>>>>> It looks like osd.17 is receiving responses to start the communication
>> >>> >>>>>>>> with osd.13, but the op is not acknowledged until almost a minute
>> >>> >>>>>>>> later. To me it seems that the message is getting received but not
>> >>> >>>>>>>> passed to another thread right away or something. This test was done
>> >>> >>>>>>>> with an idle cluster, a single fio client (rbd engine) with a single
>> >>> >>>>>>>> thread.
>> >>> >>>>>>>>
>> >>> >>>>>>>> The OSD servers are almost 100% idle during these blocked I/O
>> >>> >>>>>>>> requests. I think I'm at the end of my troubleshooting, so I can use
>> >>> >>>>>>>> some help.
>> >>> >>>>>>>>
>> >>> >>>>>>>> Single Test started about
>> >>> >>>>>>>> 2015-09-22 12:52:36
>> >>> >>>>>>>>
>> >>> >>>>>>>> 2015-09-22 12:55:36.926680 osd.17 192.168.55.14:6800/16726 56 :
>> >>> >>>>>>>> cluster [WRN] 1 slow requests, 1 included below; oldest blocked for >
>> >>> >>>>>>>> 30.439150 secs
>> >>> >>>>>>>> 2015-09-22 12:55:36.926699 osd.17 192.168.55.14:6800/16726 57 :
>> >>> >>>>>>>> cluster [WRN] slow request 30.439150 seconds old, received at
>> >>> >>>>>>>> 2015-09-22 12:55:06.487451:
>> >>> >>>>>>>>   osd_op(client.250874.0:1388 rbd_data.3380e2ae8944a.0000000000000545
>> >>> >>>>>>>> [set-alloc-hint object_size 4194304 write_size 4194304,write
>> >>> >>>>>>>> 0~4194304] 8.bbf3e8ff ack+ondisk+write+known_if_redirected e56785)
>> >>> >>>>>>>>   currently waiting for subops from 13,16
>> >>> >>>>>>>> 2015-09-22 12:55:36.697904 osd.16 192.168.55.13:6800/29410 7 : cluster
>> >>> >>>>>>>> [WRN] 2 slow requests, 2 included below; oldest blocked for >
>> >>> >>>>>>>> 30.379680 secs
>> >>> >>>>>>>> 2015-09-22 12:55:36.697918 osd.16 192.168.55.13:6800/29410 8 : cluster
>> >>> >>>>>>>> [WRN] slow request 30.291520 seconds old, received at 2015-09-22
>> >>> >>>>>>>> 12:55:06.406303:
>> >>> >>>>>>>>   osd_op(client.250874.0:1384 rbd_data.3380e2ae8944a.0000000000000541
>> >>> >>>>>>>> [set-alloc-hint object_size 4194304 write_size 4194304,write
>> >>> >>>>>>>> 0~4194304] 8.5fb2123f ack+ondisk+write+known_if_redirected e56785)
>> >>> >>>>>>>>   currently waiting for subops from 13,17
>> >>> >>>>>>>> 2015-09-22 12:55:36.697927 osd.16 192.168.55.13:6800/29410 9 : cluster
>> >>> >>>>>>>> [WRN] slow request 30.379680 seconds old, received at 2015-09-22
>> >>> >>>>>>>> 12:55:06.318144:
>> >>> >>>>>>>>   osd_op(client.250874.0:1382 rbd_data.3380e2ae8944a.000000000000053f
>> >>> >>>>>>>> [set-alloc-hint object_size 4194304 write_size 4194304,write
>> >>> >>>>>>>> 0~4194304] 8.312e69ca ack+ondisk+write+known_if_redirected e56785)
>> >>> >>>>>>>>   currently waiting for subops from 13,14
>> >>> >>>>>>>> 2015-09-22 12:58:03.998275 osd.13 192.168.55.12:6804/4574 130 :
>> >>> >>>>>>>> cluster [WRN] 1 slow requests, 1 included below; oldest blocked for >
>> >>> >>>>>>>> 30.954212 secs
>> >>> >>>>>>>> 2015-09-22 12:58:03.998286 osd.13 192.168.55.12:6804/4574 131 :
>> >>> >>>>>>>> cluster [WRN] slow request 30.954212 seconds old, received at
>> >>> >>>>>>>> 2015-09-22 12:57:33.044003:
>> >>> >>>>>>>>   osd_op(client.250874.0:1873 rbd_data.3380e2ae8944a.000000000000070d
>> >>> >>>>>>>> [set-alloc-hint object_size 4194304 write_size 4194304,write
>> >>> >>>>>>>> 0~4194304] 8.e69870d4 ack+ondisk+write+known_if_redirected e56785)
>> >>> >>>>>>>>   currently waiting for subops from 16,17
>> >>> >>>>>>>> 2015-09-22 12:58:03.759826 osd.16 192.168.55.13:6800/29410 10 :
>> >>> >>>>>>>> cluster [WRN] 1 slow requests, 1 included below; oldest blocked for >
>> >>> >>>>>>>> 30.704367 secs
>> >>> >>>>>>>> 2015-09-22 12:58:03.759840 osd.16 192.168.55.13:6800/29410 11 :
>> >>> >>>>>>>> cluster [WRN] slow request 30.704367 seconds old, received at
>> >>> >>>>>>>> 2015-09-22 12:57:33.055404:
>> >>> >>>>>>>>   osd_op(client.250874.0:1874 rbd_data.3380e2ae8944a.000000000000070e
>> >>> >>>>>>>> [set-alloc-hint object_size 4194304 write_size 4194304,write
>> >>> >>>>>>>> 0~4194304] 8.f7635819 ack+ondisk+write+known_if_redirected e56785)
>> >>> >>>>>>>>   currently waiting for subops from 13,17
>> >>> >>>>>>>>
>> >>> >>>>>>>> Server   IP addr              OSD
>> >>> >>>>>>>> nodev  - 192.168.55.11 - 12
>> >>> >>>>>>>> nodew  - 192.168.55.12 - 13
>> >>> >>>>>>>> nodex  - 192.168.55.13 - 16
>> >>> >>>>>>>> nodey  - 192.168.55.14 - 17
>> >>> >>>>>>>> nodez  - 192.168.55.15 - 14
>> >>> >>>>>>>> nodezz - 192.168.55.16 - 15
>> >>> >>>>>>>>
>> >>> >>>>>>>> fio job:
>> >>> >>>>>>>> [rbd-test]
>> >>> >>>>>>>> readwrite=write
>> >>> >>>>>>>> blocksize=4M
>> >>> >>>>>>>> #runtime=60
>> >>> >>>>>>>> name=rbd-test
>> >>> >>>>>>>> #readwrite=randwrite
>> >>> >>>>>>>> #bssplit=4k/85:32k/11:512/3:1m/1,4k/89:32k/10:512k/1
>> >>> >>>>>>>> #rwmixread=72
>> >>> >>>>>>>> #norandommap
>> >>> >>>>>>>> #size=1T
>> >>> >>>>>>>> #blocksize=4k
>> >>> >>>>>>>> ioengine=rbd
>> >>> >>>>>>>> rbdname=test2
>> >>> >>>>>>>> pool=rbd
>> >>> >>>>>>>> clientname=admin
>> >>> >>>>>>>> iodepth=8
>> >>> >>>>>>>> #numjobs=4
>> >>> >>>>>>>> #thread
>> >>> >>>>>>>> #group_reporting
>> >>> >>>>>>>> #time_based
>> >>> >>>>>>>> #direct=1
>> >>> >>>>>>>> #ramp_time=60
>> >>> >>>>>>>>
>> >>> >>>>>>>>
>> >>> >>>>>>>> Thanks,
>> >>> >>>>>>>> -----BEGIN PGP SIGNATURE-----
>> >>> >>>>>>>> Version: Mailvelope v1.1.0
>> >>> >>>>>>>> Comment: https://www.mailvelope.com
>> >>> >>>>>>>>
>> >>> >>>>>>>> wsFcBAEBCAAQBQJWAcaKCRDmVDuy+mK58QAAPMsQAKBnS94fwuw0OqpPU3/z
>> >>> >>>>>>>> tL8Z6TVRxrNigf721+2ClIu4LIH71bupDc3DgrrysQmmqGuvEMn68spmasWu
>> >>> >>>>>>>> h9I/CqqgRpHqe4lUVoUEjyWA9/6Dbb6NiHSdpJ6p5jpGc8kZCvNS+ocDgFOl
>> >>> >>>>>>>> 903i0M0E9eEMeci5O/hrMrx1FG8SN2LS8nI261aNHMOwQK0bw8wWiCJEvqVB
>> >>> >>>>>>>> sz1/+jK1BJoeIYfaT9HfUXBAvfo/W3tY/vj9KbJuZJ5AMpeYPvEHu/LAr1N7
>> >>> >>>>>>>> FzzUc7a6EMlaxmSd0ML49JbV0cY9BMDjfrkKEQNKlzszlEHm3iif98QtsxbF
>> >>> >>>>>>>> pPJ0hZ0G53BY3k976OWVMFm3WFRWUVOb/oiLF8H6PCm59b4LBNAg6iPNH1AI
>> >>> >>>>>>>> 5XhEcPpg06M03vqUaIiY9P1kQlvnn0yCXf82IUEgmg///vhxDsHWmcwClLEn
>> >>> >>>>>>>> B0VszouStTzlMYnc/2vlUiI4gFVeilWLMW00VGTWV+7V1oIzIYvWHyl2QpBq
>> >>> >>>>>>>> 4/ZwVjQ43qLfuDTS4o+IJ4ztOMd26vIv6Mn6WVwKCjoCXJc8ajywR9Dy+6lL
>> >>> >>>>>>>> o8oJ+tn7hMc9Qy1iBhu3/QIP4WCsUf9RVeu60oahNEpde89qW32S9CZlrJDO
>> >>> >>>>>>>> gf4iTryRjkAhdmZIj9JiaE8jQ6dvN817D9cqs/CXKV9vhzYoM7p5YWHghBKB
>> >>> >>>>>>>> J3hS
>> >>> >>>>>>>> =0J7F
>> >>> >>>>>>>> -----END PGP SIGNATURE-----
>> >>> >>>>>>>> ----------------
>> >>> >>>>>>>> Robert LeBlanc
>> >>> >>>>>>>> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
>> >>> >>>>>>>>
>> >>> >>>>>>>>
>> >>> >>>>>>>> On Tue, Sep 22, 2015 at 8:31 AM, Gregory Farnum  wrote:
>> >>> >>>>>>>>>
>> >>> >>>>>>>>> On Tue, Sep 22, 2015 at 7:24 AM, Robert LeBlanc  wrote:
>> >>> >>>>>>>>>>
>> >>> >>>>>>>>>> -----BEGIN PGP SIGNED MESSAGE-----
>> >>> >>>>>>>>>> Hash: SHA256
>> >>> >>>>>>>>>>
>> >>> >>>>>>>>>> Is there some way to tell in the logs that this is happening?
>> >>> >>>>>>>>>
>> >>> >>>>>>>>>
>> >>> >>>>>>>>> You can search for the (mangled) name _split_collection
>> >>> >>>>>>>>>>
>> >>> >>>>>>>>>> I'm not
>> >>> >>>>>>>>>> seeing much I/O, CPU usage during these times. Is there some way to
>> >>> >>>>>>>>>> prevent the splitting? Is there a negative side effect to doing so?
>> >>> >>>>>>>>>
>> >>> >>>>>>>>>
>> >>> >>>>>>>>> Bump up the split and merge thresholds. You can search the list for
>> >>> >>>>>>>>> this, it was discussed not too long ago.
>> >>> >>>>>>>>>
>> >>> >>>>>>>>>> We've had I/O block for over 900 seconds and as soon as the sessions
>> >>> >>>>>>>>>> are aborted, they are reestablished and complete immediately.
>> >>> >>>>>>>>>>
>> >>> >>>>>>>>>> The fio test is just a seq write, starting it over (rewriting from
>> >>> >>>>>>>>>> the
>> >>> >>>>>>>>>> beginning) is still causing the issue. I was suspect that it is not
>> >>> >>>>>>>>>> having to create new file and therefore split collections. This is
>> >>> >>>>>>>>>> on
>> >>> >>>>>>>>>> my test cluster with no other load.
>> >>> >>>>>>>>>
>> >>> >>>>>>>>>
>> >>> >>>>>>>>> Hmm, that does make it seem less likely if you're really not creating
>> >>> >>>>>>>>> new objects, if you're actually running fio in such a way that it's
>> >>> >>>>>>>>> not allocating new FS blocks (this is probably hard to set up?).
>> >>> >>>>>>>>>
>> >>> >>>>>>>>>>
>> >>> >>>>>>>>>> I'll be doing a lot of testing today. Which log options and depths
>> >>> >>>>>>>>>> would be the most helpful for tracking this issue down?
>> >>> >>>>>>>>>
>> >>> >>>>>>>>>
>> >>> >>>>>>>>> If you want to go log diving "debug osd = 20", "debug filestore =
>> >>> >>>>>>>>> 20",
>> >>> >>>>>>>>> "debug ms = 1" are what the OSD guys like to see. That should spit
>> >>> >>>>>>>>> out
>> >>> >>>>>>>>> everything you need to track exactly what each Op is doing.
>> >>> >>>>>>>>> -Greg
>> >>> >>>>>>>>
>> >>> >>>>>>>> --
>> >>> >>>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>> >>> >>>>>>>> in
>> >>> >>>>>>>> the body of a message to majordomo@vger.kernel.org
>> >>> >>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> >>> >>>>>>>
>> >>> >>>>>>>
>> >>> >>>>>>>
>> >>> >>>>>
>> >>> >>>>> -----BEGIN PGP SIGNATURE-----
>> >>> >>>>> Version: Mailvelope v1.1.0
>> >>> >>>>> Comment: https://www.mailvelope.com
>> >>> >>>>>
>> >>> >>>>> wsFcBAEBCAAQBQJWAdMSCRDmVDuy+mK58QAAoEgP/AqpH7i1BLpoz6fTlfWG
>> >>> >>>>> a6swvF8xvsyR15PDiPINYT0N7MgoikikGrMmhWpJ6utEr1XPW0MPFgzvNIsf
>> >>> >>>>> a1eMtNzyww4rAo6JCq6BtjmUsSKmOrBNhRNr6It9v4Nv+biqZHkiY8x/rRtV
>> >>> >>>>> s9z0cv3Q9Wqa6y/zKZg3H1XtbtUAx0r/DUwzSsP3omupZgNyaKkCgdkil9Vc
>> >>> >>>>> iyzBxFZU4+qXNT2FBG4dYDjxSHQv4psjvKR3AWXSN4yEn286KyMDjFrsDY5B
>> >>> >>>>> izS3h603QPoErqsUQngDE8COcaTAHHrV7gNJTikmGoNW6oQBjFq/z/zindTz
>> >>> >>>>> caXshVQQ+OTLo/qzJM8QPswh0TGU74SVbDkTq+eTOb5pBhQbp+42Pkkqh7jj
>> >>> >>>>> efyyYgDzpB1WrWRbUlWMNqmnjq7DT3lnAtuHyKbkwVs8x3JMPEiCl6PBvJbx
>> >>> >>>>> GnNSCqgDJrpb4fHQ2iqfQeh8Ai6AL1C1Ai19RZPrAUhpDW0/DbUvuoKSR8m7
>> >>> >>>>> glYYuH3hpy+oPYRhFcHm2fpNJ3u9npyk2Dai9RpzQ+mWmp3xi7becYmL482H
>> >>> >>>>> +WyvLeY+8AiJQDpA0CdD8KeSlOC9bw5TPmihAIn9dVTJ1O2RlapCLqL3YAJg
>> >>> >>>>> pGyDs8ercTEJLmvEyElj5XWh5DarsGscd2LELNS/UpyuYurbPcyPKUQ0uPjp
>> >>> >>>>> gcZm
>> >>> >>>>> =CjwB
>> >>> >>>>> -----END PGP SIGNATURE-----
>> >>> >>>>
>> >>> >>>> --
>> >>> >>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> >>> >>>> the body of a message to majordomo@vger.kernel.org
>> >>> >>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> >>> >>>>
>> >>> >>>
>> >>> >>
>> >>> >> -----BEGIN PGP SIGNATURE-----
>> >>> >> Version: Mailvelope v1.1.0
>> >>> >> Comment: https://www.mailvelope.com
>> >>> >>
>> >>> >> wsFcBAEBCAAQBQJWAv3QCRDmVDuy+mK58QAABr4QAJcQj8zjl606aMdkmQG7
>> >>> >> S46iMXVav/Tv2os9GCUsQmMPx2u1w3/WmPfjByd6Divczfo0JLDDqrbsqre2
>> >>> >> lq0GNK6e8fq6FXHhPpnL+t4uFV4UZ289cma3yklRqEBDXWHlP59Hu7VpxC5l
>> >>> >> 0MIcCg4wM5VM/LkrfcMven5em5CnjyFJYbActGzw9043rZoyUwCM+eL7sotl
>> >>> >> JYHMcNWnqwdt8TLFDhUfVGiAQyV8/6E33CuCNUEuFGdtiBKzs9IZadOI8Ce0
>> >>> >> dod2DQNyFSvomqNq6t0DuTCSA+pT8uuks2O0NcrHjoqwIWVkxQGPYlpbpckf
>> >>> >> nxQdVM7vkqapVeQ0qUZx43Db9A5wDTC3PaEfVJZPZzWsSDjh9z7o6qHs3Kvp
>> >>> >> krfyS+dJaZ3tOYAP1VFDfasj06sOTFu3mfGYToKA75zz5HN7QZ13Zau/qhDu
>> >>> >> FHxsgk4oIXJsjj22LiSpoiigH5Ls+aVqtIbg8/vWp+EO6pK1fovEtJVeGAfE
>> >>> >> tLOdxfJJLVjMCAScFG9BRl1ePPLeptivKV0v9ruWsTpn+Q96VtqAR5GQCkYE
>> >>> >> hFrlxM+oIzHeArhhiIxSPCYLlnzxoD5IYXmTrWUYBCGvlY1mrI3j80mZ4VTj
>> >>> >> BErsSlqnjUyFKmaI7YNKyARCloMroz3wqdy/wpg/63Io62nmh5IyY+WO8hPo
>> >>> >> ae22
>> >>> >> =AX+L
>> >>> >> -----END PGP SIGNATURE-----
>> >>> _______________________________________________
>> >>> ceph-users mailing list
>> >>> ceph-users@lists.ceph.com
>> >>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>> >>>
>> >>>
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users@lists.ceph.com
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>
>>
