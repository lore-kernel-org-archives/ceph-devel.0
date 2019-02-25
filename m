From: =?UTF-8?Q?Darius_Kasparavi=C4=8Dius?= <daznis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Ceph cluster stability
Date: Mon, 25 Feb 2019 13:23:48 +0200
Message-ID: <CANrNMwWbg56GDomsnFLyyN1=G5+m2GNWL0vYhNXF2zAUc=N36A@mail.gmail.com>
References: <CANA9Uk5YZYbq5EN40PX5vo55wPzjYLU+Oy9m8Hm-DRG-f1zxFw@mail.gmail.com>
 <CAN-Gep+H2sbh+LL4Pzj9-XVyvCnP+2m++1yFgErBQaWNH3fv=A@mail.gmail.com>
 <CANA9Uk5_FfQqEbZ7O3xp4PPy=cSYUwSf-xWVM6+5WnQO6YkqmQ@mail.gmail.com>
 <CANrNMwUVupc80VWW_OKbYnH1JzB9fKRJFB7q7wVgJH9MY8fB6w@mail.gmail.com>
 <CANA9Uk5p7so6BYrR+BMhN-qQv3BFnqJwW7cpNA-Xpqtu3mQFhg@mail.gmail.com>
 <CAN-GepJDYqs931SwNvevPPYLUnAcqWPc3oQUDLDeBVFVrWHZEw@mail.gmail.com>
 <CANA9Uk4_Ynn8+3BDWDiy5Pshv2u_cp90a=vGWwUxrJXS+Q-STQ@mail.gmail.com>
 <CAN-Gep+wy9axKNL26RUpCKy3S2uTxzOrSXq+bf=+zhsrGxAvCQ@mail.gmail.com>
 <CANA9Uk6rHoAtvAUGtW1VqZnXDz6EjaFOUfxmYUocChRe5mZwDw@mail.gmail.com>
 <CANrNMwUuODV3Ju+TxosZE0hM9qwAU1Rk0efST6QmzmWXW+hXFA@mail.gmail.com>
 <CANA9Uk6CFJnGXz-Bcwe7Cb9JMBFGw5rwd3xgFvyo9teCWoUcCQ@mail.gmail.com>
 <7B24D99C-9F31-401F-9455-8F7B0E013160@dreamsnake.net>
 <CANA9Uk7=gbKEpzrN7XAe71FD5M7Y+MgUi=FM1qNDc0Y_s6E6gA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3311485484403933173=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CANA9Uk7=gbKEpzrN7XAe71FD5M7Y+MgUi=FM1qNDc0Y_s6E6gA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, Anthony D'Atri <aad-lmG3kWHAawoohuQDye/k0w@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============3311485484403933173==
Content-Type: multipart/alternative; boundary="0000000000005004ae0582b62d24"

--0000000000005004ae0582b62d24
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I think this should give you a bit of isight on using large scale clusters.
https://www.youtube.com/watch?v=3DNdGHE-yq1gU and
https://www.youtube.com/watch?v=3DWpMzAFH6Mc4 . Watch the second video I
think it more relates to your problem.


On Mon, Feb 25, 2019, 11:33 M Ranga Swami Reddy <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
wrote:

