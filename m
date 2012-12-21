From: Michael Chapman <michael.chapman@anu.edu.au>
Subject: Re: mon not marking dead osds down and slow streaming write performance
Date: Fri, 21 Dec 2012 11:24:33 +1100
Message-ID: <CABf87XmB9qgusXdSgfPD9qnDtMuCyFtWk_tyX8h8=fSZGs6=Ag@mail.gmail.com>
References: <CABf87Xk54Q-SP2258MsXDVKAo2TgjOw8xds2f9W=XxmgdSRFTA@mail.gmail.com>
	<alpine.DEB.2.00.1212201046050.16508@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169]:65287 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751274Ab2LUAYe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Dec 2012 19:24:34 -0500
Received: by mail-qc0-f169.google.com with SMTP id t2so2250175qcq.14
        for <ceph-devel@vger.kernel.org>; Thu, 20 Dec 2012 16:24:33 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1212201046050.16508@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Fri, Dec 21, 2012 at 5:47 AM, Sage Weil <sage@inktank.com> wrote:
> On Wed, 19 Dec 2012, Michael Chapman wrote:
>> Hi all,
>>
>> I apologise if this list is only for dev issues and not for operators,
>> I didn't see a more general list on the ceph website.
>>
>> I have 5 OSD processes per host, and an FC uplink port failure caused
>> kernel panics in two hosts - 0404 and 0401. The mon log looks like
>> this:
>>
>> 2012-12-19 13:30:38.634865 7f9a0f167700 10 mon.3@0(leader).osd e2184
>> preprocess_query osd_failure(osd.404 172.22.4.4:6812/12835 for 8832
>> e2184 v2184) v3 from osd.602 172.22.4.6:6806/5152
>> 2012-12-19 13:30:38.634875 7f9a0f167700  5 mon.3@0(leader).osd e2184
>> can_mark_down current up_ratio 0.298429 < min 0.3, will not mark
>> osd.404 down
>
> This probably means that there are too many in osds and not enough of them
> are up.  Can you attach a 'ceph osd dump'?

I just realised what I did wrong. I did a ceph osd crush remove on
about 100 OSDs to try to determine the source of our performance
issues but didn't do a ceph osd out.

I'll remove them properly. Thanks for your help. Do you have any
suggestions on the second (mon IO) issue I'm seeing?

Here's the dump in any case:

# id	weight	type name	up/down	reweight
-1	30	pool default
-3	30		rack unknownrack
-2	6			host os-0401
100	1				osd.100	up	1	
101	1				osd.101	up	1	
102	1				osd.102	up	1	
103	1				osd.103	down	0	
104	1				osd.104	up	1	
112	1				osd.112	up	1	
-4	6			host os-0402
200	1				osd.200	up	1	
201	1				osd.201	up	1	
202	1				osd.202	up	1	
203	1				osd.203	up	1	
204	1				osd.204	up	1	
212	1				osd.212	up	1	
-5	6			host os-0403
300	1				osd.300	up	1	
301	1				osd.301	up	1	
302	1				osd.302	up	1	
303	1				osd.303	up	1	
304	1				osd.304	up	1	
312	1				osd.312	up	1	
-6	6			host os-0404
400	1				osd.400	down	0	
401	1				osd.401	down	0	
402	1				osd.402	down	0	
403	1				osd.403	down	0	
404	1				osd.404	down	0	
412	1				osd.412	down	0	
-7	0			host os-0405
-8	6			host os-0406
600	1				osd.600	up	1	
601	1				osd.601	up	1	
602	1				osd.602	up	1	
603	1				osd.603	up	1	
604	1				osd.604	up	1	
612	1				osd.612	up	1	

