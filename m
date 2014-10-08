From: Abhishek L <abhishek.lekshmanan@gmail.com>
Subject: v0.86 Contributor Credits
Date: Wed, 08 Oct 2014 13:26:17 +0530
Message-ID: <877g0buh9a.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:60847 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753396AbaJHH6n (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Oct 2014 03:58:43 -0400
Received: by mail-pa0-f47.google.com with SMTP id rd3so8582735pab.6
        for <ceph-devel@vger.kernel.org>; Wed, 08 Oct 2014 00:58:42 -0700 (PDT)
Received: from trusty ([49.32.0.227])
        by mx.google.com with ESMTPSA id cw5sm17889449pbc.9.2014.10.08.00.58.40
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 08 Oct 2014 00:58:41 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

--=-=-=
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

Here is a sorted list of authors and organizations who contributed to
v0.86, by number of commits or reviews back to v0.85. The affiliation of
authors to organizations can be updated by submitting a patch to
https://github.com/ceph/ceph/blob/master/.organizationmap

All commits are reviewed but the number of reviews is a fraction of the
number of commits. More often than not, the reviewer(s) is only
mentioned in the message of the merge although it means that all
associated commits have been reviewed. If you are curious about how it
is done, do checkout the wiki entry at https://wiki.ceph.com/Community/Ceph=
_contributors_list_maintenance_guide

Commits by authors
     1	    146 Sage Weil <sweil@redhat.com>
     2	    139 Adam Crume <adamcrume@gmail.com>
     3	     99 John Spray <jspray@redhat.com>
     4	     87 Loic Dachary <loic@dachary.org>
     5	     39 David Zafman <dzafman@redhat.com>
     6	     33 Yehuda Sadeh <ysadehwe@redhat.com>
     7	     29 Danny Al-Gaaf <danny.al-gaaf@bisect.de>
     8	     24 Jo=E3o Eduardo Lu=EDs <joao.luis@inktank.com>
     9	     23 John Wilkins <jwilkins@redhat.com>
    10	     20 Samuel Just <sam.just@inktank.com>
    11	     13 Jo=E3o Eduardo Lu=EDs <joao@redhat.com>
    12	     11 Noah Watkins <noah.watkins@inktank.com>
    13	     10 Ma Jianpeng <jianpeng.ma@intel.com>
    14	      8 Yan, Zheng <zyan@redhat.com>
    15	      7 Swami Reddy <swami.reddy@ril.com>
    16	      7 Abhishek Lekshmanan <abhishek.lekshmanan@ril.com>
    17	      6 Zhiqiang Wang <wonzhq@hotmail.com>
    18	      6 Somnath Roy <somnath.roy@sandisk.com>
    19	      6 Dan Mick <dan.mick@inktank.com>
    20	      5 Guang Yang <yguang@yahoo-inc.com>
    21	      5 Greg Farnum <greg@inktank.com>
    22	      4 Xiaoxi Chen <xiaoxi.chen@intel.com>
    23	      4 Luis Pab=F3n <lpabon@redhat.com>
    24	      4 Jason Dillaman <dillaman@redhat.com>
    25	      4 Erik Logtenberg <erik@logtenberg.eu>
    26	      3 Wido den Hollander <wido@42on.com>
    27	      3 Haomai Wang <haomaiwang@gmail.com>
    28	      3 Alfredo Deza <alfredo.deza@inktank.com>
    29	      2 Stephen Jahl <stephenjahl@gmail.com>
    30	      2 Shu, Xinxin <xinxin.shu@intel.com>
    31	      2 Sandon Van Ness <sandon@inktank.com>
    32	      2 Pavan Rallabhandi <pavan.rallabhandi@sandisk.com>
    33	      2 Johnu George <johnugeo@cisco.com>
    34	      2 Huamin Chen <hchen@redhat.com>
    35	      2 Fran=E7ois Lafont <flafdivers@free.fr>
    36	      2 Dan van der Ster <daniel.vanderster@cern.ch>
    37	      2 Andreas Peters <andreas.joachim.peters@cern.ch>
    38	      1 Yongyue Sun <abioy.sun@gmail.com>
    39	      1 Thorsten Glaser <tg@mirbsd.de>
    40	      1 Sebastien Han <sebastien.han@enovance.com>
    41	      1 Roman Haritonov <reclosedev@gmail.com>
    42	      1 Ray Lv <xiangyulv@gmail.com>
    43	      1 Mohammad Salehe <salehe+dev@gmail.com>
    44	      1 Marco Garc=EAs <marco.garces@bci.co.mz>
    45	      1 JuanJose 'JJ' Galvez <jgalvez@redhat.com>
    46	      1 Jiang Heng <jiangheng0511@gmail.com>
    47	      1 Jenkins <jenkins@inktank.com>
    48	      1 Gerben Meijer <gerben@daybyday.nl>
    49	      1 Dmitry Smirnov <onlyjob@member.fsf.org>
    50	      1 David Moreau Simard <dmsimard@iweb.com>
    51	      1 Ashish Chandra <ashish.a.chandra@ril.com>
    52	      1 Andreas Peters <Andreas.Joachim.Peters@cern.ch>
    53	      1 Alexandre Oliva <oliva@gnu.org>
    54	      1 Alexandre Marangone <alexandre.marangone@inktank.com>
Commits by organizations
     1	    363 Red Hat <contact@redhat.com>
     2	    157 Inktank <contact@inktank.com>
     3	    139 University of California, Santa Cruz <contact@cs.ucsc.edu>
     4	     29 Intel <contact@intel.com>
     5	     29 Deutsche Telekom <contact@telekom.de>
     6	     15 Reliance Jio Infocomm Ltd. <contact@ril.com>
     7	      9 Unaffiliated <no@organization.net>
     8	      8 SanDisk <contact@sandisk.com>
     9	      6 Yahoo! <contact@yahoo-inc.com>
    10	      5 Cloudwatt <libre.licensing@cloudwatt.com>
    11	      5 CERN <contact@cern.ch>
    12	      3 Wido 42on <contact@42on.com>
    13	      3 UnitedStack <contact@unitedstack.com>
    14	      2 MIT Computer Science and Artificial Intelligence Laboratory =
<webmaster@csail.mit.edu>
    15	      2 Debian GNU/Linux <contact@debian.org>
    16	      2 CISCO <contact@cisco.com>
    17	      1 IWeb <contact@iweb.com>
    18	      1 GNU <contact@gnu.org>
    19	      1 eNovance <contact@enovance.com>
    20	      1 Day By Day <contact@daybyday.nl>
    21	      1 BCI <contact@bci.co.mz>
    22	      1 Bayan <contact@bayan.co.ir>
Reviews by authors (one review spans multiple commits)
     1	     77 Sage Weil <sweil@redhat.com>
     2	     25 Loic Dachary <loic@dachary.org>
     3	     18 Greg Farnum <greg@inktank.com>
     4	     17 Samuel Just <sam.just@inktank.com>
     5	     13 John Spray <jspray@redhat.com>
     6	      7 Josh Durgin <josh.durgin@inktank.com>
     7	      5 Yehuda Sadeh <ysadehwe@redhat.com>
     8	      3 John Wilkins <jwilkins@redhat.com>
     9	      3 Jo=E3o Eduardo Lu=EDs <joao.luis@inktank.com>
    10	      2 Yan, Zheng <zyan@redhat.com>
    11	      2 Pavan Rallabhandi <pavan.rallabhandi@sandisk.com>
    12	      2 Jo=E3o Eduardo Lu=EDs <joao@redhat.com>
    13	      2 Janne Grunau <j@jannau.net>
    14	      2 David Zafman <dzafman@redhat.com>
    15	      1 Xiaoxi Chen <xiaoxi.chen@intel.com>
    16	      1 Volker Voigt <volker.voigt@1und1.de>
    17	      1 Swami Reddy <swami.reddy@ril.com>
    18	      1 Noah Watkins <noah.watkins@inktank.com>
    19	      1 Marco Garc=EAs <marco.garces@bci.co.mz>
    20	      1 Johnu George <johnugeo@cisco.com>
    21	      1 Huamin Chen <hchen@redhat.com>
    22	      1 Guang Yang <yguang@yahoo-inc.com>
    23	      1 Federico Simoncelli <fsimonce@redhat.com>
    24	      1 Erik Logtenberg <erik@logtenberg.eu>
    25	      1 Danny Al-Gaaf <danny.al-gaaf@bisect.de>
    26	      1 Dan Mick <dan.mick@inktank.com>
    27	      1 Daniel Schepler <dschepler@gmail.com>
    28	      1 Cheng Cheng <ccheng.leo@gmail.com>
    29	      1 Boris Ranto <branto@redhat.com>
    30	      1 Andreas Peters <andreas.joachim.peters@cern.ch>
    31	      1 Abhishek Lekshmanan <abhishek.lekshmanan@ril.com>
Reviews by organizations (one review spans multiple commits)
     1	    123 Red Hat <contact@redhat.com>
     2	     49 Inktank <contact@inktank.com>
     3	      6 Unaffiliated <no@organization.net>
     4	      5 Cloudwatt <libre.licensing@cloudwatt.com>
     5	      3 Intel <contact@intel.com>
     6	      2 SanDisk <contact@sandisk.com>
     7	      2 Reliance Jio Infocomm Ltd. <contact@ril.com>
     8	      1 Yahoo! <contact@yahoo-inc.com>
     9	      1 Deutsche Telekom <contact@telekom.de>
    10	      1 CISCO <contact@cisco.com>
    11	      1 CERN <contact@cern.ch>
    12	      1 BCI <contact@bci.co.mz>

Cheers
=2D-=20
Abhishek

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"; description="Digital signature"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJUNO4hAAoJEPnwZB8bZe1fvZwH/133S4kKhmQeLXssw0zQ+8mT
rL/L+q/9LBhZhLq8REmsmpx3S4rh+ELgkxgCW03JmQmiAQdQfY9u1BnmzruEX+u9
jPethsJrt2D8Kn424+mM/96kyZzEvSRmHxIitAgMd09JqxxWJUviYqzGqTX2/Vx5
k4uycM5ZA7JvXv+cpWrE+HamDvr7VadWvJezLpWwTg/ke2LOHm7NU22y+uQhcR3U
znUInr46qBR/6jzdGJ5Y6CDrdUlfsnxlCl7G1zJKnIdoKq5CR8AjnTxjfC5RRU9v
Q/Hk8ZUyV2kgQpstXciJJnETyIbp7vuRo/tEzqCjXr2DpzZryLErlR31tFftARw=
=PFv/
-----END PGP SIGNATURE-----
--=-=-=--
