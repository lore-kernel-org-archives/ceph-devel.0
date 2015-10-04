From: Josef Johansson <josef86-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Potential OSD deadlock?
Date: Sun, 4 Oct 2015 08:16:50 +0200
Message-ID: <CAOnYue-T061jkAvpe3cwH7Et4xXY_dkW73KyKcbwiefgzgs8cA@mail.gmail.com>
References: <CAANLjFpAXaDWQzumg1hCs=SC_0YvdYDd6vyodz5_ZBNvGWdkSw@mail.gmail.com>
	<CAANLjFob5ZsJzYop0RjQsXw-4UfV4OvdhBjT2sGF-u6gq9NrhQ@mail.gmail.com>
	<CAJ4mKGZ8WhY5JWD2P=5fQ+9EYQazEKETCTg8gU6qcZ03V3jrVw@mail.gmail.com>
	<CAANLjFrcx_M7BxW5UCZxUk_Y7-s3NneBevnP+JHU0PA8pazpAw@mail.gmail.com>
	<CAJ4mKGZLD4QfAfhZEXAe6KSbq9Z6wPXdUes_GJunfgnTf+K0Yg@mail.gmail.com>
	<CAANLjFqn8t+w3hACiCvgi2zpG4TGFYzmAW5ocsa1TOjqueY6QQ@mail.gmail.com>
	<CAJ4mKGY-XcFvbzSCRH4d5qJuwNE1uQ0Kdj7UCq5p0saFyaoiBA@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2141083990=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAANLjFoafHQ1X8U7LUrvhh2h8fu3WgNpUsMDR+QkSWpfW8ad0g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Robert LeBlanc <robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org>
Cc: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============2141083990==
Content-Type: multipart/alternative; boundary=089e0102ef54afa8e70521415745

--089e0102ef54afa8e70521415745
Content-Type: text/plain; charset=UTF-8

Hi,

I don't know what brand those 4TB spindles are, but I know that mine are
very bad at doing write at the same time as read. Especially small read
write.

This has an absurdly bad effect when doing maintenance on ceph. That being
said we see a lot of difference between dumpling and hammer in performance
on these drives. Most likely due to hammer able to read write degraded PGs.

We have run into two different problems along the way, the first was
blocked request where we had to upgrade from 64GB mem on each node to
256GB. We thought that it was the only safe buy make things better.

I believe it worked because more reads were cached so we had less mixed
read write on the nodes, thus giving the spindles more room to breath. Now
this was a shot in the dark then, but the price is not that high even to
just try it out.. compared to 6 people working on it. I believe the IO on
disk was not huge either, but what kills the disk is high latency. How much
bandwidth are the disk using? We had very low.. 3-5MB/s.

The second problem was defragmentations hitting 70%, lowering that to 6%
made a lot of difference. Depending on IO pattern this increases different.

TL;DR read kills the 4TB spindles.

