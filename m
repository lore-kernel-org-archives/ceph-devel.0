From: David Turner <drakonstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Ceph cluster stability
Date: Fri, 22 Feb 2019 06:43:42 -0500
Message-ID: <CAN-Gep+wy9axKNL26RUpCKy3S2uTxzOrSXq+bf=+zhsrGxAvCQ@mail.gmail.com>
References: <CANA9Uk5YZYbq5EN40PX5vo55wPzjYLU+Oy9m8Hm-DRG-f1zxFw@mail.gmail.com>
 <CAN-Gep+H2sbh+LL4Pzj9-XVyvCnP+2m++1yFgErBQaWNH3fv=A@mail.gmail.com>
 <CANA9Uk5_FfQqEbZ7O3xp4PPy=cSYUwSf-xWVM6+5WnQO6YkqmQ@mail.gmail.com>
 <CANrNMwUVupc80VWW_OKbYnH1JzB9fKRJFB7q7wVgJH9MY8fB6w@mail.gmail.com>
 <CANA9Uk5p7so6BYrR+BMhN-qQv3BFnqJwW7cpNA-Xpqtu3mQFhg@mail.gmail.com>
 <CAN-GepJDYqs931SwNvevPPYLUnAcqWPc3oQUDLDeBVFVrWHZEw@mail.gmail.com>
 <CANA9Uk4_Ynn8+3BDWDiy5Pshv2u_cp90a=vGWwUxrJXS+Q-STQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1902477026652385573=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CANA9Uk4_Ynn8+3BDWDiy5Pshv2u_cp90a=vGWwUxrJXS+Q-STQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

--===============1902477026652385573==
Content-Type: multipart/alternative; boundary="000000000000fcf8a805827a1a1d"

--000000000000fcf8a805827a1a1d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Mon disks don't have journals, they're just a folder on a filesystem on a
disk.

On Fri, Feb 22, 2019, 6:40 AM M Ranga Swami Reddy <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
wrote:

