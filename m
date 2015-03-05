From: David Burley <david-kIZutuWb7l0/lw2aP8KBIQC/G2K4zDHf@public.gmane.org>
Subject: Re: pool distribution quality report script
Date: Thu, 5 Mar 2015 13:52:25 -0500
Message-ID: <CANvNco10mVkMytCwGqKtxRpR-64OFAn4weoopqD3cNGUar3-fQ@mail.gmail.com>
References: <54F7D78D.2090200@redhat.com>
	<CA+z5DszPviPvJd3WS2_3RKd_GXGf8NkCe8og2EQ8wZZsbe=kUA@mail.gmail.com>
	<54F8A468.30707@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0208595958=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <54F8A468.30707-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Mark Nelson <mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Blair Bethwaite <blair.bethwaite-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0208595958==
Content-Type: multipart/alternative; boundary=001a11345cf2f0f7ff05108f11ab

--001a11345cf2f0f7ff05108f11ab
Content-Type: text/plain; charset=UTF-8

Mark,

It worked for me earlier this morning but the new rev is throwing a
traceback:

$ ceph pg dump -f json | python ./readpgdump.py > pgdump_analysis.txt
dumped all in format json
Traceback (most recent call last):
  File "./readpgdump.py", line 294, in <module>
    parse_json(data)
  File "./readpgdump.py", line 263, in parse_json
    print_report(pool_counts, total_counts, "JSON")
  File "./readpgdump.py", line 119, in print_report
    print_data(data, pool_weights, total_weights)
  File "./readpgdump.py", line 161, in print_data
    print format_line("Efficiency score using optimal weights for pool %s:
%.1f%%" % (pool, efficiency_score(data[name], weights['acting_totals'])))
  File "./readpgdump.py", line 71, in efficiency_score
    if weights and weights[osd]:
KeyError: 0

On Thu, Mar 5, 2015 at 1:46 PM, Mark Nelson <mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> Hi Blair,
>
> I've updated the script and it now (theoretically) computes optimal crush
> weights based on both primary and secondary acting set OSDs.  It also
> attempts to show you the efficiency of equal weights vs using weights
> optimized for different pools (or all pools).  This is done by looking at
> the way weights would be assigned and how they would affect the current
> pool distribution, then looking at the skew for the heaviest weighted OSD
> vs the average.
>
> Unfortunately the output has now become beastly and complex (granted this
> is a large cluster with many pools!).  I think the trick now is how to make
> the interface for this more manageable.  For instance perhaps it's not
> interesting to know how one pool's weights affect the efficiency of the
> acting primary OSDs for another pool.
>
> I've included sample output, but it's huge (15K lines long!)
>
> Mark
>
>
> On 03/05/2015 01:52 AM, Blair Bethwaite wrote:
>
>> Hi Mark,
>>
>> Cool, that looks handy. Though it'd be even better if it could go a
>> step further and recommend re-weighting values to balance things out
>> (or increased PG counts where needed).
>>
>> Cheers,
>>
>> On 5 March 2015 at 15:11, Mark Nelson <mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>>
>>> Hi All,
>>>
>>> Recently some folks showed interest in gathering pool distribution
>>> statistics and I remembered I wrote a script to do that a while back. It
>>> was
>>> broken due to a change in the ceph pg dump output format that was
>>> committed
>>> a while back, so I cleaned the script up, added detection of header
>>> fields,
>>> automatic json support, and also added in calculation of expected max and
>>> min PGs per OSD and std deviation.
>>>
>>> The script is available here:
>>>
>>> https://github.com/ceph/ceph-tools/blob/master/cbt/tools/readpgdump.py
>>>
>>> Some general comments:
>>>
>>> 1) Expected numbers are derived by treating PGs and OSDs as a
>>> balls-in-buckets problem ala Raab & Steger:
>>>
>>> http://www14.in.tum.de/personen/raab/publ/balls.pdf
>>>
>>> 2) You can invoke it either by passing it a file or stdout, ie:
>>>
>>> ceph pg dump -f json | ./readpgdump.py
>>>
>>> or
>>>
>>> ./readpgdump.py ~/pgdump.out
>>>
>>>
>>> 3) Here's a snippet of some of some sample output from a 210 OSD cluster.
>>> Does this output make sense to people?  Is it useful?
>>>
>>>  [nhm@burnupiX tools]$ ./readpgdump.py ~/pgdump.out
>>>>
>>>> +-----------------------------------------------------------
>>>> -----------------+
>>>> | Detected input as plain
>>>> |
>>>>
>>>> +-----------------------------------------------------------
>>>> -----------------+
>>>>
>>>>
>>>> +-----------------------------------------------------------
>>>> -----------------+
>>>> | Pool ID: 681
>>>> |
>>>>
>>>> +-----------------------------------------------------------
>>>> -----------------+
>>>> | Participating OSDs: 210
>>>> |
>>>> | Participating PGs: 4096
>>>> |
>>>>
>>>> +-----------------------------------------------------------
>>>> -----------------+
>>>> | OSDs in Primary Role (Acting)
>>>> |
>>>> | Expected PGs Per OSD: Min: 4, Max: 33, Mean: 19.5, Std Dev: 7.2
>>>> |
>>>> | Actual PGs Per OSD: Min: 7, Max: 43, Mean: 19.5, Std Dev: 6.5
>>>> |
>>>> | 5 Most Subscribed OSDs: 199(43), 175(36), 149(34), 167(32), 20(31)
>>>> |
>>>> | 5 Least Subscribed OSDs: 121(7), 46(7), 70(8), 94(9), 122(9)
>>>> |
>>>> | Avg Deviation from Most Subscribed OSD: 54.6%
>>>> |
>>>>
>>>> +-----------------------------------------------------------
>>>> -----------------+
>>>> | OSDs in Secondary Role (Acting)
>>>> |
>>>> | Expected PGs Per OSD: Min: 18, Max: 59, Mean: 39.0, Std Dev: 10.2
>>>> |
>>>> | Actual PGs Per OSD: Min: 17, Max: 61, Mean: 39.0, Std Dev: 9.7
>>>> |
>>>> | 5 Most Subscribed OSDs: 44(61), 14(60), 2(59), 167(59), 164(57)
>>>> |
>>>> | 5 Least Subscribed OSDs: 35(17), 31(20), 37(20), 145(20), 16(20)
>>>> |
>>>> | Avg Deviation from Most Subscribed OSD: 36.0%
>>>> |
>>>>
>>>> +-----------------------------------------------------------
>>>> -----------------+
>>>> | OSDs in All Roles (Acting)
>>>> |
>>>> | Expected PGs Per OSD: Min: 32, Max: 83, Mean: 58.5, Std Dev: 12.5
>>>> |
>>>> | Actual PGs Per OSD: Min: 29, Max: 93, Mean: 58.5, Std Dev: 14.6
>>>> |
>>>> | 5 Most Subscribed OSDs: 199(93), 175(92), 44(92), 167(91), 14(91)
>>>> |
>>>> | 5 Least Subscribed OSDs: 121(29), 35(30), 47(30), 131(32), 145(32)
>>>> |
>>>> | Avg Deviation from Most Subscribed OSD: 37.1%
>>>> |
>>>>
>>>> +-----------------------------------------------------------
>>>> -----------------+
>>>> | OSDs in Primary Role (Up)
>>>> |
>>>> | Expected PGs Per OSD: Min: 4, Max: 33, Mean: 19.5, Std Dev: 7.2
>>>> |
>>>> | Actual PGs Per OSD: Min: 7, Max: 43, Mean: 19.5, Std Dev: 6.5
>>>> |
>>>> | 5 Most Subscribed OSDs: 199(43), 175(36), 149(34), 167(32), 20(31)
>>>> |
>>>> | 5 Least Subscribed OSDs: 121(7), 46(7), 70(8), 94(9), 122(9)
>>>> |
>>>> | Avg Deviation from Most Subscribed OSD: 54.6%
>>>> |
>>>>
>>>> +-----------------------------------------------------------
>>>> -----------------+
>>>> | OSDs in Secondary Role (Up)
>>>> |
>>>> | Expected PGs Per OSD: Min: 18, Max: 59, Mean: 39.0, Std Dev: 10.2
>>>> |
>>>> | Actual PGs Per OSD: Min: 17, Max: 61, Mean: 39.0, Std Dev: 9.7
>>>> |
>>>> | 5 Most Subscribed OSDs: 44(61), 14(60), 2(59), 167(59), 164(57)
>>>> |
>>>> | 5 Least Subscribed OSDs: 35(17), 31(20), 37(20), 145(20), 16(20)
>>>> |
>>>> | Avg Deviation from Most Subscribed OSD: 36.0%
>>>> |
>>>>
>>>> +-----------------------------------------------------------
>>>> -----------------+
>>>> | OSDs in All Roles (Up)
>>>> |
>>>> | Expected PGs Per OSD: Min: 32, Max: 83, Mean: 58.5, Std Dev: 12.5
>>>> |
>>>> | Actual PGs Per OSD: Min: 29, Max: 93, Mean: 58.5, Std Dev: 14.6
>>>> |
>>>> | 5 Most Subscribed OSDs: 199(93), 175(92), 44(92), 167(91), 14(91)
>>>> |
>>>> | 5 Least Subscribed OSDs: 121(29), 35(30), 47(30), 131(32), 145(32)
>>>> |
>>>> | Avg Deviation from Most Subscribed OSD: 37.1%
>>>> |
>>>>
>>>> +-----------------------------------------------------------
>>>> -----------------+
>>>>
>>>
>>>
>>> This is shown for all the pools, followed by the totals:
>>>
>>>
>>>> +-----------------------------------------------------------
>>>> -----------------+
>>>> | Pool ID: Totals (All Pools)
>>>> |
>>>>
>>>> +-----------------------------------------------------------
>>>> -----------------+
>>>> | Participating OSDs: 210
>>>> |
>>>> | Participating PGs: 131072
>>>> |
>>>>
>>>> +-----------------------------------------------------------
>>>> -----------------+
>>>> | OSDs in Primary Role (Acting)
>>>> |
>>>> | Expected PGs Per OSD: Min: 542, Max: 705, Mean: 624.0, Std Dev: 40.8
>>>> |
>>>> | Actual PGs Per OSD: Min: 356, Max: 917, Mean: 624.0, Std Dev: 176.2
>>>> |
>>>> | 5 Most Subscribed OSDs: 167(917), 123(876), 23(873), 194(869), 60(868)
>>>> |
>>>> | 5 Least Subscribed OSDs: 117(356), 155(358), 46(361), 78(361), 70(362)
>>>> |
>>>> | Avg Deviation from Most Subscribed OSD: 32.0%
>>>> |
>>>>
>>>> +-----------------------------------------------------------
>>>> -----------------+
>>>> | OSDs in Secondary Role (Acting)
>>>> |
>>>> | Expected PGs Per OSD: Min: 1132, Max: 1363, Mean: 1248.0, Std Dev:
>>>> 57.8
>>>> |
>>>> | Actual PGs Per OSD: Min: 864, Max: 1554, Mean: 1248.0, Std Dev: 229.9
>>>> |
>>>> | 5 Most Subscribed OSDs: 182(1554), 142(1552), 4(1548), 123(1544),
>>>> 100(1540)|
>>>> | 5 Least Subscribed OSDs: 16(864), 55(885), 18(885), 42(885), 85(891)
>>>> |
>>>> | Avg Deviation from Most Subscribed OSD: 19.7%
>>>> |
>>>>
>>>> +-----------------------------------------------------------
>>>> -----------------+
>>>> | OSDs in All Roles (Acting)
>>>> |
>>>> | Expected PGs Per OSD: Min: 1730, Max: 2013, Mean: 1872.0, Std Dev:
>>>> 70.7
>>>> |
>>>> | Actual PGs Per OSD: Min: 1252, Max: 2420, Mean: 1872.0, Std Dev: 402.0
>>>> |
>>>> | 5 Most Subscribed OSDs: 123(2420), 142(2403), 195(2390), 100(2389),
>>>> 182(2380)|
>>>> | 5 Least Subscribed OSDs: 55(1252), 42(1268), 16(1271), 85(1271),
>>>> 155(1275) |
>>>> | Avg Deviation from Most Subscribed OSD: 22.6%
>>>> |
>>>>
>>>> +-----------------------------------------------------------
>>>> -----------------+
>>>> | OSDs in Primary Role (Up)
>>>> |
>>>> | Expected PGs Per OSD: Min: 542, Max: 705, Mean: 624.0, Std Dev: 40.8
>>>> |
>>>> | Actual PGs Per OSD: Min: 356, Max: 917, Mean: 624.0, Std Dev: 176.2
>>>> |
>>>> | 5 Most Subscribed OSDs: 167(917), 123(876), 23(873), 194(869), 60(868)
>>>> |
>>>> | 5 Least Subscribed OSDs: 117(356), 155(358), 46(361), 78(361), 70(362)
>>>> |
>>>> | Avg Deviation from Most Subscribed OSD: 32.0%
>>>> |
>>>>
>>>> +-----------------------------------------------------------
>>>> -----------------+
>>>> | OSDs in Secondary Role (Up)
>>>> |
>>>> | Expected PGs Per OSD: Min: 1132, Max: 1363, Mean: 1248.0, Std Dev:
>>>> 57.8
>>>> |
>>>> | Actual PGs Per OSD: Min: 864, Max: 1554, Mean: 1248.0, Std Dev: 229.9
>>>> |
>>>> | 5 Most Subscribed OSDs: 182(1554), 142(1552), 4(1548), 123(1544),
>>>> 100(1540)|
>>>> | 5 Least Subscribed OSDs: 16(864), 55(885), 18(885), 42(885), 85(891)
>>>> |
>>>> | Avg Deviation from Most Subscribed OSD: 19.7%
>>>> |
>>>>
>>>> +-----------------------------------------------------------
>>>> -----------------+
>>>> | OSDs in All Roles (Up)
>>>> |
>>>> | Expected PGs Per OSD: Min: 1730, Max: 2013, Mean: 1872.0, Std Dev:
>>>> 70.7
>>>> |
>>>> | Actual PGs Per OSD: Min: 1252, Max: 2420, Mean: 1872.0, Std Dev: 402.0
>>>> |
>>>> | 5 Most Subscribed OSDs: 123(2420), 142(2403), 195(2390), 100(2389),
>>>> 182(2380)|
>>>> | 5 Least Subscribed OSDs: 55(1252), 42(1268), 16(1271), 85(1271),
>>>> 155(1275) |
>>>> | Avg Deviation from Most Subscribed OSD: 22.6%
>>>> |
>>>>
>>>> +-----------------------------------------------------------
>>>> -----------------+
>>>>
>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>>
>>
>>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
>