Hope you guys clear out of the woods.
/Josef
On 3 Oct 2015 10:10 pm, "Robert LeBlanc" <robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org> wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>
> We are still struggling with this and have tried a lot of different
> things. Unfortunately, Inktank (now Red Hat) no longer provides
> consulting services for non-Red Hat systems. If there are some
> certified Ceph consultants in the US that we can do both remote and
> on-site engagements, please let us know.
>
> This certainly seems to be network related, but somewhere in the
> kernel. We have tried increasing the network and TCP buffers, number
> of TCP sockets, reduced the FIN_WAIT2 state. There is about 25% idle
> on the boxes, the disks are busy, but not constantly at 100% (they
> cycle from <10% up to 100%, but not 100% for more than a few seconds
> at a time). There seems to be no reasonable explanation why I/O is
> blocked pretty frequently longer than 30 seconds. We have verified
> Jumbo frames by pinging from/to each node with 9000 byte packets. The
> network admins have verified that packets are not being dropped in the
> switches for these nodes. We have tried different kernels including
> the recent Google patch to cubic. This is showing up on three cluster
> (two Ethernet and one IPoIB). I booted one cluster into Debian Jessie
> (from CentOS 7.1) with similar results.
>
> The messages seem slightly different:
> 2015-10-03 14:38:23.193082 osd.134 10.208.16.25:6800/1425 439 :
> cluster [WRN] 14 slow requests, 1 included below; oldest blocked for >
> 100.087155 secs
> 2015-10-03 14:38:23.193090 osd.134 10.208.16.25:6800/1425 440 :
> cluster [WRN] slow request 30.041999 seconds old, received at
> 2015-10-03 14:37:53.151014: osd_op(client.1328605.0:7082862
> rbd_data.13fdcb2ae8944a.000000000001264f [read 975360~4096]
> 11.6d19c36f ack+read+known_if_redirected e10249) currently no flag
> points reached
>
> I don't know what "no flag points reached" means.
>
> The problem is most pronounced when we have to reboot an OSD node (1
> of 13), we will have hundreds of I/O blocked for some times up to 300
> seconds. It takes a good 15 minutes for things to settle down. The
> production cluster is very busy doing normally 8,000 I/O and peaking
> at 15,000. This is all 4TB spindles with SSD journals and the disks
> are between 25-50% full. We are currently splitting PGs to distribute
> the load better across the disks, but we are having to do this 10 PGs
> at a time as we get blocked I/O. We have max_backfills and
> max_recovery set to 1, client op priority is set higher than recovery
> priority. We tried increasing the number of op threads but this didn't
> seem to help. It seems as soon as PGs are finished being checked, they
> become active and could be the cause for slow I/O while the other PGs
> are being checked.
>
> What I don't understand is that the messages are delayed. As soon as
> the message is received by Ceph OSD process, it is very quickly
> committed to the journal and a response is sent back to the primary
> OSD which is received very quickly as well. I've adjust
> min_free_kbytes and it seems to keep the OSDs from crashing, but
> doesn't solve the main problem. We don't have swap and there is 64 GB
> of RAM per nodes for 10 OSDs.
>
> Is there something that could cause the kernel to get a packet but not
> be able to dispatch it to Ceph such that it could be explaining why we
> are seeing these blocked I/O for 30+ seconds. Is there some pointers
> to tracing Ceph messages from the network buffer through the kernel to
> the Ceph process?
>
> We can really use some pointers no matter how outrageous. We've have
> over 6 people looking into this for weeks now and just can't think of
> anything else.
>
> Thanks,
> -----BEGIN PGP SIGNATURE-----
> Version: Mailvelope v1.1.0
> Comment: https://www.mailvelope.com
>
> wsFcBAEBCAAQBQJWEDY1CRDmVDuy+mK58QAARgoP/RcoL1qVmg7qbQrzStar
> NK80bqYGeYHb26xHbt1fZVgnZhXU0nN0Dv4ew0e/cYJLELSO2KCeXNfXN6F1
> prZuzYagYEyj1Q1TOo+4h/nOQRYsTwQDdFzbHb/OUDN55C0QGZ29DjEvrqP6
> K5l6sAQzvQDpUEEIiOCkS6pH59ira740nSmnYkEWhr1lxF/hMjb6fFlfCFe2
> h1djM0GfY7vBHFGgI3jkw0BL5AQnWe+SCcCiKZmxY6xiR70FWl3XqK5M+nxm
> iq74y7Dv6cpenit6boMr6qtOeIt+8ko85hVMh09Hkaqz/m2FzxAKLcahzkGF
> Fh/M6YBzgnX7QBURTC4YQT/FVyDTW3JMuT3RKQdaX6c0iiOsVdkE+iyidWyY
> Hr1KzWU23Ur9yBfZ39Y43jrsSiAEwHnKjSqMowSGljdTysNEAAZQhlqZIoHb
> JlgpB39ugkHI1H5fZ5b2SIDz32/d5ywG4Gay9Rk6hp8VanvIrBbev+JYEoYT
> 8/WX+fhueHt4dqUYWIl3HZ0CEzbXbug0xmFvhrbmL2f3t9XOkDZRbAjlYrGm
> lswiJMDueY8JkxSnPvCQrHXqjbCcy9rMG7nTnLFz98rTcHNCwtpv0qVYhheg
> 4YRNRVMbfNP/6xsJvG1wVOSQPwxZSPqJh42pDqMRePJl3Zn66MTx5wvdNDpk
> l7OF
> =OI++
> -----END PGP SIGNATURE-----
> ----------------
> Robert LeBlanc
> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
>
>
> On Fri, Sep 25, 2015 at 2:40 PM, Robert LeBlanc <robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org>
> wrote:
> > We dropped the replication on our cluster from 4 to 3 and it looks
> > like all the blocked I/O has stopped (no entries in the log for the
> > last 12 hours). This makes me believe that there is some issue with
> > the number of sockets or some other TCP issue. We have not messed with
> > Ephemeral ports and TIME_WAIT at this point. There are 130 OSDs, 8 KVM
> > hosts hosting about 150 VMs. Open files is set at 32K for the OSD
> > processes and 16K system wide.
> >
> > Does this seem like the right spot to be looking? What are some
> > configuration items we should be looking at?
> >
> > Thanks,
> > ----------------
> > Robert LeBlanc
> > PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
> >
> >
> > On Wed, Sep 23, 2015 at 1:30 PM, Robert LeBlanc <robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org>
> wrote:
> >> -----BEGIN PGP SIGNED MESSAGE-----
> >> Hash: SHA256
> >>
> >> We were able to only get ~17Gb out of the XL710 (heavily tweaked)
> >> until we went to the 4.x kernel where we got ~36Gb (no tweaking). It
> >> seems that there were some major reworks in the network handling in
> >> the kernel to efficiently handle that network rate. If I remember
> >> right we also saw a drop in CPU utilization. I'm starting to think
> >> that we did see packet loss while congesting our ISLs in our initial
> >> testing, but we could not tell where the dropping was happening. We
> >> saw some on the switches, but it didn't seem to be bad if we weren't
> >> trying to congest things. We probably already saw this issue, just
> >> didn't know it.
> >> - ----------------
> >> Robert LeBlanc
> >> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
> >>
> >>
> >> On Wed, Sep 23, 2015 at 1:10 PM, Mark Nelson  wrote:
> >>> FWIW, we've got some 40GbE Intel cards in the community performance
> cluster
> >>> on a Mellanox 40GbE switch that appear (knock on wood) to be running
> fine
> >>> with 3.10.0-229.7.2.el7.x86_64.  We did get feedback from Intel that
> older
> >>> drivers might cause problems though.
> >>>
> >>> Here's ifconfig from one of the nodes:
> >>>
> >>> ens513f1: flags=4163  mtu 1500
> >>>         inet 10.0.10.101  netmask 255.255.255.0  broadcast 10.0.10.255
> >>>         inet6 fe80::6a05:caff:fe2b:7ea1  prefixlen 64  scopeid 0x20
> >>>         ether 68:05:ca:2b:7e:a1  txqueuelen 1000  (Ethernet)
> >>>         RX packets 169232242875  bytes 229346261232279 (208.5 TiB)
> >>>         RX errors 0  dropped 0  overruns 0  frame 0
> >>>         TX packets 153491686361  bytes 203976410836881 (185.5 TiB)
> >>>         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
> >>>
> >>> Mark
> >>>
> >>>
> >>> On 09/23/2015 01:48 PM, Robert LeBlanc wrote:
> >>>>
> >>>> -----BEGIN PGP SIGNED MESSAGE-----
> >>>> Hash: SHA256
> >>>>
> >>>> OK, here is the update on the saga...
> >>>>
> >>>> I traced some more of blocked I/Os and it seems that communication
> >>>> between two hosts seemed worse than others. I did a two way ping flood
> >>>> between the two hosts using max packet sizes (1500). After 1.5M
> >>>> packets, no lost pings. Then then had the ping flood running while I
> >>>> put Ceph load on the cluster and the dropped pings started increasing
> >>>> after stopping the Ceph workload the pings stopped dropping.
> >>>>
> >>>> I then ran iperf between all the nodes with the same results, so that
> >>>> ruled out Ceph to a large degree. I then booted in the the
> >>>> 3.10.0-229.14.1.el7.x86_64 kernel and with an hour test so far there
> >>>> hasn't been any dropped pings or blocked I/O. Our 40 Gb NICs really
> >>>> need the network enhancements in the 4.x series to work well.
> >>>>
> >>>> Does this sound familiar to anyone? I'll probably start bisecting the
> >>>> kernel to see where this issue in introduced. Both of the clusters
> >>>> with this issue are running 4.x, other than that, they are pretty
> >>>> differing hardware and network configs.
> >>>>
> >>>> Thanks,
> >>>> -----BEGIN PGP SIGNATURE-----
> >>>> Version: Mailvelope v1.1.0
> >>>> Comment: https://www.mailvelope.com
> >>>>
> >>>> wsFcBAEBCAAQBQJWAvOzCRDmVDuy+mK58QAApOMP/1xmCtW++G11qcE8y/sr
> >>>> RkXguqZJLc4czdOwV/tjUvhVsm5qOl4wvQCtABFZpc6t4+m5nzE3LkA1rl2l
> >>>> AnARPOjh61TO6cV0CT8O0DlqtHmSd2y0ElgAUl0594eInEn7eI7crz8R543V
> >>>> 7I68XU5zL/vNJ9IIx38UqdhtSzXQQL664DGq3DLINK0Yb9XRVBlFip+Slt+j
> >>>> cB64TuWjOPLSH09pv7SUyksodqrTq3K7p6sQkq0MOzBkFQM1FHfOipbo/LYv
> >>>> F42iiQbCvFizArMu20WeOSQ4dmrXT/iecgTfEag/Zxvor2gOi/J6d2XS9ckW
> >>>> byEC5/rbm4yDBua2ZugeNxQLWq0Oa7spZnx7usLsu/6YzeDNI6kmtGURajdE
> >>>> /XC8bESWKveBzmGDzjff5oaMs9A1PZURYnlYADEODGAt6byoaoQEGN6dlFGe
> >>>> LwQ5nOdQYuUrWpJzTJBN3aduOxursoFY8S0eR0uXm0l1CHcp22RWBDvRinok
> >>>> UWk5xRBgjDCD2gIwc+wpImZbCtiTdf0vad1uLvdxGL29iFta4THzJgUGrp98
> >>>> sUqM3RaTRdJYjFcNP293H7/DC0mqpnmo0Clx3jkdHX+x1EXpJUtocSeI44LX
> >>>> KWIMhe9wXtKAoHQFEcJ0o0+wrXWMevvx33HPC4q1ULrFX0ILNx5Mo0Rp944X
> >>>> 4OEo
> >>>> =P33I
> >>>> -----END PGP SIGNATURE-----
> >>>> ----------------
> >>>> Robert LeBlanc
> >>>> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
> >>>>
> >>>>
> >>>> On Tue, Sep 22, 2015 at 4:15 PM, Robert LeBlanc
> >>>> wrote:
> >>>>>
> >>>>> -----BEGIN PGP SIGNED MESSAGE-----
> >>>>> Hash: SHA256
> >>>>>
> >>>>> This is IPoIB and we have the MTU set to 64K. There was some issues
> >>>>> pinging hosts with "No buffer space available" (hosts are currently
> >>>>> configured for 4GB to test SSD caching rather than page cache). I
> >>>>> found that MTU under 32K worked reliable for ping, but still had the
> >>>>> blocked I/O.
> >>>>>
> >>>>> I reduced the MTU to 1500 and checked pings (OK), but I'm still
> seeing
> >>>>> the blocked I/O.
> >>>>> - ----------------
> >>>>> Robert LeBlanc
> >>>>> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
> >>>>>
> >>>>>
> >>>>> On Tue, Sep 22, 2015 at 3:52 PM, Sage Weil  wrote:
> >>>>>>
> >>>>>> On Tue, 22 Sep 2015, Samuel Just wrote:
> >>>>>>>
> >>>>>>> I looked at the logs, it looks like there was a 53 second delay
> >>>>>>> between when osd.17 started sending the osd_repop message and when
> >>>>>>> osd.13 started reading it, which is pretty weird.  Sage, didn't we
> >>>>>>> once see a kernel issue which caused some messages to be
> mysteriously
> >>>>>>> delayed for many 10s of seconds?
> >>>>>>
> >>>>>>
> >>>>>> Every time we have seen this behavior and diagnosed it in the wild
> it
> >>>>>> has
> >>>>>> been a network misconfiguration.  Usually related to jumbo frames.
> >>>>>>
> >>>>>> sage
> >>>>>>
> >>>>>>
> >>>>>>>
> >>>>>>> What kernel are you running?
> >>>>>>> -Sam
> >>>>>>>
> >>>>>>> On Tue, Sep 22, 2015 at 2:22 PM, Robert LeBlanc  wrote:
> >>>>>>>>
> >>>>>>>> -----BEGIN PGP SIGNED MESSAGE-----
> >>>>>>>> Hash: SHA256
> >>>>>>>>
> >>>>>>>> OK, looping in ceph-devel to see if I can get some more eyes. I've
> >>>>>>>> extracted what I think are important entries from the logs for the
> >>>>>>>> first blocked request. NTP is running all the servers so the logs
> >>>>>>>> should be close in terms of time. Logs for 12:50 to 13:00 are
> >>>>>>>> available at
> http://162.144.87.113/files/ceph_block_io.logs.tar.xz
> >>>>>>>>
> >>>>>>>> 2015-09-22 12:55:06.500374 - osd.17 gets I/O from client
> >>>>>>>> 2015-09-22 12:55:06.557160 - osd.17 submits I/O to osd.13
> >>>>>>>> 2015-09-22 12:55:06.557305 - osd.17 submits I/O to osd.16
> >>>>>>>> 2015-09-22 12:55:06.573711 - osd.16 gets I/O from osd.17
> >>>>>>>> 2015-09-22 12:55:06.595716 - osd.17 gets ondisk result=0 from
> osd.16
> >>>>>>>> 2015-09-22 12:55:06.640631 - osd.16 reports to osd.17 ondisk
> result=0
> >>>>>>>> 2015-09-22 12:55:36.926691 - osd.17 reports slow I/O > 30.439150
> sec
> >>>>>>>> 2015-09-22 12:55:59.790591 - osd.13 gets I/O from osd.17
> >>>>>>>> 2015-09-22 12:55:59.812405 - osd.17 gets ondisk result=0 from
> osd.13
> >>>>>>>> 2015-09-22 12:56:02.941602 - osd.13 reports to osd.17 ondisk
> result=0
> >>>>>>>>
> >>>>>>>> In the logs I can see that osd.17 dispatches the I/O to osd.13 and
> >>>>>>>> osd.16 almost silmutaniously. osd.16 seems to get the I/O right
> away,
> >>>>>>>> but for some reason osd.13 doesn't get the message until 53
> seconds
> >>>>>>>> later. osd.17 seems happy to just wait and doesn't resend the data
> >>>>>>>> (well, I'm not 100% sure how to tell which entries are the actual
> data
> >>>>>>>> transfer).
> >>>>>>>>
> >>>>>>>> It looks like osd.17 is receiving responses to start the
> communication
> >>>>>>>> with osd.13, but the op is not acknowledged until almost a minute
> >>>>>>>> later. To me it seems that the message is getting received but not
> >>>>>>>> passed to another thread right away or something. This test was
> done
> >>>>>>>> with an idle cluster, a single fio client (rbd engine) with a
> single
> >>>>>>>> thread.
> >>>>>>>>
> >>>>>>>> The OSD servers are almost 100% idle during these blocked I/O
> >>>>>>>> requests. I think I'm at the end of my troubleshooting, so I can
> use
> >>>>>>>> some help.
> >>>>>>>>
> >>>>>>>> Single Test started about
> >>>>>>>> 2015-09-22 12:52:36
> >>>>>>>>
> >>>>>>>> 2015-09-22 12:55:36.926680 osd.17 192.168.55.14:6800/16726 56 :
> >>>>>>>> cluster [WRN] 1 slow requests, 1 included below; oldest blocked
> for >
> >>>>>>>> 30.439150 secs
> >>>>>>>> 2015-09-22 12:55:36.926699 osd.17 192.168.55.14:6800/16726 57 :
> >>>>>>>> cluster [WRN] slow request 30.439150 seconds old, received at
> >>>>>>>> 2015-09-22 12:55:06.487451:
> >>>>>>>>   osd_op(client.250874.0:1388
> rbd_data.3380e2ae8944a.0000000000000545
> >>>>>>>> [set-alloc-hint object_size 4194304 write_size 4194304,write
> >>>>>>>> 0~4194304] 8.bbf3e8ff ack+ondisk+write+known_if_redirected e56785)
> >>>>>>>>   currently waiting for subops from 13,16
> >>>>>>>> 2015-09-22 12:55:36.697904 osd.16 192.168.55.13:6800/29410 7 :
> cluster
> >>>>>>>> [WRN] 2 slow requests, 2 included below; oldest blocked for >
> >>>>>>>> 30.379680 secs
> >>>>>>>> 2015-09-22 12:55:36.697918 osd.16 192.168.55.13:6800/29410 8 :
> cluster
> >>>>>>>> [WRN] slow request 30.291520 seconds old, received at 2015-09-22
> >>>>>>>> 12:55:06.406303:
> >>>>>>>>   osd_op(client.250874.0:1384
> rbd_data.3380e2ae8944a.0000000000000541
> >>>>>>>> [set-alloc-hint object_size 4194304 write_size 4194304,write
> >>>>>>>> 0~4194304] 8.5fb2123f ack+ondisk+write+known_if_redirected e56785)
> >>>>>>>>   currently waiting for subops from 13,17
> >>>>>>>> 2015-09-22 12:55:36.697927 osd.16 192.168.55.13:6800/29410 9 :
> cluster
> >>>>>>>> [WRN] slow request 30.379680 seconds old, received at 2015-09-22
> >>>>>>>> 12:55:06.318144:
> >>>>>>>>   osd_op(client.250874.0:1382
> rbd_data.3380e2ae8944a.000000000000053f
> >>>>>>>> [set-alloc-hint object_size 4194304 write_size 4194304,write
> >>>>>>>> 0~4194304] 8.312e69ca ack+ondisk+write+known_if_redirected e56785)
> >>>>>>>>   currently waiting for subops from 13,14
> >>>>>>>> 2015-09-22 12:58:03.998275 osd.13 192.168.55.12:6804/4574 130 :
> >>>>>>>> cluster [WRN] 1 slow requests, 1 included below; oldest blocked
> for >
> >>>>>>>> 30.954212 secs
> >>>>>>>> 2015-09-22 12:58:03.998286 osd.13 192.168.55.12:6804/4574 131 :
> >>>>>>>> cluster [WRN] slow request 30.954212 seconds old, received at
> >>>>>>>> 2015-09-22 12:57:33.044003:
> >>>>>>>>   osd_op(client.250874.0:1873
> rbd_data.3380e2ae8944a.000000000000070d
> >>>>>>>> [set-alloc-hint object_size 4194304 write_size 4194304,write
> >>>>>>>> 0~4194304] 8.e69870d4 ack+ondisk+write+known_if_redirected e56785)
> >>>>>>>>   currently waiting for subops from 16,17
> >>>>>>>> 2015-09-22 12:58:03.759826 osd.16 192.168.55.13:6800/29410 10 :
> >>>>>>>> cluster [WRN] 1 slow requests, 1 included below; oldest blocked
> for >
> >>>>>>>> 30.704367 secs
> >>>>>>>> 2015-09-22 12:58:03.759840 osd.16 192.168.55.13:6800/29410 11 :
> >>>>>>>> cluster [WRN] slow request 30.704367 seconds old, received at
> >>>>>>>> 2015-09-22 12:57:33.055404:
> >>>>>>>>   osd_op(client.250874.0:1874
> rbd_data.3380e2ae8944a.000000000000070e
> >>>>>>>> [set-alloc-hint object_size 4194304 write_size 4194304,write
> >>>>>>>> 0~4194304] 8.f7635819 ack+ondisk+write+known_if_redirected e56785)
> >>>>>>>>   currently waiting for subops from 13,17
> >>>>>>>>
> >>>>>>>> Server   IP addr              OSD
> >>>>>>>> nodev  - 192.168.55.11 - 12
> >>>>>>>> nodew  - 192.168.55.12 - 13
> >>>>>>>> nodex  - 192.168.55.13 - 16
> >>>>>>>> nodey  - 192.168.55.14 - 17
> >>>>>>>> nodez  - 192.168.55.15 - 14
> >>>>>>>> nodezz - 192.168.55.16 - 15
> >>>>>>>>
> >>>>>>>> fio job:
> >>>>>>>> [rbd-test]
> >>>>>>>> readwrite=write
> >>>>>>>> blocksize=4M
> >>>>>>>> #runtime=60
> >>>>>>>> name=rbd-test
> >>>>>>>> #readwrite=randwrite
> >>>>>>>> #bssplit=4k/85:32k/11:512/3:1m/1,4k/89:32k/10:512k/1
> >>>>>>>> #rwmixread=72
> >>>>>>>> #norandommap
> >>>>>>>> #size=1T
> >>>>>>>> #blocksize=4k
> >>>>>>>> ioengine=rbd
> >>>>>>>> rbdname=test2
> >>>>>>>> pool=rbd
> >>>>>>>> clientname=admin
> >>>>>>>> iodepth=8
> >>>>>>>> #numjobs=4
> >>>>>>>> #thread
> >>>>>>>> #group_reporting
> >>>>>>>> #time_based
> >>>>>>>> #direct=1
> >>>>>>>> #ramp_time=60
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> Thanks,
> >>>>>>>> -----BEGIN PGP SIGNATURE-----
> >>>>>>>> Version: Mailvelope v1.1.0
> >>>>>>>> Comment: https://www.mailvelope.com
> >>>>>>>>
> >>>>>>>> wsFcBAEBCAAQBQJWAcaKCRDmVDuy+mK58QAAPMsQAKBnS94fwuw0OqpPU3/z
> >>>>>>>> tL8Z6TVRxrNigf721+2ClIu4LIH71bupDc3DgrrysQmmqGuvEMn68spmasWu
> >>>>>>>> h9I/CqqgRpHqe4lUVoUEjyWA9/6Dbb6NiHSdpJ6p5jpGc8kZCvNS+ocDgFOl
> >>>>>>>> 903i0M0E9eEMeci5O/hrMrx1FG8SN2LS8nI261aNHMOwQK0bw8wWiCJEvqVB
> >>>>>>>> sz1/+jK1BJoeIYfaT9HfUXBAvfo/W3tY/vj9KbJuZJ5AMpeYPvEHu/LAr1N7
> >>>>>>>> FzzUc7a6EMlaxmSd0ML49JbV0cY9BMDjfrkKEQNKlzszlEHm3iif98QtsxbF
> >>>>>>>> pPJ0hZ0G53BY3k976OWVMFm3WFRWUVOb/oiLF8H6PCm59b4LBNAg6iPNH1AI
> >>>>>>>> 5XhEcPpg06M03vqUaIiY9P1kQlvnn0yCXf82IUEgmg///vhxDsHWmcwClLEn
> >>>>>>>> B0VszouStTzlMYnc/2vlUiI4gFVeilWLMW00VGTWV+7V1oIzIYvWHyl2QpBq
> >>>>>>>> 4/ZwVjQ43qLfuDTS4o+IJ4ztOMd26vIv6Mn6WVwKCjoCXJc8ajywR9Dy+6lL
> >>>>>>>> o8oJ+tn7hMc9Qy1iBhu3/QIP4WCsUf9RVeu60oahNEpde89qW32S9CZlrJDO
> >>>>>>>> gf4iTryRjkAhdmZIj9JiaE8jQ6dvN817D9cqs/CXKV9vhzYoM7p5YWHghBKB
> >>>>>>>> J3hS
> >>>>>>>> =0J7F
> >>>>>>>> -----END PGP SIGNATURE-----
> >>>>>>>> ----------------
> >>>>>>>> Robert LeBlanc
> >>>>>>>> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> On Tue, Sep 22, 2015 at 8:31 AM, Gregory Farnum  wrote:
> >>>>>>>>>
> >>>>>>>>> On Tue, Sep 22, 2015 at 7:24 AM, Robert LeBlanc  wrote:
> >>>>>>>>>>
> >>>>>>>>>> -----BEGIN PGP SIGNED MESSAGE-----
> >>>>>>>>>> Hash: SHA256
> >>>>>>>>>>
> >>>>>>>>>> Is there some way to tell in the logs that this is happening?
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> You can search for the (mangled) name _split_collection
> >>>>>>>>>>
> >>>>>>>>>> I'm not
> >>>>>>>>>> seeing much I/O, CPU usage during these times. Is there some
> way to
> >>>>>>>>>> prevent the splitting? Is there a negative side effect to doing
> so?
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> Bump up the split and merge thresholds. You can search the list
> for
> >>>>>>>>> this, it was discussed not too long ago.
> >>>>>>>>>
> >>>>>>>>>> We've had I/O block for over 900 seconds and as soon as the
> sessions
> >>>>>>>>>> are aborted, they are reestablished and complete immediately.
> >>>>>>>>>>
> >>>>>>>>>> The fio test is just a seq write, starting it over (rewriting
> from
> >>>>>>>>>> the
> >>>>>>>>>> beginning) is still causing the issue. I was suspect that it is
> not
> >>>>>>>>>> having to create new file and therefore split collections. This
> is
> >>>>>>>>>> on
> >>>>>>>>>> my test cluster with no other load.
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> Hmm, that does make it seem less likely if you're really not
> creating
> >>>>>>>>> new objects, if you're actually running fio in such a way that
> it's
> >>>>>>>>> not allocating new FS blocks (this is probably hard to set up?).
> >>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> I'll be doing a lot of testing today. Which log options and
> depths
> >>>>>>>>>> would be the most helpful for tracking this issue down?
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> If you want to go log diving "debug osd = 20", "debug filestore =
> >>>>>>>>> 20",
> >>>>>>>>> "debug ms = 1" are what the OSD guys like to see. That should
> spit
> >>>>>>>>> out
> >>>>>>>>> everything you need to track exactly what each Op is doing.
> >>>>>>>>> -Greg
> >>>>>>>>
> >>>>>>>> --
> >>>>>>>> To unsubscribe from this list: send the line "unsubscribe
> ceph-devel"
> >>>>>>>> in
> >>>>>>>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> >>>>>>>> More majordomo info at
> http://vger.kernel.org/majordomo-info.html
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>
> >>>>> -----BEGIN PGP SIGNATURE-----
> >>>>> Version: Mailvelope v1.1.0
> >>>>> Comment: https://www.mailvelope.com
> >>>>>
> >>>>> wsFcBAEBCAAQBQJWAdMSCRDmVDuy+mK58QAAoEgP/AqpH7i1BLpoz6fTlfWG
> >>>>> a6swvF8xvsyR15PDiPINYT0N7MgoikikGrMmhWpJ6utEr1XPW0MPFgzvNIsf
> >>>>> a1eMtNzyww4rAo6JCq6BtjmUsSKmOrBNhRNr6It9v4Nv+biqZHkiY8x/rRtV
> >>>>> s9z0cv3Q9Wqa6y/zKZg3H1XtbtUAx0r/DUwzSsP3omupZgNyaKkCgdkil9Vc
> >>>>> iyzBxFZU4+qXNT2FBG4dYDjxSHQv4psjvKR3AWXSN4yEn286KyMDjFrsDY5B
> >>>>> izS3h603QPoErqsUQngDE8COcaTAHHrV7gNJTikmGoNW6oQBjFq/z/zindTz
> >>>>> caXshVQQ+OTLo/qzJM8QPswh0TGU74SVbDkTq+eTOb5pBhQbp+42Pkkqh7jj
> >>>>> efyyYgDzpB1WrWRbUlWMNqmnjq7DT3lnAtuHyKbkwVs8x3JMPEiCl6PBvJbx
> >>>>> GnNSCqgDJrpb4fHQ2iqfQeh8Ai6AL1C1Ai19RZPrAUhpDW0/DbUvuoKSR8m7
> >>>>> glYYuH3hpy+oPYRhFcHm2fpNJ3u9npyk2Dai9RpzQ+mWmp3xi7becYmL482H
> >>>>> +WyvLeY+8AiJQDpA0CdD8KeSlOC9bw5TPmihAIn9dVTJ1O2RlapCLqL3YAJg
> >>>>> pGyDs8ercTEJLmvEyElj5XWh5DarsGscd2LELNS/UpyuYurbPcyPKUQ0uPjp
> >>>>> gcZm
> >>>>> =CjwB
> >>>>> -----END PGP SIGNATURE-----
> >>>>
> >>>> --
> >>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> in
> >>>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> >>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>>>
> >>>
> >>
> >> -----BEGIN PGP SIGNATURE-----
> >> Version: Mailvelope v1.1.0
> >> Comment: https://www.mailvelope.com
> >>
> >> wsFcBAEBCAAQBQJWAv3QCRDmVDuy+mK58QAABr4QAJcQj8zjl606aMdkmQG7
> >> S46iMXVav/Tv2os9GCUsQmMPx2u1w3/WmPfjByd6Divczfo0JLDDqrbsqre2
> >> lq0GNK6e8fq6FXHhPpnL+t4uFV4UZ289cma3yklRqEBDXWHlP59Hu7VpxC5l
> >> 0MIcCg4wM5VM/LkrfcMven5em5CnjyFJYbActGzw9043rZoyUwCM+eL7sotl
> >> JYHMcNWnqwdt8TLFDhUfVGiAQyV8/6E33CuCNUEuFGdtiBKzs9IZadOI8Ce0
> >> dod2DQNyFSvomqNq6t0DuTCSA+pT8uuks2O0NcrHjoqwIWVkxQGPYlpbpckf
> >> nxQdVM7vkqapVeQ0qUZx43Db9A5wDTC3PaEfVJZPZzWsSDjh9z7o6qHs3Kvp
> >> krfyS+dJaZ3tOYAP1VFDfasj06sOTFu3mfGYToKA75zz5HN7QZ13Zau/qhDu
> >> FHxsgk4oIXJsjj22LiSpoiigH5Ls+aVqtIbg8/vWp+EO6pK1fovEtJVeGAfE
> >> tLOdxfJJLVjMCAScFG9BRl1ePPLeptivKV0v9ruWsTpn+Q96VtqAR5GQCkYE
> >> hFrlxM+oIzHeArhhiIxSPCYLlnzxoD5IYXmTrWUYBCGvlY1mrI3j80mZ4VTj
> >> BErsSlqnjUyFKmaI7YNKyARCloMroz3wqdy/wpg/63Io62nmh5IyY+WO8hPo
> >> ae22
> >> =AX+L
> >> -----END PGP SIGNATURE-----
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--089e0102ef54afa8e70521415745
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Hi,</p>
<p dir=3D"ltr">I don&#39;t know what brand those 4TB spindles are, but I kn=
ow that mine are very bad at doing write at the same time as read. Especial=
ly small read write.</p>
<p dir=3D"ltr">This has an absurdly bad effect when doing maintenance on ce=
ph. That being said we see a lot of difference between dumpling and hammer =
in performance on these drives. Most likely due to hammer able to read writ=
e degraded PGs.</p>
<p dir=3D"ltr">We have run into two different problems along the way, the f=
irst was blocked request where we had to upgrade from 64GB mem on each node=
 to 256GB. We thought that it was the only safe buy make things better.</p>