> ceph mons looks fine during the recovery.  Using  HDD with SSD
> journals. with recommeded CPU and RAM numbers.
>
> On Fri, Feb 22, 2019 at 4:40 PM David Turner <drakonstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> wrote:
> >
> > What about the system stats on your mons during recovery? If they are
> having a hard time keeping up with requests during a recovery, I could se=
e
> that impacting client io. What disks are they running on? CPU? Etc.
> >
> > On Fri, Feb 22, 2019, 6:01 AM M Ranga Swami Reddy <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org=
>
> wrote:
> >>
> >> Debug setting defaults are using..like 1/5 and 0/5 for almost..
> >> Shall I try with 0 for all debug settings?
> >>
> >> On Wed, Feb 20, 2019 at 9:17 PM Darius Kasparavi=C4=8Dius <daznis@gmai=
l.com>
> wrote:
> >> >
> >> > Hello,
> >> >
> >> >
> >> > Check your CPU usage when you are doing those kind of operations. We
> >> > had a similar issue where our CPU monitoring was reporting fine < 40=
%
> >> > usage, but our load on the nodes was high mid 60-80. If it's possibl=
e
> >> > try disabling ht and see the actual cpu usage.
> >> > If you are hitting CPU limits you can try disabling crc on messages.
> >> > ms_nocrc
> >> > ms_crc_data
> >> > ms_crc_header
> >> >
> >> > And setting all your debug messages to 0.
> >> > If you haven't done you can also lower your recovery settings a
> little.
> >> > osd recovery max active
> >> > osd max backfills
> >> >
> >> > You can also lower your file store threads.
> >> > filestore op threads
> >> >
> >> >
> >> > If you can also switch to bluestore from filestore. This will also
> >> > lower your CPU usage. I'm not sure that this is bluestore that does
> >> > it, but I'm seeing lower cpu usage when moving to bluestore + rocksd=
b
> >> > compared to filestore + leveldb .
> >> >
> >> >
> >> > On Wed, Feb 20, 2019 at 4:27 PM M Ranga Swami Reddy
> >> > <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >> > >
> >> > > Thats expected from Ceph by design. But in our case, we are using
> all
> >> > > recommendation like rack failure domain, replication n/w,etc, stil=
l
> >> > > face client IO performance issues during one OSD down..
> >> > >
> >> > > On Tue, Feb 19, 2019 at 10:56 PM David Turner <
> drakonstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >> > > >
> >> > > > With a RACK failure domain, you should be able to have an entire
> rack powered down without noticing any major impact on the clients.  I
> regularly take down OSDs and nodes for maintenance and upgrades without
> seeing any problems with client IO.
> >> > > >
> >> > > > On Tue, Feb 12, 2019 at 5:01 AM M Ranga Swami Reddy <
> swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >> > > >>
> >> > > >> Hello - I have a couple of questions on ceph cluster stability,
> even
> >> > > >> we follow all recommendations as below:
> >> > > >> - Having separate replication n/w and data n/w
> >> > > >> - RACK is the failure domain
> >> > > >> - Using SSDs for journals (1:4ratio)
> >> > > >>
> >> > > >> Q1 - If one OSD down, cluster IO down drastically and customer
> Apps impacted.
> >> > > >> Q2 - what is stability ratio, like with above, is ceph cluster
> >> > > >> workable condition, if one osd down or one node down,etc.
> >> > > >>
> >> > > >> Thanks
> >> > > >> Swami
> >> > > >> _______________________________________________
> >> > > >> ceph-users mailing list
> >> > > >> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> >> > > >> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> >> > > _______________________________________________
> >> > > ceph-users mailing list
> >> > > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> >> > > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--000000000000fcf8a805827a1a1d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Mon disks don&#39;t have journals, they&#39;re just a fol=
der on a filesystem on a disk.</div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Fri, Feb 22, 2019, 6:40 AM M Ranga Swami R=
eddy &lt;<a href=3D"mailto:swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex">ceph mons looks fine duri=
ng the recovery.=C2=A0 Using=C2=A0 HDD with SSD<br>
journals. with recommeded CPU and RAM numbers.<br>
<br>
On Fri, Feb 22, 2019 at 4:40 PM David Turner &lt;<a href=3D"mailto:drakonst=
ein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank" rel=3D"noreferrer">drakonstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</=
a>&gt; wrote:<br>
&gt;<br>
&gt; What about the system stats on your mons during recovery? If they are =
having a hard time keeping up with requests during a recovery, I could see =
that impacting client io. What disks are they running on? CPU? Etc.<br>
&gt;<br>
&gt; On Fri, Feb 22, 2019, 6:01 AM M Ranga Swami Reddy &lt;<a href=3D"mailt=
o:swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank" rel=3D"noreferrer">swamireddy@gma=
il.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; Debug setting defaults are using..like 1/5 and 0/5 for almost..<br=
>
&gt;&gt; Shall I try with 0 for all debug settings?<br>
&gt;&gt;<br>
&gt;&gt; On Wed, Feb 20, 2019 at 9:17 PM Darius Kasparavi=C4=8Dius &lt;<a h=
ref=3D"mailto:daznis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank" rel=3D"noreferrer">daznis=
@gmail.com</a>&gt; wrote:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Hello,<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Check your CPU usage when you are doing those kind of operati=
ons. We<br>
&gt;&gt; &gt; had a similar issue where our CPU monitoring was reporting fi=
ne &lt; 40%<br>
&gt;&gt; &gt; usage, but our load on the nodes was high mid 60-80. If it&#3=
9;s possible<br>
&gt;&gt; &gt; try disabling ht and see the actual cpu usage.<br>
&gt;&gt; &gt; If you are hitting CPU limits you can try disabling crc on me=
ssages.<br>
&gt;&gt; &gt; ms_nocrc<br>
&gt;&gt; &gt; ms_crc_data<br>
&gt;&gt; &gt; ms_crc_header<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; And setting all your debug messages to 0.<br>
&gt;&gt; &gt; If you haven&#39;t done you can also lower your recovery sett=
ings a little.<br>
&gt;&gt; &gt; osd recovery max active<br>
&gt;&gt; &gt; osd max backfills<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; You can also lower your file store threads.<br>
&gt;&gt; &gt; filestore op threads<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; If you can also switch to bluestore from filestore. This will=
 also<br>
&gt;&gt; &gt; lower your CPU usage. I&#39;m not sure that this is bluestore=
 that does<br>
