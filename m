From: Jan Schermer <jan@schermer.cz>
Subject: Re: [ceph-users] jemalloc and transparent hugepage
Date: Wed, 9 Sep 2015 11:54:00 +0200
Message-ID: <FB27F807-B398-4FA2-AD64-EB8FE7A66B47@schermer.cz>
References: <1694547545.35004320.1441741355122.JavaMail.zimbra@oxygem.tv> <1751466764.35298801.1441755238223.JavaMail.zimbra@oxygem.tv> <55EF740F.5090605@redhat.com> <502903422.35467518.1441764112283.JavaMail.zimbra@oxygem.tv> <alpine.DEB.2.00.1509081904060.24969@cobra.newdream.net> <2101903912.35682875.1441773442800.JavaMail.zimbra@oxygem.tv> <1072493400.35732686.1441775305490.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0 (Mac OS X Mail 9.0 \(3093\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:38386 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753167AbbIIJyD convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Sep 2015 05:54:03 -0400
Received: by wiclk2 with SMTP id lk2so15105893wic.1
        for <ceph-devel@vger.kernel.org>; Wed, 09 Sep 2015 02:54:01 -0700 (PDT)
In-Reply-To: <1072493400.35732686.1441775305490.JavaMail.zimbra@oxygem.tv>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

I looked at THP before. It comes enabled on RHEL6 and on our KVM hosts =
it merges a lot (~300GB hugepages on a 400GB KVM footprint).
I am probably going to disable it and see if it introduces any problems=
 for me - the most important gain here is better processor memory looku=
p table (cache) utilization where it considerably lowers the number of =
entries. Not sure how it affects different workloads - HPC guys should =
have a good idea? I can only evaluate the effect on OSDs and KVM, but t=
he problem is that going over the cache limit even by a tiny bit can ha=
ve huge impact - theoretically...

This issue sounds strange, though. THP should kick in and defrag/remerg=
e the pages that are part-empty. Maybe it's just not aggressive enough?
Does the "free" memory show as used (part of RSS of the process using t=
he page)? I guess not because there might be more processes with memory=
 in the same hugepage.

This might actually partially explain the pagecache problem I mentioned=
 there about a week ago (slow OSD startup), maybe kswapd is what has to=
 do the work and defrag the pages when memory pressure is high!

I'll try to test it somehow, hopefully then there will be cake.

Jan

> On 09 Sep 2015, at 07:08, Alexandre DERUMIER <aderumier@odiso.com> wr=
ote:
>=20
> They are a tracker here
>=20
> https://github.com/jemalloc/jemalloc/issues/243
> "Improve interaction with transparent huge pages"
>=20
>=20
>=20
> ----- Mail original -----
> De: "aderumier" <aderumier@odiso.com>
> =C3=80: "Sage Weil" <sweil@redhat.com>
> Cc: "ceph-devel" <ceph-devel@vger.kernel.org>, "ceph-users" <ceph-use=
rs@lists.ceph.com>
> Envoy=C3=A9: Mercredi 9 Septembre 2015 06:37:22
> Objet: Re: [ceph-users] jemalloc and transparent hugepage
>=20
>>> Is this something we can set with mallctl[1] at startup?=20
>=20
> I don't think it's possible.=20
>=20
> TP hugepage are managed by kernel, not jemalloc.=20
>=20
> (but a simple "echo never > /sys/kernel/mm/transparent_hugepage/enabl=
ed" in init script is enough)=20
>=20
> ----- Mail original -----=20
> De: "Sage Weil" <sweil@redhat.com>=20
> =C3=80: "aderumier" <aderumier@odiso.com>=20
> Cc: "Mark Nelson" <mnelson@redhat.com>, "ceph-devel" <ceph-devel@vger=
=2Ekernel.org>, "ceph-users" <ceph-users@lists.ceph.com>, "Somnath Roy"=
 <somnath.roy@sandisk.com>=20
> Envoy=C3=A9: Mercredi 9 Septembre 2015 04:07:59=20
> Objet: Re: [ceph-users] jemalloc and transparent hugepage=20
>=20
> On Wed, 9 Sep 2015, Alexandre DERUMIER wrote:=20
>>>> Have you noticed any performance difference with tp=3Dnever?=20
>>=20
>> No difference.=20
>>=20
>> I think hugepage could speedup big memory sets like 100-200GB, but f=
or=20
>> 1-2GB they are no noticable difference.=20
>=20
> Is this something we can set with mallctl[1] at startup?=20
>=20
> sage=20
>=20
> [1] http://www.canonware.com/download/jemalloc/jemalloc-latest/doc/je=
malloc.html=20
>=20
>>=20
>>=20
>>=20
>>=20
>>=20
>>=20
>> ----- Mail original -----=20
>> De: "Mark Nelson" <mnelson@redhat.com>=20
>> =C3=80: "aderumier" <aderumier@odiso.com>, "ceph-devel" <ceph-devel@=
vger.kernel.org>, "ceph-users" <ceph-users@lists.ceph.com>=20
>> Cc: "Somnath Roy" <somnath.roy@sandisk.com>=20
>> Envoy=C3=A9: Mercredi 9 Septembre 2015 01:49:35=20
>> Objet: Re: [ceph-users] jemalloc and transparent hugepage=20
>>=20
>> Excellent investigation Alexandre! Have you noticed any performance=20
>> difference with tp=3Dnever?=20
>>=20
>> Mark=20
>>=20
>> On 09/08/2015 06:33 PM, Alexandre DERUMIER wrote:=20
>>> I have done small benchmark with tcmalloc and jemalloc, transparent=
 hugepage=3Dalways|never.=20
>>>=20
>>> for tcmalloc, they are no difference.=20
>>> but for jemalloc, the difference is huge (around 25% lower with tp=3D=
never).=20
>>>=20
>>> jemmaloc 4.6.0+tp=3Dnever vs tcmalloc use 10% more RSS memory=20
>>>=20
>>> jemmaloc 4.0+tp=3Dnever almost use same RSS memory than tcmalloc !=20
>>>=20
>>>=20
>>> I don't have monitored memory usage in recovery, but I think it sho=
uld help too.=20
>>>=20
>>>=20
>>>=20
>>>=20
>>> tcmalloc 2.1 tp=3Dalways=20
>>> -------------------=20
>>> USER PID %CPU %MEM VSZ RSS TTY STAT START TIME COMMAND=20
>>>=20
>>> root 67746 120 1.0 1531220 671152 ? Ssl 01:18 0:43 /usr/bin/ceph-os=
d --cluster=3Dceph -i 0 -f=20
>>> root 67764 144 1.0 1570256 711232 ? Ssl 01:18 0:51 /usr/bin/ceph-os=
d --cluster=3Dceph -i 1 -f=20
>>>=20
>>> root 68363 220 0.9 1522292 655888 ? Ssl 01:19 0:46 /usr/bin/ceph-os=
d --cluster=3Dceph -i 0 -f=20
>>> root 68381 261 1.0 1563396 702500 ? Ssl 01:19 0:55 /usr/bin/ceph-os=
d --cluster=3Dceph -i 1 -f=20
>>>=20
>>> root 68963 228 1.0 1519240 666196 ? Ssl 01:20 0:31 /usr/bin/ceph-os=
d --cluster=3Dceph -i 0 -f=20
>>> root 68981 268 1.0 1564452 694352 ? Ssl 01:20 0:37 /usr/bin/ceph-os=
d --cluster=3Dceph -i 1 -f=20
>>>=20
>>>=20
>>>=20
>>> tcmalloc 2.1 tp=3Dnever=20
>>> -----------------=20
>>> USER PID %CPU %MEM VSZ RSS TTY STAT START TIME COMMAND=20
>>>=20
>>> root 69560 144 1.0 1544968 677584 ? Ssl 01:21 0:20 /usr/bin/ceph-os=
d --cluster=3Dceph -i 0 -f=20
>>> root 69578 167 1.0 1568620 704456 ? Ssl 01:21 0:23 /usr/bin/ceph-os=
d --cluster=3Dceph -i 1 -f=20
>>>=20
>>>=20
>>> root 70156 164 0.9 1519680 649776 ? Ssl 01:21 0:16 /usr/bin/ceph-os=
d --cluster=3Dceph -i 0 -f=20
>>> root 70174 214 1.0 1559772 692828 ? Ssl 01:21 0:19 /usr/bin/ceph-os=
d --cluster=3Dceph -i 1 -f=20
>>>=20
>>> root 70757 202 0.9 1520376 650572 ? Ssl 01:22 0:20 /usr/bin/ceph-os=
d --cluster=3Dceph -i 0 -f=20
>>> root 70775 236 1.0 1560644 694088 ? Ssl 01:22 0:23 /usr/bin/ceph-os=
d --cluster=3Dceph -i 1 -f=20
>>>=20
>>>=20
>>>=20
>>> jemalloc 3.6 tp =3D always=20
>>> ------------------------=20
>>> USER PID %CPU %MEM VSZ RSS TTY STAT START TIME COMMAND=20
>>>=20
>>> root 92005 46.1 1.4 2033864 967512 ? Ssl 01:00 0:04 /usr/bin/ceph-o=
sd --cluster=3Dceph -i 5 -f=20
>>> root 92027 45.5 1.4 2021624 963536 ? Ssl 01:00 0:04 /usr/bin/ceph-o=
sd --cluster=3Dceph -i 4 -f=20
>>>=20
>>>=20
>>>=20
>>> root 92703 191 1.5 2138724 1002376 ? Ssl 01:02 1:16 /usr/bin/ceph-o=
sd --cluster=3Dceph -i 5 -f=20
>>> root 92721 183 1.5 2126228 986448 ? Ssl 01:02 1:13 /usr/bin/ceph-os=
d --cluster=3Dceph -i 4 -f=20
>>>=20
>>>=20
>>> root 93366 258 1.4 2139052 984132 ? Ssl 01:03 1:09 /usr/bin/ceph-os=
d --cluster=3Dceph -i 5 -f=20
>>> root 93384 250 1.5 2126244 990348 ? Ssl 01:03 1:07 /usr/bin/ceph-os=
d --cluster=3Dceph -i 4 -f=20
>>>=20
>>>=20
>>>=20
>>> jemalloc 3.6 tp =3D never=20
>>> -----------------------=20
>>> USER PID %CPU %MEM VSZ RSS TTY STAT START TIME COMMAND=20
>>>=20
>>> root 93990 238 1.1 2105812 762628 ? Ssl 01:04 1:16 /usr/bin/ceph-os=
d --cluster=3Dceph -i 4 -f=20
>>> root 94033 263 1.1 2118288 781768 ? Ssl 01:04 1:18 /usr/bin/ceph-os=
d --cluster=3Dceph -i 5 -f=20
>>>=20
>>>=20
>>> root 94656 266 1.1 2139096 781392 ? Ssl 01:05 0:58 /usr/bin/ceph-os=
d --cluster=3Dceph -i 5 -f=20
>>> root 94674 257 1.1 2126316 760632 ? Ssl 01:05 0:56 /usr/bin/ceph-os=
d --cluster=3Dceph -i 4 -f=20
>>>=20
>>> root 95317 297 1.1 2135044 780532 ? Ssl 01:06 0:35 /usr/bin/ceph-os=
d --cluster=3Dceph -i 5 -f=20
>>> root 95335 284 1.1 2112016 760972 ? Ssl 01:06 0:34 /usr/bin/ceph-os=
d --cluster=3Dceph -i 4 -f=20
>>>=20
>>>=20
>>>=20
>>> jemalloc 4.0 tp =3D always=20
>>> ------------------------=20
>>> USER PID %CPU %MEM VSZ RSS TTY STAT START TIME COMMAND=20
>>>=20
>>> root 100275 198 1.3 1784520 880288 ? Ssl 01:14 0:45 /usr/bin/ceph-o=
sd --cluster=3Dceph -i 4 -f=20
>>> root 100320 239 1.1 1793184 760824 ? Ssl 01:14 0:47 /usr/bin/ceph-o=
sd --cluster=3Dceph -i 5 -f=20
>>>=20
>>>=20
>>> root 100897 200 1.3 1765780 891256 ? Ssl 01:15 0:50 /usr/bin/ceph-o=
sd --cluster=3Dceph -i 4 -f=20
>>> root 100942 245 1.1 1817436 746956 ? Ssl 01:15 0:53 /usr/bin/ceph-o=
sd --cluster=3Dceph -i 5 -f=20
>>>=20
>>> root 101517 196 1.3 1769904 877132 ? Ssl 01:16 0:33 /usr/bin/ceph-o=
sd --cluster=3Dceph -i 4 -f=20
>>> root 101562 258 1.1 1805172 746532 ? Ssl 01:16 0:36 /usr/bin/ceph-o=
sd --cluster=3Dceph -i 5 -f=20
>>>=20
>>>=20
>>> jemalloc 4.0 tp =3D never=20
>>> -----------------------=20
>>> USER PID %CPU %MEM VSZ RSS TTY STAT START TIME COMMAND=20
>>>=20
>>> root 98362 87.8 1.0 1841748 678848 ? Ssl 01:10 0:53 /usr/bin/ceph-o=
sd --cluster=3Dceph -i 4 -f=20
>>> root 98405 97.0 1.0 1846328 699620 ? Ssl 01:10 0:56 /usr/bin/ceph-o=
sd --cluster=3Dceph -i 5 -f=20
>>>=20
>>>=20
>>>=20
>>> root 99018 233 1.0 1812580 698848 ? Ssl 01:12 0:30 /usr/bin/ceph-os=
d --cluster=3Dceph -i 5 -f=20
>>> root 99036 226 1.0 1822344 677420 ? Ssl 01:12 0:29 /usr/bin/ceph-os=
d --cluster=3Dceph -i 4 -f=20
>>>=20
>>> root 99666 281 1.0 1814640 696420 ? Ssl 01:13 0:33 /usr/bin/ceph-os=
d --cluster=3Dceph -i 5 -f=20
>>> root 99684 266 1.0 1835676 676768 ? Ssl 01:13 0:32 /usr/bin/ceph-os=
d --cluster=3Dceph -i 4 -f=20
>>>=20
>>>=20
>>>=20
>>>=20
>>> ----- Mail original -----=20
>>> De: "aderumier" <aderumier@odiso.com>=20
>>> =C3=80: "ceph-devel" <ceph-devel@vger.kernel.org>, "ceph-users" <ce=
ph-users@lists.ceph.com>=20
>>> Envoy=C3=A9: Mardi 8 Septembre 2015 21:42:35=20
>>> Objet: [ceph-users] jemalloc and transparent hugepage=20
>>>=20
>>> Hi,=20
>>> I have found an interesting article about jemalloc and transparent =
hugepages=20
>>>=20
>>> https://www.digitalocean.com/company/blog/transparent-huge-pages-an=
d-alternative-memory-allocators/=20
>>>=20
>>>=20
>>> Could be great to see if disable transparent hugepage help to have =
lower jemalloc memory usage.=20
>>>=20
>>>=20
>>> Regards,=20
>>>=20
>>> Alexandre=20
>>>=20
>>> _______________________________________________=20
>>> ceph-users mailing list=20
>>> ceph-users@lists.ceph.com=20
>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com=20
>>> --=20
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in=20
>>> the body of a message to majordomo@vger.kernel.org=20
>>> More majordomo info at http://vger.kernel.org/majordomo-info.html=20
>>>=20
>> --=20
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in=20
>> the body of a message to majordomo@vger.kernel.org=20
>> More majordomo info at http://vger.kernel.org/majordomo-info.html=20
>>=20
>>=20
> _______________________________________________=20
> ceph-users mailing list=20
> ceph-users@lists.ceph.com=20
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com=20
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