<p dir=3D"ltr">I believe it worked because more reads were cached so we had=
 less mixed read write on the nodes, thus giving the spindles more room to =
breath. Now this was a shot in the dark then, but the price is not that hig=
h even to just try it out.. compared to 6 people working on it. I believe t=
he IO on disk was not huge either, but what kills the disk is high latency.=
 How much bandwidth are the disk using? We had very low.. 3-5MB/s.</p>
<p dir=3D"ltr">The second problem was defragmentations hitting 70%, lowerin=
g that to 6% made a lot of difference. Depending on IO pattern this increas=
es different.</p>
<p dir=3D"ltr">TL;DR read kills the 4TB spindles. </p>
<p dir=3D"ltr">Hope you guys clear out of the woods.<br>
/Josef</p>
<div class=3D"gmail_quote">On 3 Oct 2015 10:10 pm, &quot;Robert LeBlanc&quo=
t; &lt;<a href=3D"mailto:robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org">robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org</a>&gt;=
 wrote:<br type=3D"attribution"><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">-----BEGIN P=
GP SIGNED MESSAGE-----<br>
Hash: SHA256<br>
<br>
We are still struggling with this and have tried a lot of different<br>
things. Unfortunately, Inktank (now Red Hat) no longer provides<br>
consulting services for non-Red Hat systems. If there are some<br>
certified Ceph consultants in the US that we can do both remote and<br>
on-site engagements, please let us know.<br>
<br>
This certainly seems to be network related, but somewhere in the<br>
kernel. We have tried increasing the network and TCP buffers, number<br>
of TCP sockets, reduced the FIN_WAIT2 state. There is about 25% idle<br>
on the boxes, the disks are busy, but not constantly at 100% (they<br>
cycle from &lt;10% up to 100%, but not 100% for more than a few seconds<br>
at a time). There seems to be no reasonable explanation why I/O is<br>
blocked pretty frequently longer than 30 seconds. We have verified<br>
Jumbo frames by pinging from/to each node with 9000 byte packets. The<br>
network admins have verified that packets are not being dropped in the<br>
switches for these nodes. We have tried different kernels including<br>
the recent Google patch to cubic. This is showing up on three cluster<br>
(two Ethernet and one IPoIB). I booted one cluster into Debian Jessie<br>
(from CentOS 7.1) with similar results.<br>
<br>
The messages seem slightly different:<br>
2015-10-03 14:38:23.193082 osd.134 <a href=3D"http://10.208.16.25:6800/1425=
" rel=3D"noreferrer" target=3D"_blank">10.208.16.25:6800/1425</a> 439 :<br>
cluster [WRN] 14 slow requests, 1 included below; oldest blocked for &gt;<b=
r>
100.087155 secs<br>
2015-10-03 14:38:23.193090 osd.134 <a href=3D"http://10.208.16.25:6800/1425=
" rel=3D"noreferrer" target=3D"_blank">10.208.16.25:6800/1425</a> 440 :<br>
cluster [WRN] slow request 30.041999 seconds old, received at<br>
2015-10-03 14:37:53.151014: osd_op(client.1328605.0:7082862<br>
rbd_data.13fdcb2ae8944a.000000000001264f [read 975360~4096]<br>
11.6d19c36f ack+read+known_if_redirected e10249) currently no flag<br>
points reached<br>
<br>
I don&#39;t know what &quot;no flag points reached&quot; means.<br>
<br>
The problem is most pronounced when we have to reboot an OSD node (1<br>
of 13), we will have hundreds of I/O blocked for some times up to 300<br>
seconds. It takes a good 15 minutes for things to settle down. The<br>
production cluster is very busy doing normally 8,000 I/O and peaking<br>
at 15,000. This is all 4TB spindles with SSD journals and the disks<br>
are between 25-50% full. We are currently splitting PGs to distribute<br>
the load better across the disks, but we are having to do this 10 PGs<br>
at a time as we get blocked I/O. We have max_backfills and<br>
max_recovery set to 1, client op priority is set higher than recovery<br>
priority. We tried increasing the number of op threads but this didn&#39;t<=
br>
seem to help. It seems as soon as PGs are finished being checked, they<br>
become active and could be the cause for slow I/O while the other PGs<br>
are being checked.<br>
<br>
What I don&#39;t understand is that the messages are delayed. As soon as<br=
>
the message is received by Ceph OSD process, it is very quickly<br>
committed to the journal and a response is sent back to the primary<br>
OSD which is received very quickly as well. I&#39;ve adjust<br>
min_free_kbytes and it seems to keep the OSDs from crashing, but<br>
doesn&#39;t solve the main problem. We don&#39;t have swap and there is 64 =
GB<br>
of RAM per nodes for 10 OSDs.<br>
<br>
Is there something that could cause the kernel to get a packet but not<br>
be able to dispatch it to Ceph such that it could be explaining why we<br>
are seeing these blocked I/O for 30+ seconds. Is there some pointers<br>
to tracing Ceph messages from the network buffer through the kernel to<br>
the Ceph process?<br>
<br>
We can really use some pointers no matter how outrageous. We&#39;ve have<br=
>
over 6 people looking into this for weeks now and just can&#39;t think of<b=
r>
anything else.<br>
<br>
Thanks,<br>
-----BEGIN PGP SIGNATURE-----<br>
Version: Mailvelope v1.1.0<br>
Comment: <a href=3D"https://www.mailvelope.com" rel=3D"noreferrer" target=
=3D"_blank">https://www.mailvelope.com</a><br>
<br>
wsFcBAEBCAAQBQJWEDY1CRDmVDuy+mK58QAARgoP/RcoL1qVmg7qbQrzStar<br>
NK80bqYGeYHb26xHbt1fZVgnZhXU0nN0Dv4ew0e/cYJLELSO2KCeXNfXN6F1<br>
prZuzYagYEyj1Q1TOo+4h/nOQRYsTwQDdFzbHb/OUDN55C0QGZ29DjEvrqP6<br>
K5l6sAQzvQDpUEEIiOCkS6pH59ira740nSmnYkEWhr1lxF/hMjb6fFlfCFe2<br>
h1djM0GfY7vBHFGgI3jkw0BL5AQnWe+SCcCiKZmxY6xiR70FWl3XqK5M+nxm<br>
iq74y7Dv6cpenit6boMr6qtOeIt+8ko85hVMh09Hkaqz/m2FzxAKLcahzkGF<br>
Fh/M6YBzgnX7QBURTC4YQT/FVyDTW3JMuT3RKQdaX6c0iiOsVdkE+iyidWyY<br>
Hr1KzWU23Ur9yBfZ39Y43jrsSiAEwHnKjSqMowSGljdTysNEAAZQhlqZIoHb<br>
JlgpB39ugkHI1H5fZ5b2SIDz32/d5ywG4Gay9Rk6hp8VanvIrBbev+JYEoYT<br>
8/WX+fhueHt4dqUYWIl3HZ0CEzbXbug0xmFvhrbmL2f3t9XOkDZRbAjlYrGm<br>
lswiJMDueY8JkxSnPvCQrHXqjbCcy9rMG7nTnLFz98rTcHNCwtpv0qVYhheg<br>
4YRNRVMbfNP/6xsJvG1wVOSQPwxZSPqJh42pDqMRePJl3Zn66MTx5wvdNDpk<br>
l7OF<br>
=3DOI++<br>
-----END PGP SIGNATURE-----<br>
----------------<br>
Robert LeBlanc<br>
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904=C2=A0 C70E E654 3BB2 FA62 B9F1<br>
<br>
<br>
On Fri, Sep 25, 2015 at 2:40 PM, Robert LeBlanc &lt;<a href=3D"mailto:rober=
t@leblancnet.us">robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org</a>&gt; wrote:<br>
&gt; We dropped the replication on our cluster from 4 to 3 and it looks<br>
&gt; like all the blocked I/O has stopped (no entries in the log for the<br=
>
&gt; last 12 hours). This makes me believe that there is some issue with<br=
>
&gt; the number of sockets or some other TCP issue. We have not messed with=
<br>
&gt; Ephemeral ports and TIME_WAIT at this point. There are 130 OSDs, 8 KVM=
<br>
&gt; hosts hosting about 150 VMs. Open files is set at 32K for the OSD<br>
&gt; processes and 16K system wide.<br>
&gt;<br>
&gt; Does this seem like the right spot to be looking? What are some<br>
&gt; configuration items we should be looking at?<br>
&gt;<br>
&gt; Thanks,<br>
&gt; ----------------<br>
&gt; Robert LeBlanc<br>
&gt; PGP Fingerprint 79A2 9CA4 6CC4 45DD A904=C2=A0 C70E E654 3BB2 FA62 B9F=
1<br>
&gt;<br>
&gt;<br>
&gt; On Wed, Sep 23, 2015 at 1:30 PM, Robert LeBlanc &lt;<a href=3D"mailto:=
robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org">robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org</a>&gt; wrote:<br>
&gt;&gt; -----BEGIN PGP SIGNED MESSAGE-----<br>
&gt;&gt; Hash: SHA256<br>
&gt;&gt;<br>
&gt;&gt; We were able to only get ~17Gb out of the XL710 (heavily tweaked)<=
br>
&gt;&gt; until we went to the 4.x kernel where we got ~36Gb (no tweaking). =
It<br>
&gt;&gt; seems that there were some major reworks in the network handling i=
n<br>
&gt;&gt; the kernel to efficiently handle that network rate. If I remember<=
br>
&gt;&gt; right we also saw a drop in CPU utilization. I&#39;m starting to t=
hink<br>
&gt;&gt; that we did see packet loss while congesting our ISLs in our initi=
al<br>
&gt;&gt; testing, but we could not tell where the dropping was happening. W=
e<br>
&gt;&gt; saw some on the switches, but it didn&#39;t seem to be bad if we w=
eren&#39;t<br>
&gt;&gt; trying to congest things. We probably already saw this issue, just=
<br>
&gt;&gt; didn&#39;t know it.<br>
&gt;&gt; - ----------------<br>
&gt;&gt; Robert LeBlanc<br>
&gt;&gt; PGP Fingerprint 79A2 9CA4 6CC4 45DD A904=C2=A0 C70E E654 3BB2 FA62=
 B9F1<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; On Wed, Sep 23, 2015 at 1:10 PM, Mark Nelson=C2=A0 wrote:<br>
