From: =?UTF-8?Q?Marc_Sch=c3=b6chlin?= <ms-aJA5TdoZkU0dnm+yROfE0A@public.gmane.org>
Subject: unable to perform a "rbd-nbd map" without forgroud flag
Date: Fri, 27 Apr 2018 00:27:33 +0200
Message-ID: <63123611-dd14-8bf6-39b2-b527573d874f@256bit.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0388974721850279048=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-Language: de-DE
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

This is a multi-part message in MIME format.
--===============0388974721850279048==
Content-Type: multipart/alternative;
 boundary="------------325B9D6B70421A39277A931C"
Content-Language: de-DE

This is a multi-part message in MIME format.
--------------325B9D6B70421A39277A931C
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hello list,

this bug is filed as: https://tracker.ceph.com/issues/23891

From my point of this is a bug, probably others are experiencing also
this problem and can provide additional details.

I would like to map a rbd using rbd-nbd. Without adding the foreground
flag it is not possible to map the device.

The command listed beyond, are executed on a mon server (same thing
happens on other servers)

##################################################################################
### Not working scenario: running rbd-nbd as background proccess

Shell 1:

# rmmod nbd
rmmod: ERROR: Module nbd is not currently loaded
# rbd-nbd map  --nbds_max 16
RBD_XenStorage-07449252-bf96-4daa-b0a6-687b7f1c369c/RBD-17efad10-6807-433f-879a-c59b511f895c
-> it blocks probably forever

Strace of the problem situation

# strace -frvT -s128 -o /tmp/fail.strace rbd-nbd map  --nbds_max 16
RBD_XenStorage-07449252-bf96-4daa-b0a6-687b7f1c369c/RBD-17efad10-6807-433f-879a-c59b511f895c
(see  https://tracker.ceph.com/issues/23891)

Shell 2:

# rbd-nbd list-mapped
-> no output
# lsmod |grep nbd
-> no output

##################################################################################
### Working scenario running rbd-nbd in foreground:

Shell 1:

# rbd-nbd map  -d --nbds_max 16
RBD_XenStorage-07449252-bf96-4daa-b0a6-687b7f1c369c/RBD-17efad10-6807-433f-879a-c59b511f895c
2018-04-26 23:22:19.681903 7fde4b442e80  0 ceph version 12.2.5
(cad919881333ac92274171586c827e01f554a70a) luminous (stable), process
(unknown), pid 326958
2018-04-26 23:22:19.681919 7fde4b442e80  0 pidfile_write: ignore empty
--pid-file
/dev/nbd0
-> Blocking, because its running as foreeground proccess

Shell 2:

# rbd-nbd list-mapped
pid    pool                                               
image                                    snap device   
326958 RBD_XenStorage-07449252-bf96-4daa-b0a6-687b7f1c369c
RBD-17efad10-6807-433f-879a-c59b511f895c -    /dev/nbd0
# blockdev --getsize64 /dev/nbd0
21474836480
# blockdev --setra 1024 /dev/nbd0
# blockdev --getra  /dev/nbd0
1024
# rbd-nbd unmap /dev/nbd0

Shell 1:

-> terminates in unmap
2018-04-26 23:24:55.660478 7fdded7ba700  0 rbd-nbd: disconnect request
received

###################################################################################
### Our System:

  *     Luminous/12.2.5
  *     Ubuntu 16.04
  *     5 OSD Nodes (24*8 TB HDD OSDs, 48*1TB SSD OSDS, Bluestore, 6Gb
    Cache per OSD)
  *     Size per OSD, 192GB RAM, 56 HT CPUs)
  *     3 Mons (64 GB RAM, 200GB SSD, 4 visible CPUs)
  *     2 * 10 GBIT, SFP+, bonded xmit_hash_policy layer3+4




