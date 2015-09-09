From: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: jemalloc and transparent hugepage
Date: Tue, 8 Sep 2015 19:07:59 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1509081904060.24969@cobra.newdream.net>
References: <1694547545.35004320.1441741355122.JavaMail.zimbra@oxygem.tv>
	<1751466764.35298801.1441755238223.JavaMail.zimbra@oxygem.tv>
	<55EF740F.5090605@redhat.com>
	<502903422.35467518.1441764112283.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="557981400-1585410181-1441764481=:24969"
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <502903422.35467518.1441764112283.JavaMail.zimbra-M8QNeUgB6UTyG1zEObXtfA@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Alexandre DERUMIER <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1585410181-1441764481=:24969
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, 9 Sep 2015, Alexandre DERUMIER wrote:
> >>Have you noticed any performance difference with tp=3Dnever?
>=20
> No difference.
>=20
> I think hugepage could speedup big memory sets like 100-200GB, but for=20
> 1-2GB they are no noticable difference.

Is this something we can set with mallctl[1] at startup?

sage

[1] http://www.canonware.com/download/jemalloc/jemalloc-latest/doc/jemall=
oc.html

>=20
>=20
>=20
>=20
>=20
>=20
> ----- Mail original -----
> De: "Mark Nelson" <mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> =C3=80: "aderumier" <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org>, "ceph-devel" <ceph-devel@vge=
r.kernel.org>, "ceph-users" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
> Cc: "Somnath Roy" <somnath.roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>
> Envoy=C3=A9: Mercredi 9 Septembre 2015 01:49:35
> Objet: Re: [ceph-users] jemalloc and transparent hugepage
>=20
> Excellent investigation Alexandre! Have you noticed any performance=20
> difference with tp=3Dnever?=20
>=20
> Mark=20
>=20
> On 09/08/2015 06:33 PM, Alexandre DERUMIER wrote:=20
> > I have done small benchmark with tcmalloc and jemalloc, transparent h=
ugepage=3Dalways|never.=20
> >=20
> > for tcmalloc, they are no difference.=20
> > but for jemalloc, the difference is huge (around 25% lower with tp=3D=
never).=20
> >=20
> > jemmaloc 4.6.0+tp=3Dnever vs tcmalloc use 10% more RSS memory=20
> >=20
> > jemmaloc 4.0+tp=3Dnever almost use same RSS memory than tcmalloc !=20
> >=20
> >=20
> > I don't have monitored memory usage in recovery, but I think it shoul=
d help too.=20
> >=20
> >=20
> >=20
> >=20
> > tcmalloc 2.1 tp=3Dalways=20
> > -------------------=20
> > USER PID %CPU %MEM VSZ RSS TTY STAT START TIME COMMAND=20
> >=20
> > root 67746 120 1.0 1531220 671152 ? Ssl 01:18 0:43 /usr/bin/ceph-osd =
--cluster=3Dceph -i 0 -f=20
> > root 67764 144 1.0 1570256 711232 ? Ssl 01:18 0:51 /usr/bin/ceph-osd =
--cluster=3Dceph -i 1 -f=20
> >=20
> > root 68363 220 0.9 1522292 655888 ? Ssl 01:19 0:46 /usr/bin/ceph-osd =
--cluster=3Dceph -i 0 -f=20
> > root 68381 261 1.0 1563396 702500 ? Ssl 01:19 0:55 /usr/bin/ceph-osd =
--cluster=3Dceph -i 1 -f=20
> >=20
> > root 68963 228 1.0 1519240 666196 ? Ssl 01:20 0:31 /usr/bin/ceph-osd =
--cluster=3Dceph -i 0 -f=20
> > root 68981 268 1.0 1564452 694352 ? Ssl 01:20 0:37 /usr/bin/ceph-osd =
--cluster=3Dceph -i 1 -f=20
> >=20
> >=20
> >=20
> > tcmalloc 2.1 tp=3Dnever=20
> > -----------------=20
> > USER PID %CPU %MEM VSZ RSS TTY STAT START TIME COMMAND=20
> >=20
> > root 69560 144 1.0 1544968 677584 ? Ssl 01:21 0:20 /usr/bin/ceph-osd =
--cluster=3Dceph -i 0 -f=20
> > root 69578 167 1.0 1568620 704456 ? Ssl 01:21 0:23 /usr/bin/ceph-osd =
--cluster=3Dceph -i 1 -f=20
> >=20
> >=20
> > root 70156 164 0.9 1519680 649776 ? Ssl 01:21 0:16 /usr/bin/ceph-osd =
--cluster=3Dceph -i 0 -f=20
> > root 70174 214 1.0 1559772 692828 ? Ssl 01:21 0:19 /usr/bin/ceph-osd =
--cluster=3Dceph -i 1 -f=20
> >=20
> > root 70757 202 0.9 1520376 650572 ? Ssl 01:22 0:20 /usr/bin/ceph-osd =
--cluster=3Dceph -i 0 -f=20
> > root 70775 236 1.0 1560644 694088 ? Ssl 01:22 0:23 /usr/bin/ceph-osd =
--cluster=3Dceph -i 1 -f=20
> >=20
> >=20
> >=20
> > jemalloc 3.6 tp =3D always=20
> > ------------------------=20
> > USER PID %CPU %MEM VSZ RSS TTY STAT START TIME COMMAND=20
> >=20
> > root 92005 46.1 1.4 2033864 967512 ? Ssl 01:00 0:04 /usr/bin/ceph-osd=
 --cluster=3Dceph -i 5 -f=20