&gt;&gt;&gt; FWIW, we&#39;ve got some 40GbE Intel cards in the community pe=
rformance cluster<br>
&gt;&gt;&gt; on a Mellanox 40GbE switch that appear (knock on wood) to be r=
unning fine<br>
&gt;&gt;&gt; with 3.10.0-229.7.2.el7.x86_64.=C2=A0 We did get feedback from=
 Intel that older<br>
&gt;&gt;&gt; drivers might cause problems though.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Here&#39;s ifconfig from one of the nodes:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; ens513f1: flags=3D4163=C2=A0 mtu 1500<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0inet 10.0.10.101=C2=A0 netmas=
k 255.255.255.0=C2=A0 broadcast 10.0.10.255<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0inet6 fe80::6a05:caff:fe2b:7e=
a1=C2=A0 prefixlen 64=C2=A0 scopeid 0x20<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ether 68:05:ca:2b:7e:a1=C2=A0=
 txqueuelen 1000=C2=A0 (Ethernet)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RX packets 169232242875=C2=A0=
 bytes 229346261232279 (208.5 TiB)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RX errors 0=C2=A0 dropped 0=
=C2=A0 overruns 0=C2=A0 frame 0<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TX packets 153491686361=C2=A0=
 bytes 203976410836881 (185.5 TiB)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TX errors 0=C2=A0 dropped 0 o=
