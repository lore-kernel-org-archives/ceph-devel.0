From: Mark Nelson <mnelson@redhat.com>
Subject: Re: [ceph-users] jemalloc and transparent hugepage
Date: Tue, 08 Sep 2015 18:49:35 -0500
Message-ID: <55EF740F.5090605@redhat.com>
References: <1694547545.35004320.1441741355122.JavaMail.zimbra@oxygem.tv> <1751466764.35298801.1441755238223.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58329 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751912AbbIHXtm (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 8 Sep 2015 19:49:42 -0400
In-Reply-To: <1751466764.35298801.1441755238223.JavaMail.zimbra@oxygem.tv>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>, ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@lists.ceph.com>
Cc: Somnath Roy <somnath.roy@sandisk.com>

Excellent investigation Alexandre!  Have you noticed any performance=20
difference with tp=3Dnever?

Mark

On 09/08/2015 06:33 PM, Alexandre DERUMIER wrote:
> I have done small benchmark with tcmalloc and jemalloc, transparent h=
ugepage=3Dalways|never.
>
> for tcmalloc, they are no difference.
> but for jemalloc, the difference is huge (around 25% lower with tp=3D=
never).
>
> jemmaloc 4.6.0+tp=3Dnever vs tcmalloc use 10% more RSS memory
>
> jemmaloc 4.0+tp=3Dnever almost use same RSS memory than tcmalloc !
>
>
> I don't have monitored memory usage in recovery, but I think it shoul=
d help too.
>
>
>
>
> tcmalloc 2.1 tp=3Dalways
> -------------------
> USER        PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COM=
MAND
>
> root      67746  120  1.0 1531220 671152 ?      Ssl  01:18   0:43 /us=
r/bin/ceph-osd --cluster=3Dceph -i 0 -f
> root      67764  144  1.0 1570256 711232 ?      Ssl  01:18   0:51 /us=
r/bin/ceph-osd --cluster=3Dceph -i 1 -f
>
> root      68363  220  0.9 1522292 655888 ?      Ssl  01:19   0:46 /us=
r/bin/ceph-osd --cluster=3Dceph -i 0 -f
> root      68381  261  1.0 1563396 702500 ?      Ssl  01:19   0:55 /us=
r/bin/ceph-osd --cluster=3Dceph -i 1 -f
>
> root      68963  228  1.0 1519240 666196 ?      Ssl  01:20   0:31 /us=
r/bin/ceph-osd --cluster=3Dceph -i 0 -f
> root      68981  268  1.0 1564452 694352 ?      Ssl  01:20   0:37 /us=
r/bin/ceph-osd --cluster=3Dceph -i 1 -f
>
>
>
> tcmalloc 2.1  tp=3Dnever
> -----------------
> USER        PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COM=
MAND
>
> root      69560  144  1.0 1544968 677584 ?      Ssl  01:21   0:20 /us=
r/bin/ceph-osd --cluster=3Dceph -i 0 -f
> root      69578  167  1.0 1568620 704456 ?      Ssl  01:21   0:23 /us=
r/bin/ceph-osd --cluster=3Dceph -i 1 -f
>
>
> root      70156  164  0.9 1519680 649776 ?      Ssl  01:21   0:16 /us=
r/bin/ceph-osd --cluster=3Dceph -i 0 -f
> root      70174  214  1.0 1559772 692828 ?      Ssl  01:21   0:19 /us=
r/bin/ceph-osd --cluster=3Dceph -i 1 -f
>
> root      70757  202  0.9 1520376 650572 ?      Ssl  01:22   0:20 /us=
r/bin/ceph-osd --cluster=3Dceph -i 0 -f
> root      70775  236  1.0 1560644 694088 ?      Ssl  01:22   0:23 /us=
r/bin/ceph-osd --cluster=3Dceph -i 1 -f
>
>
>
> jemalloc 3.6 tp =3D always
> ------------------------
> USER        PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COM=
MAND
>
> root      92005 46.1  1.4 2033864 967512 ?      Ssl  01:00   0:04 /us=
r/bin/ceph-osd --cluster=3Dceph -i 5 -f
> root      92027 45.5  1.4 2021624 963536 ?      Ssl  01:00   0:04 /us=
r/bin/ceph-osd --cluster=3Dceph -i 4 -f
>
>
>
> root      92703  191  1.5 2138724 1002376 ?     Ssl  01:02   1:16 /us=
r/bin/ceph-osd --cluster=3Dceph -i 5 -f
> root      92721  183  1.5 2126228 986448 ?      Ssl  01:02   1:13 /us=
r/bin/ceph-osd --cluster=3Dceph -i 4 -f
>
>
> root      93366  258  1.4 2139052 984132 ?      Ssl  01:03   1:09 /us=
r/bin/ceph-osd --cluster=3Dceph -i 5 -f
> root      93384  250  1.5 2126244 990348 ?      Ssl  01:03   1:07 /us=
r/bin/ceph-osd --cluster=3Dceph -i 4 -f
>
>
>
> jemalloc 3.6 tp =3D never
> -----------------------
> USER        PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COM=
MAND
>
> root      93990  238  1.1 2105812 762628 ?      Ssl  01:04   1:16 /us=
r/bin/ceph-osd --cluster=3Dceph -i 4 -f
> root      94033  263  1.1 2118288 781768 ?      Ssl  01:04   1:18 /us=
r/bin/ceph-osd --cluster=3Dceph -i 5 -f
>
>
> root      94656  266  1.1 2139096 781392 ?      Ssl  01:05   0:58 /us=
r/bin/ceph-osd --cluster=3Dceph -i 5 -f
> root      94674  257  1.1 2126316 760632 ?      Ssl  01:05   0:56 /us=
r/bin/ceph-osd --cluster=3Dceph -i 4 -f
>
> root      95317  297  1.1 2135044 780532 ?      Ssl  01:06   0:35 /us=
r/bin/ceph-osd --cluster=3Dceph -i 5 -f
> root      95335  284  1.1 2112016 760972 ?      Ssl  01:06   0:34 /us=
r/bin/ceph-osd --cluster=3Dceph -i 4 -f
>
>
>
> jemalloc 4.0 tp =3D always
> ------------------------
> USER        PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COM=
MAND
>
> root     100275  198  1.3 1784520 880288 ?      Ssl  01:14   0:45 /us=
r/bin/ceph-osd --cluster=3Dceph -i 4 -f
> root     100320  239  1.1 1793184 760824 ?      Ssl  01:14   0:47 /us=
r/bin/ceph-osd --cluster=3Dceph -i 5 -f
>
>
> root     100897  200  1.3 1765780 891256 ?      Ssl  01:15   0:50 /us=
r/bin/ceph-osd --cluster=3Dceph -i 4 -f
> root     100942  245  1.1 1817436 746956 ?      Ssl  01:15   0:53 /us=
r/bin/ceph-osd --cluster=3Dceph -i 5 -f
>
> root     101517  196  1.3 1769904 877132 ?      Ssl  01:16   0:33 /us=
r/bin/ceph-osd --cluster=3Dceph -i 4 -f
> root     101562  258  1.1 1805172 746532 ?      Ssl  01:16   0:36 /us=
r/bin/ceph-osd --cluster=3Dceph -i 5 -f
>
>
> jemalloc 4.0 tp =3D never
> -----------------------
> USER        PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COM=
MAND
>
> root      98362 87.8  1.0 1841748 678848 ?      Ssl  01:10   0:53 /us=
r/bin/ceph-osd --cluster=3Dceph -i 4 -f
> root      98405 97.0  1.0 1846328 699620 ?      Ssl  01:10   0:56 /us=
r/bin/ceph-osd --cluster=3Dceph -i 5 -f
>
>
>
> root      99018  233  1.0 1812580 698848 ?      Ssl  01:12   0:30 /us=
r/bin/ceph-osd --cluster=3Dceph -i 5 -f
> root      99036  226  1.0 1822344 677420 ?      Ssl  01:12   0:29 /us=
r/bin/ceph-osd --cluster=3Dceph -i 4 -f
>
> root      99666  281  1.0 1814640 696420 ?      Ssl  01:13   0:33 /us=
r/bin/ceph-osd --cluster=3Dceph -i 5 -f
> root      99684  266  1.0 1835676 676768 ?      Ssl  01:13   0:32 /us=
r/bin/ceph-osd --cluster=3Dceph -i 4 -f
>
>
>
>
> ----- Mail original -----
> De: "aderumier" <aderumier@odiso.com>
> =C3=80: "ceph-devel" <ceph-devel@vger.kernel.org>, "ceph-users" <ceph=
-users@lists.ceph.com>
> Envoy=C3=A9: Mardi 8 Septembre 2015 21:42:35
> Objet: [ceph-users] jemalloc and transparent hugepage
>
> Hi,
> I have found an interesting article about jemalloc and transparent hu=
gepages
>
> https://www.digitalocean.com/company/blog/transparent-huge-pages-and-=
alternative-memory-allocators/
>
>
> Could be great to see if disable transparent hugepage help to have lo=
wer jemalloc memory usage.
>
>
> Regards,
>
> Alexandre
>
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