-- 
David Burley
NOC Manager, Sr. Systems Programmer/Analyst
Slashdot Media

e: david-kIZutuWb7l0/lw2aP8KBIQC/G2K4zDHf@public.gmane.org

--001a11345cf2f0f7ff05108f11ab
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Mark,<div><br></div><div>It worked for me earlier this mor=
ning but the new rev is throwing a traceback:</div><div><br></div>$ ceph pg=
 dump -f json | python ./readpgdump.py &gt; pgdump_analysis.txt<br>dumped a=
ll in format json<br>Traceback (most recent call last):<br>=C2=A0 File &quo=
t;./readpgdump.py&quot;, line 294, in &lt;module&gt;<br>=C2=A0 =C2=A0 parse=
_json(data) <br>=C2=A0 File &quot;./readpgdump.py&quot;, line 263, in parse=
_json<br>=C2=A0 =C2=A0 print_report(pool_counts, total_counts, &quot;JSON&q=
uot;)<br>=C2=A0 File &quot;./readpgdump.py&quot;, line 119, in print_report=
<br>=C2=A0 =C2=A0 print_data(data, pool_weights, total_weights)<br>=C2=A0 F=
ile &quot;./readpgdump.py&quot;, line 161, in print_data<br>=C2=A0 =C2=A0 p=
rint format_line(&quot;Efficiency score using optimal weights for pool %s: =
%.1f%%&quot; % (pool, efficiency_score(data[name], weights[&#39;acting_tota=
ls&#39;])))<br>=C2=A0 File &quot;./readpgdump.py&quot;, line 71, in efficie=
ncy_score<br>=C2=A0 =C2=A0 if weights and weights[osd]:<br>KeyError: 0<div =
class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Thu, Mar 5, 2015 at=
 1:46 PM, Mark Nelson <span dir=3D"ltr">&lt;<a href=3D"mailto:mnelson@redha=
t.com" target=3D"_blank">mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;</span> wrote:<br><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">Hi Blair,<br>
<br>
I&#39;ve updated the script and it now (theoretically) computes optimal cru=
sh weights based on both primary and secondary acting set OSDs.=C2=A0 It al=
so attempts to show you the efficiency of equal weights vs using weights op=
timized for different pools (or all pools).=C2=A0 This is done by looking a=
t the way weights would be assigned and how they would affect the current p=
ool distribution, then looking at the skew for the heaviest weighted OSD vs=
 the average.<br>
<br>
Unfortunately the output has now become beastly and complex (granted this i=
s a large cluster with many pools!).=C2=A0 I think the trick now is how to =
make the interface for this more manageable.=C2=A0 For instance perhaps it&=
#39;s not interesting to know how one pool&#39;s weights affect the efficie=
ncy of the acting primary OSDs for another pool.<br>
<br>
I&#39;ve included sample output, but it&#39;s huge (15K lines long!)<span c=
lass=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
Mark</font></span><div class=3D"HOEnZb"><div class=3D"h5"><br>
<br>
On 03/05/2015 01:52 AM, Blair Bethwaite wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Hi Mark,<br>
<br>
Cool, that looks handy. Though it&#39;d be even better if it could go a<br>
step further and recommend re-weighting values to balance things out<br>
(or increased PG counts where needed).<br>
<br>
Cheers,<br>
<br>
On 5 March 2015 at 15:11, Mark Nelson &lt;<a href=3D"mailto:mnelson@redhat.=
com" target=3D"_blank">mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt; wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Hi All,<br>
<br>
Recently some folks showed interest in gathering pool distribution<br>
statistics and I remembered I wrote a script to do that a while back. It wa=
s<br>
broken due to a change in the ceph pg dump output format that was committed=
<br>
a while back, so I cleaned the script up, added detection of header fields,=
<br>
automatic json support, and also added in calculation of expected max and<b=
r>
min PGs per OSD and std deviation.<br>
<br>
The script is available here:<br>
<br>
<a href=3D"https://github.com/ceph/ceph-tools/blob/master/cbt/tools/readpgd=
ump.py" target=3D"_blank">https://github.com/ceph/ceph-<u></u>tools/blob/ma=
ster/cbt/tools/<u></u>readpgdump.py</a><br>
<br>
Some general comments:<br>
<br>
1) Expected numbers are derived by treating PGs and OSDs as a<br>
balls-in-buckets problem ala Raab &amp; Steger:<br>
<br>
<a href=3D"http://www14.in.tum.de/personen/raab/publ/balls.pdf" target=3D"_=
blank">http://www14.in.tum.de/<u></u>personen/raab/publ/balls.pdf</a><br>
<br>
2) You can invoke it either by passing it a file or stdout, ie:<br>
<br>
ceph pg dump -f json | ./readpgdump.py<br>
<br>
or<br>
<br>
./readpgdump.py ~/pgdump.out<br>
<br>
<br>
3) Here&#39;s a snippet of some of some sample output from a 210 OSD cluste=
r.<br>
Does this output make sense to people?=C2=A0 Is it useful?<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
[nhm@burnupiX tools]$ ./readpgdump.py ~/pgdump.out<br>
<br>
+-----------------------------<u></u>------------------------------<u></u>-=
----------------+<br>
| Detected input as plain<br>
|<br>
<br>
+-----------------------------<u></u>------------------------------<u></u>-=
----------------+<br>
<br>
<br>
+-----------------------------<u></u>------------------------------<u></u>-=
----------------+<br>
| Pool ID: 681<br>
|<br>
<br>
+-----------------------------<u></u>------------------------------<u></u>-=
----------------+<br>
| Participating OSDs: 210<br>
|<br>
| Participating PGs: 4096<br>
|<br>
<br>
+-----------------------------<u></u>------------------------------<u></u>-=
----------------+<br>
| OSDs in Primary Role (Acting)<br>
|<br>
| Expected PGs Per OSD: Min: 4, Max: 33, Mean: 19.5, Std Dev: 7.2<br>
|<br>
| Actual PGs Per OSD: Min: 7, Max: 43, Mean: 19.5, Std Dev: 6.5<br>
|<br>
| 5 Most Subscribed OSDs: 199(43), 175(36), 149(34), 167(32), 20(31)<br>
|<br>
| 5 Least Subscribed OSDs: 121(7), 46(7), 70(8), 94(9), 122(9)<br>
|<br>
| Avg Deviation from Most Subscribed OSD: 54.6%<br>
|<br>
<br>
+-----------------------------<u></u>------------------------------<u></u>-=
----------------+<br>
| OSDs in Secondary Role (Acting)<br>
|<br>
| Expected PGs Per OSD: Min: 18, Max: 59, Mean: 39.0, Std Dev: 10.2<br>
|<br>
| Actual PGs Per OSD: Min: 17, Max: 61, Mean: 39.0, Std Dev: 9.7<br>
|<br>
| 5 Most Subscribed OSDs: 44(61), 14(60), 2(59), 167(59), 164(57)<br>
|<br>
| 5 Least Subscribed OSDs: 35(17), 31(20), 37(20), 145(20), 16(20)<br>
|<br>
| Avg Deviation from Most Subscribed OSD: 36.0%<br>
|<br>
<br>
+-----------------------------<u></u>------------------------------<u></u>-=
----------------+<br>
| OSDs in All Roles (Acting)<br>
|<br>
| Expected PGs Per OSD: Min: 32, Max: 83, Mean: 58.5, Std Dev: 12.5<br>
|<br>
| Actual PGs Per OSD: Min: 29, Max: 93, Mean: 58.5, Std Dev: 14.6<br>
|<br>
| 5 Most Subscribed OSDs: 199(93), 175(92), 44(92), 167(91), 14(91)<br>
|<br>
| 5 Least Subscribed OSDs: 121(29), 35(30), 47(30), 131(32), 145(32)<br>
|<br>
| Avg Deviation from Most Subscribed OSD: 37.1%<br>
|<br>
<br>
+-----------------------------<u></u>------------------------------<u></u>-=
----------------+<br>
| OSDs in Primary Role (Up)<br>
|<br>
| Expected PGs Per OSD: Min: 4, Max: 33, Mean: 19.5, Std Dev: 7.2<br>
|<br>
| Actual PGs Per OSD: Min: 7, Max: 43, Mean: 19.5, Std Dev: 6.5<br>
|<br>
| 5 Most Subscribed OSDs: 199(43), 175(36), 149(34), 167(32), 20(31)<br>
|<br>
| 5 Least Subscribed OSDs: 121(7), 46(7), 70(8), 94(9), 122(9)<br>
|<br>
| Avg Deviation from Most Subscribed OSD: 54.6%<br>
|<br>
<br>
+-----------------------------<u></u>------------------------------<u></u>-=
----------------+<br>
| OSDs in Secondary Role (Up)<br>
|<br>
| Expected PGs Per OSD: Min: 18, Max: 59, Mean: 39.0, Std Dev: 10.2<br>
|<br>
| Actual PGs Per OSD: Min: 17, Max: 61, Mean: 39.0, Std Dev: 9.7<br>
|<br>
| 5 Most Subscribed OSDs: 44(61), 14(60), 2(59), 167(59), 164(57)<br>
|<br>
| 5 Least Subscribed OSDs: 35(17), 31(20), 37(20), 145(20), 16(20)<br>
|<br>
| Avg Deviation from Most Subscribed OSD: 36.0%<br>
|<br>
<br>
+-----------------------------<u></u>------------------------------<u></u>-=
----------------+<br>
| OSDs in All Roles (Up)<br>
|<br>
| Expected PGs Per OSD: Min: 32, Max: 83, Mean: 58.5, Std Dev: 12.5<br>
|<br>
| Actual PGs Per OSD: Min: 29, Max: 93, Mean: 58.5, Std Dev: 14.6<br>
|<br>
| 5 Most Subscribed OSDs: 199(93), 175(92), 44(92), 167(91), 14(91)<br>
|<br>
| 5 Least Subscribed OSDs: 121(29), 35(30), 47(30), 131(32), 145(32)<br>
|<br>
| Avg Deviation from Most Subscribed OSD: 37.1%<br>
|<br>
<br>
+-----------------------------<u></u>------------------------------<u></u>-=
----------------+<br>
</blockquote>
<br>
<br>
This is shown for all the pools, followed by the totals:<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
+-----------------------------<u></u>------------------------------<u></u>-=
----------------+<br>
| Pool ID: Totals (All Pools)<br>
|<br>
<br>
+-----------------------------<u></u>------------------------------<u></u>-=
----------------+<br>
| Participating OSDs: 210<br>
|<br>
| Participating PGs: 131072<br>
|<br>
<br>
+-----------------------------<u></u>------------------------------<u></u>-=
----------------+<br>
| OSDs in Primary Role (Acting)<br>
|<br>
| Expected PGs Per OSD: Min: 542, Max: 705, Mean: 624.0, Std Dev: 40.8<br>
|<br>
| Actual PGs Per OSD: Min: 356, Max: 917, Mean: 624.0, Std Dev: 176.2<br>
|<br>
| 5 Most Subscribed OSDs: 167(917), 123(876), 23(873), 194(869), 60(868)<br=
>
|<br>
| 5 Least Subscribed OSDs: 117(356), 155(358), 46(361), 78(361), 70(362)<br=
>
|<br>
| Avg Deviation from Most Subscribed OSD: 32.0%<br>
|<br>
<br>
+-----------------------------<u></u>------------------------------<u></u>-=
----------------+<br>
| OSDs in Secondary Role (Acting)<br>
|<br>
| Expected PGs Per OSD: Min: 1132, Max: 1363, Mean: 1248.0, Std Dev: 57.8<b=
r>
|<br>
| Actual PGs Per OSD: Min: 864, Max: 1554, Mean: 1248.0, Std Dev: 229.9<br>
|<br>
| 5 Most Subscribed OSDs: 182(1554), 142(1552), 4(1548), 123(1544),<br>
100(1540)|<br>
| 5 Least Subscribed OSDs: 16(864), 55(885), 18(885), 42(885), 85(891)<br>
|<br>
| Avg Deviation from Most Subscribed OSD: 19.7%<br>
|<br>
<br>
+-----------------------------<u></u>------------------------------<u></u>-=
----------------+<br>
| OSDs in All Roles (Acting)<br>
|<br>
| Expected PGs Per OSD: Min: 1730, Max: 2013, Mean: 1872.0, Std Dev: 70.7<b=
r>
|<br>
| Actual PGs Per OSD: Min: 1252, Max: 2420, Mean: 1872.0, Std Dev: 402.0<br=
>
|<br>
| 5 Most Subscribed OSDs: 123(2420), 142(2403), 195(2390), 100(2389),<br>
182(2380)|<br>
| 5 Least Subscribed OSDs: 55(1252), 42(1268), 16(1271), 85(1271),<br>
155(1275) |<br>
| Avg Deviation from Most Subscribed OSD: 22.6%<br>
|<br>
<br>
+-----------------------------<u></u>------------------------------<u></u>-=
----------------+<br>
| OSDs in Primary Role (Up)<br>
|<br>
| Expected PGs Per OSD: Min: 542, Max: 705, Mean: 624.0, Std Dev: 40.8<br>
|<br>
| Actual PGs Per OSD: Min: 356, Max: 917, Mean: 624.0, Std Dev: 176.2<br>
|<br>
| 5 Most Subscribed OSDs: 167(917), 123(876), 23(873), 194(869), 60(868)<br=
>
|<br>
| 5 Least Subscribed OSDs: 117(356), 155(358), 46(361), 78(361), 70(362)<br=
>
|<br>
| Avg Deviation from Most Subscribed OSD: 32.0%<br>
|<br>
<br>
+-----------------------------<u></u>------------------------------<u></u>-=
----------------+<br>
| OSDs in Secondary Role (Up)<br>
|<br>
| Expected PGs Per OSD: Min: 1132, Max: 1363, Mean: 1248.0, Std Dev: 57.8<b=
r>
|<br>
| Actual PGs Per OSD: Min: 864, Max: 1554, Mean: 1248.0, Std Dev: 229.9<br>
|<br>
| 5 Most Subscribed OSDs: 182(1554), 142(1552), 4(1548), 123(1544),<br>
100(1540)|<br>
| 5 Least Subscribed OSDs: 16(864), 55(885), 18(885), 42(885), 85(891)<br>
|<br>
| Avg Deviation from Most Subscribed OSD: 19.7%<br>
|<br>
<br>
+-----------------------------<u></u>------------------------------<u></u>-=
----------------+<br>
| OSDs in All Roles (Up)<br>
|<br>
| Expected PGs Per OSD: Min: 1730, Max: 2013, Mean: 1872.0, Std Dev: 70.7<b=
r>
|<br>
| Actual PGs Per OSD: Min: 1252, Max: 2420, Mean: 1872.0, Std Dev: 402.0<br=
>
|<br>
| 5 Most Subscribed OSDs: 123(2420), 142(2403), 195(2390), 100(2389),<br>
182(2380)|<br>
| 5 Least Subscribed OSDs: 55(1252), 42(1268), 16(1271), 85(1271),<br>
155(1275) |<br>
| Avg Deviation from Most Subscribed OSD: 22.6%<br>
|<br>
<br>
+-----------------------------<u></u>------------------------------<u></u>-=
----------------+<br>
</blockquote>
<br>
<br>
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe ceph-devel&q=
uot; in<br>
the body of a message to <a href=3D"mailto:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" targe=
t=3D"_blank">majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br>
More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/majordomo-in=
fo.html" target=3D"_blank">http://vger.kernel.org/<u></u>majordomo-info.htm=
l</a><br>
</blockquote>
<br>
<br>
<br>
</blockquote>
</div></div><br>_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><=
br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" target=
=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a><br>
<br></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div cla=
ss=3D"gmail_signature">David Burley<div>NOC Manager, Sr. Systems Programmer=
/Analyst</div><div>Slashdot Media</div><div><br></div><div>e:=C2=A0<a href=
=3D"mailto:david-kIZutuWb7l0/lw2aP8KBIQC/G2K4zDHf@public.gmane.org" target=3D"_blank">david@slashdotmedia.c=
om</a></div></div>
</div></div>

--001a11345cf2f0f7ff05108f11ab--

--===============0208595958==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0208595958==--