verruns 0=C2=A0 carrier 0=C2=A0 collisions 0<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Mark<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; On 09/23/2015 01:48 PM, Robert LeBlanc wrote:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; -----BEGIN PGP SIGNED MESSAGE-----<br>
&gt;&gt;&gt;&gt; Hash: SHA256<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; OK, here is the update on the saga...<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; I traced some more of blocked I/Os and it seems that commu=
nication<br>
&gt;&gt;&gt;&gt; between two hosts seemed worse than others. I did a two wa=
y ping flood<br>
&gt;&gt;&gt;&gt; between the two hosts using max packet sizes (1500). After=
 1.5M<br>
&gt;&gt;&gt;&gt; packets, no lost pings. Then then had the ping flood runni=
ng while I<br>
&gt;&gt;&gt;&gt; put Ceph load on the cluster and the dropped pings started=
 increasing<br>
&gt;&gt;&gt;&gt; after stopping the Ceph workload the pings stopped droppin=
g.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; I then ran iperf between all the nodes with the same resul=
ts, so that<br>
&gt;&gt;&gt;&gt; ruled out Ceph to a large degree. I then booted in the the=
<br>
&gt;&gt;&gt;&gt; 3.10.0-229.14.1.el7.x86_64 kernel and with an hour test so=
 far there<br>
