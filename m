From: GuangYang <yguang11-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Ceph GET latency
Date: Fri, 21 Feb 2014 22:35:21 +0800
Message-ID: <BLU0-SMTP609B0C3314F7BDB33C0B3CDF850@phx.gbl>
References: <1392737074.11284.YahooMailNeo@web140905.mail.bf1.yahoo.com>
	<CAPYLRzj_SrmcrEdrCJBPy4khsGqFfcd==vxyYFQ7xKXijcFTPw@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Content-Type: multipart/mixed; boundary="===============1569966841=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAPYLRzj_SrmcrEdrCJBPy4khsGqFfcd==vxyYFQ7xKXijcFTPw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Gregory Farnum <greg-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Cc: Ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, Ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1569966841==
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_CCD8EF26-45BD-481D-9E82-02F5B2F956E5"

--Apple-Mail=_CCD8EF26-45BD-481D-9E82-02F5B2F956E5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="windows-1252"

Thanks Greg for the response, my comments inline=85

Thanks,
Guang
On Feb 20, 2014, at 11:16 PM, Gregory Farnum <greg-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org> wrote:

> On Tue, Feb 18, 2014 at 7:24 AM, Guang Yang <yguang11-/E1597aS9LQAvxtiuMwx3w@public.gmane.org> =
wrote:
>> Hi ceph-users,
>> We are using Ceph (radosgw) to store user generated images, as GET =
latency
>> is critical for us, most recently I did some investigation over the =
GET path
>> to understand where time spend.
>>=20
>> I first confirmed that the latency came from OSD (read op), so that =
we
>> instrumented code to trace the GET request (read op at OSD side, to =
be more
>> specific,
>=20
> How'd you instrument it? Are you aware of the OpTracker system that
> records and can output important events?
I just add some time measurement code before and after some calls, here =
is a the diff (I ported the lock contention fix to dumpling on my test, =
please ignore that) - https://github.com/ceph/ceph/pull/1281/files
Yeah we are using OpTracker as well (dump history op), however, from the =
dumped history op, it is a little bit hard to tell where does the time =
spend (it is between started and finish). As read latency is critical =
for us, we would like to check next level details so that we add some =
checking for lock / file system call.

I am also thinking to refine the code more log to reflect where time =
spent at filestore side, are you interested in such type of code change? =
(it took me some time to trouble shoot the get latency and finally I =
need to add some more log to get a picture).

>> each object with size [512K + 4M * x]  are splitted into [1 + x]
>> chunks, each chunk needs one read op ), for each read op, it needs to =
go
>> through the following steps:
>>    1. Dispatch and take by a op thread to process (process not =
started).
>>             0   - 20 ms,    94%
>>             20 - 50 ms,    2%
>>             50 - 100 ms,  2%
>>              100ms+   ,         2%
>>         For those having 20ms+ latency, half of them are due to =
waiting for
>> pg lock =
(https://github.com/ceph/ceph/blob/dumpling/src/osd/OSD.cc#L7089),
>> another half are yet to be investigated.
>=20
> The PG lock conflict means that there's something else happening in
> the PG at the same time; that's a logical contention issue. However,
> 20ms is a long time, so if you can figure out what else the PG is
> doing during that time it'd be interesting
I haven=92t deep dive that yet (that is a relatively small percentage =
comparing to the second part (which comes from filestore i/o slowness =
due to Dentry / inode cache), my interoperation is that as we serialize =
PG operation and there are some ops taking (like caused by the below), =
so that there is a chance the op are trying to operate on the same pg =
might wait for some time.
BTW, what is the long term strategy for Ceph to support small files =
(which motivated Facebook to build haystack to solve)?

>>=20
>>    2. Get file xattr ('-'), which open the file and populate fd cache
>> =
(https://github.com/ceph/ceph/blob/dumpling/src/os/FileStore.cc#L230).
>>              0   - 20 ms,  80%
>>              20 - 50 ms,   8%
>>              50 - 100 ms, 7%
>>              100ms+   ,      5%
>>         The latency either comes from (from more to less): file path =
lookup
>> =
(https://github.com/ceph/ceph/blob/dumpling/src/os/HashIndex.cc#L294), =
file
>> open, or fd cache lookup /add.
>>         Currently objects are store in level 6 or level 7 folder (due =
to
>> http://tracker.ceph.com/issues/7207, I stopped folder splitting).
>=20
> FYI there's been some community and Inktank work to try and speed this
> up recently. None of it's been merged into master yet, but we'll
> definitely have some improvements to this post-Firefly.
Yeah I am aware of that and we are extremely interested in the effort as =
well. Basically our use case is:
  1. Get latency is more critical than PUT latency.
  2. Our work load is mainly small files (95% are less than 512KB).=20
> -Greg
> Software Engineer #42 @ http://inktank.com | http://ceph.com
>=20
>>=20
>>    3. Get more xattrs, this is fast due to previous fd cache (rarely =
>
>> 1ms).
>>=20
>>    4. Read the data.
>>            0   - 20 ms,   84%
>>            20 - 50 ms, 10%
>>            50 - 100 ms, 4%
>>            100ms+        , 2%
>>=20
>> I decreased vfs_cache_pressure from its default value 100 to 5 to =
make VFS
>> favor dentry/inode cache over page cache, unfortunately it does not =
help.
>>=20
>> Long story short, most of the long latency read op comes from file =
system
>> call (for cold data), as our workload mainly stores objects less than =
500KB,
>> so that it generates a large bunch of objects.
>>=20
>> I would like to ask if people experienced similar issue and if there =
is any
>> suggestion I can try to boost the GET performance. On the other hand, =
PUT
>> could be sacrificed.
>>=20
>> Thanks,
>> Guang
>>=20
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com


--Apple-Mail=_CCD8EF26-45BD-481D-9E82-02F5B2F956E5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="windows-1252"

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dwindows-1252"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;">Thanks =
Greg for the response, my comments =
inline=85<div><br></div><div>Thanks,</div><div>Guang</div><div><div><div>O=
n Feb 20, 2014, at 11:16 PM, Gregory Farnum &lt;<a =
href=3D"mailto:greg-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org">greg-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org</a>&gt; =
wrote:</div><br class=3D"Apple-interchange-newline"><blockquote =
type=3D"cite"><div style=3D"font-size: 14px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
line-height: normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px;">On Tue, Feb 18, 2014 at 7:24 AM, =
Guang Yang &lt;<a =
href=3D"mailto:yguang11-/E1597aS9LQAvxtiuMwx3w@public.gmane.org">yguang11-/E1597aS9LQAvxtiuMwx3w@public.gmane.org</a>&gt; =
wrote:<br><blockquote type=3D"cite">Hi ceph-users,<br>We are using Ceph =
(radosgw) to store user generated images, as GET latency<br>is critical =
for us, most recently I did some investigation over the GET path<br>to =
understand where time spend.<br><br>I first confirmed that the latency =
came from OSD (read op), so that we<br>instrumented code to trace the =
GET request (read op at OSD side, to be =
more<br>specific,<br></blockquote><br>How'd you instrument it? Are you =
aware of the OpTracker system that<br>records and can output important =
events?<br></div></blockquote>I just add some time measurement code =
before and after some calls, here is a the diff (I ported the lock =
contention fix to dumpling on my test, please ignore that) -&nbsp;<a =
href=3D"https://github.com/ceph/ceph/pull/1281/files">https://github.com/c=
eph/ceph/pull/1281/files</a></div><div>Yeah we are using OpTracker as =
well (dump history op), however, from the dumped history op, it is a =
little bit hard to tell where does the time spend (it is between started =
and finish). As read latency is critical for us, we would like to check =
next level details so that we add some checking for lock / file system =
call.<br><br>I am also thinking to refine the code more log to reflect =
where time spent at filestore side, are you interested in such type of =
code change? (it took me some time to trouble shoot the get latency and =
finally I need to add some more log to get a =
picture).<br><br><blockquote type=3D"cite"><div style=3D"font-size: =
14px; font-style: normal; font-variant: normal; font-weight: normal; =
letter-spacing: normal; line-height: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;"><blockquote type=3D"cite">each object with size [512K + 4M * x] =
&nbsp;are splitted into [1 + x]<br>chunks, each chunk needs one read op =
), for each read op, it needs to go<br>through the following =
steps:<br>&nbsp;&nbsp;&nbsp;1. Dispatch and take by a op thread to =
process (process not =
started).<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;0 &nbsp;&nbsp;- 20 ms, =
&nbsp;&nbsp;&nbsp;94%<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;20 - 50 ms, =
&nbsp;&nbsp;&nbsp;2%<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;50 - 100 ms, =
&nbsp;2%<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;100ms+ &nbsp;&nbsp;, =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2%<br>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;For those having 20ms+ latency, half of them =
are due to waiting for<br>pg lock (<a =
href=3D"https://github.com/ceph/ceph/blob/dumpling/src/osd/OSD.cc#L7089">h=
ttps://github.com/ceph/ceph/blob/dumpling/src/osd/OSD.cc#L7089</a>),<br>an=
other half are yet to be investigated.<br></blockquote><br>The PG lock =
conflict means that there's something else happening in<br>the PG at the =
same time; that's a logical contention issue. However,<br>20ms is a long =
time, so if you can figure out what else the PG is<br>doing during that =
time it'd be interesting<br></div></blockquote>I haven=92t deep dive =
that yet (that is a relatively small percentage comparing to the second =
part (which comes from filestore i/o slowness due to Dentry / inode =
cache), my interoperation is that as we serialize PG operation and there =
are some ops taking (like caused by the below), so that there is a =
chance the op are trying to operate on the same pg might wait for some =
time.</div><div>BTW, what is the long term strategy for Ceph to support =
small files (which motivated Facebook to build haystack to =
solve)?</div><div><br><blockquote type=3D"cite"><div style=3D"font-size: =
14px; font-style: normal; font-variant: normal; font-weight: normal; =
letter-spacing: normal; line-height: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;"><blockquote type=3D"cite"><br>&nbsp;&nbsp;&nbsp;2. Get file xattr =
('-'), which open the file and populate fd cache<br>(<a =
href=3D"https://github.com/ceph/ceph/blob/dumpling/src/os/FileStore.cc#L23=
0">https://github.com/ceph/ceph/blob/dumpling/src/os/FileStore.cc#L230</a>=
).<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;0 &nbsp;&nbsp;- 20 ms, =
&nbsp;80%<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;20 - 50 ms, =
&nbsp;&nbsp;8%<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;50 - 100 ms, =
7%<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;100ms+ &nbsp;&nbsp;, =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;5%<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;The latency either comes from (from more to less): file path =
lookup<br>(<a =
href=3D"https://github.com/ceph/ceph/blob/dumpling/src/os/HashIndex.cc#L29=
4">https://github.com/ceph/ceph/blob/dumpling/src/os/HashIndex.cc#L294</a>=
), file<br>open, or fd cache lookup =
/add.<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Currently =
objects are store in level 6 or level 7 folder (due to<br><a =
href=3D"http://tracker.ceph.com/issues/7207">http://tracker.ceph.com/issue=
s/7207</a>, I stopped folder splitting).<br></blockquote><br>FYI there's =
been some community and Inktank work to try and speed this<br>up =
recently. None of it's been merged into master yet, but =
we'll<br>definitely have some improvements to this =
post-Firefly.<br></div></blockquote>Yeah I am aware of that and we are =
extremely interested in the effort as well. Basically our use case =
is:</div><div>&nbsp; 1. Get latency is more critical than PUT =
latency.</div><div>&nbsp; 2. Our work load is mainly small files (95% =
are less than 512KB).&nbsp;<br><blockquote type=3D"cite"><div =
style=3D"font-size: 14px; font-style: normal; font-variant: normal; =
font-weight: normal; letter-spacing: normal; line-height: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;">-Greg<br>Software Engineer #42 @<span =
class=3D"Apple-converted-space">&nbsp;</span><a =
href=3D"http://inktank.com/">http://inktank.com</a><span =
class=3D"Apple-converted-space">&nbsp;</span>|<span =
class=3D"Apple-converted-space">&nbsp;</span><a =
href=3D"http://ceph.com/">http://ceph.com</a><br><br><blockquote =
type=3D"cite"><br>&nbsp;&nbsp;&nbsp;3. Get more xattrs, this is fast due =
to previous fd cache (rarely &gt;<br>1ms).<br><br>&nbsp;&nbsp;&nbsp;4. =
Read the =
data.<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;0 &nbsp;&nbsp;- 20 ms, =
&nbsp;&nbsp;84%<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;20 - 50 ms, =
10%<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;5=
0 - 100 ms, =
4%<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;10=
0ms+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;, 2%<br><br>I decreased =
vfs_cache_pressure from its default value 100 to 5 to make VFS<br>favor =
dentry/inode cache over page cache, unfortunately it does not =
help.<br><br>Long story short, most of the long latency read op comes =
from file system<br>call (for cold data), as our workload mainly stores =
objects less than 500KB,<br>so that it generates a large bunch of =
objects.<br><br>I would like to ask if people experienced similar issue =
and if there is any<br>suggestion I can try to boost the GET =
performance. On the other hand, PUT<br>could be =
sacrificed.<br><br>Thanks,<br>Guang<br><br>_______________________________=
________________<br>ceph-users mailing list<br><a =
href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><br=
><a =
href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com">http://lis=
ts.ceph.com/listinfo.cgi/ceph-users-ceph.com</a></blockquote></div></block=
quote></div><br></div></body></html>=

--Apple-Mail=_CCD8EF26-45BD-481D-9E82-02F5B2F956E5--

--===============1569966841==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1569966841==--