105	0	osd.105	up	1	
106	0	osd.106	up	1	
107	0	osd.107	up	1	
108	0	osd.108	up	1	
109	0	osd.109	up	1	
110	0	osd.110	up	1	
111	0	osd.111	up	1	
113	0	osd.113	up	1	
114	0	osd.114	up	1	
115	0	osd.115	up	1	
116	0	osd.116	up	1	
117	0	osd.117	up	1	
118	0	osd.118	up	1	
119	0	osd.119	up	1	
120	0	osd.120	up	1	
121	0	osd.121	up	1	
122	0	osd.122	up	1	
123	0	osd.123	up	1	
124	0	osd.124	up	1	
125	0	osd.125	up	1	
126	0	osd.126	up	1	
127	0	osd.127	up	1	
128	0	osd.128	up	1	
129	0	osd.129	up	1	
130	0	osd.130	up	1	
131	0	osd.131	up	1	
205	0	osd.205	down	0	
206	0	osd.206	down	0	
207	0	osd.207	down	0	
208	0	osd.208	down	0	
209	0	osd.209	down	0	
210	0	osd.210	down	0	
211	0	osd.211	down	0	
213	0	osd.213	down	0	
214	0	osd.214	down	0	
215	0	osd.215	down	0	
216	0	osd.216	down	0	
217	0	osd.217	down	0	
218	0	osd.218	down	0	
219	0	osd.219	down	0	
220	0	osd.220	down	0	
221	0	osd.221	down	0	
222	0	osd.222	down	0	
223	0	osd.223	down	0	
224	0	osd.224	down	0	
225	0	osd.225	down	0	
227	0	osd.227	down	0	
228	0	osd.228	down	0	
229	0	osd.229	down	0	
230	0	osd.230	down	0	
231	0	osd.231	down	0	
305	0	osd.305	down	0	
306	0	osd.306	down	0	
307	0	osd.307	down	0	
308	0	osd.308	down	0	
309	0	osd.309	down	0	
310	0	osd.310	down	0	
311	0	osd.311	down	0	
313	0	osd.313	down	0	
314	0	osd.314	down	0	
315	0	osd.315	down	0	
316	0	osd.316	down	0	
317	0	osd.317	down	0	
318	0	osd.318	down	0	
319	0	osd.319	down	0	
320	0	osd.320	down	0	
321	0	osd.321	down	0	
322	0	osd.322	down	0	
323	0	osd.323	down	0	
324	0	osd.324	down	0	
325	0	osd.325	down	0	
326	0	osd.326	down	0	
327	0	osd.327	down	0	
328	0	osd.328	down	0	
329	0	osd.329	down	0	
330	0	osd.330	down	0	
331	0	osd.331	down	0	
405	0	osd.405	down	0	
406	0	osd.406	down	0	
407	0	osd.407	down	0	
408	0	osd.408	down	0	
409	0	osd.409	down	0	
410	0	osd.410	down	0	
411	0	osd.411	down	0	
413	0	osd.413	down	0	
414	0	osd.414	down	0	
415	0	osd.415	down	0	
416	0	osd.416	down	0	
417	0	osd.417	down	0	
418	0	osd.418	down	0	
419	0	osd.419	down	0	
420	0	osd.420	down	0	
421	0	osd.421	down	0	
422	0	osd.422	down	0	
423	0	osd.423	down	0	
424	0	osd.424	down	0	
425	0	osd.425	down	0	
426	0	osd.426	down	0	
427	0	osd.427	down	0	
428	0	osd.428	down	0	
429	0	osd.429	down	0	
430	0	osd.430	down	0	
431	0	osd.431	down	0	
500	0	osd.500	down	0	
501	0	osd.501	down	0	
502	0	osd.502	down	0	
503	0	osd.503	down	0	
504	0	osd.504	down	0	
505	0	osd.505	down	0	
506	0	osd.506	down	0	
507	0	osd.507	down	0	
508	0	osd.508	down	0	
509	0	osd.509	down	0	
510	0	osd.510	down	0	
511	0	osd.511	down	0	
512	0	osd.512	down	0	
513	0	osd.513	down	0	
514	0	osd.514	down	0	
515	0	osd.515	down	0	
516	0	osd.516	down	0	
517	0	osd.517	down	0	
518	0	osd.518	down	0	
519	0	osd.519	down	0	
520	0	osd.520	down	0	
521	0	osd.521	down	0	
522	0	osd.522	down	0	
523	0	osd.523	down	0	
524	0	osd.524	down	0	
525	0	osd.525	down	0	
526	0	osd.526	down	0	
527	0	osd.527	down	0	
528	0	osd.528	down	0	
529	0	osd.529	down	0	
530	0	osd.530	down	0	
531	0	osd.531	down	0	
605	0	osd.605	down	0	
606	0	osd.606	down	0	
607	0	osd.607	down	0	
608	0	osd.608	down	0	
609	0	osd.609	down	0	
610	0	osd.610	down	0	
611	0	osd.611	down	0	
613	0	osd.613	down	0	
614	0	osd.614	down	0	
615	0	osd.615	down	0	
616	0	osd.616	down	0	
617	0	osd.617	down	0	
618	0	osd.618	up	1	
619	0	osd.619	up	1	
620	0	osd.620	down	0	
621	0	osd.621	down	0	
622	0	osd.622	up	1	
623	0	osd.623	down	0	
624	0	osd.624	up	1	
625	0	osd.625	up	1	
626	0	osd.626	up	1	
627	0	osd.627	down	0	
628	0	osd.628	down	0	
629	0	osd.629	up	1	
630	0	osd.630	down	0	
631	0	osd.631	up	1	