&gt;&gt;&gt;&gt; hasn&#39;t been any dropped pings or blocked I/O. Our 40 G=
b NICs really<br>
&gt;&gt;&gt;&gt; need the network enhancements in the 4.x series to work we=
ll.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Does this sound familiar to anyone? I&#39;ll probably star=
t bisecting the<br>
&gt;&gt;&gt;&gt; kernel to see where this issue in introduced. Both of the =
clusters<br>
&gt;&gt;&gt;&gt; with this issue are running 4.x, other than that, they are=
 pretty<br>
&gt;&gt;&gt;&gt; differing hardware and network configs.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Thanks,<br>
&gt;&gt;&gt;&gt; -----BEGIN PGP SIGNATURE-----<br>
&gt;&gt;&gt;&gt; Version: Mailvelope v1.1.0<br>
&gt;&gt;&gt;&gt; Comment: <a href=3D"https://www.mailvelope.com" rel=3D"nor=
eferrer" target=3D"_blank">https://www.mailvelope.com</a><br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; wsFcBAEBCAAQBQJWAvOzCRDmVDuy+mK58QAApOMP/1xmCtW++G11qcE8y/=
sr<br>
&gt;&gt;&gt;&gt; RkXguqZJLc4czdOwV/tjUvhVsm5qOl4wvQCtABFZpc6t4+m5nzE3LkA1rl=
2l<br>
&gt;&gt;&gt;&gt; AnARPOjh61TO6cV0CT8O0DlqtHmSd2y0ElgAUl0594eInEn7eI7crz8R54=
3V<br>
&gt;&gt;&gt;&gt; 7I68XU5zL/vNJ9IIx38UqdhtSzXQQL664DGq3DLINK0Yb9XRVBlFip+Slt=
+j<br>
&gt;&gt;&gt;&gt; cB64TuWjOPLSH09pv7SUyksodqrTq3K7p6sQkq0MOzBkFQM1FHfOipbo/L=
Yv<br>
&gt;&gt;&gt;&gt; F42iiQbCvFizArMu20WeOSQ4dmrXT/iecgTfEag/Zxvor2gOi/J6d2XS9c=
kW<br>
&gt;&gt;&gt;&gt; byEC5/rbm4yDBua2ZugeNxQLWq0Oa7spZnx7usLsu/6YzeDNI6kmtGURaj=
dE<br>
&gt;&gt;&gt;&gt; /XC8bESWKveBzmGDzjff5oaMs9A1PZURYnlYADEODGAt6byoaoQEGN6dlF=
Ge<br>
&gt;&gt;&gt;&gt; LwQ5nOdQYuUrWpJzTJBN3aduOxursoFY8S0eR0uXm0l1CHcp22RWBDvRin=
ok<br>
&gt;&gt;&gt;&gt; UWk5xRBgjDCD2gIwc+wpImZbCtiTdf0vad1uLvdxGL29iFta4THzJgUGrp=
98<br>
&gt;&gt;&gt;&gt; sUqM3RaTRdJYjFcNP293H7/DC0mqpnmo0Clx3jkdHX+x1EXpJUtocSeI44=
LX<br>
&gt;&gt;&gt;&gt; KWIMhe9wXtKAoHQFEcJ0o0+wrXWMevvx33HPC4q1ULrFX0ILNx5Mo0Rp94=
4X<br>
&gt;&gt;&gt;&gt; 4OEo<br>
&gt;&gt;&gt;&gt; =3DP33I<br>
&gt;&gt;&gt;&gt; -----END PGP SIGNATURE-----<br>
&gt;&gt;&gt;&gt; ----------------<br>
&gt;&gt;&gt;&gt; Robert LeBlanc<br>
&gt;&gt;&gt;&gt; PGP Fingerprint 79A2 9CA4 6CC4 45DD A904=C2=A0 C70E E654 3=
BB2 FA62 B9F1<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; On Tue, Sep 22, 2015 at 4:15 PM, Robert LeBlanc<br>
&gt;&gt;&gt;&gt; wrote:<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; -----BEGIN PGP SIGNED MESSAGE-----<br>
&gt;&gt;&gt;&gt;&gt; Hash: SHA256<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; This is IPoIB and we have the MTU set to 64K. There wa=
s some issues<br>
&gt;&gt;&gt;&gt;&gt; pinging hosts with &quot;No buffer space available&quo=
t; (hosts are currently<br>
&gt;&gt;&gt;&gt;&gt; configured for 4GB to test SSD caching rather than pag=
e cache). I<br>
&gt;&gt;&gt;&gt;&gt; found that MTU under 32K worked reliable for ping, but=
 still had the<br>
&gt;&gt;&gt;&gt;&gt; blocked I/O.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; I reduced the MTU to 1500 and checked pings (OK), but =
I&#39;m still seeing<br>
&gt;&gt;&gt;&gt;&gt; the blocked I/O.<br>
&gt;&gt;&gt;&gt;&gt; - ----------------<br>
&gt;&gt;&gt;&gt;&gt; Robert LeBlanc<br>
&gt;&gt;&gt;&gt;&gt; PGP Fingerprint 79A2 9CA4 6CC4 45DD A904=C2=A0 C70E E6=
54 3BB2 FA62 B9F1<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; On Tue, Sep 22, 2015 at 3:52 PM, Sage Weil=C2=A0 wrote=
:<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; On Tue, 22 Sep 2015, Samuel Just wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; I looked at the logs, it looks like there was =
a 53 second delay<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; between when osd.17 started sending the osd_re=
pop message and when<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; osd.13 started reading it, which is pretty wei=
rd.=C2=A0 Sage, didn&#39;t we<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; once see a kernel issue which caused some mess=
ages to be mysteriously<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; delayed for many 10s of seconds?<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Every time we have seen this behavior and diagnose=
d it in the wild it<br>
&gt;&gt;&gt;&gt;&gt;&gt; has<br>
&gt;&gt;&gt;&gt;&gt;&gt; been a network misconfiguration.=C2=A0 Usually rel=
ated to jumbo frames.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; sage<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; What kernel are you running?<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; -Sam<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; On Tue, Sep 22, 2015 at 2:22 PM, Robert LeBlan=
c=C2=A0 wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; -----BEGIN PGP SIGNED MESSAGE-----<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Hash: SHA256<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; OK, looping in ceph-devel to see if I can =
get some more eyes. I&#39;ve<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; extracted what I think are important entri=
es from the logs for the<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; first blocked request. NTP is running all =
the servers so the logs<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; should be close in terms of time. Logs for=
 12:50 to 13:00 are<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; available at <a href=3D"http://162.144.87.=
