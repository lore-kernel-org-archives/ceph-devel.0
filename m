From: =?UTF-8?Q?Marc_Sch=c3=b6chlin?= <ms-aJA5TdoZkU0dnm+yROfE0A@public.gmane.org>
Subject: RBD Cache and rbd-nbd
Date: Thu, 10 May 2018 21:03:51 +0200
Message-ID: <f57c4834-517e-0c0e-7496-831689327bac@256bit.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2211919861881359176=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

This is a multi-part message in MIME format.
--===============2211919861881359176==
Content-Type: multipart/alternative;
 boundary="------------1C02E0B83B69AA33442355A9"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------1C02E0B83B69AA33442355A9
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello list,

i map ~30 rbds=C2=A0 per xenserver
<https://github.com/vico-research-and-consulting/RBDSR> host by using
rbd-nbd to run virtual machines on these devices.

I have the following questions:

  * Is it possible to use rbd cache for rbd-nbd? I assume that this is
    true, but=C2=A0 the documentation does not make a clear statement abo=
ut this.
    (http://docs.ceph.com/docs/luminous/rbd/rbd-config-ref/(
  * If i configure caches like described at
    http://docs.ceph.com/docs/luminous/rbd/rbd-config-ref/, are there
    dedicated caches per rbd-nbd/krbd device or is there a only a single
    cache area.
    How can i identify the rbd cache with the tools provided by the
    operating system?
  * Can you provide some hints how to about adequate cache settings for
    a write intensive environment (70% write, 30% read)?
    Is it a good idea to specify a huge rbd cache of 1 GB with a max
    dirty age of 10 seconds?

Regards
Marc

Our system:

  * Luminous/12.2.5
  * Ubuntu 16.04
  * 5 OSD Nodes (24*8 TB HDD OSDs, 48*1TB SSD OSDS, Bluestore, 6Gb Cache
    per OSD)
  * Size per OSD, 192GB RAM, 56 HT CPUs)
  * 3 Mons (64 GB RAM, 200GB SSD, 4 visible CPUs)
  * 2 * 10 GBIT, SFP+, bonded xmit_hash_policy layer3+4


--------------1C02E0B83B69AA33442355A9
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>Hello list,</p>
    <p>i map ~30 rbds  per <a moz-do-not-send="true"
        href="https://github.com/vico-research-and-consulting/RBDSR">xenserver</a>
      host by using rbd-nbd to run virtual machines on these devices.<br>
    </p>
    <p>I have the following questions:</p>
    <ul>
      <li>Is it possible to use rbd cache for rbd-nbd? I assume that
        this is true, but  the documentation does not make a clear
        statement about this.<br>
        (<a class="moz-txt-link-freetext" href="http://docs.ceph.com/docs/luminous/rbd/rbd-config-ref/(">http://docs.ceph.com/docs/luminous/rbd/rbd-config-ref/(</a></li>
      <li>If i configure caches like described at
        <a class="moz-txt-link-freetext" href="http://docs.ceph.com/docs/luminous/rbd/rbd-config-ref/">http://docs.ceph.com/docs/luminous/rbd/rbd-config-ref/</a>, are
        there dedicated caches per rbd-nbd/krbd device or is there a
        only a single cache area.<br>
        How can i identify the rbd cache with the tools provided by the
        operating system?</li>
      <li>Can you provide some hints how to about adequate cache
        settings for a write intensive environment (70% write, 30%
        read)?<br>
        Is it a good idea to specify a huge rbd cache of 1 GB with a max
        dirty age of 10 seconds?<br>
      </li>
    </ul>
    <p>Regards<br>
      Marc</p>
    <p>Our system:<br>
    </p>
    <ul>
      <li>Luminous/12.2.5</li>
      <li>Ubuntu 16.04</li>
      <li>5 OSD Nodes (24*8 TB HDD OSDs, 48*1TB SSD OSDS, Bluestore, 6Gb
        Cache per OSD)</li>
      <li>Size per OSD, 192GB RAM, 56 HT CPUs)</li>
      <li>3 Mons (64 GB RAM, 200GB SSD, 4 visible CPUs)</li>
      <li>2 * 10 GBIT, SFP+, bonded xmit_hash_policy layer3+4</li>
    </ul>
  </body>
</html>

--------------1C02E0B83B69AA33442355A9--

--===============2211919861881359176==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============2211919861881359176==--
