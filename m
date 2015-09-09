From: "HEWLETT, Paul (Paul)" <paul.hewlett-cfy2TCaE7SFv+uJa97DSA9BPR1lH4CV8@public.gmane.org>
Subject: Re: jemalloc and transparent hugepage
Date: Wed, 9 Sep 2015 10:37:29 +0000
Message-ID: <D215C8FB.6087%paul.hewlett@alcatel-lucent.com>
References: <1694547545.35004320.1441741355122.JavaMail.zimbra@oxygem.tv>
	<1751466764.35298801.1441755238223.JavaMail.zimbra@oxygem.tv>
	<55EF740F.5090605@redhat.com>
	<502903422.35467518.1441764112283.JavaMail.zimbra@oxygem.tv>
	<alpine.DEB.2.00.1509081904060.24969@cobra.newdream.net>
	<2101903912.35682875.1441773442800.JavaMail.zimbra@oxygem.tv>
	<1072493400.35732686.1441775305490.JavaMail.zimbra@oxygem.tv>
	<FB27F807-B398-4FA2-AD64-EB8FE7A66B47@schermer.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <FB27F807-B398-4FA2-AD64-EB8FE7A66B47-SB6/BxVxTjHtwjQa/ONI9g@public.gmane.org>
Content-Language: en-US
Content-ID: <55E5D23748A43441B05D767C2769A975-Lp/cVzEoVyYY7hVctCAC/EEOCMrvLtNR@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Jan Schermer <jan-SB6/BxVxTjHtwjQa/ONI9g@public.gmane.org>, Alexandre DERUMIER <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org>
Cc: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hi Jan

If I can suggest that you look at:

http://engineering.linkedin.com/performance/optimizing-linux-memory-managem
ent-low-latency-high-throughput-databases


where LinkedIn ended up disabling some of the new kernel features to
prevent memory thrashing.
Search for Transparent Huge Pages..

RHEL7 has these now disabled by default - LinkedIn are using GraphDB which
is a log-structured system.

Paul

On 09/09/2015 10:54, "ceph-devel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org on behalf of Jan
Schermer" <ceph-devel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org on behalf of jan-SB6/BxVxTjHtwjQa/ONI9g@public.gmane.org>
wrote:

>I looked at THP before. It comes enabled on RHEL6 and on our KVM hosts it
>merges a lot (~300GB hugepages on a 400GB KVM footprint).
>I am probably going to disable it and see if it introduces any problems
>for me - the most important gain here is better processor memory lookup
>table (cache) utilization where it considerably lowers the number of
>entries. Not sure how it affects different workloads - HPC guys should
>have a good idea? I can only evaluate the effect on OSDs and KVM, but the
>problem is that going over the cache limit even by a tiny bit can have
>huge impact - theoretically...
>
>This issue sounds strange, though. THP should kick in and defrag/remerge
>the pages that are part-empty. Maybe it's just not aggressive enough?
>Does the "free" memory show as used (part of RSS of the process using the
>page)? I guess not because there might be more processes with memory in
>the same hugepage.
>
>This might actually partially explain the pagecache problem I mentioned
>there about a week ago (slow OSD startup), maybe kswapd is what has to do
>the work and defrag the pages when memory pressure is high!
>
>I'll try to test it somehow, hopefully then there will be cake.
>
>Jan
>
>> On 09 Sep 2015, at 07:08, Alexandre DERUMIER <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org>
>>wrote:
>> =

>> They are a tracker here
>> =

>> https://github.com/jemalloc/jemalloc/issues/243
>> "Improve interaction with transparent huge pages"
>> =

>> =

>> =

>> ----- Mail original -----
>> De: "aderumier" <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org>
>> =C0: "Sage Weil" <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> Cc: "ceph-devel" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users"
>><ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
>> Envoy=E9: Mercredi 9 Septembre 2015 06:37:22
>> Objet: Re: [ceph-users] jemalloc and transparent hugepage
>> =

>>>> Is this something we can set with mallctl[1] at startup?
>> =

>> I don't think it's possible.
>> =