113/files/ceph_block_io.logs.tar.xz" rel=3D"noreferrer" target=3D"_blank">h=
ttp://162.144.87.113/files/ceph_block_io.logs.tar.xz</a><br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:55:06.500374 - osd.17 gets I=
/O from client<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:55:06.557160 - osd.17 submit=
s I/O to osd.13<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:55:06.557305 - osd.17 submit=
s I/O to osd.16<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:55:06.573711 - osd.16 gets I=
/O from osd.17<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:55:06.595716 - osd.17 gets o=
ndisk result=3D0 from osd.16<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:55:06.640631 - osd.16 report=
s to osd.17 ondisk result=3D0<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:55:36.926691 - osd.17 report=
s slow I/O &gt; 30.439150 sec<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:55:59.790591 - osd.13 gets I=
/O from osd.17<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:55:59.812405 - osd.17 gets o=
ndisk result=3D0 from osd.13<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:56:02.941602 - osd.13 report=
s to osd.17 ondisk result=3D0<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; In the logs I can see that osd.17 dispatch=
es the I/O to osd.13 and<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; osd.16 almost silmutaniously. osd.16 seems=
 to get the I/O right away,<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; but for some reason osd.13 doesn&#39;t get=
 the message until 53 seconds<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; later. osd.17 seems happy to just wait and=
 doesn&#39;t resend the data<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; (well, I&#39;m not 100% sure how to tell w=
hich entries are the actual data<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; transfer).<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; It looks like osd.17 is receiving response=
s to start the communication<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; with osd.13, but the op is not acknowledge=
d until almost a minute<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; later. To me it seems that the message is =
getting received but not<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; passed to another thread right away or som=
ething. This test was done<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; with an idle cluster, a single fio client =
(rbd engine) with a single<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; thread.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; The OSD servers are almost 100% idle durin=
g these blocked I/O<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; requests. I think I&#39;m at the end of my=
 troubleshooting, so I can use<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; some help.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Single Test started about<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:52:36<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:55:36.926680 osd.17 <a href=
=3D"http://192.168.55.14:6800/16726" rel=3D"noreferrer" target=3D"_blank">1=
92.168.55.14:6800/16726</a> 56 :<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; cluster [WRN] 1 slow requests, 1 included =
below; oldest blocked for &gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 30.439150 secs<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:55:36.926699 osd.17 <a href=
=3D"http://192.168.55.14:6800/16726" rel=3D"noreferrer" target=3D"_blank">1=
92.168.55.14:6800/16726</a> 57 :<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; cluster [WRN] slow request 30.439150 secon=
ds old, received at<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:55:06.487451:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0osd_op(client.250874.0:1388 rb=
d_data.3380e2ae8944a.0000000000000545<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [set-alloc-hint object_size 4194304 write_=
size 4194304,write<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 0~4194304] 8.bbf3e8ff ack+ondisk+write+kno=
wn_if_redirected e56785)<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0currently waiting for subops f=
rom 13,16<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:55:36.697904 osd.16 <a href=
=3D"http://192.168.55.13:6800/29410" rel=3D"noreferrer" target=3D"_blank">1=
92.168.55.13:6800/29410</a> 7 : cluster<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [WRN] 2 slow requests, 2 included below; o=
ldest blocked for &gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 30.379680 secs<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:55:36.697918 osd.16 <a href=
=3D"http://192.168.55.13:6800/29410" rel=3D"noreferrer" target=3D"_blank">1=
92.168.55.13:6800/29410</a> 8 : cluster<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [WRN] slow request 30.291520 seconds old, =
received at 2015-09-22<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 12:55:06.406303:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0osd_op(client.250874.0:1384 rb=
d_data.3380e2ae8944a.0000000000000541<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [set-alloc-hint object_size 4194304 write_=
size 4194304,write<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 0~4194304] 8.5fb2123f ack+ondisk+write+kno=
wn_if_redirected e56785)<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0currently waiting for subops f=
rom 13,17<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:55:36.697927 osd.16 <a href=
=3D"http://192.168.55.13:6800/29410" rel=3D"noreferrer" target=3D"_blank">1=
92.168.55.13:6800/29410</a> 9 : cluster<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [WRN] slow request 30.379680 seconds old, =
received at 2015-09-22<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 12:55:06.318144:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0osd_op(client.250874.0:1382 rb=
d_data.3380e2ae8944a.000000000000053f<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [set-alloc-hint object_size 4194304 write_=
size 4194304,write<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 0~4194304] 8.312e69ca ack+ondisk+write+kno=
wn_if_redirected e56785)<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0currently waiting for subops f=
rom 13,14<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:58:03.998275 osd.13 <a href=
=3D"http://192.168.55.12:6804/4574" rel=3D"noreferrer" target=3D"_blank">19=
2.168.55.12:6804/4574</a> 130 :<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; cluster [WRN] 1 slow requests, 1 included =
below; oldest blocked for &gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 30.954212 secs<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:58:03.998286 osd.13 <a href=
=3D"http://192.168.55.12:6804/4574" rel=3D"noreferrer" target=3D"_blank">19=
2.168.55.12:6804/4574</a> 131 :<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; cluster [WRN] slow request 30.954212 secon=
ds old, received at<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:57:33.044003:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0osd_op(client.250874.0:1873 rb=
d_data.3380e2ae8944a.000000000000070d<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [set-alloc-hint object_size 4194304 write_=
size 4194304,write<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 0~4194304] 8.e69870d4 ack+ondisk+write+kno=
wn_if_redirected e56785)<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0currently waiting for subops f=
rom 16,17<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:58:03.759826 osd.16 <a href=
=3D"http://192.168.55.13:6800/29410" rel=3D"noreferrer" target=3D"_blank">1=
92.168.55.13:6800/29410</a> 10 :<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; cluster [WRN] 1 slow requests, 1 included =
below; oldest blocked for &gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 30.704367 secs<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:58:03.759840 osd.16 <a href=
=3D"http://192.168.55.13:6800/29410" rel=3D"noreferrer" target=3D"_blank">1=
92.168.55.13:6800/29410</a> 11 :<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; cluster [WRN] slow request 30.704367 secon=
ds old, received at<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:57:33.055404:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0osd_op(client.250874.0:1874 rb=
d_data.3380e2ae8944a.000000000000070e<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [set-alloc-hint object_size 4194304 write_=
size 4194304,write<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 0~4194304] 8.f7635819 ack+ondisk+write+kno=
wn_if_redirected e56785)<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0currently waiting for subops f=
rom 13,17<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Server=C2=A0 =C2=A0IP addr=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OSD<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; nodev=C2=A0 - 192.168.55.11 - 12<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; nodew=C2=A0 - 192.168.55.12 - 13<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; nodex=C2=A0 - 192.168.55.13 - 16<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; nodey=C2=A0 - 192.168.55.14 - 17<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; nodez=C2=A0 - 192.168.55.15 - 14<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; nodezz - 192.168.55.16 - 15<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; fio job:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [rbd-test]<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; readwrite=3Dwrite<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; blocksize=3D4M<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; #runtime=3D60<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; name=3Drbd-test<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; #readwrite=3Drandwrite<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; #bssplit=3D4k/85:32k/11:512/3:1m/1,4k/89:3=
2k/10:512k/1<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; #rwmixread=3D72<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; #norandommap<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; #size=3D1T<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; #blocksize=3D4k<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; ioengine=3Drbd<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; rbdname=3Dtest2<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; pool=3Drbd<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; clientname=3Dadmin<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; iodepth=3D8<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; #numjobs=3D4<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; #thread<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; #group_reporting<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; #time_based<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; #direct=3D1<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; #ramp_time=3D60<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Thanks,<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; -----BEGIN PGP SIGNATURE-----<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Version: Mailvelope v1.1.0<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Comment: <a href=3D"https://www.mailvelope=
.com" rel=3D"noreferrer" target=3D"_blank">https://www.mailvelope.com</a><b=
r>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; wsFcBAEBCAAQBQJWAcaKCRDmVDuy+mK58QAAPMsQAK=
BnS94fwuw0OqpPU3/z<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; tL8Z6TVRxrNigf721+2ClIu4LIH71bupDc3DgrrysQ=
mmqGuvEMn68spmasWu<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; h9I/CqqgRpHqe4lUVoUEjyWA9/6Dbb6NiHSdpJ6p5j=
pGc8kZCvNS+ocDgFOl<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 903i0M0E9eEMeci5O/hrMrx1FG8SN2LS8nI261aNHM=
OwQK0bw8wWiCJEvqVB<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; sz1/+jK1BJoeIYfaT9HfUXBAvfo/W3tY/vj9KbJuZJ=
5AMpeYPvEHu/LAr1N7<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; FzzUc7a6EMlaxmSd0ML49JbV0cY9BMDjfrkKEQNKlz=
szlEHm3iif98QtsxbF<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; pPJ0hZ0G53BY3k976OWVMFm3WFRWUVOb/oiLF8H6PC=
m59b4LBNAg6iPNH1AI<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 5XhEcPpg06M03vqUaIiY9P1kQlvnn0yCXf82IUEgmg=
///vhxDsHWmcwClLEn<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; B0VszouStTzlMYnc/2vlUiI4gFVeilWLMW00VGTWV+=
7V1oIzIYvWHyl2QpBq<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 4/ZwVjQ43qLfuDTS4o+IJ4ztOMd26vIv6Mn6WVwKCj=
oCXJc8ajywR9Dy+6lL<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; o8oJ+tn7hMc9Qy1iBhu3/QIP4WCsUf9RVeu60oahNE=
pde89qW32S9CZlrJDO<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; gf4iTryRjkAhdmZIj9JiaE8jQ6dvN817D9cqs/CXKV=
9vhzYoM7p5YWHghBKB<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; J3hS<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =3D0J7F<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; -----END PGP SIGNATURE-----<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; ----------------<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Robert LeBlanc<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; PGP Fingerprint 79A2 9CA4 6CC4 45DD A904=
=C2=A0 C70E E654 3BB2 FA62 B9F1<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; On Tue, Sep 22, 2015 at 8:31 AM, Gregory F=
arnum=C2=A0 wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; On Tue, Sep 22, 2015 at 7:24 AM, Rober=
t LeBlanc=C2=A0 wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; -----BEGIN PGP SIGNED MESSAGE-----=
<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Hash: SHA256<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Is there some way to tell in the l=
ogs that this is happening?<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; You can search for the (mangled) name =
_split_collection<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; I&#39;m not<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; seeing much I/O, CPU usage during =
these times. Is there some way to<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; prevent the splitting? Is there a =
negative side effect to doing so?<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Bump up the split and merge thresholds=
. You can search the list for<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; this, it was discussed not too long ag=
o.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; We&#39;ve had I/O block for over 9=
00 seconds and as soon as the sessions<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; are aborted, they are reestablishe=
d and complete immediately.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; The fio test is just a seq write, =
starting it over (rewriting from<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; the<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; beginning) is still causing the is=
sue. I was suspect that it is not<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; having to create new file and ther=
efore split collections. This is<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; on<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; my test cluster with no other load=
.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Hmm, that does make it seem less likel=
y if you&#39;re really not creating<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; new objects, if you&#39;re actually ru=
nning fio in such a way that it&#39;s<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; not allocating new FS blocks (this is =
probably hard to set up?).<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; I&#39;ll be doing a lot of testing=
 today. Which log options and depths<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; would be the most helpful for trac=
