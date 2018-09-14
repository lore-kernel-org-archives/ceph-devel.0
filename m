From: =?UTF-8?Q?Charles=2DFran=C3=A7ois_Natali?= <cf.natali-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: AsyncConnection seems to keep buffers allocated
 for longer than necessary
Date: Fri, 14 Sep 2018 21:19:34 +0100
Message-ID: <CAH_1eM25gSdgETbQ8OJjFCvxJsmP2F8+WCxri88sq_AUCHibgA@mail.gmail.com>
References: <CAH_1eM0U7Xb=is+GQJEBiiyzTP1bH9h9c=vdgXG3eE_9nTEUuw@mail.gmail.com>
 <CAJ4mKGY_rxY3wRrwuZQ0XTkMs7xGL9+itn11x1uAUKBGNWYvGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3263131270280440112=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAJ4mKGY_rxY3wRrwuZQ0XTkMs7xGL9+itn11x1uAUKBGNWYvGw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Gregory Farnum <gfarnum-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ceph Users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============3263131270280440112==
Content-Type: multipart/alternative; boundary="00000000000078b5a70575da8b19"

--00000000000078b5a70575da8b19
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Greg!
Will test and report back on Monday.

Cheers,

Charles


On Fri, 14 Sep 2018, 20:32 Gregory Farnum, <gfarnum-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> [Adding ceph-devel]
>
> On Fri, Sep 14, 2018 at 5:22 AM, Charles-Fran=C3=A7ois Natali
> <cf.natali-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > See
> >
> http://lists.ceph.com/pipermail/ceph-users-ceph.com/2018-September/029780=
.html
> > for the original thread.
> >
> > Here is a trivial reproducer not using any aio or dynamically allocated
> > memory to store the objects read.
> > It simply reads 20,000 1MB large objects sequentially: when run, instea=
d
> of
> > using a roughly fixed amount of memory, the RSS increases up to 400 MB.
> >
> > <code>
> > #include <assert.h>
> > #include <stdio.h>
> > #include <stdlib.h>
> > #include <string.h>
> > #include <rados/librados.h>
> >
> > #define SIZE 1000000
> >
> > void readobj(rados_ioctx_t* io, char objname[], unsigned long size) {
> >     static char data[SIZE];
> >     unsigned long bytes_read;
> >     int retval;
> >
> >     rados_read_op_t read_op =3D rados_create_read_op();
> >     rados_read_op_read(read_op, 0, size, data, &bytes_read, &retval);
> >     retval =3D rados_read_op_operate(read_op, *io, objname, 0);
> >     assert(retval =3D=3D 0);
> >     rados_release_read_op(read_op);
> > }
> >
> > int main() {
> >     rados_t cluster;
> >     rados_create(&cluster, "test");
> >     rados_conf_read_file(cluster, "/etc/ceph/ceph.conf");
> >     rados_connect(cluster);
> >
> >     rados_ioctx_t io;
> >     rados_ioctx_create(cluster, "test", &io);
> >
> >     char smallobj_name[16];
> >     int i;
> >     long long total_bytes_read =3D 0;
> >
> >     for (i =3D 0; i < 20000; i++) {
> >         sprintf(smallobj_name, "1mobj_%d", i);
> >         readobj(&io, smallobj_name, SIZE);
> >         readobj(&io, smallobj_name, 1);
> >
> >         total_bytes_read +=3D SIZE;
> >         printf("Read %s for total %lld\n", smallobj_name,
> total_bytes_read);
> >     }
> >
> >     return 0;
> > }
> > </code>
> >
> >
> > Running it under valgrind with --show-reachable=3Dyes shows where the
> problem
> > is:
> >
> > =3D=3D10253=3D=3D 423,755,776 bytes in 424 blocks are still reachable i=
n loss
> record
> > 882 of 882
> > =3D=3D10253=3D=3D    at 0x4C2FEA6: memalign (in
> > /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
> > =3D=3D10253=3D=3D    by 0x4C2FFB1: posix_memalign (in
> > /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
> > =3D=3D10253=3D=3D    by 0x57A3C06:
> ceph::buffer::create_aligned_in_mempool(unsigned
> > int, unsigned int, int) (in /usr/lib/ceph/libceph-common.so.0)
> > =3D=3D10253=3D=3D    by 0x5984B49: AsyncConnection::process() (in
> > /usr/lib/ceph/libceph-common.so.0)
> > =3D=3D10253=3D=3D    by 0x5994C97: EventCenter::process_events(int,
> > std::chrono::duration<unsigned long, std::ratio<1l, 1000000000l> >*) (i=
n
> > /usr/lib/ceph/libceph-common.so.0)
> > =3D=3D10253=3D=3D    by 0x5999817: ??? (in /usr/lib/ceph/libceph-common=
.so.0)
> > =3D=3D10253=3D=3D    by 0xE960C7F: ??? (in
> > /usr/lib/x86_64-linux-gnu/libstdc++.so.6.0.21)
> > =3D=3D10253=3D=3D    by 0xE6926B9: start_thread (pthread_create.c:333)
> > =3D=3D10253=3D=3D    by 0x52A041C: clone (clone.S:109)
> >
> > We can see that the memory is allocated in AsyncConnection::process,
> > precisely here:
> >
> https://github.com/ceph/ceph/blob/master/src/msg/async/AsyncConnection.cc=
#L614
> >
> > From my understanding - I have never read ceph code before, so my
> > understanding might be flawed - this code is allocating a buffer to sto=
re
> > the data contained in the message received from a ceph node and adding
> it to
> > a buffers list `data_buf`.
> > Note that this list of buffers is per AsyncConnection, that's important=
.
> >
> > Unfortunately, looking through the file shows that `data_buf` only gets
> > cleared here:
> >
> https://github.com/ceph/ceph/blob/master/src/msg/async/AsyncConnection.cc=
#L477
> > when it transitions to the STATE_OPEN_MESSAGE_HEADER state, IIUC only
> occurs
> > when it starts receiving a new CEPH_MSGR_TAG_MSG message.
> >
> > Which means that basically the following happens - the below is for a
> single
> > AsyncConnection:
> >
> > repeat:
> >    0. wait for message
> >    1. parse message header
> >    2. realize it's an CEPH_MSGR_TAG_MSG message (not a heartbeat, etc):
> > transition to STATE_OPEN_MESSAGE_HEADER
> >    3. clear all buffers
> > (
> https://github.com/ceph/ceph/blob/master/src/msg/async/AsyncConnection.cc=
#L477
> )
> >    4. start parsing message, allocate memory buffer
> > (
> https://github.com/ceph/ceph/blob/master/src/msg/async/AsyncConnection.cc=
#L614
> )
> >    ...
> >    n. done processing message
> >
> > Which means that the memory allocated when processing a message - at
> step 4
> > - is only released when a subsequent CEPH_MSGR_TAG_MSG message is
> received.
> > For a single connection that's not too bad - memory is just freed later
> than
> > it could, but with a large OSD pool, it adds up.
> > Our cluster is made of over 40 ceph OSDs, which results in around 400
> > connections. Which means that if reading for example 1MB objects, this
> > delayed freeing can use up to 400MB (1MB per connection), which is
> exactly
> > what we're seeing.
> >
> > It would also explains:
> > - why reading a small subset of objects over and over again doesn't
> result
> > in a memory increase: because they are distributed over few ceph OSDs,
> hence
> > use few connections
> > - the shape of the memory consumption over time: if it were a leak (eve=
n
> > with reachable objects), it would grow linearly, whereas we expect it t=
o
> > grow slower and slower as we've connected all ceph OSDs in the pool
> > - why interspersing small reads helps: if one does a large read follows
> by a
> > small read over the same connection, the large read buffer will be
> cleared
> > before the small read buffer is allocated
> >
> > The followingg is enough to keep the memory usage under control:
> > <diff>
> > --- a.c     2018-09-14 12:56:13.770350595 +0100
> > +++ b.c        2018-09-14 12:55:32.921856548 +0100
> > @@ -34,7 +34,6 @@
> >      for (i =3D 0; i < 20000; i++) {
> >          sprintf(smallobj_name, "1mobj_%d", i);
> >          readobj(&io, smallobj_name, SIZE);
> > +        readobj(&io, smallobj_name, 1);
> >
> >          total_bytes_read +=3D SIZE;
> >          printf("Read %s for total %lld\n", smallobj_name,
> > total_bytes_read);
> > </diff>
> >
> > Reading just 1 byte of the same object after having read the object wil=
l
> > make the AsyncConnection clear the buffer allocated for processing the
> large
> > read result, and allocate a tiny buffer for the 1 byte read result.
> >
> >
> > TLDR: It seems that the buffers allocated while processing a message in
> > AsyncConnection are not cleared when the message has been processed, bu=
t
> > only when a subsequent message is received, which yields to a significa=
nt
> > memory usage if there are many connections in use (objects stored on ma=
ny
> > different OSDs).
>
> Nice sleuthing! This does look correct to me. I've created a tracker
> issue (http://tracker.ceph.com/issues/35987) and pull request
> (https://github.com/ceph/ceph/pull/24111).
>
> If you wanted to try testing that branch (or cherry-picking the patch,
> if you're building it yourself) with your librados client to see if
> that resolves the issue, it'd be helpful! The packages should be
> available shortly from the dev branch repository (see
> http://docs.ceph.com/docs/master/install/get-packages/#add-ceph-developme=
nt
> ).
> -Greg
>
> >
> >
> > _______________________________________________
> > ceph-users mailing list
> > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> >
>

--00000000000078b5a70575da8b19
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Thanks Greg!<div dir=3D"auto">Will test and report back o=
n Monday.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Cheers,</div><=
div dir=3D"auto"><br></div><div dir=3D"auto">Charles</div><div dir=3D"auto"=
><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Fri, 14=
 Sep 2018, 20:32 Gregory Farnum, &lt;<a href=3D"mailto:gfarnum-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">=
gfarnum-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">[=
Adding ceph-devel]<br>
<br>
On Fri, Sep 14, 2018 at 5:22 AM, Charles-Fran=C3=A7ois Natali<br>
&lt;<a href=3D"mailto:cf.natali-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank" rel=3D"norefer=
rer">cf.natali-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt; See<br>
&gt; <a href=3D"http://lists.ceph.com/pipermail/ceph-users-ceph.com/2018-Se=
ptember/029780.html" rel=3D"noreferrer noreferrer" target=3D"_blank">http:/=
/lists.ceph.com/pipermail/ceph-users-ceph.com/2018-September/029780.html</a=
><br>
&gt; for the original thread.<br>
&gt;<br>
&gt; Here is a trivial reproducer not using any aio or dynamically allocate=
d<br>
&gt; memory to store the objects read.<br>
&gt; It simply reads 20,000 1MB large objects sequentially: when run, inste=
ad of<br>
&gt; using a roughly fixed amount of memory, the RSS increases up to 400 MB=
.<br>
&gt;<br>
&gt; &lt;code&gt;<br>
&gt; #include &lt;assert.h&gt;<br>
&gt; #include &lt;stdio.h&gt;<br>
&gt; #include &lt;stdlib.h&gt;<br>
&gt; #include &lt;string.h&gt;<br>
&gt; #include &lt;rados/librados.h&gt;<br>
&gt;<br>
&gt; #define SIZE 1000000<br>
&gt;<br>
&gt; void readobj(rados_ioctx_t* io, char objname[], unsigned long size) {<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0static char data[SIZE];<br>
&gt;=C2=A0 =C2=A0 =C2=A0unsigned long bytes_read;<br>
&gt;=C2=A0 =C2=A0 =C2=A0int retval;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0rados_read_op_t read_op =3D rados_create_read_op();=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0rados_read_op_read(read_op, 0, size, data, &amp;byt=
es_read, &amp;retval);<br>
&gt;=C2=A0 =C2=A0 =C2=A0retval =3D rados_read_op_operate(read_op, *io, objn=
ame, 0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0assert(retval =3D=3D 0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0rados_release_read_op(read_op);<br>
&gt; }<br>
&gt;<br>
&gt; int main() {<br>
&gt;=C2=A0 =C2=A0 =C2=A0rados_t cluster;<br>
&gt;=C2=A0 =C2=A0 =C2=A0rados_create(&amp;cluster, &quot;test&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0rados_conf_read_file(cluster, &quot;/etc/ceph/ceph.=
conf&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0rados_connect(cluster);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0rados_ioctx_t io;<br>
&gt;=C2=A0 =C2=A0 =C2=A0rados_ioctx_create(cluster, &quot;test&quot;, &amp;=
io);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0char smallobj_name[16];<br>
&gt;=C2=A0 =C2=A0 =C2=A0int i;<br>
&gt;=C2=A0 =C2=A0 =C2=A0long long total_bytes_read =3D 0;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; 20000; i++) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sprintf(smallobj_name, &quot;1mobj_%d=
&quot;, i);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0readobj(&amp;io, smallobj_name, SIZE)=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0readobj(&amp;io, smallobj_name, 1);<b=
r>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0total_bytes_read +=3D SIZE;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;Read %s for total %lld\n=
&quot;, smallobj_name, total_bytes_read);<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; }<br>
&gt; &lt;/code&gt;<br>
&gt;<br>
&gt;<br>
&gt; Running it under valgrind with --show-reachable=3Dyes shows where the =
problem<br>
&gt; is:<br>
&gt;<br>
&gt; =3D=3D10253=3D=3D 423,755,776 bytes in 424 blocks are still reachable =
in loss record<br>
&gt; 882 of 882<br>
&gt; =3D=3D10253=3D=3D=C2=A0 =C2=A0 at 0x4C2FEA6: memalign (in<br>
&gt; /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)<br>
&gt; =3D=3D10253=3D=3D=C2=A0 =C2=A0 by 0x4C2FFB1: posix_memalign (in<br>
&gt; /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)<br>
&gt; =3D=3D10253=3D=3D=C2=A0 =C2=A0 by 0x57A3C06: ceph::buffer::create_alig=
ned_in_mempool(unsigned<br>
&gt; int, unsigned int, int) (in /usr/lib/ceph/libceph-common.so.0)<br>
&gt; =3D=3D10253=3D=3D=C2=A0 =C2=A0 by 0x5984B49: AsyncConnection::process(=
) (in<br>
&gt; /usr/lib/ceph/libceph-common.so.0)<br>
&gt; =3D=3D10253=3D=3D=C2=A0 =C2=A0 by 0x5994C97: EventCenter::process_even=
ts(int,<br>
&gt; std::chrono::duration&lt;unsigned long, std::ratio&lt;1l, 1000000000l&=
gt; &gt;*) (in<br>
&gt; /usr/lib/ceph/libceph-common.so.0)<br>
&gt; =3D=3D10253=3D=3D=C2=A0 =C2=A0 by 0x5999817: ??? (in /usr/lib/ceph/lib=
ceph-common.so.0)<br>
&gt; =3D=3D10253=3D=3D=C2=A0 =C2=A0 by 0xE960C7F: ??? (in<br>
&gt; /usr/lib/x86_64-linux-gnu/libstdc++.so.6.0.21)<br>
&gt; =3D=3D10253=3D=3D=C2=A0 =C2=A0 by 0xE6926B9: start_thread (pthread_cre=
ate.c:333)<br>
&gt; =3D=3D10253=3D=3D=C2=A0 =C2=A0 by 0x52A041C: clone (clone.S:109)<br>
&gt;<br>
&gt; We can see that the memory is allocated in AsyncConnection::process,<b=
r>
&gt; precisely here:<br>
&gt; <a href=3D"https://github.com/ceph/ceph/blob/master/src/msg/async/Asyn=
cConnection.cc#L614" rel=3D"noreferrer noreferrer" target=3D"_blank">https:=
//github.com/ceph/ceph/blob/master/src/msg/async/AsyncConnection.cc#L614</a=
><br>
&gt;<br>
&gt; From my understanding - I have never read ceph code before, so my<br>
&gt; understanding might be flawed - this code is allocating a buffer to st=
ore<br>
&gt; the data contained in the message received from a ceph node and adding=
 it to<br>
&gt; a buffers list `data_buf`.<br>
&gt; Note that this list of buffers is per AsyncConnection, that&#39;s impo=
rtant.<br>
&gt;<br>
&gt; Unfortunately, looking through the file shows that `data_buf` only get=
s<br>
&gt; cleared here:<br>
&gt; <a href=3D"https://github.com/ceph/ceph/blob/master/src/msg/async/Asyn=
cConnection.cc#L477" rel=3D"noreferrer noreferrer" target=3D"_blank">https:=
//github.com/ceph/ceph/blob/master/src/msg/async/AsyncConnection.cc#L477</a=
><br>
&gt; when it transitions to the STATE_OPEN_MESSAGE_HEADER state, IIUC only =
occurs<br>
&gt; when it starts receiving a new CEPH_MSGR_TAG_MSG message.<br>
&gt;<br>
&gt; Which means that basically the following happens - the below is for a =
single<br>
&gt; AsyncConnection:<br>
&gt;<br>
&gt; repeat:<br>
&gt;=C2=A0 =C2=A0 0. wait for message<br>
&gt;=C2=A0 =C2=A0 1. parse message header<br>
&gt;=C2=A0 =C2=A0 2. realize it&#39;s an CEPH_MSGR_TAG_MSG message (not a h=
eartbeat, etc):<br>
&gt; transition to STATE_OPEN_MESSAGE_HEADER<br>
&gt;=C2=A0 =C2=A0 3. clear all buffers<br>
&gt; (<a href=3D"https://github.com/ceph/ceph/blob/master/src/msg/async/Asy=
ncConnection.cc#L477" rel=3D"noreferrer noreferrer" target=3D"_blank">https=
://github.com/ceph/ceph/blob/master/src/msg/async/AsyncConnection.cc#L477</=
a>)<br>
&gt;=C2=A0 =C2=A0 4. start parsing message, allocate memory buffer<br>
&gt; (<a href=3D"https://github.com/ceph/ceph/blob/master/src/msg/async/Asy=
ncConnection.cc#L614" rel=3D"noreferrer noreferrer" target=3D"_blank">https=
://github.com/ceph/ceph/blob/master/src/msg/async/AsyncConnection.cc#L614</=
a>)<br>
&gt;=C2=A0 =C2=A0 ...<br>
&gt;=C2=A0 =C2=A0 n. done processing message<br>
&gt;<br>
&gt; Which means that the memory allocated when processing a message - at s=
tep 4<br>
&gt; - is only released when a subsequent CEPH_MSGR_TAG_MSG message is rece=
ived.<br>
&gt; For a single connection that&#39;s not too bad - memory is just freed =
later than<br>
&gt; it could, but with a large OSD pool, it adds up.<br>
&gt; Our cluster is made of over 40 ceph OSDs, which results in around 400<=
br>
&gt; connections. Which means that if reading for example 1MB objects, this=
<br>
&gt; delayed freeing can use up to 400MB (1MB per connection), which is exa=
ctly<br>
&gt; what we&#39;re seeing.<br>
&gt;<br>
&gt; It would also explains:<br>
&gt; - why reading a small subset of objects over and over again doesn&#39;=
t result<br>
&gt; in a memory increase: because they are distributed over few ceph OSDs,=
 hence<br>
&gt; use few connections<br>
&gt; - the shape of the memory consumption over time: if it were a leak (ev=
en<br>
&gt; with reachable objects), it would grow linearly, whereas we expect it =
to<br>
&gt; grow slower and slower as we&#39;ve connected all ceph OSDs in the poo=
l<br>
&gt; - why interspersing small reads helps: if one does a large read follow=
s by a<br>
&gt; small read over the same connection, the large read buffer will be cle=
ared<br>
&gt; before the small read buffer is allocated<br>
&gt;<br>
&gt; The followingg is enough to keep the memory usage under control:<br>
&gt; &lt;diff&gt;<br>
&gt; --- a.c=C2=A0 =C2=A0 =C2=A02018-09-14 12:56:13.770350595 +0100<br>
&gt; +++ b.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 2018-09-14 12:55:32.921856548 +0100=
<br>
&gt; @@ -34,7 +34,6 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; 20000; i++) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sprintf(smallobj_name, &quot;1mobj_%=
d&quot;, i);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 readobj(&amp;io, smallobj_name, SIZE=
);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 readobj(&amp;io, smallobj_name, 1);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 total_bytes_read +=3D SIZE;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(&quot;Read %s for total %lld\=
n&quot;, smallobj_name,<br>
&gt; total_bytes_read);<br>
&gt; &lt;/diff&gt;<br>
&gt;<br>
&gt; Reading just 1 byte of the same object after having read the object wi=
ll<br>
&gt; make the AsyncConnection clear the buffer allocated for processing the=
 large<br>
&gt; read result, and allocate a tiny buffer for the 1 byte read result.<br=
>
&gt;<br>
&gt;<br>
&gt; TLDR: It seems that the buffers allocated while processing a message i=
n<br>
&gt; AsyncConnection are not cleared when the message has been processed, b=
ut<br>
&gt; only when a subsequent message is received, which yields to a signific=
ant<br>
&gt; memory usage if there are many connections in use (objects stored on m=
any<br>
&gt; different OSDs).<br>
<br>
Nice sleuthing! This does look correct to me. I&#39;ve created a tracker<br=
>
issue (<a href=3D"http://tracker.ceph.com/issues/35987" rel=3D"noreferrer n=
oreferrer" target=3D"_blank">http://tracker.ceph.com/issues/35987</a>) and =
pull request<br>
(<a href=3D"https://github.com/ceph/ceph/pull/24111" rel=3D"noreferrer nore=
ferrer" target=3D"_blank">https://github.com/ceph/ceph/pull/24111</a>).<br>
<br>
If you wanted to try testing that branch (or cherry-picking the patch,<br>
if you&#39;re building it yourself) with your librados client to see if<br>
that resolves the issue, it&#39;d be helpful! The packages should be<br>
available shortly from the dev branch repository (see<br>
<a href=3D"http://docs.ceph.com/docs/master/install/get-packages/#add-ceph-=
development" rel=3D"noreferrer noreferrer" target=3D"_blank">http://docs.ce=
ph.com/docs/master/install/get-packages/#add-ceph-development</a>).<br>
-Greg<br>
<br>
&gt;<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; ceph-users mailing list<br>
&gt; <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank" rel=3D"=
noreferrer">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><br>
&gt; <a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=
=3D"noreferrer noreferrer" target=3D"_blank">http://lists.ceph.com/listinfo=
.cgi/ceph-users-ceph.com</a><br>
&gt;<br>
</blockquote></div>

--00000000000078b5a70575da8b19--

--===============3263131270280440112==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============3263131270280440112==--
