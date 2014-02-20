From: GuangYang <yguang11-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Ceph GET latency
Date: Thu, 20 Feb 2014 14:27:52 +0800
Message-ID: <BLU0-SMTP1702038AD1BFE1E25CCA4AADF9A0@phx.gbl>
References: <1392737074.11284.YahooMailNeo@web140905.mail.bf1.yahoo.com>
	<CABBk=J8M7HDZQ5DX6LPqHGB9u3aqS_SpTzMb1TZjor6W3x+3xw@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Content-Type: multipart/mixed; boundary="===============0415782301=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CABBk=J8M7HDZQ5DX6LPqHGB9u3aqS_SpTzMb1TZjor6W3x+3xw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Yehuda Sadeh <yehuda-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Cc: Ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, Ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0415782301==
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_7E147840-830C-46A3-B98B-D5C941CA7CB8"

--Apple-Mail=_7E147840-830C-46A3-B98B-D5C941CA7CB8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Thanks Yehuda.

>=20
> Try looking at the perfcounters, see if there's any other throttling
> happening. Also, make sure you have enough pgs for your data pool. One
> other thing to try is disabling leveldb xattrs and see if it affects
> your latency.
1. There is not throttling happening.
2. According to ceph recommendation, there is 100PGs per OSD and we bump =
that to 200.
3. Can you elaborate on the xattrs stuff, how could that affect the get =
latency?

Thanks,
Guang

On Feb 20, 2014, at 3:09 AM, Yehuda Sadeh <yehuda-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org> wrote:

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
>> specific, each object with size [512K + 4M * x]  are splitted into [1 =
+ x]
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
>=20
> Try looking at the perfcounters, see if there's any other throttling
> happening. Also, make sure you have enough pgs for your data pool. One
> other thing to try is disabling leveldb xattrs and see if it affects
> your latency.
>=20
> Yehuda


--Apple-Mail=_7E147840-830C-46A3-B98B-D5C941CA7CB8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="iso-8859-1"

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Diso-8859-1"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;">Thanks =
Yehuda.<div><br></div><div><blockquote type=3D"cite"><br>Try looking at =
the perfcounters, see if there's any other throttling<br>happening. =
Also, make sure you have enough pgs for your data pool. One<br>other =
thing to try is disabling leveldb xattrs and see if it affects<br>your =
latency.</blockquote>1. There is not throttling happening.</div><div>2. =
According to ceph recommendation, there is 100PGs per OSD and we bump =
that to 200.</div><div>3. Can you elaborate on the xattrs stuff, how =
could that affect the get =
latency?</div><div><br></div><div>Thanks,</div><div>Guang</div><div><br><d=
iv><div>On Feb 20, 2014, at 3:09 AM, Yehuda Sadeh &lt;<a =
href=3D"mailto:yehuda-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org">yehuda-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org</a>&gt; =
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
GET request (read op at OSD side, to be more<br>specific, each object =
with size [512K + 4M * x] &nbsp;are splitted into [1 + x]<br>chunks, =
each chunk needs one read op ), for each read op, it needs to =
go<br>through the following steps:<br>&nbsp;&nbsp;&nbsp;1. Dispatch and =
take by a op thread to process (process not =
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
other half are yet to be investigated.<br><br>&nbsp;&nbsp;&nbsp;2. Get =
file xattr ('-'), which open the file and populate fd cache<br>(<a =
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
s/7207</a>, I stopped folder splitting).<br><br>&nbsp;&nbsp;&nbsp;3. Get =
more xattrs, this is fast due to previous fd cache (rarely =
&gt;<br>1ms).<br><br>&nbsp;&nbsp;&nbsp;4. Read the =
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
sacrificed.<br><br></blockquote><br>Try looking at the perfcounters, see =
if there's any other throttling<br>happening. Also, make sure you have =
enough pgs for your data pool. One<br>other thing to try is disabling =
leveldb xattrs and see if it affects<br>your =
latency.<br><br>Yehuda</div></blockquote></div><br></div></body></html>=

--Apple-Mail=_7E147840-830C-46A3-B98B-D5C941CA7CB8--

--===============0415782301==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0415782301==--
