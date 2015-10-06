From: Robert LeBlanc <robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org>
Subject: Re: Potential OSD deadlock?
Date: Tue, 6 Oct 2015 08:30:35 -0600
Message-ID: <CAANLjFo==i7wivrGR9LJFs3GOrD2iQHLdCpEfR-AruHyOMLi-w@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============1758183069=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1510060534010.32037-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============1758183069==
Content-Type: multipart/alternative; boundary=001a11c013002597f605217079e9

--001a11c013002597f605217079e9
Content-Type: text/plain; charset=UTF-8

Thanks for your time Sage. It sounds like a few people may be helped if you
can find something.

I did a recursive chown as in the instructions (although I didn't know
about the doc at the time). I did an osd debug at 20/20 but didn't see
anything. I'll also do ms and make the logs available. I'll also review the
document to make sure I didn't miss anything else.

Robert LeBlanc

Sent from a mobile device please excuse any typos.
On Oct 6, 2015 6:37 AM, "Sage Weil" <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> On Mon, 5 Oct 2015, Robert LeBlanc wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA256
> >
> > With some off-list help, we have adjusted
> > osd_client_message_cap=10000. This seems to have helped a bit and we
> > have seen some OSDs have a value up to 4,000 for client messages. But
> > it does not solve the problem with the blocked I/O.
> >
> > One thing that I have noticed is that almost exactly 30 seconds elapse
> > between an OSD boots and the first blocked I/O message. I don't know
> > if the OSD doesn't have time to get it's brain right about a PG before
> > it starts servicing it or what exactly.
>
> I'm downloading the logs from yesterday now; sorry it's taking so long.
>
> > On another note, I tried upgrading our CentOS dev cluster from Hammer
> > to master and things didn't go so well. The OSDs would not start
> > because /var/lib/ceph was not owned by ceph. I chowned the directory
> > and all OSDs and the OSD then started, but never became active in the
> > cluster. It just sat there after reading all the PGs. There were
> > sockets open to the monitor, but no OSD to OSD sockets. I tried
> > downgrading to the Infernalis branch and still no luck getting the
> > OSDs to come up. The OSD processes were idle after the initial boot.
> > All packages were installed from gitbuilder.
>
> Did you chown -R ?
>
>
> https://github.com/ceph/ceph/blob/infernalis/doc/release-notes.rst#upgrading-from-hammer
>
> My guess is you only chowned the root dir, and the OSD didn't throw
> an error when it encountered the other files?  If you can generate a debug
> osd = 20 log, that would be helpful.. thanks!
>
> sage
>
>
> >
> > Thanks,
> > -----BEGIN PGP SIGNATURE-----
> > Version: Mailvelope v1.2.0
> > Comment: https://www.mailvelope.com
> >
> > wsFcBAEBCAAQBQJWE0F5CRDmVDuy+mK58QAAaCYQAJuFcCvRUJ46k0rYrMcc
> > YlrSrGwS57GJS/JjaFHsvBV7KTobEMNeMkSv4PTGpwylNV9Dx4Ad74DDqX4g
> > 6hZDe0rE+uEI7tW9Lqp+MN7eaU2lDuwLt/pOzZI14jTskUYTlNi3HjlN67mQ
> > aiX1rbrJL6FFkuMOn/YqHpMbxI5ZOUZc1s7RDhASOPIs4z/CxpDfluW6fZA/
> > y8C+pW6zzS9U/6jZwtGhBq4dvDBO41Lxb9WOehD8Aa/Qt6XNDzGw2KEkEkw7
> > 8dBc7UFa2Wx3Tnzy238a/nKhtz6O6OrHsroA+HGWwCoxPWjOsz/xOoOmfwp+
> > ALkY3id+t2uJEqzbL8/MgJ2RV1A+AZ7W1VWIJUOkDz0wR+KxQsxduHoD6rQy
> > zg0fj2KSAlmVusYOPM1s1+jBsqNF3wcNxpbRoVuFqk0xMgGPrIdUNdZHg6bs
> > D5sfkjNKexFe0ifFJ0cfv6UaGIKv4dK2eq3jUKgXHfh/qZmJbEB+zHaqJNyg
> > CN6w6xu1FHLeVobKAWe5ZzKY5lxw6b8YG+ce/E2dvW73gSASPTvtv68gaT04
> > 2SPF9Ql0fERL5EDY9Pc4MHpQVcS0XxxJA69CgnWgaG6fzq2eY7fALeMBVWlB
> > fRj3zQwqJls/X8JZ3c4P4G0R6DP9bmMwGr++oYc3gWGrvgzxw3N7+ornd0jd
> > GdXC
> > =Aigq
> > -----END PGP SIGNATURE-----
> > ----------------
> > Robert LeBlanc
> > PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
> >
> >
> > On Sun, Oct 4, 2015 at 3:04 PM, Robert LeBlanc <robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org>
> wrote:
> > > -----BEGIN PGP SIGNED MESSAGE-----
> > > Hash: SHA256
> > >
> > > I have eight nodes running the fio job rbd_test_real to different RBD
> > > volumes. I've included the CRUSH map in the tarball.
> > >
> > > I stopped one OSD process and marked it out. I let it recover for a
> > > few minutes and then I started the process again and marked it in. I
> > > started getting block I/O messages during the recovery.
> > >
> > > The logs are located at http://162.144.87.113/files/ushou1.tar.xz
> > >
> > > Thanks,
> > > -----BEGIN PGP SIGNATURE-----
> > > Version: Mailvelope v1.2.0
> > > Comment: https://www.mailvelope.com
> > >
> > > wsFcBAEBCAAQBQJWEZRcCRDmVDuy+mK58QAALbEQAK5pFiixJarUdLm50zp/
> > > 3AGgGBPrieExKmoZZLCoMGfOLfxZDbN2ybtopKDQDfrTqndE/6Xi9UXqTOdW
> > > jDc9U1wusgG0CKPsY1SMYnB9akvaDwtdh5q5k4VpN2zsG9R6lRojHeNQR3Nf
> > > 56QevJL4/e5lC3sLhVnxXXi2XKnHCVOHT+PYgNour2ZWt6OTLoFFxuSU3zLN
> > > OtfXgrFiiNF0mrDpm0gg2l8a8N5SwP9mM233S2U/JiGAqsqoqkfd0okjDenC
> > > ksesU/n7zordFpfLN3yjL6+X9pQ4YA6otZrq4wWtjWKO/H0b+6iIsf/AE131
> > > R6a4Vufndpd3Ce+FNfM+iu3FmKk0KVfDAaF/tIP6S6XUzGVMAbpvpmqNL17o
> > > boh3wPZEyK+7KiF4Qlt2KoI/FV24Yj8XiyMnKin3MbMYbammb4ER977VH7iI
> > > sZyelNPSsYmmw/MF+AkA5KVgzQ4DAPflaejIgC5uw3dYKrn2AQE5CE9nN8Gz
> > > GVVaGItu1Bvrz21QoT9o5v0dZ85zttFvtrKIYgSi4mdpC6XkzUbg9s9EB1/T
> > > SEY+fau7W7TtiLpzCAIQ3zDvgsvkx2P6tKg5U8e93LVv9B+YI8i8mUxxv1j5
> > > PHFi7KTgRUPm1FPMJDSyzvOgqyMj9AzaESl1Na6k529ILFIcyfko0niTT1oZ
> > > 3EPx
> > > =UDIV
> > > -----END PGP SIGNATURE-----
> > >
> > > ----------------
> > > Robert LeBlanc
> > > PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
> > >
> > >
> > > On Sun, Oct 4, 2015 at 7:48 AM, Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> > >> On Sat, 3 Oct 2015, Robert LeBlanc wrote:
> > >>> -----BEGIN PGP SIGNED MESSAGE-----
> > >>> Hash: SHA256
> > >>>
> > >>> We are still struggling with this and have tried a lot of different
> > >>> things. Unfortunately, Inktank (now Red Hat) no longer provides
> > >>> consulting services for non-Red Hat systems. If there are some
> > >>> certified Ceph consultants in the US that we can do both remote and
> > >>> on-site engagements, please let us know.
> > >>>
> > >>> This certainly seems to be network related, but somewhere in the
> > >>> kernel. We have tried increasing the network and TCP buffers, number
> > >>> of TCP sockets, reduced the FIN_WAIT2 state. There is about 25% idle
> > >>> on the boxes, the disks are busy, but not constantly at 100% (they
> > >>> cycle from <10% up to 100%, but not 100% for more than a few seconds
> > >>> at a time). There seems to be no reasonable explanation why I/O is
> > >>> blocked pretty frequently longer than 30 seconds. We have verified
> > >>> Jumbo frames by pinging from/to each node with 9000 byte packets. The
> > >>> network admins have verified that packets are not being dropped in
> the
> > >>> switches for these nodes. We have tried different kernels including
> > >>> the recent Google patch to cubic. This is showing up on three cluster
> > >>> (two Ethernet and one IPoIB). I booted one cluster into Debian Jessie
> > >>> (from CentOS 7.1) with similar results.
> > >>>
> > >>> The messages seem slightly different:
> > >>> 2015-10-03 14:38:23.193082 osd.134 10.208.16.25:6800/1425 439 :
> > >>> cluster [WRN] 14 slow requests, 1 included below; oldest blocked for
> >
> > >>> 100.087155 secs
> > >>> 2015-10-03 14:38:23.193090 osd.134 10.208.16.25:6800/1425 440 :
> > >>> cluster [WRN] slow request 30.041999 seconds old, received at
> > >>> 2015-10-03 14:37:53.151014: osd_op(client.1328605.0:7082862
> > >>> rbd_data.13fdcb2ae8944a.000000000001264f [read 975360~4096]
> > >>> 11.6d19c36f ack+read+known_if_redirected e10249) currently no flag
> > >>> points reached
> > >>>
> > >>> I don't know what "no flag points reached" means.
> > >>
> > >> Just that the op hasn't been marked as reaching any interesting points
> > >> (op->mark_*() calls).
> > >>
> > >> Is it possible to gather a lot with debug ms = 20 and debug osd = 20?
> > >> It's extremely verbose but it'll let us see where the op is getting
> > >> blocked.  If you see the "slow request" message it means the op in
> > >> received by ceph (that's when the clock starts), so I suspect it's not
> > >> something we can blame on the network stack.
> > >>
> > >> sage
> > >>
> > >>
> > >>>
> > >>> The problem is most pronounced when we have to reboot an OSD node (1
> > >>> of 13), we will have hundreds of I/O blocked for some times up to 300
> > >>> seconds. It takes a good 15 minutes for things to settle down. The
> > >>> production cluster is very busy doing normally 8,000 I/O and peaking
> > >>> at 15,000. This is all 4TB spindles with SSD journals and the disks
> > >>> are between 25-50% full. We are currently splitting PGs to distribute
> > >>> the load better across the disks, but we are having to do this 10 PGs
> > >>> at a time as we get blocked I/O. We have max_backfills and
> > >>> max_recovery set to 1, client op priority is set higher than recovery
> > >>> priority. We tried increasing the number of op threads but this
> didn't
> > >>> seem to help. It seems as soon as PGs are finished being checked,
> they
> > >>> become active and could be the cause for slow I/O while the other PGs
> > >>> are being checked.
> > >>>
> > >>> What I don't understand is that the messages are delayed. As soon as
> > >>> the message is received by Ceph OSD process, it is very quickly
> > >>> committed to the journal and a response is sent back to the primary
> > >>> OSD which is received very quickly as well. I've adjust
> > >>> min_free_kbytes and it seems to keep the OSDs from crashing, but
> > >>> doesn't solve the main problem. We don't have swap and there is 64 GB
> > >>> of RAM per nodes for 10 OSDs.
> > >>>
> > >>> Is there something that could cause the kernel to get a packet but
> not
> > >>> be able to dispatch it to Ceph such that it could be explaining why
> we
> > >>> are seeing these blocked I/O for 30+ seconds. Is there some pointers
> > >>> to tracing Ceph messages from the network buffer through the kernel
> to
> > >>> the Ceph process?
> > >>>
> > >>> We can really use some pointers no matter how outrageous. We've have
> > >>> over 6 people looking into this for weeks now and just can't think of
> > >>> anything else.
> > >>>
> > >>> Thanks,
> > >>> -----BEGIN PGP SIGNATURE-----
> > >>> Version: Mailvelope v1.1.0
> > >>> Comment: https://www.mailvelope.com
> > >>>
> > >>> wsFcBAEBCAAQBQJWEDY1CRDmVDuy+mK58QAARgoP/RcoL1qVmg7qbQrzStar
> > >>> NK80bqYGeYHb26xHbt1fZVgnZhXU0nN0Dv4ew0e/cYJLELSO2KCeXNfXN6F1
> > >>> prZuzYagYEyj1Q1TOo+4h/nOQRYsTwQDdFzbHb/OUDN55C0QGZ29DjEvrqP6
> > >>> K5l6sAQzvQDpUEEIiOCkS6pH59ira740nSmnYkEWhr1lxF/hMjb6fFlfCFe2
> > >>> h1djM0GfY7vBHFGgI3jkw0BL5AQnWe+SCcCiKZmxY6xiR70FWl3XqK5M+nxm
> > >>> iq74y7Dv6cpenit6boMr6qtOeIt+8ko85hVMh09Hkaqz/m2FzxAKLcahzkGF
> > >>> Fh/M6YBzgnX7QBURTC4YQT/FVyDTW3JMuT3RKQdaX6c0iiOsVdkE+iyidWyY
> > >>> Hr1KzWU23Ur9yBfZ39Y43jrsSiAEwHnKjSqMowSGljdTysNEAAZQhlqZIoHb
> > >>> JlgpB39ugkHI1H5fZ5b2SIDz32/d5ywG4Gay9Rk6hp8VanvIrBbev+JYEoYT
> > >>> 8/WX+fhueHt4dqUYWIl3HZ0CEzbXbug0xmFvhrbmL2f3t9XOkDZRbAjlYrGm
> > >>> lswiJMDueY8JkxSnPvCQrHXqjbCcy9rMG7nTnLFz98rTcHNCwtpv0qVYhheg
> > >>> 4YRNRVMbfNP/6xsJvG1wVOSQPwxZSPqJh42pDqMRePJl3Zn66MTx5wvdNDpk
> > >>> l7OF
> > >>> =OI++
> > >>> -----END PGP SIGNATURE-----
> > >>> ----------------
> > >>> Robert LeBlanc
> > >>> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
> > >>>
> > >>>
> > >>> On Fri, Sep 25, 2015 at 2:40 PM, Robert LeBlanc <
> robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org> wrote:
> > >>> > We dropped the replication on our cluster from 4 to 3 and it looks
> > >>> > like all the blocked I/O has stopped (no entries in the log for the
> > >>> > last 12 hours). This makes me believe that there is some issue with
> > >>> > the number of sockets or some other TCP issue. We have not messed
> with
> > >>> > Ephemeral ports and TIME_WAIT at this point. There are 130 OSDs, 8
> KVM
> > >>> > hosts hosting about 150 VMs. Open files is set at 32K for the OSD
> > >>> > processes and 16K system wide.
> > >>> >
> > >>> > Does this seem like the right spot to be looking? What are some
> > >>> > configuration items we should be looking at?
> > >>> >
> > >>> > Thanks,
> > >>> > ----------------
> > >>> > Robert LeBlanc
> > >>> > PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
> > >>> >
> > >>> >
> > >>> > On Wed, Sep 23, 2015 at 1:30 PM, Robert LeBlanc <
> robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org> wrote:
> > >>> >> -----BEGIN PGP SIGNED MESSAGE-----
> > >>> >> Hash: SHA256
> > >>> >>
> > >>> >> We were able to only get ~17Gb out of the XL710 (heavily tweaked)
> > >>> >> until we went to the 4.x kernel where we got ~36Gb (no tweaking).
> It
> > >>> >> seems that there were some major reworks in the network handling
> in
> > >>> >> the kernel to efficiently handle that network rate. If I remember
> > >>> >> right we also saw a drop in CPU utilization. I'm starting to think
> > >>> >> that we did see packet loss while congesting our ISLs in our
> initial
> > >>> >> testing, but we could not tell where the dropping was happening.
> We
> > >>> >> saw some on the switches, but it didn't seem to be bad if we
> weren't
> > >>> >> trying to congest things. We probably already saw this issue, just
> > >>> >> didn't know it.
> > >>> >> - ----------------
> > >>> >> Robert LeBlanc
> > >>> >> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
> > >>> >>
> > >>> >>
> > >>> >> On Wed, Sep 23, 2015 at 1:10 PM, Mark Nelson  wrote:
> > >>> >>> FWIW, we've got some 40GbE Intel cards in the community
> performance cluster
> > >>> >>> on a Mellanox 40GbE switch that appear (knock on wood) to be
> running fine
> > >>> >>> with 3.10.0-229.7.2.el7.x86_64.  We did get feedback from Intel
> that older
> > >>> >>> drivers might cause problems though.
> > >>> >>>
> > >>> >>> Here's ifconfig from one of the nodes:
> > >>> >>>
> > >>> >>> ens513f1: flags=4163  mtu 1500
> > >>> >>>         inet 10.0.10.101  netmask 255.255.255.0  broadcast
> 10.0.10.255
> > >>> >>>         inet6 fe80::6a05:caff:fe2b:7ea1  prefixlen 64  scopeid
> 0x20
> > >>> >>>         ether 68:05:ca:2b:7e:a1  txqueuelen 1000  (Ethernet)
> > >>> >>>         RX packets 169232242875  bytes 229346261232279 (208.5
> TiB)
> > >>> >>>         RX errors 0  dropped 0  overruns 0  frame 0
> > >>> >>>         TX packets 153491686361  bytes 203976410836881 (185.5
> TiB)
> > >>> >>>         TX errors 0  dropped 0 overruns 0  carrier 0  collisions
> 0
> > >>> >>>
> > >>> >>> Mark
> > >>> >>>
> > >>> >>>
> > >>> >>> On 09/23/2015 01:48 PM, Robert LeBlanc wrote:
> > >>> >>>>
> > >>> >>>> -----BEGIN PGP SIGNED MESSAGE-----
> > >>> >>>> Hash: SHA256
> > >>> >>>>
> > >>> >>>> OK, here is the update on the saga...
> > >>> >>>>
> > >>> >>>> I traced some more of blocked I/Os and it seems that
> communication
> > >>> >>>> between two hosts seemed worse than others. I did a two way
> ping flood
> > >>> >>>> between the two hosts using max packet sizes (1500). After 1.5M
> > >>> >>>> packets, no lost pings. Then then had the ping flood running
> while I
> > >>> >>>> put Ceph load on the cluster and the dropped pings started
> increasing
> > >>> >>>> after stopping the Ceph workload the pings stopped dropping.
> > >>> >>>>
> > >>> >>>> I then ran iperf between all the nodes with the same results,
> so that
> > >>> >>>> ruled out Ceph to a large degree. I then booted in the the
> > >>> >>>> 3.10.0-229.14.1.el7.x86_64 kernel and with an hour test so far
> there
> > >>> >>>> hasn't been any dropped pings or blocked I/O. Our 40 Gb NICs
> really
> > >>> >>>> need the network enhancements in the 4.x series to work well.
> > >>> >>>>
> > >>> >>>> Does this sound familiar to anyone? I'll probably start
> bisecting the
> > >>> >>>> kernel to see where this issue in introduced. Both of the
> clusters
> > >>> >>>> with this issue are running 4.x, other than that, they are
> pretty
> > >>> >>>> differing hardware and network configs.
> > >>> >>>>
> > >>> >>>> Thanks,
> > >>> >>>> -----BEGIN PGP SIGNATURE-----
> > >>> >>>> Version: Mailvelope v1.1.0
> > >>> >>>> Comment: https://www.mailvelope.com
> > >>> >>>>
> > >>> >>>> wsFcBAEBCAAQBQJWAvOzCRDmVDuy+mK58QAApOMP/1xmCtW++G11qcE8y/sr
> > >>> >>>> RkXguqZJLc4czdOwV/tjUvhVsm5qOl4wvQCtABFZpc6t4+m5nzE3LkA1rl2l
> > >>> >>>> AnARPOjh61TO6cV0CT8O0DlqtHmSd2y0ElgAUl0594eInEn7eI7crz8R543V
> > >>> >>>> 7I68XU5zL/vNJ9IIx38UqdhtSzXQQL664DGq3DLINK0Yb9XRVBlFip+Slt+j
> > >>> >>>> cB64TuWjOPLSH09pv7SUyksodqrTq3K7p6sQkq0MOzBkFQM1FHfOipbo/LYv
> > >>> >>>> F42iiQbCvFizArMu20WeOSQ4dmrXT/iecgTfEag/Zxvor2gOi/J6d2XS9ckW
> > >>> >>>> byEC5/rbm4yDBua2ZugeNxQLWq0Oa7spZnx7usLsu/6YzeDNI6kmtGURajdE
> > >>> >>>> /XC8bESWKveBzmGDzjff5oaMs9A1PZURYnlYADEODGAt6byoaoQEGN6dlFGe
> > >>> >>>> LwQ5nOdQYuUrWpJzTJBN3aduOxursoFY8S0eR0uXm0l1CHcp22RWBDvRinok
> > >>> >>>> UWk5xRBgjDCD2gIwc+wpImZbCtiTdf0vad1uLvdxGL29iFta4THzJgUGrp98
> > >>> >>>> sUqM3RaTRdJYjFcNP293H7/DC0mqpnmo0Clx3jkdHX+x1EXpJUtocSeI44LX
> > >>> >>>> KWIMhe9wXtKAoHQFEcJ0o0+wrXWMevvx33HPC4q1ULrFX0ILNx5Mo0Rp944X
> > >>> >>>> 4OEo
> > >>> >>>> =P33I
> > >>> >>>> -----END PGP SIGNATURE-----
> > >>> >>>> ----------------
> > >>> >>>> Robert LeBlanc
> > >>> >>>> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62
> B9F1
> > >>> >>>>
> > >>> >>>>
> > >>> >>>> On Tue, Sep 22, 2015 at 4:15 PM, Robert LeBlanc
> > >>> >>>> wrote:
> > >>> >>>>>
> > >>> >>>>> -----BEGIN PGP SIGNED MESSAGE-----
> > >>> >>>>> Hash: SHA256
> > >>> >>>>>
> > >>> >>>>> This is IPoIB and we have the MTU set to 64K. There was some
> issues
> > >>> >>>>> pinging hosts with "No buffer space available" (hosts are
> currently
> > >>> >>>>> configured for 4GB to test SSD caching rather than page
> cache). I
> > >>> >>>>> found that MTU under 32K worked reliable for ping, but still
> had the
> > >>> >>>>> blocked I/O.
> > >>> >>>>>
> > >>> >>>>> I reduced the MTU to 1500 and checked pings (OK), but I'm
> still seeing
> > >>> >>>>> the blocked I/O.
> > >>> >>>>> - ----------------
> > >>> >>>>> Robert LeBlanc
> > >>> >>>>> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62
> B9F1
> > >>> >>>>>
> > >>> >>>>>
> > >>> >>>>> On Tue, Sep 22, 2015 at 3:52 PM, Sage Weil  wrote:
> > >>> >>>>>>
> > >>> >>>>>> On Tue, 22 Sep 2015, Samuel Just wrote:
> > >>> >>>>>>>
> > >>> >>>>>>> I looked at the logs, it looks like there was a 53 second
> delay
> > >>> >>>>>>> between when osd.17 started sending the osd_repop message
> and when
> > >>> >>>>>>> osd.13 started reading it, which is pretty weird.  Sage,
> didn't we
> > >>> >>>>>>> once see a kernel issue which caused some messages to be
> mysteriously
> > >>> >>>>>>> delayed for many 10s of seconds?
> > >>> >>>>>>
> > >>> >>>>>>
> > >>> >>>>>> Every time we have seen this behavior and diagnosed it in the
> wild it
> > >>> >>>>>> has
> > >>> >>>>>> been a network misconfiguration.  Usually related to jumbo
> frames.
> > >>> >>>>>>
> > >>> >>>>>> sage
> > >>> >>>>>>
> > >>> >>>>>>
> > >>> >>>>>>>
> > >>> >>>>>>> What kernel are you running?
> > >>> >>>>>>> -Sam
> > >>> >>>>>>>
> > >>> >>>>>>> On Tue, Sep 22, 2015 at 2:22 PM, Robert LeBlanc  wrote:
> > >>> >>>>>>>>
> > >>> >>>>>>>> -----BEGIN PGP SIGNED MESSAGE-----
> > >>> >>>>>>>> Hash: SHA256
> > >>> >>>>>>>>
> > >>> >>>>>>>> OK, looping in ceph-devel to see if I can get some more
> eyes. I've
> > >>> >>>>>>>> extracted what I think are important entries from the logs
> for the
> > >>> >>>>>>>> first blocked request. NTP is running all the servers so
> the logs
> > >>> >>>>>>>> should be close in terms of time. Logs for 12:50 to 13:00
> are
> > >>> >>>>>>>> available at
> http://162.144.87.113/files/ceph_block_io.logs.tar.xz
> > >>> >>>>>>>>
> > >>> >>>>>>>> 2015-09-22 12:55:06.500374 - osd.17 gets I/O from client
> > >>> >>>>>>>> 2015-09-22 12:55:06.557160 - osd.17 submits I/O to osd.13
> > >>> >>>>>>>> 2015-09-22 12:55:06.557305 - osd.17 submits I/O to osd.16
> > >>> >>>>>>>> 2015-09-22 12:55:06.573711 - osd.16 gets I/O from osd.17
> > >>> >>>>>>>> 2015-09-22 12:55:06.595716 - osd.17 gets ondisk result=0
> from osd.16
> > >>> >>>>>>>> 2015-09-22 12:55:06.640631 - osd.16 reports to osd.17
> ondisk result=0
> > >>> >>>>>>>> 2015-09-22 12:55:36.926691 - osd.17 reports slow I/O >
> 30.439150 sec
> > >>> >>>>>>>> 2015-09-22 12:55:59.790591 - osd.13 gets I/O from osd.17
> > >>> >>>>>>>> 2015-09-22 12:55:59.812405 - osd.17 gets ondisk result=0
> from osd.13
> > >>> >>>>>>>> 2015-09-22 12:56:02.941602 - osd.13 reports to osd.17
> ondisk result=0
> > >>> >>>>>>>>
> > >>> >>>>>>>> In the logs I can see that osd.17 dispatches the I/O to
> osd.13 and
> > >>> >>>>>>>> osd.16 almost silmutaniously. osd.16 seems to get the I/O
> right away,
> > >>> >>>>>>>> but for some reason osd.13 doesn't get the message until 53
> seconds
> > >>> >>>>>>>> later. osd.17 seems happy to just wait and doesn't resend
> the data
> > >>> >>>>>>>> (well, I'm not 100% sure how to tell which entries are the
> actual data
> > >>> >>>>>>>> transfer).
> > >>> >>>>>>>>
> > >>> >>>>>>>> It looks like osd.17 is receiving responses to start the
> communication
> > >>> >>>>>>>> with osd.13, but the op is not acknowledged until almost a
> minute
> > >>> >>>>>>>> later. To me it seems that the message is getting received
> but not
> > >>> >>>>>>>> passed to another thread right away or something. This test
> was done
> > >>> >>>>>>>> with an idle cluster, a single fio client (rbd engine) with
> a single
> > >>> >>>>>>>> thread.
> > >>> >>>>>>>>
> > >>> >>>>>>>> The OSD servers are almost 100% idle during these blocked
> I/O
> > >>> >>>>>>>> requests. I think I'm at the end of my troubleshooting, so
> I can use
> > >>> >>>>>>>> some help.
> > >>> >>>>>>>>
> > >>> >>>>>>>> Single Test started about
> > >>> >>>>>>>> 2015-09-22 12:52:36
> > >>> >>>>>>>>
> > >>> >>>>>>>> 2015-09-22 12:55:36.926680 osd.17 192.168.55.14:6800/16726
> 56 :
> > >>> >>>>>>>> cluster [WRN] 1 slow requests, 1 included below; oldest
> blocked for >
> > >>> >>>>>>>> 30.439150 secs
> > >>> >>>>>>>> 2015-09-22 12:55:36.926699 osd.17 192.168.55.14:6800/16726
> 57 :
> > >>> >>>>>>>> cluster [WRN] slow request 30.439150 seconds old, received
> at
> > >>> >>>>>>>> 2015-09-22 12:55:06.487451:
> > >>> >>>>>>>>   osd_op(client.250874.0:1388
> rbd_data.3380e2ae8944a.0000000000000545
> > >>> >>>>>>>> [set-alloc-hint object_size 4194304 write_size 4194304,write
> > >>> >>>>>>>> 0~4194304] 8.bbf3e8ff ack+ondisk+write+known_if_redirected
> e56785)
> > >>> >>>>>>>>   currently waiting for subops from 13,16
> > >>> >>>>>>>> 2015-09-22 12:55:36.697904 osd.16 192.168.55.13:6800/29410
> 7 : cluster
> > >>> >>>>>>>> [WRN] 2 slow requests, 2 included below; oldest blocked for
> >
> > >>> >>>>>>>> 30.379680 secs
> > >>> >>>>>>>> 2015-09-22 12:55:36.697918 osd.16 192.168.55.13:6800/29410
> 8 : cluster
> > >>> >>>>>>>> [WRN] slow request 30.291520 seconds old, received at
> 2015-09-22
> > >>> >>>>>>>> 12:55:06.406303:
> > >>> >>>>>>>>   osd_op(client.250874.0:1384
> rbd_data.3380e2ae8944a.0000000000000541
> > >>> >>>>>>>> [set-alloc-hint object_size 4194304 write_size 4194304,write
> > >>> >>>>>>>> 0~4194304] 8.5fb2123f ack+ondisk+write+known_if_redirected
> e56785)
> > >>> >>>>>>>>   currently waiting for subops from 13,17
> > >>> >>>>>>>> 2015-09-22 12:55:36.697927 osd.16 192.168.55.13:6800/29410
> 9 : cluster
> > >>> >>>>>>>> [WRN] slow request 30.379680 seconds old, received at
> 2015-09-22
> > >>> >>>>>>>> 12:55:06.318144:
> > >>> >>>>>>>>   osd_op(client.250874.0:1382
> rbd_data.3380e2ae8944a.000000000000053f
> > >>> >>>>>>>> [set-alloc-hint object_size 4194304 write_size 4194304,write
> > >>> >>>>>>>> 0~4194304] 8.312e69ca ack+ondisk+write+known_if_redirected
> e56785)
> > >>> >>>>>>>>   currently waiting for subops from 13,14
> > >>> >>>>>>>> 2015-09-22 12:58:03.998275 osd.13 192.168.55.12:6804/4574
> 130 :
> > >>> >>>>>>>> cluster [WRN] 1 slow requests, 1 included below; oldest
> blocked for >
> > >>> >>>>>>>> 30.954212 secs
> > >>> >>>>>>>> 2015-09-22 12:58:03.998286 osd.13 192.168.55.12:6804/4574
> 131 :
> > >>> >>>>>>>> cluster [WRN] slow request 30.954212 seconds old, received
> at
> > >>> >>>>>>>> 2015-09-22 12:57:33.044003:
> > >>> >>>>>>>>   osd_op(client.250874.0:1873
> rbd_data.3380e2ae8944a.000000000000070d
> > >>> >>>>>>>> [set-alloc-hint object_size 4194304 write_size 4194304,write
> > >>> >>>>>>>> 0~4194304] 8.e69870d4 ack+ondisk+write+known_if_redirected
> e56785)
> > >>> >>>>>>>>   currently waiting for subops from 16,17
> > >>> >>>>>>>> 2015-09-22 12:58:03.759826 osd.16 192.168.55.13:6800/29410
> 10 :
> > >>> >>>>>>>> cluster [WRN] 1 slow requests, 1 included below; oldest
> blocked for >
> > >>> >>>>>>>> 30.704367 secs
> > >>> >>>>>>>> 2015-09-22 12:58:03.759840 osd.16 192.168.55.13:6800/29410
> 11 :
> > >>> >>>>>>>> cluster [WRN] slow request 30.704367 seconds old, received
> at
> > >>> >>>>>>>> 2015-09-22 12:57:33.055404:
> > >>> >>>>>>>>   osd_op(client.250874.0:1874
> rbd_data.3380e2ae8944a.000000000000070e
> > >>> >>>>>>>> [set-alloc-hint object_size 4194304 write_size 4194304,write
> > >>> >>>>>>>> 0~4194304] 8.f7635819 ack+ondisk+write+known_if_redirected
> e56785)
> > >>> >>>>>>>>   currently waiting for subops from 13,17
> > >>> >>>>>>>>
> > >>> >>>>>>>> Server   IP addr              OSD
> > >>> >>>>>>>> nodev  - 192.168.55.11 - 12
> > >>> >>>>>>>> nodew  - 192.168.55.12 - 13
> > >>> >>>>>>>> nodex  - 192.168.55.13 - 16
> > >>> >>>>>>>> nodey  - 192.168.55.14 - 17
> > >>> >>>>>>>> nodez  - 192.168.55.15 - 14
> > >>> >>>>>>>> nodezz - 192.168.55.16 - 15
> > >>> >>>>>>>>
> > >>> >>>>>>>> fio job:
> > >>> >>>>>>>> [rbd-test]
> > >>> >>>>>>>> readwrite=write
> > >>> >>>>>>>> blocksize=4M
> > >>> >>>>>>>> #runtime=60
> > >>> >>>>>>>> name=rbd-test
> > >>> >>>>>>>> #readwrite=randwrite
> > >>> >>>>>>>> #bssplit=4k/85:32k/11:512/3:1m/1,4k/89:32k/10:512k/1
> > >>> >>>>>>>> #rwmixread=72
> > >>> >>>>>>>> #norandommap
> > >>> >>>>>>>> #size=1T
> > >>> >>>>>>>> #blocksize=4k
> > >>> >>>>>>>> ioengine=rbd
> > >>> >>>>>>>> rbdname=test2
> > >>> >>>>>>>> pool=rbd
> > >>> >>>>>>>> clientname=admin
> > >>> >>>>>>>> iodepth=8
> > >>> >>>>>>>> #numjobs=4
> > >>> >>>>>>>> #thread
> > >>> >>>>>>>> #group_reporting
> > >>> >>>>>>>> #time_based
> > >>> >>>>>>>> #direct=1
> > >>> >>>>>>>> #ramp_time=60
> > >>> >>>>>>>>
> > >>> >>>>>>>>
> > >>> >>>>>>>> Thanks,
> > >>> >>>>>>>> -----BEGIN PGP SIGNATURE-----
> > >>> >>>>>>>> Version: Mailvelope v1.1.0
> > >>> >>>>>>>> Comment: https://www.mailvelope.com
> > >>> >>>>>>>>
> > >>> >>>>>>>> wsFcBAEBCAAQBQJWAcaKCRDmVDuy+mK58QAAPMsQAKBnS94fwuw0OqpPU3/z
> > >>> >>>>>>>> tL8Z6TVRxrNigf721+2ClIu4LIH71bupDc3DgrrysQmmqGuvEMn68spmasWu
> > >>> >>>>>>>> h9I/CqqgRpHqe4lUVoUEjyWA9/6Dbb6NiHSdpJ6p5jpGc8kZCvNS+ocDgFOl
> > >>> >>>>>>>> 903i0M0E9eEMeci5O/hrMrx1FG8SN2LS8nI261aNHMOwQK0bw8wWiCJEvqVB
> > >>> >>>>>>>> sz1/+jK1BJoeIYfaT9HfUXBAvfo/W3tY/vj9KbJuZJ5AMpeYPvEHu/LAr1N7
> > >>> >>>>>>>> FzzUc7a6EMlaxmSd0ML49JbV0cY9BMDjfrkKEQNKlzszlEHm3iif98QtsxbF
> > >>> >>>>>>>> pPJ0hZ0G53BY3k976OWVMFm3WFRWUVOb/oiLF8H6PCm59b4LBNAg6iPNH1AI
> > >>> >>>>>>>> 5XhEcPpg06M03vqUaIiY9P1kQlvnn0yCXf82IUEgmg///vhxDsHWmcwClLEn
> > >>> >>>>>>>> B0VszouStTzlMYnc/2vlUiI4gFVeilWLMW00VGTWV+7V1oIzIYvWHyl2QpBq
> > >>> >>>>>>>> 4/ZwVjQ43qLfuDTS4o+IJ4ztOMd26vIv6Mn6WVwKCjoCXJc8ajywR9Dy+6lL
> > >>> >>>>>>>> o8oJ+tn7hMc9Qy1iBhu3/QIP4WCsUf9RVeu60oahNEpde89qW32S9CZlrJDO
> > >>> >>>>>>>> gf4iTryRjkAhdmZIj9JiaE8jQ6dvN817D9cqs/CXKV9vhzYoM7p5YWHghBKB
> > >>> >>>>>>>> J3hS
> > >>> >>>>>>>> =0J7F
> > >>> >>>>>>>> -----END PGP SIGNATURE-----
> > >>> >>>>>>>> ----------------
> > >>> >>>>>>>> Robert LeBlanc
> > >>> >>>>>>>> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2
> FA62 B9F1
> > >>> >>>>>>>>
> > >>> >>>>>>>>
> > >>> >>>>>>>> On Tue, Sep 22, 2015 at 8:31 AM, Gregory Farnum  wrote:
> > >>> >>>>>>>>>
> > >>> >>>>>>>>> On Tue, Sep 22, 2015 at 7:24 AM, Robert LeBlanc  wrote:
> > >>> >>>>>>>>>>
> > >>> >>>>>>>>>> -----BEGIN PGP SIGNED MESSAGE-----
> > >>> >>>>>>>>>> Hash: SHA256
> > >>> >>>>>>>>>>
> > >>> >>>>>>>>>> Is there some way to tell in the logs that this is
> happening?
> > >>> >>>>>>>>>
> > >>> >>>>>>>>>
> > >>> >>>>>>>>> You can search for the (mangled) name _split_collection
> > >>> >>>>>>>>>>
> > >>> >>>>>>>>>> I'm not
> > >>> >>>>>>>>>> seeing much I/O, CPU usage during these times. Is there
> some way to
> > >>> >>>>>>>>>> prevent the splitting? Is there a negative side effect to
> doing so?
> > >>> >>>>>>>>>
> > >>> >>>>>>>>>
> > >>> >>>>>>>>> Bump up the split and merge thresholds. You can search the
> list for
> > >>> >>>>>>>>> this, it was discussed not too long ago.
> > >>> >>>>>>>>>
> > >>> >>>>>>>>>> We've had I/O block for over 900 seconds and as soon as
> the sessions
> > >>> >>>>>>>>>> are aborted, they are reestablished and complete
> immediately.
> > >>> >>>>>>>>>>
> > >>> >>>>>>>>>> The fio test is just a seq write, starting it over
> (rewriting from
> > >>> >>>>>>>>>> the
> > >>> >>>>>>>>>> beginning) is still causing the issue. I was suspect that
> it is not
> > >>> >>>>>>>>>> having to create new file and therefore split
> collections. This is
> > >>> >>>>>>>>>> on
> > >>> >>>>>>>>>> my test cluster with no other load.
> > >>> >>>>>>>>>
> > >>> >>>>>>>>>
> > >>> >>>>>>>>> Hmm, that does make it seem less likely if you're really
> not creating
> > >>> >>>>>>>>> new objects, if you're actually running fio in such a way
> that it's
> > >>> >>>>>>>>> not allocating new FS blocks (this is probably hard to set
> up?).
> > >>> >>>>>>>>>
> > >>> >>>>>>>>>>
> > >>> >>>>>>>>>> I'll be doing a lot of testing today. Which log options
> and depths
> > >>> >>>>>>>>>> would be the most helpful for tracking this issue down?
> > >>> >>>>>>>>>
> > >>> >>>>>>>>>
> > >>> >>>>>>>>> If you want to go log diving "debug osd = 20", "debug
> filestore =
> > >>> >>>>>>>>> 20",
> > >>> >>>>>>>>> "debug ms = 1" are what the OSD guys like to see. That
> should spit
> > >>> >>>>>>>>> out
> > >>> >>>>>>>>> everything you need to track exactly what each Op is doing.
> > >>> >>>>>>>>> -Greg
> > >>> >>>>>>>>
> > >>> >>>>>>>> --
> > >>> >>>>>>>> To unsubscribe from this list: send the line "unsubscribe
> ceph-devel"
> > >>> >>>>>>>> in
> > >>> >>>>>>>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > >>> >>>>>>>> More majordomo info at
> http://vger.kernel.org/majordomo-info.html
> > >>> >>>>>>>
> > >>> >>>>>>>
> > >>> >>>>>>>
> > >>> >>>>>
> > >>> >>>>> -----BEGIN PGP SIGNATURE-----
> > >>> >>>>> Version: Mailvelope v1.1.0
> > >>> >>>>> Comment: https://www.mailvelope.com
> > >>> >>>>>
> > >>> >>>>> wsFcBAEBCAAQBQJWAdMSCRDmVDuy+mK58QAAoEgP/AqpH7i1BLpoz6fTlfWG
> > >>> >>>>> a6swvF8xvsyR15PDiPINYT0N7MgoikikGrMmhWpJ6utEr1XPW0MPFgzvNIsf
> > >>> >>>>> a1eMtNzyww4rAo6JCq6BtjmUsSKmOrBNhRNr6It9v4Nv+biqZHkiY8x/rRtV
> > >>> >>>>> s9z0cv3Q9Wqa6y/zKZg3H1XtbtUAx0r/DUwzSsP3omupZgNyaKkCgdkil9Vc
> > >>> >>>>> iyzBxFZU4+qXNT2FBG4dYDjxSHQv4psjvKR3AWXSN4yEn286KyMDjFrsDY5B
> > >>> >>>>> izS3h603QPoErqsUQngDE8COcaTAHHrV7gNJTikmGoNW6oQBjFq/z/zindTz
> > >>> >>>>> caXshVQQ+OTLo/qzJM8QPswh0TGU74SVbDkTq+eTOb5pBhQbp+42Pkkqh7jj
> > >>> >>>>> efyyYgDzpB1WrWRbUlWMNqmnjq7DT3lnAtuHyKbkwVs8x3JMPEiCl6PBvJbx
> > >>> >>>>> GnNSCqgDJrpb4fHQ2iqfQeh8Ai6AL1C1Ai19RZPrAUhpDW0/DbUvuoKSR8m7
> > >>> >>>>> glYYuH3hpy+oPYRhFcHm2fpNJ3u9npyk2Dai9RpzQ+mWmp3xi7becYmL482H
> > >>> >>>>> +WyvLeY+8AiJQDpA0CdD8KeSlOC9bw5TPmihAIn9dVTJ1O2RlapCLqL3YAJg
> > >>> >>>>> pGyDs8ercTEJLmvEyElj5XWh5DarsGscd2LELNS/UpyuYurbPcyPKUQ0uPjp
> > >>> >>>>> gcZm
> > >>> >>>>> =CjwB
> > >>> >>>>> -----END PGP SIGNATURE-----
> > >>> >>>>
> > >>> >>>> --
> > >>> >>>> To unsubscribe from this list: send the line "unsubscribe
> ceph-devel" in
> > >>> >>>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > >>> >>>> More majordomo info at
> http://vger.kernel.org/majordomo-info.html
> > >>> >>>>
> > >>> >>>
> > >>> >>
> > >>> >> -----BEGIN PGP SIGNATURE-----
> > >>> >> Version: Mailvelope v1.1.0
> > >>> >> Comment: https://www.mailvelope.com
> > >>> >>
> > >>> >> wsFcBAEBCAAQBQJWAv3QCRDmVDuy+mK58QAABr4QAJcQj8zjl606aMdkmQG7
> > >>> >> S46iMXVav/Tv2os9GCUsQmMPx2u1w3/WmPfjByd6Divczfo0JLDDqrbsqre2
> > >>> >> lq0GNK6e8fq6FXHhPpnL+t4uFV4UZ289cma3yklRqEBDXWHlP59Hu7VpxC5l
> > >>> >> 0MIcCg4wM5VM/LkrfcMven5em5CnjyFJYbActGzw9043rZoyUwCM+eL7sotl
> > >>> >> JYHMcNWnqwdt8TLFDhUfVGiAQyV8/6E33CuCNUEuFGdtiBKzs9IZadOI8Ce0
> > >>> >> dod2DQNyFSvomqNq6t0DuTCSA+pT8uuks2O0NcrHjoqwIWVkxQGPYlpbpckf
> > >>> >> nxQdVM7vkqapVeQ0qUZx43Db9A5wDTC3PaEfVJZPZzWsSDjh9z7o6qHs3Kvp
> > >>> >> krfyS+dJaZ3tOYAP1VFDfasj06sOTFu3mfGYToKA75zz5HN7QZ13Zau/qhDu
> > >>> >> FHxsgk4oIXJsjj22LiSpoiigH5Ls+aVqtIbg8/vWp+EO6pK1fovEtJVeGAfE
> > >>> >> tLOdxfJJLVjMCAScFG9BRl1ePPLeptivKV0v9ruWsTpn+Q96VtqAR5GQCkYE
> > >>> >> hFrlxM+oIzHeArhhiIxSPCYLlnzxoD5IYXmTrWUYBCGvlY1mrI3j80mZ4VTj
> > >>> >> BErsSlqnjUyFKmaI7YNKyARCloMroz3wqdy/wpg/63Io62nmh5IyY+WO8hPo
> > >>> >> ae22
> > >>> >> =AX+L
> > >>> >> -----END PGP SIGNATURE-----
> > >>> _______________________________________________
> > >>> ceph-users mailing list
> > >>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> > >>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> > >>>
> > >>>
> > _______________________________________________
> > ceph-users mailing list
> > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> >
> >
>

--001a11c013002597f605217079e9
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Thanks for your time Sage. It sounds like a few people may b=
e helped if you can find something. </p>
<p dir=3D"ltr">I did a recursive chown as in the instructions (although I d=
idn&#39;t know about the doc at the time). I did an osd debug at 20/20 but =
didn&#39;t see anything. I&#39;ll also do ms and make the logs available. I=
&#39;ll also review the document to make sure I didn&#39;t miss anything el=
se. </p>
<p dir=3D"ltr">Robert LeBlanc</p>
<p dir=3D"ltr">Sent from a mobile device please excuse any typos.</p>
<div class=3D"gmail_quote">On Oct 6, 2015 6:37 AM, &quot;Sage Weil&quot; &l=
t;<a href=3D"mailto:sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt; wrote:<br ty=
pe=3D"attribution"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex">On Mon, 5 Oct 2015, Rober=
t LeBlanc wrote:<br>
&gt; -----BEGIN PGP SIGNED MESSAGE-----<br>
&gt; Hash: SHA256<br>
&gt;<br>
&gt; With some off-list help, we have adjusted<br>
&gt; osd_client_message_cap=3D10000. This seems to have helped a bit and we=
<br>
&gt; have seen some OSDs have a value up to 4,000 for client messages. But<=
br>
&gt; it does not solve the problem with the blocked I/O.<br>
&gt;<br>
&gt; One thing that I have noticed is that almost exactly 30 seconds elapse=
<br>
&gt; between an OSD boots and the first blocked I/O message. I don&#39;t kn=
ow<br>
&gt; if the OSD doesn&#39;t have time to get it&#39;s brain right about a P=
G before<br>
&gt; it starts servicing it or what exactly.<br>
<br>
I&#39;m downloading the logs from yesterday now; sorry it&#39;s taking so l=
ong.<br>
<br>
&gt; On another note, I tried upgrading our CentOS dev cluster from Hammer<=
br>
&gt; to master and things didn&#39;t go so well. The OSDs would not start<b=
r>
&gt; because /var/lib/ceph was not owned by ceph. I chowned the directory<b=
r>
&gt; and all OSDs and the OSD then started, but never became active in the<=
br>
&gt; cluster. It just sat there after reading all the PGs. There were<br>
&gt; sockets open to the monitor, but no OSD to OSD sockets. I tried<br>
&gt; downgrading to the Infernalis branch and still no luck getting the<br>
&gt; OSDs to come up. The OSD processes were idle after the initial boot.<b=
r>
&gt; All packages were installed from gitbuilder.<br>
<br>
Did you chown -R ?<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://github.com/ceph/ceph/blob/in=
fernalis/doc/release-notes.rst#upgrading-from-hammer" rel=3D"noreferrer" ta=
rget=3D"_blank">https://github.com/ceph/ceph/blob/infernalis/doc/release-no=
tes.rst#upgrading-from-hammer</a><br>
<br>
My guess is you only chowned the root dir, and the OSD didn&#39;t throw<br>
an error when it encountered the other files?=C2=A0 If you can generate a d=
ebug<br>
osd =3D 20 log, that would be helpful.. thanks!<br>
<br>
sage<br>
<br>
<br>
&gt;<br>
&gt; Thanks,<br>
&gt; -----BEGIN PGP SIGNATURE-----<br>
&gt; Version: Mailvelope v1.2.0<br>
&gt; Comment: <a href=3D"https://www.mailvelope.com" rel=3D"noreferrer" tar=
get=3D"_blank">https://www.mailvelope.com</a><br>
&gt;<br>
&gt; wsFcBAEBCAAQBQJWE0F5CRDmVDuy+mK58QAAaCYQAJuFcCvRUJ46k0rYrMcc<br>
&gt; YlrSrGwS57GJS/JjaFHsvBV7KTobEMNeMkSv4PTGpwylNV9Dx4Ad74DDqX4g<br>
&gt; 6hZDe0rE+uEI7tW9Lqp+MN7eaU2lDuwLt/pOzZI14jTskUYTlNi3HjlN67mQ<br>
&gt; aiX1rbrJL6FFkuMOn/YqHpMbxI5ZOUZc1s7RDhASOPIs4z/CxpDfluW6fZA/<br>
&gt; y8C+pW6zzS9U/6jZwtGhBq4dvDBO41Lxb9WOehD8Aa/Qt6XNDzGw2KEkEkw7<br>
&gt; 8dBc7UFa2Wx3Tnzy238a/nKhtz6O6OrHsroA+HGWwCoxPWjOsz/xOoOmfwp+<br>
&gt; ALkY3id+t2uJEqzbL8/MgJ2RV1A+AZ7W1VWIJUOkDz0wR+KxQsxduHoD6rQy<br>
&gt; zg0fj2KSAlmVusYOPM1s1+jBsqNF3wcNxpbRoVuFqk0xMgGPrIdUNdZHg6bs<br>
&gt; D5sfkjNKexFe0ifFJ0cfv6UaGIKv4dK2eq3jUKgXHfh/qZmJbEB+zHaqJNyg<br>
&gt; CN6w6xu1FHLeVobKAWe5ZzKY5lxw6b8YG+ce/E2dvW73gSASPTvtv68gaT04<br>
&gt; 2SPF9Ql0fERL5EDY9Pc4MHpQVcS0XxxJA69CgnWgaG6fzq2eY7fALeMBVWlB<br>
&gt; fRj3zQwqJls/X8JZ3c4P4G0R6DP9bmMwGr++oYc3gWGrvgzxw3N7+ornd0jd<br>
&gt; GdXC<br>
&gt; =3DAigq<br>
&gt; -----END PGP SIGNATURE-----<br>
&gt; ----------------<br>
&gt; Robert LeBlanc<br>
&gt; PGP Fingerprint 79A2 9CA4 6CC4 45DD A904=C2=A0 C70E E654 3BB2 FA62 B9F=
1<br>
&gt;<br>
&gt;<br>
&gt; On Sun, Oct 4, 2015 at 3:04 PM, Robert LeBlanc &lt;<a href=3D"mailto:r=
obert-4JaGZRWAfWbajFs6igw21g@public.gmane.org">robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org</a>&gt; wrote:<br>
&gt; &gt; -----BEGIN PGP SIGNED MESSAGE-----<br>
&gt; &gt; Hash: SHA256<br>
&gt; &gt;<br>
&gt; &gt; I have eight nodes running the fio job rbd_test_real to different=
 RBD<br>
&gt; &gt; volumes. I&#39;ve included the CRUSH map in the tarball.<br>
&gt; &gt;<br>
&gt; &gt; I stopped one OSD process and marked it out. I let it recover for=
 a<br>
&gt; &gt; few minutes and then I started the process again and marked it in=
. I<br>
&gt; &gt; started getting block I/O messages during the recovery.<br>
&gt; &gt;<br>
&gt; &gt; The logs are located at <a href=3D"http://162.144.87.113/files/us=
hou1.tar.xz" rel=3D"noreferrer" target=3D"_blank">http://162.144.87.113/fil=
es/ushou1.tar.xz</a><br>
&gt; &gt;<br>
&gt; &gt; Thanks,<br>
&gt; &gt; -----BEGIN PGP SIGNATURE-----<br>
&gt; &gt; Version: Mailvelope v1.2.0<br>
&gt; &gt; Comment: <a href=3D"https://www.mailvelope.com" rel=3D"noreferrer=
" target=3D"_blank">https://www.mailvelope.com</a><br>
&gt; &gt;<br>
&gt; &gt; wsFcBAEBCAAQBQJWEZRcCRDmVDuy+mK58QAALbEQAK5pFiixJarUdLm50zp/<br>
&gt; &gt; 3AGgGBPrieExKmoZZLCoMGfOLfxZDbN2ybtopKDQDfrTqndE/6Xi9UXqTOdW<br>
&gt; &gt; jDc9U1wusgG0CKPsY1SMYnB9akvaDwtdh5q5k4VpN2zsG9R6lRojHeNQR3Nf<br>
&gt; &gt; 56QevJL4/e5lC3sLhVnxXXi2XKnHCVOHT+PYgNour2ZWt6OTLoFFxuSU3zLN<br>
&gt; &gt; OtfXgrFiiNF0mrDpm0gg2l8a8N5SwP9mM233S2U/JiGAqsqoqkfd0okjDenC<br>
&gt; &gt; ksesU/n7zordFpfLN3yjL6+X9pQ4YA6otZrq4wWtjWKO/H0b+6iIsf/AE131<br>
&gt; &gt; R6a4Vufndpd3Ce+FNfM+iu3FmKk0KVfDAaF/tIP6S6XUzGVMAbpvpmqNL17o<br>
&gt; &gt; boh3wPZEyK+7KiF4Qlt2KoI/FV24Yj8XiyMnKin3MbMYbammb4ER977VH7iI<br>
&gt; &gt; sZyelNPSsYmmw/MF+AkA5KVgzQ4DAPflaejIgC5uw3dYKrn2AQE5CE9nN8Gz<br>
&gt; &gt; GVVaGItu1Bvrz21QoT9o5v0dZ85zttFvtrKIYgSi4mdpC6XkzUbg9s9EB1/T<br>
&gt; &gt; SEY+fau7W7TtiLpzCAIQ3zDvgsvkx2P6tKg5U8e93LVv9B+YI8i8mUxxv1j5<br>
&gt; &gt; PHFi7KTgRUPm1FPMJDSyzvOgqyMj9AzaESl1Na6k529ILFIcyfko0niTT1oZ<br>
&gt; &gt; 3EPx<br>
&gt; &gt; =3DUDIV<br>
&gt; &gt; -----END PGP SIGNATURE-----<br>
&gt; &gt;<br>
&gt; &gt; ----------------<br>
&gt; &gt; Robert LeBlanc<br>
&gt; &gt; PGP Fingerprint 79A2 9CA4 6CC4 45DD A904=C2=A0 C70E E654 3BB2 FA6=
2 B9F1<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; On Sun, Oct 4, 2015 at 7:48 AM, Sage Weil &lt;<a href=3D"mailto:s=
weil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt; wrote:<br>
&gt; &gt;&gt; On Sat, 3 Oct 2015, Robert LeBlanc wrote:<br>
&gt; &gt;&gt;&gt; -----BEGIN PGP SIGNED MESSAGE-----<br>
&gt; &gt;&gt;&gt; Hash: SHA256<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; We are still struggling with this and have tried a lot of=
 different<br>
&gt; &gt;&gt;&gt; things. Unfortunately, Inktank (now Red Hat) no longer pr=
ovides<br>
&gt; &gt;&gt;&gt; consulting services for non-Red Hat systems. If there are=
 some<br>
&gt; &gt;&gt;&gt; certified Ceph consultants in the US that we can do both =
remote and<br>
&gt; &gt;&gt;&gt; on-site engagements, please let us know.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; This certainly seems to be network related, but somewhere=
 in the<br>
&gt; &gt;&gt;&gt; kernel. We have tried increasing the network and TCP buff=
ers, number<br>
&gt; &gt;&gt;&gt; of TCP sockets, reduced the FIN_WAIT2 state. There is abo=
ut 25% idle<br>
&gt; &gt;&gt;&gt; on the boxes, the disks are busy, but not constantly at 1=
00% (they<br>
&gt; &gt;&gt;&gt; cycle from &lt;10% up to 100%, but not 100% for more than=
 a few seconds<br>
&gt; &gt;&gt;&gt; at a time). There seems to be no reasonable explanation w=
hy I/O is<br>
&gt; &gt;&gt;&gt; blocked pretty frequently longer than 30 seconds. We have=
 verified<br>
&gt; &gt;&gt;&gt; Jumbo frames by pinging from/to each node with 9000 byte =
packets. The<br>
&gt; &gt;&gt;&gt; network admins have verified that packets are not being d=
ropped in the<br>
&gt; &gt;&gt;&gt; switches for these nodes. We have tried different kernels=
 including<br>
&gt; &gt;&gt;&gt; the recent Google patch to cubic. This is showing up on t=
hree cluster<br>
&gt; &gt;&gt;&gt; (two Ethernet and one IPoIB). I booted one cluster into D=
ebian Jessie<br>
&gt; &gt;&gt;&gt; (from CentOS 7.1) with similar results.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; The messages seem slightly different:<br>
&gt; &gt;&gt;&gt; 2015-10-03 14:38:23.193082 osd.134 <a href=3D"http://10.2=
08.16.25:6800/1425" rel=3D"noreferrer" target=3D"_blank">10.208.16.25:6800/=
1425</a> 439 :<br>
&gt; &gt;&gt;&gt; cluster [WRN] 14 slow requests, 1 included below; oldest =
blocked for &gt;<br>
&gt; &gt;&gt;&gt; 100.087155 secs<br>
&gt; &gt;&gt;&gt; 2015-10-03 14:38:23.193090 osd.134 <a href=3D"http://10.2=
08.16.25:6800/1425" rel=3D"noreferrer" target=3D"_blank">10.208.16.25:6800/=
1425</a> 440 :<br>
&gt; &gt;&gt;&gt; cluster [WRN] slow request 30.041999 seconds old, receive=
d at<br>
&gt; &gt;&gt;&gt; 2015-10-03 14:37:53.151014: osd_op(client.1328605.0:70828=
62<br>
&gt; &gt;&gt;&gt; rbd_data.13fdcb2ae8944a.000000000001264f [read 975360~409=
6]<br>
&gt; &gt;&gt;&gt; 11.6d19c36f ack+read+known_if_redirected e10249) currentl=
y no flag<br>
&gt; &gt;&gt;&gt; points reached<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; I don&#39;t know what &quot;no flag points reached&quot; =
means.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Just that the op hasn&#39;t been marked as reaching any inter=
esting points<br>
&gt; &gt;&gt; (op-&gt;mark_*() calls).<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Is it possible to gather a lot with debug ms =3D 20 and debug=
 osd =3D 20?<br>
&gt; &gt;&gt; It&#39;s extremely verbose but it&#39;ll let us see where the=
 op is getting<br>
&gt; &gt;&gt; blocked.=C2=A0 If you see the &quot;slow request&quot; messag=
e it means the op in<br>
&gt; &gt;&gt; received by ceph (that&#39;s when the clock starts), so I sus=
pect it&#39;s not<br>
&gt; &gt;&gt; something we can blame on the network stack.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; sage<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; The problem is most pronounced when we have to reboot an =
OSD node (1<br>
&gt; &gt;&gt;&gt; of 13), we will have hundreds of I/O blocked for some tim=
es up to 300<br>
&gt; &gt;&gt;&gt; seconds. It takes a good 15 minutes for things to settle =
down. The<br>
&gt; &gt;&gt;&gt; production cluster is very busy doing normally 8,000 I/O =
and peaking<br>
&gt; &gt;&gt;&gt; at 15,000. This is all 4TB spindles with SSD journals and=
 the disks<br>
&gt; &gt;&gt;&gt; are between 25-50% full. We are currently splitting PGs t=
o distribute<br>
&gt; &gt;&gt;&gt; the load better across the disks, but we are having to do=
 this 10 PGs<br>
&gt; &gt;&gt;&gt; at a time as we get blocked I/O. We have max_backfills an=
d<br>
&gt; &gt;&gt;&gt; max_recovery set to 1, client op priority is set higher t=
han recovery<br>
&gt; &gt;&gt;&gt; priority. We tried increasing the number of op threads bu=
t this didn&#39;t<br>
&gt; &gt;&gt;&gt; seem to help. It seems as soon as PGs are finished being =
checked, they<br>
&gt; &gt;&gt;&gt; become active and could be the cause for slow I/O while t=
he other PGs<br>
&gt; &gt;&gt;&gt; are being checked.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; What I don&#39;t understand is that the messages are dela=
yed. As soon as<br>
&gt; &gt;&gt;&gt; the message is received by Ceph OSD process, it is very q=
uickly<br>
&gt; &gt;&gt;&gt; committed to the journal and a response is sent back to t=
he primary<br>
&gt; &gt;&gt;&gt; OSD which is received very quickly as well. I&#39;ve adju=
st<br>
&gt; &gt;&gt;&gt; min_free_kbytes and it seems to keep the OSDs from crashi=
ng, but<br>
&gt; &gt;&gt;&gt; doesn&#39;t solve the main problem. We don&#39;t have swa=
p and there is 64 GB<br>
&gt; &gt;&gt;&gt; of RAM per nodes for 10 OSDs.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Is there something that could cause the kernel to get a p=
acket but not<br>
&gt; &gt;&gt;&gt; be able to dispatch it to Ceph such that it could be expl=
aining why we<br>
&gt; &gt;&gt;&gt; are seeing these blocked I/O for 30+ seconds. Is there so=
me pointers<br>
&gt; &gt;&gt;&gt; to tracing Ceph messages from the network buffer through =
the kernel to<br>
&gt; &gt;&gt;&gt; the Ceph process?<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; We can really use some pointers no matter how outrageous.=
 We&#39;ve have<br>
&gt; &gt;&gt;&gt; over 6 people looking into this for weeks now and just ca=
n&#39;t think of<br>
&gt; &gt;&gt;&gt; anything else.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Thanks,<br>
&gt; &gt;&gt;&gt; -----BEGIN PGP SIGNATURE-----<br>
&gt; &gt;&gt;&gt; Version: Mailvelope v1.1.0<br>
&gt; &gt;&gt;&gt; Comment: <a href=3D"https://www.mailvelope.com" rel=3D"no=
referrer" target=3D"_blank">https://www.mailvelope.com</a><br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; wsFcBAEBCAAQBQJWEDY1CRDmVDuy+mK58QAARgoP/RcoL1qVmg7qbQrzS=
tar<br>
&gt; &gt;&gt;&gt; NK80bqYGeYHb26xHbt1fZVgnZhXU0nN0Dv4ew0e/cYJLELSO2KCeXNfXN=
6F1<br>
&gt; &gt;&gt;&gt; prZuzYagYEyj1Q1TOo+4h/nOQRYsTwQDdFzbHb/OUDN55C0QGZ29DjEvr=
qP6<br>
&gt; &gt;&gt;&gt; K5l6sAQzvQDpUEEIiOCkS6pH59ira740nSmnYkEWhr1lxF/hMjb6fFlfC=
Fe2<br>
&gt; &gt;&gt;&gt; h1djM0GfY7vBHFGgI3jkw0BL5AQnWe+SCcCiKZmxY6xiR70FWl3XqK5M+=
nxm<br>
&gt; &gt;&gt;&gt; iq74y7Dv6cpenit6boMr6qtOeIt+8ko85hVMh09Hkaqz/m2FzxAKLcahz=
kGF<br>
&gt; &gt;&gt;&gt; Fh/M6YBzgnX7QBURTC4YQT/FVyDTW3JMuT3RKQdaX6c0iiOsVdkE+iyid=
WyY<br>
&gt; &gt;&gt;&gt; Hr1KzWU23Ur9yBfZ39Y43jrsSiAEwHnKjSqMowSGljdTysNEAAZQhlqZI=
oHb<br>
&gt; &gt;&gt;&gt; JlgpB39ugkHI1H5fZ5b2SIDz32/d5ywG4Gay9Rk6hp8VanvIrBbev+JYE=
oYT<br>
&gt; &gt;&gt;&gt; 8/WX+fhueHt4dqUYWIl3HZ0CEzbXbug0xmFvhrbmL2f3t9XOkDZRbAjlY=
rGm<br>
&gt; &gt;&gt;&gt; lswiJMDueY8JkxSnPvCQrHXqjbCcy9rMG7nTnLFz98rTcHNCwtpv0qVYh=
heg<br>
&gt; &gt;&gt;&gt; 4YRNRVMbfNP/6xsJvG1wVOSQPwxZSPqJh42pDqMRePJl3Zn66MTx5wvdN=
Dpk<br>
&gt; &gt;&gt;&gt; l7OF<br>
&gt; &gt;&gt;&gt; =3DOI++<br>
&gt; &gt;&gt;&gt; -----END PGP SIGNATURE-----<br>
&gt; &gt;&gt;&gt; ----------------<br>
&gt; &gt;&gt;&gt; Robert LeBlanc<br>
&gt; &gt;&gt;&gt; PGP Fingerprint 79A2 9CA4 6CC4 45DD A904=C2=A0 C70E E654 =
3BB2 FA62 B9F1<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; On Fri, Sep 25, 2015 at 2:40 PM, Robert LeBlanc &lt;<a hr=
ef=3D"mailto:robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org">robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org</a>&gt; wrote:<br>
&gt; &gt;&gt;&gt; &gt; We dropped the replication on our cluster from 4 to =
3 and it looks<br>
&gt; &gt;&gt;&gt; &gt; like all the blocked I/O has stopped (no entries in =
the log for the<br>
&gt; &gt;&gt;&gt; &gt; last 12 hours). This makes me believe that there is =
some issue with<br>
&gt; &gt;&gt;&gt; &gt; the number of sockets or some other TCP issue. We ha=
ve not messed with<br>
&gt; &gt;&gt;&gt; &gt; Ephemeral ports and TIME_WAIT at this point. There a=
re 130 OSDs, 8 KVM<br>
&gt; &gt;&gt;&gt; &gt; hosts hosting about 150 VMs. Open files is set at 32=
K for the OSD<br>
&gt; &gt;&gt;&gt; &gt; processes and 16K system wide.<br>
&gt; &gt;&gt;&gt; &gt;<br>
&gt; &gt;&gt;&gt; &gt; Does this seem like the right spot to be looking? Wh=
at are some<br>
&gt; &gt;&gt;&gt; &gt; configuration items we should be looking at?<br>
&gt; &gt;&gt;&gt; &gt;<br>
&gt; &gt;&gt;&gt; &gt; Thanks,<br>
&gt; &gt;&gt;&gt; &gt; ----------------<br>
&gt; &gt;&gt;&gt; &gt; Robert LeBlanc<br>
&gt; &gt;&gt;&gt; &gt; PGP Fingerprint 79A2 9CA4 6CC4 45DD A904=C2=A0 C70E =
E654 3BB2 FA62 B9F1<br>
&gt; &gt;&gt;&gt; &gt;<br>
&gt; &gt;&gt;&gt; &gt;<br>
&gt; &gt;&gt;&gt; &gt; On Wed, Sep 23, 2015 at 1:30 PM, Robert LeBlanc &lt;=
<a href=3D"mailto:robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org">robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org</a>&gt; wrote:=
<br>
&gt; &gt;&gt;&gt; &gt;&gt; -----BEGIN PGP SIGNED MESSAGE-----<br>
&gt; &gt;&gt;&gt; &gt;&gt; Hash: SHA256<br>
&gt; &gt;&gt;&gt; &gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt; We were able to only get ~17Gb out of the XL710 =
(heavily tweaked)<br>
&gt; &gt;&gt;&gt; &gt;&gt; until we went to the 4.x kernel where we got ~36=
Gb (no tweaking). It<br>
&gt; &gt;&gt;&gt; &gt;&gt; seems that there were some major reworks in the =
network handling in<br>
&gt; &gt;&gt;&gt; &gt;&gt; the kernel to efficiently handle that network ra=
te. If I remember<br>
&gt; &gt;&gt;&gt; &gt;&gt; right we also saw a drop in CPU utilization. I&#=
39;m starting to think<br>
&gt; &gt;&gt;&gt; &gt;&gt; that we did see packet loss while congesting our=
 ISLs in our initial<br>
&gt; &gt;&gt;&gt; &gt;&gt; testing, but we could not tell where the droppin=
g was happening. We<br>
&gt; &gt;&gt;&gt; &gt;&gt; saw some on the switches, but it didn&#39;t seem=
 to be bad if we weren&#39;t<br>
&gt; &gt;&gt;&gt; &gt;&gt; trying to congest things. We probably already sa=
w this issue, just<br>
&gt; &gt;&gt;&gt; &gt;&gt; didn&#39;t know it.<br>
&gt; &gt;&gt;&gt; &gt;&gt; - ----------------<br>
&gt; &gt;&gt;&gt; &gt;&gt; Robert LeBlanc<br>
&gt; &gt;&gt;&gt; &gt;&gt; PGP Fingerprint 79A2 9CA4 6CC4 45DD A904=C2=A0 C=
70E E654 3BB2 FA62 B9F1<br>
&gt; &gt;&gt;&gt; &gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt; On Wed, Sep 23, 2015 at 1:10 PM, Mark Nelson=C2=
=A0 wrote:<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt; FWIW, we&#39;ve got some 40GbE Intel cards i=
n the community performance cluster<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt; on a Mellanox 40GbE switch that appear (knoc=
k on wood) to be running fine<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt; with 3.10.0-229.7.2.el7.x86_64.=C2=A0 We did=
 get feedback from Intel that older<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt; drivers might cause problems though.<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt; Here&#39;s ifconfig from one of the nodes:<b=
r>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt; ens513f1: flags=3D4163=C2=A0 mtu 1500<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0inet 10.0.1=
0.101=C2=A0 netmask 255.255.255.0=C2=A0 broadcast 10.0.10.255<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0inet6 fe80:=
:6a05:caff:fe2b:7ea1=C2=A0 prefixlen 64=C2=A0 scopeid 0x20<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ether 68:05=
:ca:2b:7e:a1=C2=A0 txqueuelen 1000=C2=A0 (Ethernet)<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RX packets =
169232242875=C2=A0 bytes 229346261232279 (208.5 TiB)<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RX errors 0=
=C2=A0 dropped 0=C2=A0 overruns 0=C2=A0 frame 0<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TX packets =
153491686361=C2=A0 bytes 203976410836881 (185.5 TiB)<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TX errors 0=
=C2=A0 dropped 0 overruns 0=C2=A0 carrier 0=C2=A0 collisions 0<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt; Mark<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt; On 09/23/2015 01:48 PM, Robert LeBlanc wrote=
:<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt; -----BEGIN PGP SIGNED MESSAGE-----<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt; Hash: SHA256<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt; OK, here is the update on the saga...<br=
>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt; I traced some more of blocked I/Os and i=
t seems that communication<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt; between two hosts seemed worse than othe=
rs. I did a two way ping flood<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt; between the two hosts using max packet s=
izes (1500). After 1.5M<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt; packets, no lost pings. Then then had th=
e ping flood running while I<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt; put Ceph load on the cluster and the dro=
pped pings started increasing<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt; after stopping the Ceph workload the pin=
gs stopped dropping.<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt; I then ran iperf between all the nodes w=
ith the same results, so that<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt; ruled out Ceph to a large degree. I then=
 booted in the the<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt; 3.10.0-229.14.1.el7.x86_64 kernel and wi=
th an hour test so far there<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt; hasn&#39;t been any dropped pings or blo=
cked I/O. Our 40 Gb NICs really<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt; need the network enhancements in the 4.x=
 series to work well.<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt; Does this sound familiar to anyone? I&#3=
9;ll probably start bisecting the<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt; kernel to see where this issue in introd=
uced. Both of the clusters<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt; with this issue are running 4.x, other t=
han that, they are pretty<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt; differing hardware and network configs.<=
br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt; Thanks,<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt; -----BEGIN PGP SIGNATURE-----<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt; Version: Mailvelope v1.1.0<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt; Comment: <a href=3D"https://www.mailvelo=
pe.com" rel=3D"noreferrer" target=3D"_blank">https://www.mailvelope.com</a>=
<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt; wsFcBAEBCAAQBQJWAvOzCRDmVDuy+mK58QAApOMP=
/1xmCtW++G11qcE8y/sr<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt; RkXguqZJLc4czdOwV/tjUvhVsm5qOl4wvQCtABFZ=
pc6t4+m5nzE3LkA1rl2l<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt; AnARPOjh61TO6cV0CT8O0DlqtHmSd2y0ElgAUl05=
94eInEn7eI7crz8R543V<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt; 7I68XU5zL/vNJ9IIx38UqdhtSzXQQL664DGq3DLI=
NK0Yb9XRVBlFip+Slt+j<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt; cB64TuWjOPLSH09pv7SUyksodqrTq3K7p6sQkq0M=
OzBkFQM1FHfOipbo/LYv<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt; F42iiQbCvFizArMu20WeOSQ4dmrXT/iecgTfEag/=
Zxvor2gOi/J6d2XS9ckW<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt; byEC5/rbm4yDBua2ZugeNxQLWq0Oa7spZnx7usLs=
u/6YzeDNI6kmtGURajdE<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt; /XC8bESWKveBzmGDzjff5oaMs9A1PZURYnlYADEO=
DGAt6byoaoQEGN6dlFGe<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt; LwQ5nOdQYuUrWpJzTJBN3aduOxursoFY8S0eR0uX=
m0l1CHcp22RWBDvRinok<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt; UWk5xRBgjDCD2gIwc+wpImZbCtiTdf0vad1uLvdx=
GL29iFta4THzJgUGrp98<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt; sUqM3RaTRdJYjFcNP293H7/DC0mqpnmo0Clx3jkd=
HX+x1EXpJUtocSeI44LX<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt; KWIMhe9wXtKAoHQFEcJ0o0+wrXWMevvx33HPC4q1=
ULrFX0ILNx5Mo0Rp944X<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt; 4OEo<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt; =3DP33I<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt; -----END PGP SIGNATURE-----<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt; ----------------<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt; Robert LeBlanc<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt; PGP Fingerprint 79A2 9CA4 6CC4 45DD A904=
=C2=A0 C70E E654 3BB2 FA62 B9F1<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt; On Tue, Sep 22, 2015 at 4:15 PM, Robert =
LeBlanc<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt; wrote:<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt; -----BEGIN PGP SIGNED MESSAGE-----<b=
r>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt; Hash: SHA256<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt; This is IPoIB and we have the MTU se=
t to 64K. There was some issues<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt; pinging hosts with &quot;No buffer s=
pace available&quot; (hosts are currently<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt; configured for 4GB to test SSD cachi=
ng rather than page cache). I<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt; found that MTU under 32K worked reli=
able for ping, but still had the<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt; blocked I/O.<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt; I reduced the MTU to 1500 and checke=
d pings (OK), but I&#39;m still seeing<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt; the blocked I/O.<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt; - ----------------<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt; Robert LeBlanc<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt; PGP Fingerprint 79A2 9CA4 6CC4 45DD =
A904=C2=A0 C70E E654 3BB2 FA62 B9F1<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt; On Tue, Sep 22, 2015 at 3:52 PM, Sag=
e Weil=C2=A0 wrote:<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; On Tue, 22 Sep 2015, Samuel Just=
 wrote:<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; I looked at the logs, it loo=
ks like there was a 53 second delay<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; between when osd.17 started =
sending the osd_repop message and when<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; osd.13 started reading it, w=
hich is pretty weird.=C2=A0 Sage, didn&#39;t we<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; once see a kernel issue whic=
h caused some messages to be mysteriously<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; delayed for many 10s of seco=
nds?<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; Every time we have seen this beh=
avior and diagnosed it in the wild it<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; has<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; been a network misconfiguration.=
=C2=A0 Usually related to jumbo frames.<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; sage<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; What kernel are you running?=
<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; -Sam<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; On Tue, Sep 22, 2015 at 2:22=
 PM, Robert LeBlanc=C2=A0 wrote:<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; -----BEGIN PGP SIGNED ME=
SSAGE-----<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Hash: SHA256<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; OK, looping in ceph-deve=
l to see if I can get some more eyes. I&#39;ve<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; extracted what I think a=
re important entries from the logs for the<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; first blocked request. N=
TP is running all the servers so the logs<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; should be close in terms=
 of time. Logs for 12:50 to 13:00 are<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; available at <a href=3D"=
http://162.144.87.113/files/ceph_block_io.logs.tar.xz" rel=3D"noreferrer" t=
arget=3D"_blank">http://162.144.87.113/files/ceph_block_io.logs.tar.xz</a><=
br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:55:06.5003=
74 - osd.17 gets I/O from client<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:55:06.5571=
60 - osd.17 submits I/O to osd.13<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:55:06.5573=
05 - osd.17 submits I/O to osd.16<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:55:06.5737=
11 - osd.16 gets I/O from osd.17<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:55:06.5957=
16 - osd.17 gets ondisk result=3D0 from osd.16<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:55:06.6406=
31 - osd.16 reports to osd.17 ondisk result=3D0<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:55:36.9266=
91 - osd.17 reports slow I/O &gt; 30.439150 sec<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:55:59.7905=
91 - osd.13 gets I/O from osd.17<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:55:59.8124=
05 - osd.17 gets ondisk result=3D0 from osd.13<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:56:02.9416=
02 - osd.13 reports to osd.17 ondisk result=3D0<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; In the logs I can see th=
at osd.17 dispatches the I/O to osd.13 and<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; osd.16 almost silmutanio=
usly. osd.16 seems to get the I/O right away,<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; but for some reason osd.=
13 doesn&#39;t get the message until 53 seconds<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; later. osd.17 seems happ=
y to just wait and doesn&#39;t resend the data<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; (well, I&#39;m not 100% =
sure how to tell which entries are the actual data<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; transfer).<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; It looks like osd.17 is =
receiving responses to start the communication<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; with osd.13, but the op =
is not acknowledged until almost a minute<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; later. To me it seems th=
at the message is getting received but not<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; passed to another thread=
 right away or something. This test was done<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; with an idle cluster, a =
single fio client (rbd engine) with a single<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; thread.<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; The OSD servers are almo=
st 100% idle during these blocked I/O<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; requests. I think I&#39;=
m at the end of my troubleshooting, so I can use<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; some help.<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Single Test started abou=
t<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:52:36<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:55:36.9266=
80 osd.17 <a href=3D"http://192.168.55.14:6800/16726" rel=3D"noreferrer" ta=
rget=3D"_blank">192.168.55.14:6800/16726</a> 56 :<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; cluster [WRN] 1 slow req=
uests, 1 included below; oldest blocked for &gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 30.439150 secs<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:55:36.9266=
99 osd.17 <a href=3D"http://192.168.55.14:6800/16726" rel=3D"noreferrer" ta=
rget=3D"_blank">192.168.55.14:6800/16726</a> 57 :<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; cluster [WRN] slow reque=
st 30.439150 seconds old, received at<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:55:06.4874=
51:<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0osd_op(clien=
t.250874.0:1388 rbd_data.3380e2ae8944a.0000000000000545<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [set-alloc-hint object_s=
ize 4194304 write_size 4194304,write<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 0~4194304] 8.bbf3e8ff ac=
k+ondisk+write+known_if_redirected e56785)<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0currently wa=
iting for subops from 13,16<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:55:36.6979=
04 osd.16 <a href=3D"http://192.168.55.13:6800/29410" rel=3D"noreferrer" ta=
rget=3D"_blank">192.168.55.13:6800/29410</a> 7 : cluster<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [WRN] 2 slow requests, 2=
 included below; oldest blocked for &gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 30.379680 secs<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:55:36.6979=
18 osd.16 <a href=3D"http://192.168.55.13:6800/29410" rel=3D"noreferrer" ta=
rget=3D"_blank">192.168.55.13:6800/29410</a> 8 : cluster<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [WRN] slow request 30.29=
1520 seconds old, received at 2015-09-22<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 12:55:06.406303:<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0osd_op(clien=
t.250874.0:1384 rbd_data.3380e2ae8944a.0000000000000541<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [set-alloc-hint object_s=
ize 4194304 write_size 4194304,write<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 0~4194304] 8.5fb2123f ac=
k+ondisk+write+known_if_redirected e56785)<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0currently wa=
iting for subops from 13,17<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:55:36.6979=
27 osd.16 <a href=3D"http://192.168.55.13:6800/29410" rel=3D"noreferrer" ta=
rget=3D"_blank">192.168.55.13:6800/29410</a> 9 : cluster<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [WRN] slow request 30.37=
9680 seconds old, received at 2015-09-22<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 12:55:06.318144:<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0osd_op(clien=
t.250874.0:1382 rbd_data.3380e2ae8944a.000000000000053f<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [set-alloc-hint object_s=
ize 4194304 write_size 4194304,write<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 0~4194304] 8.312e69ca ac=
k+ondisk+write+known_if_redirected e56785)<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0currently wa=
iting for subops from 13,14<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:58:03.9982=
75 osd.13 <a href=3D"http://192.168.55.12:6804/4574" rel=3D"noreferrer" tar=
get=3D"_blank">192.168.55.12:6804/4574</a> 130 :<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; cluster [WRN] 1 slow req=
uests, 1 included below; oldest blocked for &gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 30.954212 secs<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:58:03.9982=
86 osd.13 <a href=3D"http://192.168.55.12:6804/4574" rel=3D"noreferrer" tar=
get=3D"_blank">192.168.55.12:6804/4574</a> 131 :<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; cluster [WRN] slow reque=
st 30.954212 seconds old, received at<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:57:33.0440=
03:<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0osd_op(clien=
t.250874.0:1873 rbd_data.3380e2ae8944a.000000000000070d<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [set-alloc-hint object_s=
ize 4194304 write_size 4194304,write<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 0~4194304] 8.e69870d4 ac=
k+ondisk+write+known_if_redirected e56785)<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0currently wa=
iting for subops from 16,17<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:58:03.7598=
26 osd.16 <a href=3D"http://192.168.55.13:6800/29410" rel=3D"noreferrer" ta=
rget=3D"_blank">192.168.55.13:6800/29410</a> 10 :<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; cluster [WRN] 1 slow req=
uests, 1 included below; oldest blocked for &gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 30.704367 secs<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:58:03.7598=
40 osd.16 <a href=3D"http://192.168.55.13:6800/29410" rel=3D"noreferrer" ta=
rget=3D"_blank">192.168.55.13:6800/29410</a> 11 :<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; cluster [WRN] slow reque=
st 30.704367 seconds old, received at<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2015-09-22 12:57:33.0554=
04:<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0osd_op(clien=
t.250874.0:1874 rbd_data.3380e2ae8944a.000000000000070e<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [set-alloc-hint object_s=
ize 4194304 write_size 4194304,write<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 0~4194304] 8.f7635819 ac=
k+ondisk+write+known_if_redirected e56785)<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0currently wa=
iting for subops from 13,17<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Server=C2=A0 =C2=A0IP ad=
dr=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OSD<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; nodev=C2=A0 - 192.168.55=
.11 - 12<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; nodew=C2=A0 - 192.168.55=
.12 - 13<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; nodex=C2=A0 - 192.168.55=
.13 - 16<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; nodey=C2=A0 - 192.168.55=
.14 - 17<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; nodez=C2=A0 - 192.168.55=
.15 - 14<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; nodezz - 192.168.55.16 -=
 15<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; fio job:<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [rbd-test]<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; readwrite=3Dwrite<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; blocksize=3D4M<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; #runtime=3D60<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; name=3Drbd-test<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; #readwrite=3Drandwrite<b=
r>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; #bssplit=3D4k/85:32k/11:=
512/3:1m/1,4k/89:32k/10:512k/1<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; #rwmixread=3D72<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; #norandommap<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; #size=3D1T<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; #blocksize=3D4k<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; ioengine=3Drbd<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; rbdname=3Dtest2<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; pool=3Drbd<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; clientname=3Dadmin<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; iodepth=3D8<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; #numjobs=3D4<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; #thread<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; #group_reporting<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; #time_based<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; #direct=3D1<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; #ramp_time=3D60<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Thanks,<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; -----BEGIN PGP SIGNATURE=
-----<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Version: Mailvelope v1.1=
.0<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Comment: <a href=3D"http=
s://www.mailvelope.com" rel=3D"noreferrer" target=3D"_blank">https://www.ma=
ilvelope.com</a><br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; wsFcBAEBCAAQBQJWAcaKCRDm=
VDuy+mK58QAAPMsQAKBnS94fwuw0OqpPU3/z<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; tL8Z6TVRxrNigf721+2ClIu4=
LIH71bupDc3DgrrysQmmqGuvEMn68spmasWu<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; h9I/CqqgRpHqe4lUVoUEjyWA=
9/6Dbb6NiHSdpJ6p5jpGc8kZCvNS+ocDgFOl<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 903i0M0E9eEMeci5O/hrMrx1=
FG8SN2LS8nI261aNHMOwQK0bw8wWiCJEvqVB<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; sz1/+jK1BJoeIYfaT9HfUXBA=
vfo/W3tY/vj9KbJuZJ5AMpeYPvEHu/LAr1N7<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; FzzUc7a6EMlaxmSd0ML49JbV=
0cY9BMDjfrkKEQNKlzszlEHm3iif98QtsxbF<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; pPJ0hZ0G53BY3k976OWVMFm3=
WFRWUVOb/oiLF8H6PCm59b4LBNAg6iPNH1AI<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 5XhEcPpg06M03vqUaIiY9P1k=
Qlvnn0yCXf82IUEgmg///vhxDsHWmcwClLEn<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; B0VszouStTzlMYnc/2vlUiI4=
gFVeilWLMW00VGTWV+7V1oIzIYvWHyl2QpBq<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 4/ZwVjQ43qLfuDTS4o+IJ4zt=
OMd26vIv6Mn6WVwKCjoCXJc8ajywR9Dy+6lL<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; o8oJ+tn7hMc9Qy1iBhu3/QIP=
4WCsUf9RVeu60oahNEpde89qW32S9CZlrJDO<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; gf4iTryRjkAhdmZIj9JiaE8j=
Q6dvN817D9cqs/CXKV9vhzYoM7p5YWHghBKB<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; J3hS<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =3D0J7F<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; -----END PGP SIGNATURE--=
---<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; ----------------<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Robert LeBlanc<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; PGP Fingerprint 79A2 9CA=
4 6CC4 45DD A904=C2=A0 C70E E654 3BB2 FA62 B9F1<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; On Tue, Sep 22, 2015 at =
8:31 AM, Gregory Farnum=C2=A0 wrote:<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; On Tue, Sep 22, 2015=
 at 7:24 AM, Robert LeBlanc=C2=A0 wrote:<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; -----BEGIN PGP S=
IGNED MESSAGE-----<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Hash: SHA256<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Is there some wa=
y to tell in the logs that this is happening?<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; You can search for t=
he (mangled) name _split_collection<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; I&#39;m not<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; seeing much I/O,=
 CPU usage during these times. Is there some way to<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; prevent the spli=
tting? Is there a negative side effect to doing so?<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Bump up the split an=
d merge thresholds. You can search the list for<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; this, it was discuss=
ed not too long ago.<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; We&#39;ve had I/=
O block for over 900 seconds and as soon as the sessions<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; are aborted, the=
y are reestablished and complete immediately.<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; The fio test is =
just a seq write, starting it over (rewriting from<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; the<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; beginning) is st=
ill causing the issue. I was suspect that it is not<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; having to create=
 new file and therefore split collections. This is<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; on<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; my test cluster =
with no other load.<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Hmm, that does make =
it seem less likely if you&#39;re really not creating<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; new objects, if you&=
#39;re actually running fio in such a way that it&#39;s<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; not allocating new F=
S blocks (this is probably hard to set up?).<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; I&#39;ll be doin=
g a lot of testing today. Which log options and depths<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; would be the mos=
t helpful for tracking this issue down?<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; If you want to go lo=
g diving &quot;debug osd =3D 20&quot;, &quot;debug filestore =3D<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 20&quot;,<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &quot;debug ms =3D 1=
&quot; are what the OSD guys like to see. That should spit<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; out<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; everything you need =
to track exactly what each Op is doing.<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; -Greg<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; --<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; To unsubscribe from this=
 list: send the line &quot;unsubscribe ceph-devel&quot;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; in<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; the body of a message to=
 <a href=3D"mailto:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a>=
<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; More majordomo info at=
=C2=A0 <a href=3D"http://vger.kernel.org/majordomo-info.html" rel=3D"norefe=
rrer" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a><br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt; -----BEGIN PGP SIGNATURE-----<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt; Version: Mailvelope v1.1.0<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt; Comment: <a href=3D"https://www.mail=
velope.com" rel=3D"noreferrer" target=3D"_blank">https://www.mailvelope.com=
</a><br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt; wsFcBAEBCAAQBQJWAdMSCRDmVDuy+mK58QAA=
oEgP/AqpH7i1BLpoz6fTlfWG<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt; a6swvF8xvsyR15PDiPINYT0N7MgoikikGrMm=
hWpJ6utEr1XPW0MPFgzvNIsf<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt; a1eMtNzyww4rAo6JCq6BtjmUsSKmOrBNhRNr=
6It9v4Nv+biqZHkiY8x/rRtV<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt; s9z0cv3Q9Wqa6y/zKZg3H1XtbtUAx0r/DUwz=
SsP3omupZgNyaKkCgdkil9Vc<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt; iyzBxFZU4+qXNT2FBG4dYDjxSHQv4psjvKR3=
AWXSN4yEn286KyMDjFrsDY5B<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt; izS3h603QPoErqsUQngDE8COcaTAHHrV7gNJ=
TikmGoNW6oQBjFq/z/zindTz<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt; caXshVQQ+OTLo/qzJM8QPswh0TGU74SVbDkT=
q+eTOb5pBhQbp+42Pkkqh7jj<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt; efyyYgDzpB1WrWRbUlWMNqmnjq7DT3lnAtuH=
yKbkwVs8x3JMPEiCl6PBvJbx<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt; GnNSCqgDJrpb4fHQ2iqfQeh8Ai6AL1C1Ai19=
RZPrAUhpDW0/DbUvuoKSR8m7<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt; glYYuH3hpy+oPYRhFcHm2fpNJ3u9npyk2Dai=
9RpzQ+mWmp3xi7becYmL482H<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt; +WyvLeY+8AiJQDpA0CdD8KeSlOC9bw5TPmih=
AIn9dVTJ1O2RlapCLqL3YAJg<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt; pGyDs8ercTEJLmvEyElj5XWh5DarsGscd2LE=
LNS/UpyuYurbPcyPKUQ0uPjp<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt; gcZm<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt; =3DCjwB<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt; -----END PGP SIGNATURE-----<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt; --<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt; To unsubscribe from this list: send the =
line &quot;unsubscribe ceph-devel&quot; in<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt; the body of a message to <a href=3D"mail=
to:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt; More majordomo info at=C2=A0 <a href=3D"=
http://vger.kernel.org/majordomo-info.html" rel=3D"noreferrer" target=3D"_b=
lank">http://vger.kernel.org/majordomo-info.html</a><br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt; -----BEGIN PGP SIGNATURE-----<br>
&gt; &gt;&gt;&gt; &gt;&gt; Version: Mailvelope v1.1.0<br>
&gt; &gt;&gt;&gt; &gt;&gt; Comment: <a href=3D"https://www.mailvelope.com" =
rel=3D"noreferrer" target=3D"_blank">https://www.mailvelope.com</a><br>
&gt; &gt;&gt;&gt; &gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt; wsFcBAEBCAAQBQJWAv3QCRDmVDuy+mK58QAABr4QAJcQj8zj=
l606aMdkmQG7<br>
&gt; &gt;&gt;&gt; &gt;&gt; S46iMXVav/Tv2os9GCUsQmMPx2u1w3/WmPfjByd6Divczfo0=
JLDDqrbsqre2<br>
&gt; &gt;&gt;&gt; &gt;&gt; lq0GNK6e8fq6FXHhPpnL+t4uFV4UZ289cma3yklRqEBDXWHl=
P59Hu7VpxC5l<br>
&gt; &gt;&gt;&gt; &gt;&gt; 0MIcCg4wM5VM/LkrfcMven5em5CnjyFJYbActGzw9043rZoy=
UwCM+eL7sotl<br>
&gt; &gt;&gt;&gt; &gt;&gt; JYHMcNWnqwdt8TLFDhUfVGiAQyV8/6E33CuCNUEuFGdtiBKz=
s9IZadOI8Ce0<br>
&gt; &gt;&gt;&gt; &gt;&gt; dod2DQNyFSvomqNq6t0DuTCSA+pT8uuks2O0NcrHjoqwIWVk=
xQGPYlpbpckf<br>
&gt; &gt;&gt;&gt; &gt;&gt; nxQdVM7vkqapVeQ0qUZx43Db9A5wDTC3PaEfVJZPZzWsSDjh=
9z7o6qHs3Kvp<br>
&gt; &gt;&gt;&gt; &gt;&gt; krfyS+dJaZ3tOYAP1VFDfasj06sOTFu3mfGYToKA75zz5HN7=
QZ13Zau/qhDu<br>
&gt; &gt;&gt;&gt; &gt;&gt; FHxsgk4oIXJsjj22LiSpoiigH5Ls+aVqtIbg8/vWp+EO6pK1=
fovEtJVeGAfE<br>
&gt; &gt;&gt;&gt; &gt;&gt; tLOdxfJJLVjMCAScFG9BRl1ePPLeptivKV0v9ruWsTpn+Q96=
VtqAR5GQCkYE<br>
&gt; &gt;&gt;&gt; &gt;&gt; hFrlxM+oIzHeArhhiIxSPCYLlnzxoD5IYXmTrWUYBCGvlY1m=
rI3j80mZ4VTj<br>
&gt; &gt;&gt;&gt; &gt;&gt; BErsSlqnjUyFKmaI7YNKyARCloMroz3wqdy/wpg/63Io62nm=
h5IyY+WO8hPo<br>
&gt; &gt;&gt;&gt; &gt;&gt; ae22<br>
&gt; &gt;&gt;&gt; &gt;&gt; =3DAX+L<br>
&gt; &gt;&gt;&gt; &gt;&gt; -----END PGP SIGNATURE-----<br>
&gt; &gt;&gt;&gt; _______________________________________________<br>
&gt; &gt;&gt;&gt; ceph-users mailing list<br>
&gt; &gt;&gt;&gt; <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users@l=
ists.ceph.com</a><br>
&gt; &gt;&gt;&gt; <a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-=
ceph.com" rel=3D"noreferrer" target=3D"_blank">http://lists.ceph.com/listin=
fo.cgi/ceph-users-ceph.com</a><br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;<br>
&gt; _______________________________________________<br>
&gt; ceph-users mailing list<br>
&gt; <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org=
</a><br>
&gt; <a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=
=3D"noreferrer" target=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-u=
sers-ceph.com</a><br>
&gt;<br>
&gt;<br>
</blockquote></div>

--001a11c013002597f605217079e9--

--===============1758183069==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1758183069==--