>
> It may also be that it's because your osd ids are too sparse.. if that's
> the case, this is a bug.  But just a heads up that you don't get much
> control over the osd id that is assigned, so trying to keep them in sync
> with the host may be a losing battle.  :/
>
> sage
>
>
>
>> 2012-12-19 13:30:38.634880 7f9a0f167700  5 mon.3@0(leader).osd e2184 preprocess_
>>
>> The cluster appears healthy
>>
>> root@os-0405:~# ceph -s
>>    health HEALTH_OK
>>    monmap e3: 1 mons at {3=172.22.4.5:6789/0}, election epoch 1, quorum 0 3
>>    osdmap e2184: 191 osds: 57 up, 57 in
>>     pgmap v205386: 121952 pgs: 121951 active+clean, 1
>> active+clean+scrubbing; 4437 MB data, 49497 MB used, 103 TB / 103 TB
>> avail
>>    mdsmap e1: 0/0/1 up
>>
>> root@os-0405:~# ceph osd tree
>>
>> # id    weight  type name       up/down reweight
>> -1      30      pool default
>> -3      30              rack unknownrack
>> -2      6                       host os-0401
>> 100     1                               osd.100 up      1
>> 101     1                               osd.101 up      1
>> 102     1                               osd.102 up      1
>> 103     1                               osd.103 up      1
>> 104     1                               osd.104 up      1
>> 112     1                               osd.112 up      1
>> -4      6                       host os-0402
>> 200     1                               osd.200 up      1
>> 201     1                               osd.201 up      1
>> 202     1                               osd.202 up      1
>> 203     1                               osd.203 up      1
>> 204     1                               osd.204 up      1
>> 212     1                               osd.212 up      1
>> -5      6                       host os-0403
>> 300     1                               osd.300 up      1
>> 301     1                               osd.301 up      1
>> 302     1                               osd.302 up      1
>> 303     1                               osd.303 up      1
>> 304     1                               osd.304 up      1
>> 312     1                               osd.312 up      1
>> -6      6                       host os-0404
>> 400     1                               osd.400 up      1
>> 401     1                               osd.401 up      1
>> 402     1                               osd.402 up      1
>> 403     1                               osd.403 up      1
>> 404     1                               osd.404 up      1
>> 412     1                               osd.412 up      1
>> -7      0                       host os-0405
>> -8      6                       host os-0406
>> 600     1                               osd.600 up      1
>> 601     1                               osd.601 up      1
>> 602     1                               osd.602 up      1
>> 603     1                               osd.603 up      1
>> 604     1                               osd.604 up      1
>> 612     1                               osd.612 up      1
>>
>> but os-0404 has no osd processes running anymore.
>>
>> root@os-0404:~# ps aux | grep ceph
>> root      4964  0.0  0.0   9628   920 pts/1    S+   13:31   0:00 grep
>> --color=auto ceph
>>
>> and even if it did, it can't access the luns in order to mount the xfs
>> filesystems with all the osd data.
>>
>> What is preventing the mon from marking the osds on 0404 down?
>>
>> A second issue I have been having is that my reads+writes are very
>> bursty, going from 8MB/s to 200MB/s when doing a dd from a physical
>> client over 10GbE. It seems to be waiting on the mon most of the time,
>> and iostat shows long io wait times for the disk the mon is using. I
>> can also see it writing ~40MB/s constantly to disk in iotop, though I
>> don't know if this is random or sequential. I see a lot of waiting for
>> sub ops which I thought might be a result of the io wait.
>>
>> Is that a normal amount of activity for a mon process? Should I be
>> running the mon processes off more than just a single sata disk to
>> keep up with ~30 OSD processes?
>>
>> Thanks for your time.
>>
>>  - Michael Chapman
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>



-- 
Michael Chapman
Cloud Computing Services
ANU Supercomputer Facility
Room 318, Leonard Huxley Building (#56), Mills Road
The Australian National University
Canberra ACT 0200 Australia
Tel: +61 2 6125 7106
Web: http://nci.org.au
