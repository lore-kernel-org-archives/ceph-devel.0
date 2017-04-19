From: Aaron Ten Clay <aarontc-q67U1YB0R7xBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Extremely high OSD memory utilization on Kraken
 11.2.0 (with XFS -or- bluestore)
Date: Wed, 19 Apr 2017 16:18:55 -0700
Message-ID: <CAFFcurrA8BKF0a+9gdGAsTDbE78ci9X8dwEaWEycoF4DNQN8uw@mail.gmail.com>
References: <CAFFcurqEctQ2fHHDcGYfy3YCuaq9DxZr0VU4e8dNVACNVLDmqA@mail.gmail.com>
	<alpine.DEB.2.11.1704171457320.10661@piezo.novalocal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0968108704=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1704171457320.10661-qHenpvqtifaMSRpgCs4c+g@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============0968108704==
Content-Type: multipart/alternative; boundary=001a1134f8a48d484c054d8d3fa2

--001a1134f8a48d484c054d8d3fa2
Content-Type: text/plain; charset=UTF-8

I'm new to doing this all via systemd and systemd-coredump, but I appear to
have gotten cores from two OSD processes. When xzipped they are < 2MIB
each, but I threw them on my webserver to avoid polluting the mailing list.
This seems oddly small, so if I've botched the process somehow let me know
:)

https://aarontc.com/ceph/dumps/core.ceph-osd.150.082e9ca887c34cfbab183366a214a84c.6742.1492634493000000000000.xz
https://aarontc.com/ceph/dumps/core.ceph-osd.150.082e9ca887c34cfbab183366a214a84c.7202.1492634508000000000000.xz

And for reference:
root@osd001:/var/lib/systemd/coredump# ceph -v
ceph version 11.2.0 (f223e27eeb35991352ebc1f67423d4ebc252adb7)


I am also investigating sysdig as recommended.

Thanks!
-Aaron


On Mon, Apr 17, 2017 at 8:15 AM, Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org> wrote:

> On Sat, 15 Apr 2017, Aaron Ten Clay wrote:
> > Hi all,
> >
> > Our cluster is experiencing a very odd issue and I'm hoping for some
> > guidance on troubleshooting steps and/or suggestions to mitigate the
> issue.
> > tl;dr: Individual ceph-osd processes try to allocate > 90GiB of RAM and
> are
> > eventually nuked by oom_killer.
>
> My guess is that there there is a bug in a decoding path and it's
> trying to allocate some huge amount of memory.  Can you try setting a
> memory ulimit to something like 40gb and then enabling core dumps so you
> can get a core?  Something like
>
> ulimit -c unlimited
> ulimit -m 20000000
>
> or whatever the corresponding systemd unit file options are...
>
> Once we have a core file it will hopefully be clear who is
> doing the bad allocation...
>
> sage
>
>
>
> >
> > I'll try to explain the situation in detail:
> >
> > We have 24-4TB bluestore HDD OSDs, and 4-600GB SSD OSDs. The SSD OSDs
> are in
> > a different CRUSH "root", used as a cache tier for the main storage
> pools,
> > which are erasure coded and used for cephfs. The OSDs are spread across
> two
> > identical machines with 128GiB of RAM each, and there are three monitor
> > nodes on different hardware.
> >
> > Several times we've encountered crippling bugs with previous Ceph
> releases
> > when we were on RC or betas, or using non-recommended configurations, so
> in
> > January we abandoned all previous Ceph usage, deployed LTS Ubuntu 16.04,
> and
> > went with stable Kraken 11.2.0 with the configuration mentioned above.
> > Everything was fine until the end of March, when one day we find all but
> a
> > couple of OSDs are "down" inexplicably. Investigation reveals oom_killer
> > came along and nuked almost all the ceph-osd processes.
> >
> > We've gone through a bunch of iterations of restarting the OSDs, trying
> to
> > bring them up one at a time gradually, all at once, various configuration
> > settings to reduce cache size as suggested in this ticket:
> > http://tracker.ceph.com/issues/18924...
> >
> > I don't know if that ticket really pertains to our situation or not, I
> have
> > no experience with memory allocation debugging. I'd be willing to try if
> > someone can point me to a guide or walk me through the process.
> >
> > I've even tried, just to see if the situation was  transitory, adding
> over
> > 300GiB of swap to both OSD machines. The OSD procs managed to allocate,
> in a
> > matter of 5-10 minutes, more than 300GiB of RAM pressure and became
> > oom_killer victims once again.
> >
> > No software or hardware changes took place around the time this problem
> > started, and no significant data changes occurred either. We added about
> > 40GiB of ~1GiB files a week or so before the problem started and that's
> the
> > last time data was written.
> >
> > I can only assume we've found another crippling bug of some kind, this
> level
> > of memory usage is entirely unprecedented. What can we do?
> >
> > Thanks in advance for any suggestions.
> > -Aaron
> >
> >
>



-- 
Aaron Ten Clay
https://aarontc.com