&gt;&gt; &gt; it, but I&#39;m seeing lower cpu usage when moving to bluesto=
re + rocksdb<br>
&gt;&gt; &gt; compared to filestore + leveldb .<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; On Wed, Feb 20, 2019 at 4:27 PM M Ranga Swami Reddy<br>
&gt;&gt; &gt; &lt;<a href=3D"mailto:swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank"=
 rel=3D"noreferrer">swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt;&gt; &gt; &gt;<br>
&gt;&gt; &gt; &gt; Thats expected from Ceph by design. But in our case, we =
are using all<br>
&gt;&gt; &gt; &gt; recommendation like rack failure domain, replication n/w=
,etc, still<br>
&gt;&gt; &gt; &gt; face client IO performance issues during one OSD down..<=
br>
&gt;&gt; &gt; &gt;<br>
&gt;&gt; &gt; &gt; On Tue, Feb 19, 2019 at 10:56 PM David Turner &lt;<a hre=
f=3D"mailto:drakonstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank" rel=3D"noreferrer">dra=
konstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt;&gt; &gt; &gt; &gt;<br>
&gt;&gt; &gt; &gt; &gt; With a RACK failure domain, you should be able to h=
ave an entire rack powered down without noticing any major impact on the cl=
ients.=C2=A0 I regularly take down OSDs and nodes for maintenance and upgra=
des without seeing any problems with client IO.<br>
&gt;&gt; &gt; &gt; &gt;<br>
&gt;&gt; &gt; &gt; &gt; On Tue, Feb 12, 2019 at 5:01 AM M Ranga Swami Reddy=
 &lt;<a href=3D"mailto:swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank" rel=3D"noref=
errer">swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt;&gt; &gt; &gt; &gt;&gt;<br>
&gt;&gt; &gt; &gt; &gt;&gt; Hello - I have a couple of questions on ceph cl=
uster stability, even<br>
&gt;&gt; &gt; &gt; &gt;&gt; we follow all recommendations as below:<br>
&gt;&gt; &gt; &gt; &gt;&gt; - Having separate replication n/w and data n/w<=
br>
&gt;&gt; &gt; &gt; &gt;&gt; - RACK is the failure domain<br>
&gt;&gt; &gt; &gt; &gt;&gt; - Using SSDs for journals (1:4ratio)<br>
&gt;&gt; &gt; &gt; &gt;&gt;<br>
&gt;&gt; &gt; &gt; &gt;&gt; Q1 - If one OSD down, cluster IO down drastical=
ly and customer Apps impacted.<br>
&gt;&gt; &gt; &gt; &gt;&gt; Q2 - what is stability ratio, like with above, =
is ceph cluster<br>
&gt;&gt; &gt; &gt; &gt;&gt; workable condition, if one osd down or one node=
 down,etc.<br>
&gt;&gt; &gt; &gt; &gt;&gt;<br>
&gt;&gt; &gt; &gt; &gt;&gt; Thanks<br>
&gt;&gt; &gt; &gt; &gt;&gt; Swami<br>
&gt;&gt; &gt; &gt; &gt;&gt; _______________________________________________=
<br>
&gt;&gt; &gt; &gt; &gt;&gt; ceph-users mailing list<br>
&gt;&gt; &gt; &gt; &gt;&gt; <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" ta=
rget=3D"_blank" rel=3D"noreferrer">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><br>
&gt;&gt; &gt; &gt; &gt;&gt; <a href=3D"http://lists.ceph.com/listinfo.cgi/c=
eph-users-ceph.com" rel=3D"noreferrer noreferrer" target=3D"_blank">http://=
lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a><br>
&gt;&gt; &gt; &gt; _______________________________________________<br>
&gt;&gt; &gt; &gt; ceph-users mailing list<br>
&gt;&gt; &gt; &gt; <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_=
blank" rel=3D"noreferrer">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><br>
&gt;&gt; &gt; &gt; <a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users=
-ceph.com" rel=3D"noreferrer noreferrer" target=3D"_blank">http://lists.cep=
h.com/listinfo.cgi/ceph-users-ceph.com</a><br>
</blockquote></div>

--000000000000fcf8a805827a1a1d--

--===============1902477026652385573==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1902477026652385573==--
