From: David Turner <drakonstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Ceph cluster stability
Date: Fri, 22 Feb 2019 06:10:19 -0500
Message-ID: <CAN-GepJDYqs931SwNvevPPYLUnAcqWPc3oQUDLDeBVFVrWHZEw@mail.gmail.com>
References: <CANA9Uk5YZYbq5EN40PX5vo55wPzjYLU+Oy9m8Hm-DRG-f1zxFw@mail.gmail.com>
 <CAN-Gep+H2sbh+LL4Pzj9-XVyvCnP+2m++1yFgErBQaWNH3fv=A@mail.gmail.com>
 <CANA9Uk5_FfQqEbZ7O3xp4PPy=cSYUwSf-xWVM6+5WnQO6YkqmQ@mail.gmail.com>
 <CANrNMwUVupc80VWW_OKbYnH1JzB9fKRJFB7q7wVgJH9MY8fB6w@mail.gmail.com>
 <CANA9Uk5p7so6BYrR+BMhN-qQv3BFnqJwW7cpNA-Xpqtu3mQFhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7896716898528985112=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CANA9Uk5p7so6BYrR+BMhN-qQv3BFnqJwW7cpNA-Xpqtu3mQFhg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: M Ranga Swami Reddy <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============7896716898528985112==
Content-Type: multipart/alternative; boundary="0000000000009b79ff058279a388"

--0000000000009b79ff058279a388
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

What about the system stats on your mons during recovery? If they are
having a hard time keeping up with requests during a recovery, I could see
that impacting client io. What disks are they running on? CPU? Etc.

On Fri, Feb 22, 2019, 6:01 AM M Ranga Swami Reddy <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
wrote:

> Debug setting defaults are using..like 1/5 and 0/5 for almost..
> Shall I try with 0 for all debug settings?
>
> On Wed, Feb 20, 2019 at 9:17 PM Darius Kasparavi=C4=8Dius <daznis@gmail.c=
om>
> wrote:
> >
> > Hello,
> >
> >
> > Check your CPU usage when you are doing those kind of operations. We
> > had a similar issue where our CPU monitoring was reporting fine < 40%
> > usage, but our load on the nodes was high mid 60-80. If it's possible
> > try disabling ht and see the actual cpu usage.
> > If you are hitting CPU limits you can try disabling crc on messages.
> > ms_nocrc
> > ms_crc_data
> > ms_crc_header
> >
> > And setting all your debug messages to 0.
> > If you haven't done you can also lower your recovery settings a little.
> > osd recovery max active
> > osd max backfills
> >
> > You can also lower your file store threads.
> > filestore op threads
> >
> >
> > If you can also switch to bluestore from filestore. This will also
> > lower your CPU usage. I'm not sure that this is bluestore that does
> > it, but I'm seeing lower cpu usage when moving to bluestore + rocksdb
> > compared to filestore + leveldb .
> >
> >
> > On Wed, Feb 20, 2019 at 4:27 PM M Ranga Swami Reddy
> > <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > >
> > > Thats expected from Ceph by design. But in our case, we are using all
> > > recommendation like rack failure domain, replication n/w,etc, still
> > > face client IO performance issues during one OSD down..
> > >
> > > On Tue, Feb 19, 2019 at 10:56 PM David Turner <drakonstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> wrote:
> > > >
> > > > With a RACK failure domain, you should be able to have an entire
> rack powered down without noticing any major impact on the clients.  I
> regularly take down OSDs and nodes for maintenance and upgrades without
> seeing any problems with client IO.
> > > >
> > > > On Tue, Feb 12, 2019 at 5:01 AM M Ranga Swami Reddy <
> swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > > >>
> > > >> Hello - I have a couple of questions on ceph cluster stability, ev=
en
> > > >> we follow all recommendations as below:
> > > >> - Having separate replication n/w and data n/w
> > > >> - RACK is the failure domain
> > > >> - Using SSDs for journals (1:4ratio)
> > > >>
> > > >> Q1 - If one OSD down, cluster IO down drastically and customer App=
s
> impacted.
> > > >> Q2 - what is stability ratio, like with above, is ceph cluster
> > > >> workable condition, if one osd down or one node down,etc.
> > > >>
> > > >> Thanks
> > > >> Swami
> > > >> _______________________________________________
> > > >> ceph-users mailing list
> > > >> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> > > >> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> > > _______________________________________________
> > > ceph-users mailing list
> > > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> > > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--0000000000009b79ff058279a388
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">What about the system stats on your mons during recovery?=
 If they are having a hard time keeping up with requests during a recovery,=
 I could see that impacting client io. What disks are they running on? CPU?=
 Etc.</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_a=
ttr">On Fri, Feb 22, 2019, 6:01 AM M Ranga Swami Reddy &lt;<a href=3D"mailt=
o:swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">Debug setting defaults are using..like 1/5 and 0/5=
 for almost..<br>