king this issue down?<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; If you want to go log diving &quot;deb=
ug osd =3D 20&quot;, &quot;debug filestore =3D<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 20&quot;,<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &quot;debug ms =3D 1&quot; are what th=
e OSD guys like to see. That should spit<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; out<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; everything you need to track exactly w=
hat each Op is doing.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; -Greg<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; --<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; To unsubscribe from this list: send the li=
ne &quot;unsubscribe ceph-devel&quot;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; in<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; the body of a message to <a href=3D"mailto=
:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; More majordomo info at=C2=A0 <a href=3D"ht=
tp://vger.kernel.org/majordomo-info.html" rel=3D"noreferrer" target=3D"_bla=
nk">http://vger.kernel.org/majordomo-info.html</a><br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; -----BEGIN PGP SIGNATURE-----<br>
&gt;&gt;&gt;&gt;&gt; Version: Mailvelope v1.1.0<br>
&gt;&gt;&gt;&gt;&gt; Comment: <a href=3D"https://www.mailvelope.com" rel=3D=
"noreferrer" target=3D"_blank">https://www.mailvelope.com</a><br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; wsFcBAEBCAAQBQJWAdMSCRDmVDuy+mK58QAAoEgP/AqpH7i1BLpoz6=
fTlfWG<br>
&gt;&gt;&gt;&gt;&gt; a6swvF8xvsyR15PDiPINYT0N7MgoikikGrMmhWpJ6utEr1XPW0MPFg=
zvNIsf<br>
&gt;&gt;&gt;&gt;&gt; a1eMtNzyww4rAo6JCq6BtjmUsSKmOrBNhRNr6It9v4Nv+biqZHkiY8=
x/rRtV<br>
&gt;&gt;&gt;&gt;&gt; s9z0cv3Q9Wqa6y/zKZg3H1XtbtUAx0r/DUwzSsP3omupZgNyaKkCgd=
kil9Vc<br>
&gt;&gt;&gt;&gt;&gt; iyzBxFZU4+qXNT2FBG4dYDjxSHQv4psjvKR3AWXSN4yEn286KyMDjF=
rsDY5B<br>
&gt;&gt;&gt;&gt;&gt; izS3h603QPoErqsUQngDE8COcaTAHHrV7gNJTikmGoNW6oQBjFq/z/=
zindTz<br>
&gt;&gt;&gt;&gt;&gt; caXshVQQ+OTLo/qzJM8QPswh0TGU74SVbDkTq+eTOb5pBhQbp+42Pk=
kqh7jj<br>
&gt;&gt;&gt;&gt;&gt; efyyYgDzpB1WrWRbUlWMNqmnjq7DT3lnAtuHyKbkwVs8x3JMPEiCl6=
PBvJbx<br>
&gt;&gt;&gt;&gt;&gt; GnNSCqgDJrpb4fHQ2iqfQeh8Ai6AL1C1Ai19RZPrAUhpDW0/DbUvuo=
KSR8m7<br>
&gt;&gt;&gt;&gt;&gt; glYYuH3hpy+oPYRhFcHm2fpNJ3u9npyk2Dai9RpzQ+mWmp3xi7becY=
mL482H<br>
&gt;&gt;&gt;&gt;&gt; +WyvLeY+8AiJQDpA0CdD8KeSlOC9bw5TPmihAIn9dVTJ1O2RlapCLq=
L3YAJg<br>
&gt;&gt;&gt;&gt;&gt; pGyDs8ercTEJLmvEyElj5XWh5DarsGscd2LELNS/UpyuYurbPcyPKU=
Q0uPjp<br>
&gt;&gt;&gt;&gt;&gt; gcZm<br>
&gt;&gt;&gt;&gt;&gt; =3DCjwB<br>
&gt;&gt;&gt;&gt;&gt; -----END PGP SIGNATURE-----<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; --<br>
&gt;&gt;&gt;&gt; To unsubscribe from this list: send the line &quot;unsubsc=
ribe ceph-devel&quot; in<br>
&gt;&gt;&gt;&gt; the body of a message to <a href=3D"mailto:majordomo@vger.=
kernel.org">majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br>
&gt;&gt;&gt;&gt; More majordomo info at=C2=A0 <a href=3D"http://vger.kernel=
.org/majordomo-info.html" rel=3D"noreferrer" target=3D"_blank">http://vger.=
kernel.org/majordomo-info.html</a><br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; -----BEGIN PGP SIGNATURE-----<br>
&gt;&gt; Version: Mailvelope v1.1.0<br>
&gt;&gt; Comment: <a href=3D"https://www.mailvelope.com" rel=3D"noreferrer"=
 target=3D"_blank">https://www.mailvelope.com</a><br>
&gt;&gt;<br>
&gt;&gt; wsFcBAEBCAAQBQJWAv3QCRDmVDuy+mK58QAABr4QAJcQj8zjl606aMdkmQG7<br>
&gt;&gt; S46iMXVav/Tv2os9GCUsQmMPx2u1w3/WmPfjByd6Divczfo0JLDDqrbsqre2<br>
&gt;&gt; lq0GNK6e8fq6FXHhPpnL+t4uFV4UZ289cma3yklRqEBDXWHlP59Hu7VpxC5l<br>
&gt;&gt; 0MIcCg4wM5VM/LkrfcMven5em5CnjyFJYbActGzw9043rZoyUwCM+eL7sotl<br>
&gt;&gt; JYHMcNWnqwdt8TLFDhUfVGiAQyV8/6E33CuCNUEuFGdtiBKzs9IZadOI8Ce0<br>
&gt;&gt; dod2DQNyFSvomqNq6t0DuTCSA+pT8uuks2O0NcrHjoqwIWVkxQGPYlpbpckf<br>
&gt;&gt; nxQdVM7vkqapVeQ0qUZx43Db9A5wDTC3PaEfVJZPZzWsSDjh9z7o6qHs3Kvp<br>
&gt;&gt; krfyS+dJaZ3tOYAP1VFDfasj06sOTFu3mfGYToKA75zz5HN7QZ13Zau/qhDu<br>
&gt;&gt; FHxsgk4oIXJsjj22LiSpoiigH5Ls+aVqtIbg8/vWp+EO6pK1fovEtJVeGAfE<br>
&gt;&gt; tLOdxfJJLVjMCAScFG9BRl1ePPLeptivKV0v9ruWsTpn+Q96VtqAR5GQCkYE<br>
&gt;&gt; hFrlxM+oIzHeArhhiIxSPCYLlnzxoD5IYXmTrWUYBCGvlY1mrI3j80mZ4VTj<br>
&gt;&gt; BErsSlqnjUyFKmaI7YNKyARCloMroz3wqdy/wpg/63Io62nmh5IyY+WO8hPo<br>
&gt;&gt; ae22<br>
&gt;&gt; =3DAX+L<br>
&gt;&gt; -----END PGP SIGNATURE-----<br>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><=
br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-=
ceph.com</a><br>
</blockquote></div>

--089e0102ef54afa8e70521415745--

--===============2141083990==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============2141083990==--