> We have taken care all HW recommendations, but missing that ceph mons
> are VMs with good configuration (4 core, 64G RAM + 500G disk)...
> Is this ceph-mon configuration might cause issues?
>
> On Sat, Feb 23, 2019 at 6:31 AM Anthony D'Atri <aad-lmG3kWHAawoohuQDye/k0w@public.gmane.org> wrote=
:
> >
> >
> > ? Did we start recommending that production mons run on a VM?  I'd be
> very hesitant to do that, though probably some folks do.
> >
> > I can say for sure that in the past (Firefly) I experienced outages
> related to mons running on HDDs.  That was a cluster of 450 HDD OSDs with
> colo journals and hundreds of RBD clients.  Something obscure about runni=
ng
> out of "global IDs" and not being able to create new ones fast enough.  W=
e
> had to work around with a combo of lease settings on the mons and clients=
,
> though with Hammer and later I would not expect that exact situation to
> arise.  Still it left me paranoid about mon DBs and HDDs.
> >
> > -- aad
> >
> >
> > >
> > > But ceph recommendation is to use VM (not even the  HW node
> > > recommended). will try to change the mon disk as SSD and HW node.
> > >
> > > On Fri, Feb 22, 2019 at 5:25 PM Darius Kasparavi=C4=8Dius <daznis@gma=
il.com>
> wrote:
> > >>
> > >> If your using hdd for monitor servers. Check their load. It might be
> > >> the issue there.
> > >>
> > >> On Fri, Feb 22, 2019 at 1:50 PM M Ranga Swami Reddy
> > >> <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > >>>
> > >>> ceph-mon disk with 500G with HDD (not journals/SSDs).  Yes, mon use
> > >>> folder on FS on a disk
> > >>>
> > >>> On Fri, Feb 22, 2019 at 5:13 PM David Turner <drakonstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org=
>
> wrote:
> > >>>>
> > >>>> Mon disks don't have journals, they're just a folder on a
> filesystem on a disk.
> > >>>>
> > >>>> On Fri, Feb 22, 2019, 6:40 AM M Ranga Swami Reddy <
> swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > >>>>>
> > >>>>> ceph mons looks fine during the recovery.  Using  HDD with SSD
> > >>>>> journals. with recommeded CPU and RAM numbers.
> > >>>>>
> > >>>>> On Fri, Feb 22, 2019 at 4:40 PM David Turner <
> drakonstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > >>>>>>
> > >>>>>> What about the system stats on your mons during recovery? If the=
y
> are having a hard time keeping up with requests during a recovery, I coul=
d
> see that impacting client io. What disks are they running on? CPU? Etc.
> > >>>>>>
> > >>>>>> On Fri, Feb 22, 2019, 6:01 AM M Ranga Swami Reddy <
> swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > >>>>>>>
> > >>>>>>> Debug setting defaults are using..like 1/5 and 0/5 for almost..
> > >>>>>>> Shall I try with 0 for all debug settings?
> > >>>>>>>
> > >>>>>>> On Wed, Feb 20, 2019 at 9:17 PM Darius Kasparavi=C4=8Dius <
> daznis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > >>>>>>>>
> > >>>>>>>> Hello,
> > >>>>>>>>
> > >>>>>>>>
> > >>>>>>>> Check your CPU usage when you are doing those kind of
> operations. We
> > >>>>>>>> had a similar issue where our CPU monitoring was reporting fin=
e
> < 40%
> > >>>>>>>> usage, but our load on the nodes was high mid 60-80. If it's
> possible
> > >>>>>>>> try disabling ht and see the actual cpu usage.
> > >>>>>>>> If you are hitting CPU limits you can try disabling crc on
> messages.
> > >>>>>>>> ms_nocrc
> > >>>>>>>> ms_crc_data
> > >>>>>>>> ms_crc_header
> > >>>>>>>>
> > >>>>>>>> And setting all your debug messages to 0.
> > >>>>>>>> If you haven't done you can also lower your recovery settings =
a
> little.
> > >>>>>>>> osd recovery max active
> > >>>>>>>> osd max backfills
> > >>>>>>>>
> > >>>>>>>> You can also lower your file store threads.
> > >>>>>>>> filestore op threads
> > >>>>>>>>
> > >>>>>>>>
> > >>>>>>>> If you can also switch to bluestore from filestore. This will
> also
> > >>>>>>>> lower your CPU usage. I'm not sure that this is bluestore that
> does
> > >>>>>>>> it, but I'm seeing lower cpu usage when moving to bluestore +
> rocksdb
> > >>>>>>>> compared to filestore + leveldb .
> > >>>>>>>>
> > >>>>>>>>
> > >>>>>>>> On Wed, Feb 20, 2019 at 4:27 PM M Ranga Swami Reddy
> > >>>>>>>> <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > >>>>>>>>>
> > >>>>>>>>> Thats expected from Ceph by design. But in our case, we are
> using all
> > >>>>>>>>> recommendation like rack failure domain, replication n/w,etc,
> still
> > >>>>>>>>> face client IO performance issues during one OSD down..
> > >>>>>>>>>
> > >>>>>>>>> On Tue, Feb 19, 2019 at 10:56 PM David Turner <
> drakonstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > >>>>>>>>>>
> > >>>>>>>>>> With a RACK failure domain, you should be able to have an
> entire rack powered down without noticing any major impact on the clients=
.
> I regularly take down OSDs and nodes for maintenance and upgrades without
> seeing any problems with client IO.
> > >>>>>>>>>>
> > >>>>>>>>>> On Tue, Feb 12, 2019 at 5:01 AM M Ranga Swami Reddy <
> swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > >>>>>>>>>>>
> > >>>>>>>>>>> Hello - I have a couple of questions on ceph cluster
> stability, even
> > >>>>>>>>>>> we follow all recommendations as below:
> > >>>>>>>>>>> - Having separate replication n/w and data n/w
> > >>>>>>>>>>> - RACK is the failure domain
> > >>>>>>>>>>> - Using SSDs for journals (1:4ratio)
> > >>>>>>>>>>>
> > >>>>>>>>>>> Q1 - If one OSD down, cluster IO down drastically and
> customer Apps impacted.
> > >>>>>>>>>>> Q2 - what is stability ratio, like with above, is ceph
> cluster
> > >>>>>>>>>>> workable condition, if one osd down or one node down,etc.
> > >>>>>>>>>>>
> > >>>>>>>>>>> Thanks
> > >>>>>>>>>>> Swami
> > >>>>>>>>>>> _______________________________________________
> > >>>>>>>>>>> ceph-users mailing list
> > >>>>>>>>>>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> > >>>>>>>>>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> > >>>>>>>>> _______________________________________________
> > >>>>>>>>> ceph-users mailing list
> > >>>>>>>>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> > >>>>>>>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> >
>