> > root 92027 45.5 1.4 2021624 963536 ? Ssl 01:00 0:04 /usr/bin/ceph-osd=
 --cluster=3Dceph -i 4 -f=20
> >=20
> >=20
> >=20
> > root 92703 191 1.5 2138724 1002376 ? Ssl 01:02 1:16 /usr/bin/ceph-osd=
 --cluster=3Dceph -i 5 -f=20
> > root 92721 183 1.5 2126228 986448 ? Ssl 01:02 1:13 /usr/bin/ceph-osd =
--cluster=3Dceph -i 4 -f=20
> >=20
> >=20
> > root 93366 258 1.4 2139052 984132 ? Ssl 01:03 1:09 /usr/bin/ceph-osd =
--cluster=3Dceph -i 5 -f=20
> > root 93384 250 1.5 2126244 990348 ? Ssl 01:03 1:07 /usr/bin/ceph-osd =
--cluster=3Dceph -i 4 -f=20
> >=20
> >=20
> >=20
> > jemalloc 3.6 tp =3D never=20
> > -----------------------=20
> > USER PID %CPU %MEM VSZ RSS TTY STAT START TIME COMMAND=20
> >=20
> > root 93990 238 1.1 2105812 762628 ? Ssl 01:04 1:16 /usr/bin/ceph-osd =
--cluster=3Dceph -i 4 -f=20
> > root 94033 263 1.1 2118288 781768 ? Ssl 01:04 1:18 /usr/bin/ceph-osd =
--cluster=3Dceph -i 5 -f=20
> >=20
> >=20
> > root 94656 266 1.1 2139096 781392 ? Ssl 01:05 0:58 /usr/bin/ceph-osd =
--cluster=3Dceph -i 5 -f=20
> > root 94674 257 1.1 2126316 760632 ? Ssl 01:05 0:56 /usr/bin/ceph-osd =
--cluster=3Dceph -i 4 -f=20
> >=20
> > root 95317 297 1.1 2135044 780532 ? Ssl 01:06 0:35 /usr/bin/ceph-osd =
--cluster=3Dceph -i 5 -f=20
> > root 95335 284 1.1 2112016 760972 ? Ssl 01:06 0:34 /usr/bin/ceph-osd =
--cluster=3Dceph -i 4 -f=20
> >=20
> >=20
> >=20
> > jemalloc 4.0 tp =3D always=20
> > ------------------------=20
> > USER PID %CPU %MEM VSZ RSS TTY STAT START TIME COMMAND=20
> >=20
> > root 100275 198 1.3 1784520 880288 ? Ssl 01:14 0:45 /usr/bin/ceph-osd=
 --cluster=3Dceph -i 4 -f=20