>> TP hugepage are managed by kernel, not jemalloc.
>> =

>> (but a simple "echo never >
>>/sys/kernel/mm/transparent_hugepage/enabled" in init script is enough)
>> =

>> ----- Mail original -----
>> De: "Sage Weil" <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> =C0: "aderumier" <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org>
>> Cc: "Mark Nelson" <mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "ceph-devel"
>><ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>,
>>"Somnath Roy" <somnath.roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>
>> Envoy=E9: Mercredi 9 Septembre 2015 04:07:59
>> Objet: Re: [ceph-users] jemalloc and transparent hugepage
>> =

>> On Wed, 9 Sep 2015, Alexandre DERUMIER wrote:
>>>>> Have you noticed any performance difference with tp=3Dnever?
>>> =

>>> No difference. =

>>> =

>>> I think hugepage could speedup big memory sets like 100-200GB, but for
>>> 1-2GB they are no noticable difference.
>> =

>> Is this something we can set with mallctl[1] at startup?
>> =

>> sage =

>> =

>> [1] =

>>http://www.canonware.com/download/jemalloc/jemalloc-latest/doc/jemalloc.h
>>tml =

>> =

>>> =

>>> =

>>> =

>>> =

>>> =

>>> =

>>> ----- Mail original -----
>>> De: "Mark Nelson" <mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>>> =C0: "aderumier" <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org>, "ceph-devel"
>>><ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
>>> Cc: "Somnath Roy" <somnath.roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>
>>> Envoy=E9: Mercredi 9 Septembre 2015 01:49:35
>>> Objet: Re: [ceph-users] jemalloc and transparent hugepage
>>> =

>>> Excellent investigation Alexandre! Have you noticed any performance
>>> difference with tp=3Dnever?
>>> =

>>> Mark =

>>> =

>>> On 09/08/2015 06:33 PM, Alexandre DERUMIER wrote:
>>>> I have done small benchmark with tcmalloc and jemalloc, transparent
>>>>hugepage=3Dalways|never.
>>>> =

>>>> for tcmalloc, they are no difference.
>>>> but for jemalloc, the difference is huge (around 25% lower with
>>>>tp=3Dnever). =

>>>> =

>>>> jemmaloc 4.6.0+tp=3Dnever vs tcmalloc use 10% more RSS memory
>>>> =

>>>> jemmaloc 4.0+tp=3Dnever almost use same RSS memory than tcmalloc !
>>>> =

>>>> =

>>>> I don't have monitored memory usage in recovery, but I think it
>>>>should help too.
>>>> =

>>>> =

>>>> =

>>>> =

>>>> tcmalloc 2.1 tp=3Dalways
>>>> -------------------
>>>> USER PID %CPU %MEM VSZ RSS TTY STAT START TIME COMMAND
>>>> =

>>>> root 67746 120 1.0 1531220 671152 ? Ssl 01:18 0:43 /usr/bin/ceph-osd
>>>>--cluster=3Dceph -i 0 -f
>>>> root 67764 144 1.0 1570256 711232 ? Ssl 01:18 0:51 /usr/bin/ceph-osd
>>>>--cluster=3Dceph -i 1 -f
>>>> =

>>>> root 68363 220 0.9 1522292 655888 ? Ssl 01:19 0:46 /usr/bin/ceph-osd
>>>>--cluster=3Dceph -i 0 -f
>>>> root 68381 261 1.0 1563396 702500 ? Ssl 01:19 0:55 /usr/bin/ceph-osd
>>>>--cluster=3Dceph -i 1 -f
>>>> =

>>>> root 68963 228 1.0 1519240 666196 ? Ssl 01:20 0:31 /usr/bin/ceph-osd
>>>>--cluster=3Dceph -i 0 -f
>>>> root 68981 268 1.0 1564452 694352 ? Ssl 01:20 0:37 /usr/bin/ceph-osd
>>>>--cluster=3Dceph -i 1 -f
>>>> =

>>>> =

>>>> =

>>>> tcmalloc 2.1 tp=3Dnever
>>>> -----------------
>>>> USER PID %CPU %MEM VSZ RSS TTY STAT START TIME COMMAND
>>>> =

>>>> root 69560 144 1.0 1544968 677584 ? Ssl 01:21 0:20 /usr/bin/ceph-osd
>>>>--cluster=3Dceph -i 0 -f
>>>> root 69578 167 1.0 1568620 704456 ? Ssl 01:21 0:23 /usr/bin/ceph-osd
>>>>--cluster=3Dceph -i 1 -f
>>>> =

>>>> =

>>>> root 70156 164 0.9 1519680 649776 ? Ssl 01:21 0:16 /usr/bin/ceph-osd
>>>>--cluster=3Dceph -i 0 -f
>>>> root 70174 214 1.0 1559772 692828 ? Ssl 01:21 0:19 /usr/bin/ceph-osd
>>>>--cluster=3Dceph -i 1 -f
>>>> =

>>>> root 70757 202 0.9 1520376 650572 ? Ssl 01:22 0:20 /usr/bin/ceph-osd
>>>>--cluster=3Dceph -i 0 -f
>>>> root 70775 236 1.0 1560644 694088 ? Ssl 01:22 0:23 /usr/bin/ceph-osd
>>>>--cluster=3Dceph -i 1 -f
>>>> =

>>>> =

>>>> =

>>>> jemalloc 3.6 tp =3D always
>>>> ------------------------
>>>> USER PID %CPU %MEM VSZ RSS TTY STAT START TIME COMMAND
>>>> =

>>>> root 92005 46.1 1.4 2033864 967512 ? Ssl 01:00 0:04 /usr/bin/ceph-osd
>>>>--cluster=3Dceph -i 5 -f
>>>> root 92027 45.5 1.4 2021624 963536 ? Ssl 01:00 0:04 /usr/bin/ceph-osd
>>>>--cluster=3Dceph -i 4 -f
>>>> =

>>>> =

>>>> =

>>>> root 92703 191 1.5 2138724 1002376 ? Ssl 01:02 1:16 /usr/bin/ceph-osd
>>>>--cluster=3Dceph -i 5 -f
>>>> root 92721 183 1.5 2126228 986448 ? Ssl 01:02 1:13 /usr/bin/ceph-osd
>>>>--cluster=3Dceph -i 4 -f
>>>> =

>>>> =

>>>> root 93366 258 1.4 2139052 984132 ? Ssl 01:03 1:09 /usr/bin/ceph-osd
>>>>--cluster=3Dceph -i 5 -f
>>>> root 93384 250 1.5 2126244 990348 ? Ssl 01:03 1:07 /usr/bin/ceph-osd
>>>>--cluster=3Dceph -i 4 -f
>>>> =

>>>> =

>>>> =

>>>> jemalloc 3.6 tp =3D never
>>>> -----------------------
>>>> USER PID %CPU %MEM VSZ RSS TTY STAT START TIME COMMAND
>>>> =

>>>> root 93990 238 1.1 2105812 762628 ? Ssl 01:04 1:16 /usr/bin/ceph-osd
>>>>--cluster=3Dceph -i 4 -f
>>>> root 94033 263 1.1 2118288 781768 ? Ssl 01:04 1:18 /usr/bin/ceph-osd
>>>>--cluster=3Dceph -i 5 -f
>>>> =

>>>> =

>>>> root 94656 266 1.1 2139096 781392 ? Ssl 01:05 0:58 /usr/bin/ceph-osd
>>>>--cluster=3Dceph -i 5 -f
>>>> root 94674 257 1.1 2126316 760632 ? Ssl 01:05 0:56 /usr/bin/ceph-osd
>>>>--cluster=3Dceph -i 4 -f
>>>> =

>>>> root 95317 297 1.1 2135044 780532 ? Ssl 01:06 0:35 /usr/bin/ceph-osd
>>>>--cluster=3Dceph -i 5 -f
>>>> root 95335 284 1.1 2112016 760972 ? Ssl 01:06 0:34 /usr/bin/ceph-osd
>>>>--cluster=3Dceph -i 4 -f
>>>> =

>>>> =

>>>> =

>>>> jemalloc 4.0 tp =3D always
>>>> ------------------------
>>>> USER PID %CPU %MEM VSZ RSS TTY STAT START TIME COMMAND
>>>> =

>>>> root 100275 198 1.3 1784520 880288 ? Ssl 01:14 0:45 /usr/bin/ceph-osd
>>>>--cluster=3Dceph -i 4 -f
>>>> root 100320 239 1.1 1793184 760824 ? Ssl 01:14 0:47 /usr/bin/ceph-osd
>>>>--cluster=3Dceph -i 5 -f
>>>> =

>>>> =

>>>> root 100897 200 1.3 1765780 891256 ? Ssl 01:15 0:50 /usr/bin/ceph-osd
>>>>--cluster=3Dceph -i 4 -f
>>>> root 100942 245 1.1 1817436 746956 ? Ssl 01:15 0:53 /usr/bin/ceph-osd
>>>>--cluster=3Dceph -i 5 -f
>>>> =

>>>> root 101517 196 1.3 1769904 877132 ? Ssl 01:16 0:33 /usr/bin/ceph-osd
>>>>--cluster=3Dceph -i 4 -f
>>>> root 101562 258 1.1 1805172 746532 ? Ssl 01:16 0:36 /usr/bin/ceph-osd
>>>>--cluster=3Dceph -i 5 -f
>>>> =

>>>> =

>>>> jemalloc 4.0 tp =3D never
>>>> -----------------------
>>>> USER PID %CPU %MEM VSZ RSS TTY STAT START TIME COMMAND
>>>> =

>>>> root 98362 87.8 1.0 1841748 678848 ? Ssl 01:10 0:53 /usr/bin/ceph-osd
>>>>--cluster=3Dceph -i 4 -f
>>>> root 98405 97.0 1.0 1846328 699620 ? Ssl 01:10 0:56 /usr/bin/ceph-osd
>>>>--cluster=3Dceph -i 5 -f
>>>> =

>>>> =

>>>> =

>>>> root 99018 233 1.0 1812580 698848 ? Ssl 01:12 0:30 /usr/bin/ceph-osd
>>>>--cluster=3Dceph -i 5 -f
>>>> root 99036 226 1.0 1822344 677420 ? Ssl 01:12 0:29 /usr/bin/ceph-osd
>>>>--cluster=3Dceph -i 4 -f
>>>> =

>>>> root 99666 281 1.0 1814640 696420 ? Ssl 01:13 0:33 /usr/bin/ceph-osd
>>>>--cluster=3Dceph -i 5 -f
>>>> root 99684 266 1.0 1835676 676768 ? Ssl 01:13 0:32 /usr/bin/ceph-osd
>>>>--cluster=3Dceph -i 4 -f
>>>> =

>>>> =

>>>> =

>>>> =

>>>> ----- Mail original -----
>>>> De: "aderumier" <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org>
>>>> =C0: "ceph-devel" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users"
>>>><ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
>>>> Envoy=E9: Mardi 8 Septembre 2015 21:42:35
>>>> Objet: [ceph-users] jemalloc and transparent hugepage
>>>> =

>>>> Hi, =

>>>> I have found an interesting article about jemalloc and transparent
>>>>hugepages =

>>>> =

>>>> =

>>>>https://www.digitalocean.com/company/blog/transparent-huge-pages-and-al
>>>>ternative-memory-allocators/
>>>> =

>>>> =

>>>> Could be great to see if disable transparent hugepage help to have
>>>>lower jemalloc memory usage.
>>>> =

>>>> =

>>>> Regards, =

>>>> =

>>>> Alexandre =

>>>> =

>>>> _______________________________________________
>>>> ceph-users mailing list
>>>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>>> -- =

>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>>>in =

>>>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>>> =

>>> -- =

>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>>in =

>>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>> =

>>> =

>> _______________________________________________
>> ceph-users mailing list
>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
>--
>To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