--0000000000005004ae0582b62d24
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr">I think this should give=
 you a bit of isight on using large scale clusters.=C2=A0<a href=3D"https:/=
/www.youtube.com/watch?v=3DNdGHE-yq1gU">https://www.youtube.com/watch?v=3DN=
dGHE-yq1gU</a> and=C2=A0<a href=3D"https://www.youtube.com/watch?v=3DWpMzAF=
H6Mc4">https://www.youtube.com/watch?v=3DWpMzAFH6Mc4</a> . Watch the second=
 video I think it more relates to your problem.=C2=A0</div><div dir=3D"ltr"=
><br></div></div></div><div dir=3D"auto"></div><br><div class=3D"gmail_quot=
e"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Feb 25, 2019, 11:33 M Rang=
a Swami Reddy &lt;<a href=3D"mailto:swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank"=
>swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">We have taken care all HW recommendations, but missing=
 that ceph mons<br>
are VMs with good configuration (4 core, 64G RAM + 500G disk)...<br>
Is this ceph-mon configuration might cause issues?<br>
<br>
On Sat, Feb 23, 2019 at 6:31 AM Anthony D&#39;Atri &lt;<a href=3D"mailto:aa=
d@dreamsnake.net" rel=3D"noreferrer" target=3D"_blank">aad-lmG3kWHAawoohuQDye/k0w@public.gmane.org</=
a>&gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt; ? Did we start recommending that production mons run on a VM?=C2=A0 I&=
#39;d be very hesitant to do that, though probably some folks do.<br>
&gt;<br>
&gt; I can say for sure that in the past (Firefly) I experienced outages re=
lated to mons running on HDDs.=C2=A0 That was a cluster of 450 HDD OSDs wit=
h colo journals and hundreds of RBD clients.=C2=A0 Something obscure about =
running out of &quot;global IDs&quot; and not being able to create new ones=
 fast enough.=C2=A0 We had to work around with a combo of lease settings on=
 the mons and clients, though with Hammer and later I would not expect that=
 exact situation to arise.=C2=A0 Still it left me paranoid about mon DBs an=
d HDDs.<br>
&gt;<br>
&gt; -- aad<br>
&gt;<br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt; But ceph recommendation is to use VM (not even the=C2=A0 HW node<=
br>
&gt; &gt; recommended). will try to change the mon disk as SSD and HW node.=
<br>
&gt; &gt;<br>
&gt; &gt; On Fri, Feb 22, 2019 at 5:25 PM Darius Kasparavi=C4=8Dius &lt;<a =
href=3D"mailto:daznis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" rel=3D"noreferrer" target=3D"_blank">dazni=
s@gmail.com</a>&gt; wrote:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; If your using hdd for monitor servers. Check their load. It m=
ight be<br>
&gt; &gt;&gt; the issue there.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; On Fri, Feb 22, 2019 at 1:50 PM M Ranga Swami Reddy<br>
&gt; &gt;&gt; &lt;<a href=3D"mailto:swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" rel=3D"noreferrer=
" target=3D"_blank">swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; ceph-mon disk with 500G with HDD (not journals/SSDs).=C2=
=A0 Yes, mon use<br>
&gt; &gt;&gt;&gt; folder on FS on a disk<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; On Fri, Feb 22, 2019 at 5:13 PM David Turner &lt;<a href=
=3D"mailto:drakonstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" rel=3D"noreferrer" target=3D"_blank">drak=
onstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; Mon disks don&#39;t have journals, they&#39;re just a=
 folder on a filesystem on a disk.<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; On Fri, Feb 22, 2019, 6:40 AM M Ranga Swami Reddy &lt=