> > root 100320 239 1.1 1793184 760824 ? Ssl 01:14 0:47 /usr/bin/ceph-osd=
 --cluster=3Dceph -i 5 -f=20
> >=20
> >=20
> > root 100897 200 1.3 1765780 891256 ? Ssl 01:15 0:50 /usr/bin/ceph-osd=
 --cluster=3Dceph -i 4 -f=20
> > root 100942 245 1.1 1817436 746956 ? Ssl 01:15 0:53 /usr/bin/ceph-osd=
 --cluster=3Dceph -i 5 -f=20
> >=20
> > root 101517 196 1.3 1769904 877132 ? Ssl 01:16 0:33 /usr/bin/ceph-osd=
 --cluster=3Dceph -i 4 -f=20
> > root 101562 258 1.1 1805172 746532 ? Ssl 01:16 0:36 /usr/bin/ceph-osd=
 --cluster=3Dceph -i 5 -f=20
> >=20
> >=20
> > jemalloc 4.0 tp =3D never=20
> > -----------------------=20
> > USER PID %CPU %MEM VSZ RSS TTY STAT START TIME COMMAND=20
> >=20
> > root 98362 87.8 1.0 1841748 678848 ? Ssl 01:10 0:53 /usr/bin/ceph-osd=
 --cluster=3Dceph -i 4 -f=20
> > root 98405 97.0 1.0 1846328 699620 ? Ssl 01:10 0:56 /usr/bin/ceph-osd=
 --cluster=3Dceph -i 5 -f=20
> >=20
> >=20
> >=20
> > root 99018 233 1.0 1812580 698848 ? Ssl 01:12 0:30 /usr/bin/ceph-osd =
--cluster=3Dceph -i 5 -f=20
> > root 99036 226 1.0 1822344 677420 ? Ssl 01:12 0:29 /usr/bin/ceph-osd =
--cluster=3Dceph -i 4 -f=20
> >=20
> > root 99666 281 1.0 1814640 696420 ? Ssl 01:13 0:33 /usr/bin/ceph-osd =
--cluster=3Dceph -i 5 -f=20
> > root 99684 266 1.0 1835676 676768 ? Ssl 01:13 0:32 /usr/bin/ceph-osd =
--cluster=3Dceph -i 4 -f=20
> >=20
> >=20
> >=20
> >=20
> > ----- Mail original -----=20
> > De: "aderumier" <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org>=20
> > =C3=80: "ceph-devel" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users" <ceph=
-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>=20
> > Envoy=C3=A9: Mardi 8 Septembre 2015 21:42:35=20
> > Objet: [ceph-users] jemalloc and transparent hugepage=20
> >=20
> > Hi,=20
> > I have found an interesting article about jemalloc and transparent hu=
gepages=20
> >=20
> > https://www.digitalocean.com/company/blog/transparent-huge-pages-and-=
alternative-memory-allocators/=20
> >=20
> >=20
> > Could be great to see if disable transparent hugepage help to have lo=
wer jemalloc memory usage.=20
> >=20
> >=20
> > Regards,=20
> >=20
> > Alexandre=20
> >=20
> > _______________________________________________=20
> > ceph-users mailing list=20
> > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org=20
> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com=20
> > --=20
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in=20
> > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org=20
> > More majordomo info at http://vger.kernel.org/majordomo-info.html=20
> >=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-1585410181-1441764481=:24969
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--557981400-1585410181-1441764481=:24969--
