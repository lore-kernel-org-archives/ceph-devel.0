From: <Eric_YH_Chen@wiwynn.com>
Subject: RE: rbd map fail when the crushmap algorithm changed to tree
Date: Mon, 9 Jul 2012 02:01:04 +0000
Message-ID: <60E83269D669544E8069A09CB69135EA884B@GDC-CLDMBX-P02.whq.wistron>
References: <8512670932FB654F81AF0FEF1BE6D49D019C0EA7@WHQBEMAIL1.whq.wistron>
 <CAPYLRzhB0dmsgyKvwbkcK81+SRei6SCzik1gwRo1hNQJ=kbzSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from twnhumsw5.wistron.com ([220.128.89.25]:59910 "EHLO
	TWNHUMSW5.wistron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592Ab2GICBH convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 8 Jul 2012 22:01:07 -0400
In-Reply-To: <CAPYLRzhB0dmsgyKvwbkcK81+SRei6SCzik1gwRo1hNQJ=kbzSw@mail.gmail.com>
Content-Language: zh-TW
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: greg@inktank.com
Cc: ceph-devel@vger.kernel.org, Chris_YT_Huang@wiwynn.com, Victor_CY_Chang@wiwynn.com

Hi, Gregory:

OS: Ubuntu 12.04
kernel: 3.2.0-26
ceph: 0.48
filesystem : ext4

My step to assign new crush map
1. ceph osd getcrushmap -o curmap
2. crushtool -d curmap -o curmap.txt
3. modify the curmap.txt and rename to newmap.txt
4. service ceph -a stop  =3D> destruct the cluster
5. mkcephfs -a -c ceph.conf --crushmap newmap
6. service ceph -a start
7. rbd map <image_name>

I do not find any error log in dmesg or /var/log/ceph/osd.log. =20
It just hang at step 7.


-----Original Message-----
=46rom: Gregory Farnum [mailto:greg@inktank.com]=20
Sent: Saturday, July 07, 2012 12:59 AM
To: Eric YH Chen/WYHQ/Wiwynn
Cc: ceph-devel@vger.kernel.org; Chris YT Huang/WYHQ/Wiwynn; Victor CY C=
hang/WYHQ/Wiwynn
Subject: Re: rbd map fail when the crushmap algorithm changed to tree

On Fri, Jul 6, 2012 at 12:27 AM,  <Eric_YH_Chen@wiwynn.com> wrote:
> Hi all:
>
> Here is the original crushmap, I change the algorithm of host to "tre=
e"
> and
> set back to ceph cluster. However, when I try to map one imge to
> rados block device (RBD), it would hang and no response until I press
> ctrl-c.
> ( rbd map xxxx =A0=3D> then hang)
>
> Is there any wrong in the crushmap? Thanks for help.

Hmm, your crush map looks okay to me.

What are the versions of everything (cluster, rbd tool, kernel),
what's the exact command you run, and does it output anything? Is
there any information in dmesg?
-Greg


> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> # devices
> device 0 osd.0
> device 1 osd.1
> device 2 osd.2
> device 3 osd.3
> device 4 osd.4
> device 5 osd.5
> device 6 osd.6
> device 7 osd.7
> device 8 osd.8
> device 9 osd.9
> device 10 osd.10
> device 11 osd.11
>
> # types
> type 0 osd
> type 1 host
> type 2 rack
> type 3 row
> type 4 room
> type 5 datacenter
> type 6 pool
>
> # buckets
> host store-001 {
> =A0 =A0 =A0 =A0 id -2 =A0 =A0 =A0 =A0 =A0 # do not change unnecessari=
ly
> =A0 =A0 =A0 =A0 # weight 12.000
> =A0 =A0 =A0 =A0 alg straw
> =A0 =A0 =A0 =A0 hash 0 =A0# rjenkins1
> =A0 =A0 =A0 =A0 item osd.0 weight 1.000
> =A0 =A0 =A0 =A0 item osd.1 weight 1.000
> =A0 =A0 =A0 =A0 item osd.10 weight 1.000
> =A0 =A0 =A0 =A0 item osd.11 weight 1.000
> =A0 =A0 =A0 =A0 item osd.2 weight 1.000
> =A0 =A0 =A0 =A0 item osd.3 weight 1.000
> =A0 =A0 =A0 =A0 item osd.4 weight 1.000
> =A0 =A0 =A0 =A0 item osd.5 weight 1.000
> =A0 =A0 =A0 =A0 item osd.6 weight 1.000
> =A0 =A0 =A0 =A0 item osd.7 weight 1.000
> =A0 =A0 =A0 =A0 item osd.8 weight 1.000
> =A0 =A0 =A0 =A0 item osd.9 weight 1.000
> }
> rack unknownrack {
> =A0 =A0 =A0 =A0 id -3 =A0 =A0 =A0 =A0 =A0 # do not change unnecessari=
ly
> =A0 =A0 =A0 =A0 # weight 12.000
> =A0 =A0 =A0 =A0 alg straw
> =A0 =A0 =A0 =A0 hash 0 =A0# rjenkins1
> =A0 =A0 =A0 =A0 item store-001 weight 12.000
> }
> pool default {
> =A0 =A0 =A0 =A0 id -1 =A0 =A0 =A0 =A0 =A0 # do not change unnecessari=
ly
> =A0 =A0 =A0 =A0 # weight 12.000
> =A0 =A0 =A0 =A0 alg straw
> =A0 =A0 =A0 =A0 hash 0 =A0# rjenkins1
> =A0 =A0 =A0 =A0 item unknownrack weight 12.000
> }
>
> # rules
> rule data {
> =A0 =A0 =A0 =A0 ruleset 0
> =A0 =A0 =A0 =A0 type replicated
> =A0 =A0 =A0 =A0 min_size 1
> =A0 =A0 =A0 =A0 max_size 10
> =A0 =A0 =A0 =A0 step take default
> =A0 =A0 =A0 =A0 step choose firstn 0 type osd
> =A0 =A0 =A0 =A0 step emit
> }
> rule metadata {
> =A0 =A0 =A0 =A0 ruleset 1
> =A0 =A0 =A0 =A0 type replicated
> =A0 =A0 =A0 =A0 min_size 1
> =A0 =A0 =A0 =A0 max_size 10
> =A0 =A0 =A0 =A0 step take default
> =A0 =A0 =A0 =A0 step choose firstn 0 type osd
> =A0 =A0 =A0 =A0 step emit
> }
> rule rbd {
> =A0 =A0 =A0 =A0 ruleset 2
> =A0 =A0 =A0 =A0 type replicated
> =A0 =A0 =A0 =A0 min_size 1
> =A0 =A0 =A0 =A0 max_size 10
> =A0 =A0 =A0 =A0 step take default
> =A0 =A0 =A0 =A0 step choose firstn 0 type osd
> =A0 =A0 =A0 =A0 step emit
> }
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