;<a href=3D"mailto:swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" rel=3D"noreferrer" target=3D"_blan=
k">swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; ceph mons looks fine during the recovery.=C2=A0 U=
sing=C2=A0 HDD with SSD<br>
&gt; &gt;&gt;&gt;&gt;&gt; journals. with recommeded CPU and RAM numbers.<br=
>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; On Fri, Feb 22, 2019 at 4:40 PM David Turner &lt;=
<a href=3D"mailto:drakonstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" rel=3D"noreferrer" target=3D"_blan=
k">drakonstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; What about the system stats on your mons duri=
ng recovery? If they are having a hard time keeping up with requests during=
 a recovery, I could see that impacting client io. What disks are they runn=
ing on? CPU? Etc.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; On Fri, Feb 22, 2019, 6:01 AM M Ranga Swami R=
eddy &lt;<a href=3D"mailto:swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" rel=3D"noreferrer" target=
=3D"_blank">swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; Debug setting defaults are using..like 1/=
5 and 0/5 for almost..<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; Shall I try with 0 for all debug settings=
?<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; On Wed, Feb 20, 2019 at 9:17 PM Darius Ka=
sparavi=C4=8Dius &lt;<a href=3D"mailto:daznis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" rel=3D"noreferrer"=
 target=3D"_blank">daznis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Hello,<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Check your CPU usage when you are doi=
ng those kind of operations. We<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; had a similar issue where our CPU mon=
itoring was reporting fine &lt; 40%<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; usage, but our load on the nodes was =
high mid 60-80. If it&#39;s possible<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; try disabling ht and see the actual c=
pu usage.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; If you are hitting CPU limits you can=
 try disabling crc on messages.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; ms_nocrc<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; ms_crc_data<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; ms_crc_header<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; And setting all your debug messages t=
o 0.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; If you haven&#39;t done you can also =
lower your recovery settings a little.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; osd recovery max active<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; osd max backfills<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; You can also lower your file store th=
reads.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; filestore op threads<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; If you can also switch to bluestore f=
rom filestore. This will also<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; lower your CPU usage. I&#39;m not sur=
e that this is bluestore that does<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; it, but I&#39;m seeing lower cpu usag=
e when moving to bluestore + rocksdb<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; compared to filestore + leveldb .<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; On Wed, Feb 20, 2019 at 4:27 PM M Ran=
ga Swami Reddy<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &lt;<a href=3D"mailto:swamireddy@gmai=
l.com" rel=3D"noreferrer" target=3D"_blank">swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wr=
ote:<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Thats expected from Ceph by desig=
n. But in our case, we are using all<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; recommendation like rack failure =
domain, replication n/w,etc, still<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; face client IO performance issues=
 during one OSD down..<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; On Tue, Feb 19, 2019 at 10:56 PM =
David Turner &lt;<a href=3D"mailto:drakonstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" rel=3D"noreferrer=
" target=3D"_blank">drakonstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; With a RACK failure domain, y=
ou should be able to have an entire rack powered down without noticing any =
major impact on the clients.=C2=A0 I regularly take down OSDs and nodes for=
 maintenance and upgrades without seeing any problems with client IO.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; On Tue, Feb 12, 2019 at 5:01 =
AM M Ranga Swami Reddy &lt;<a href=3D"mailto:swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" rel=3D"n=
oreferrer" target=3D"_blank">swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Hello - I have a couple o=
f questions on ceph cluster stability, even<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; we follow all recommendat=
ions as below:<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; - Having separate replica=
tion n/w and data n/w<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; - RACK is the failure dom=
ain<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; - Using SSDs for journals=
 (1:4ratio)<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Q1 - If one OSD down, clu=
ster IO down drastically and customer Apps impacted.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Q2 - what is stability ra=
tio, like with above, is ceph cluster<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; workable condition, if on=
e osd down or one node down,etc.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Thanks<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Swami<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; _________________________=
______________________<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; ceph-users mailing list<b=
r>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"mailto:ceph-us=
ers-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" rel=3D"noreferrer" target=3D"_blank">ceph-users@lists.c=
eph.com</a><br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"http://lists.c=
eph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"noreferrer noreferrer" tar=
get=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a><b=
r>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; _________________________________=
______________<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; ceph-users mailing list<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"mailto:ceph-users@list=
s.ceph.com" rel=3D"noreferrer" target=3D"_blank">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org<=
/a><br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"http://lists.ceph.com/=
listinfo.cgi/ceph-users-ceph.com" rel=3D"noreferrer noreferrer" target=3D"_=
blank">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a><br>
&gt;<br>
</blockquote></div>

--0000000000005004ae0582b62d24--

--===============3311485484403933173==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============3311485484403933173==--