Shall I try with 0 for all debug settings?<br>
<br>
On Wed, Feb 20, 2019 at 9:17 PM Darius Kasparavi=C4=8Dius &lt;<a href=3D"ma=
ilto:daznis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank" rel=3D"noreferrer">daznis-Re5JQEeQqe8@public.gmane.org=
m</a>&gt; wrote:<br>
&gt;<br>
&gt; Hello,<br>
&gt;<br>
&gt;<br>
&gt; Check your CPU usage when you are doing those kind of operations. We<b=
r>
&gt; had a similar issue where our CPU monitoring was reporting fine &lt; 4=
0%<br>
&gt; usage, but our load on the nodes was high mid 60-80. If it&#39;s possi=
ble<br>
&gt; try disabling ht and see the actual cpu usage.<br>
&gt; If you are hitting CPU limits you can try disabling crc on messages.<b=
r>
&gt; ms_nocrc<br>
&gt; ms_crc_data<br>
&gt; ms_crc_header<br>
&gt;<br>
&gt; And setting all your debug messages to 0.<br>
&gt; If you haven&#39;t done you can also lower your recovery settings a li=
ttle.<br>
&gt; osd recovery max active<br>
&gt; osd max backfills<br>
&gt;<br>
&gt; You can also lower your file store threads.<br>
&gt; filestore op threads<br>
&gt;<br>
&gt;<br>
&gt; If you can also switch to bluestore from filestore. This will also<br>
&gt; lower your CPU usage. I&#39;m not sure that this is bluestore that doe=
s<br>
&gt; it, but I&#39;m seeing lower cpu usage when moving to bluestore + rock=
sdb<br>
&gt; compared to filestore + leveldb .<br>
&gt;<br>
&gt;<br>
&gt; On Wed, Feb 20, 2019 at 4:27 PM M Ranga Swami Reddy<br>
&gt; &lt;<a href=3D"mailto:swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank" rel=3D"n=
oreferrer">swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; Thats expected from Ceph by design. But in our case, we are using=
 all<br>
&gt; &gt; recommendation like rack failure domain, replication n/w,etc, sti=
ll<br>
&gt; &gt; face client IO performance issues during one OSD down..<br>
&gt; &gt;<br>
&gt; &gt; On Tue, Feb 19, 2019 at 10:56 PM David Turner &lt;<a href=3D"mail=
to:drakonstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank" rel=3D"noreferrer">drakonstein@=
gmail.com</a>&gt; wrote:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; With a RACK failure domain, you should be able to have an en=
tire rack powered down without noticing any major impact on the clients.=C2=
=A0 I regularly take down OSDs and nodes for maintenance and upgrades witho=
ut seeing any problems with client IO.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; On Tue, Feb 12, 2019 at 5:01 AM M Ranga Swami Reddy &lt;<a h=
ref=3D"mailto:swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank" rel=3D"noreferrer">sw=
amireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;&gt; Hello - I have a couple of questions on ceph cluster sta=
bility, even<br>
&gt; &gt; &gt;&gt; we follow all recommendations as below:<br>
&gt; &gt; &gt;&gt; - Having separate replication n/w and data n/w<br>
&gt; &gt; &gt;&gt; - RACK is the failure domain<br>
&gt; &gt; &gt;&gt; - Using SSDs for journals (1:4ratio)<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;&gt; Q1 - If one OSD down, cluster IO down drastically and cu=
stomer Apps impacted.<br>
&gt; &gt; &gt;&gt; Q2 - what is stability ratio, like with above, is ceph c=
luster<br>
&gt; &gt; &gt;&gt; workable condition, if one osd down or one node down,etc=
.<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;&gt; Thanks<br>
&gt; &gt; &gt;&gt; Swami<br>
&gt; &gt; &gt;&gt; _______________________________________________<br>
&gt; &gt; &gt;&gt; ceph-users mailing list<br>
&gt; &gt; &gt;&gt; <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_=
blank" rel=3D"noreferrer">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><br>
&gt; &gt; &gt;&gt; <a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users=
-ceph.com" rel=3D"noreferrer noreferrer" target=3D"_blank">http://lists.cep=
h.com/listinfo.cgi/ceph-users-ceph.com</a><br>
&gt; &gt; _______________________________________________<br>
&gt; &gt; ceph-users mailing list<br>
&gt; &gt; <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank" re=
l=3D"noreferrer">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><br>
&gt; &gt; <a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com=
" rel=3D"noreferrer noreferrer" target=3D"_blank">http://lists.ceph.com/lis=
tinfo.cgi/ceph-users-ceph.com</a><br>
</blockquote></div>

--0000000000009b79ff058279a388--

--===============7896716898528985112==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============7896716898528985112==--