--001a1134f8a48d484c054d8d3fa2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>I&#39;m new to doing this all via systemd and sy=
stemd-coredump, but I appear to have gotten cores from two OSD processes. W=
hen xzipped they are &lt; 2MIB each, but I threw them on my webserver to av=
oid polluting the mailing list. This seems oddly small, so if I&#39;ve botc=
hed the process somehow let me know :)<br><br></div><a href=3D"https://aaro=
ntc.com/ceph/dumps/core.ceph-osd.150.082e9ca887c34cfbab183366a214a84c.6742.=
1492634493000000000000.xz">https://aarontc.com/ceph/dumps/core.ceph-osd.150=
.082e9ca887c34cfbab183366a214a84c.6742.1492634493000000000000.xz</a><br></d=
iv><a href=3D"https://aarontc.com/ceph/dumps/core.ceph-osd.150.082e9ca887c3=
4cfbab183366a214a84c.7202.1492634508000000000000.xz">https://aarontc.com/ce=
ph/dumps/core.ceph-osd.150.082e9ca887c34cfbab183366a214a84c.7202.1492634508=
000000000000.xz</a><br><br><div><div></div><div>And for reference:<br>root@=
osd001:/var/lib/systemd/coredump# ceph -v<br>ceph version 11.2.0 (f223e27ee=
b35991352ebc1f67423d4ebc252adb7)<br><br><br></div><div>I am also investigat=
ing sysdig as recommended.<br></div><div><br></div><div>Thanks!<br></div><d=
iv>-Aaron<br></div><div><br></div></div></div><div class=3D"gmail_extra"><b=
r><div class=3D"gmail_quote">On Mon, Apr 17, 2017 at 8:15 AM, Sage Weil <sp=
an dir=3D"ltr">&lt;<a href=3D"mailto:sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org" target=3D"_blank">s=
age-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><s=
pan class=3D"">On Sat, 15 Apr 2017, Aaron Ten Clay wrote:<br>
&gt; Hi all,<br>
&gt;<br>
&gt; Our cluster is experiencing a very odd issue and I&#39;m hoping for so=
me<br>
&gt; guidance on troubleshooting steps and/or suggestions to mitigate the i=
ssue.<br>
&gt; tl;dr: Individual ceph-osd processes try to allocate &gt; 90GiB of RAM=
 and are<br>
&gt; eventually nuked by oom_killer.<br>
<br>
</span>My guess is that there there is a bug in a decoding path and it&#39;=
s<br>
trying to allocate some huge amount of memory.=C2=A0 Can you try setting a<=
br>
memory ulimit to something like 40gb and then enabling core dumps so you<br=
>
can get a core?=C2=A0 Something like<br>
<br>
ulimit -c unlimited<br>
ulimit -m 20000000<br>
<br>
or whatever the corresponding systemd unit file options are...<br>
<br>
Once we have a core file it will hopefully be clear who is<br>
doing the bad allocation...<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
sage<br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5"><br>
<br>
<br>
&gt;<br>
&gt; I&#39;ll try to explain the situation in detail:<br>
&gt;<br>
&gt; We have 24-4TB bluestore HDD OSDs, and 4-600GB SSD OSDs. The SSD OSDs =
are in<br>
&gt; a different CRUSH &quot;root&quot;, used as a cache tier for the main =
storage pools,<br>
&gt; which are erasure coded and used for cephfs. The OSDs are spread acros=
s two<br>
&gt; identical machines with 128GiB of RAM each, and there are three monito=
r<br>
&gt; nodes on different hardware.<br>
&gt;<br>
&gt; Several times we&#39;ve encountered crippling bugs with previous Ceph =
releases<br>
&gt; when we were on RC or betas, or using non-recommended configurations, =
so in<br>
&gt; January we abandoned all previous Ceph usage, deployed LTS Ubuntu 16.0=
4, and<br>
&gt; went with stable Kraken 11.2.0 with the configuration mentioned above.=
<br>
&gt; Everything was fine until the end of March, when one day we find all b=
ut a<br>
&gt; couple of OSDs are &quot;down&quot; inexplicably. Investigation reveal=
s oom_killer<br>
&gt; came along and nuked almost all the ceph-osd processes.<br>
&gt;<br>
&gt; We&#39;ve gone through a bunch of iterations of restarting the OSDs, t=
rying to<br>
&gt; bring them up one at a time gradually, all at once, various configurat=
ion<br>
&gt; settings to reduce cache size as suggested in this ticket:<br>
&gt; <a href=3D"http://tracker.ceph.com/issues/18924." rel=3D"noreferrer" t=
arget=3D"_blank">http://tracker.ceph.com/<wbr>issues/18924.</a>..<br>
&gt;<br>
&gt; I don&#39;t know if that ticket really pertains to our situation or no=
t, I have<br>
&gt; no experience with memory allocation debugging. I&#39;d be willing to =
try if<br>
&gt; someone can point me to a guide or walk me through the process.<br>
&gt;<br>
&gt; I&#39;ve even tried, just to see if the situation was=C2=A0 transitory=
, adding over<br>
&gt; 300GiB of swap to both OSD machines. The OSD procs managed to allocate=
, in a<br>
&gt; matter of 5-10 minutes, more than 300GiB of RAM pressure and became<br=
>
&gt; oom_killer victims once again.<br>
&gt;<br>
&gt; No software or hardware changes took place around the time this proble=
m<br>
&gt; started, and no significant data changes occurred either. We added abo=
ut<br>
&gt; 40GiB of ~1GiB files a week or so before the problem started and that&=
#39;s the<br>
&gt; last time data was written.<br>
&gt;<br>
&gt; I can only assume we&#39;ve found another crippling bug of some kind, =
this level<br>
&gt; of memory usage is entirely unprecedented. What can we do?<br>
&gt;<br>
&gt; Thanks in advance for any suggestions.<br>
&gt; -Aaron<br>
&gt;<br>
&gt; </div></div></blockquote></div><br><br clear=3D"all"><br>-- <br><div c=
lass=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr=
"><div>Aaron Ten Clay<br><a href=3D"https://aarontc.com/" target=3D"_blank"=
>https://aarontc.com</a><br></div></div></div>
</div>

--001a1134f8a48d484c054d8d3fa2--

--===============0968108704==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0968108704==--