--------------325B9D6B70421A39277A931C
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <p>Hello list,<br>
    </p>
    <p>this bug is filed as: <a class="moz-txt-link-freetext"
        href="https://tracker.ceph.com/issues/23891">https://tracker.ceph.com/issues/23891</a></p>
    <p>From my point of this is a bug, probably others are experiencing
      also this problem and can provide additional details.</p>
    <p>I would like to map a rbd using rbd-nbd. Without adding the
      foreground flag it is not possible to map the device.<br>
      <br>
      The command listed beyond, are executed on a mon server (same
      thing happens on other servers)</p>
    <p>##################################################################################<br>
      ### Not working scenario: running rbd-nbd as background proccess<br>
      <br>
      Shell 1:<br>
      <br>
      # rmmod nbd<br>
      rmmod: ERROR: Module nbd is not currently loaded<br>
      # rbd-nbd map  --nbds_max 16
RBD_XenStorage-07449252-bf96-4daa-b0a6-687b7f1c369c/RBD-17efad10-6807-433f-879a-c59b511f895c<br>
      -&gt; it blocks probably forever<br>
      <br>
      Strace of the problem situation<br>
      <br>
      # strace -frvT -s128 -o /tmp/fail.strace rbd-nbd map  --nbds_max
      16
RBD_XenStorage-07449252-bf96-4daa-b0a6-687b7f1c369c/RBD-17efad10-6807-433f-879a-c59b511f895c<br>
      (see  <a class="moz-txt-link-freetext" href="https://tracker.ceph.com/issues/23891">https://tracker.ceph.com/issues/23891</a>)<br>
      <br>
      Shell 2:<br>
      <br>
      # rbd-nbd list-mapped<br>
      -&gt; no output<br>
      # lsmod |grep nbd<br>
      -&gt; no output<br>
    </p>
    <p>##################################################################################<br>
      ### Working scenario running rbd-nbd in foreground:<br>
      <br>
      Shell 1:<br>
      <br>
      # rbd-nbd map  -d --nbds_max 16
RBD_XenStorage-07449252-bf96-4daa-b0a6-687b7f1c369c/RBD-17efad10-6807-433f-879a-c59b511f895c<br>
      2018-04-26 23:22:19.681903 7fde4b442e80  0 ceph version 12.2.5
      (cad919881333ac92274171586c827e01f554a70a) luminous (stable),
      process (unknown), pid 326958<br>
      2018-04-26 23:22:19.681919 7fde4b442e80  0 pidfile_write: ignore
      empty --pid-file<br>
      /dev/nbd0<br>
      -&gt; Blocking, because its running as foreeground proccess<br>
      <br>
      Shell 2:<br>
      <br>
      # rbd-nbd list-mapped<br>
      pid    pool                                               
      image                                    snap device    <br>
      326958 RBD_XenStorage-07449252-bf96-4daa-b0a6-687b7f1c369c
      RBD-17efad10-6807-433f-879a-c59b511f895c -    /dev/nbd0 <br>
      # blockdev --getsize64 /dev/nbd0<br>
      21474836480<br>
      # blockdev --setra 1024 /dev/nbd0<br>
      # blockdev --getra  /dev/nbd0<br>
      1024<br>
      # rbd-nbd unmap /dev/nbd0<br>
      <br>
      Shell 1:<br>
      <br>
      -&gt; terminates in unmap<br>
      2018-04-26 23:24:55.660478 7fdded7ba700  0 rbd-nbd: disconnect
      request received<br>
      <br>
    </p>
    <p>###################################################################################<br>
      ### Our System:<br>
      <br>
    </p>
    <ul>
      <li>    Luminous/12.2.5</li>
      <li>    Ubuntu 16.04</li>
      <li>    5 OSD Nodes (24*8 TB HDD OSDs, 48*1TB SSD OSDS, Bluestore,
        6Gb Cache per OSD)</li>
      <li>    Size per OSD, 192GB RAM, 56 HT CPUs)</li>
      <li>    3 Mons (64 GB RAM, 200GB SSD, 4 visible CPUs)</li>
      <li>    2 * 10 GBIT, SFP+, bonded xmit_hash_policy layer3+4</li>
    </ul>
    <p><br>
      <br>
    </p>
  </body>
</html>

--------------325B9D6B70421A39277A931C--

--===============0388974721850279048==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0388974721850279048==--
