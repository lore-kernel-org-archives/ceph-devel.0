From: Azad Aliyar <azad.aliyar-tQhtAXQzQEb0d+JFtaHRRQ@public.gmane.org>
Subject: Re: Ceph BIG outage : 200+ OSD are down ,
 OSD cannot create thread
Date: Mon, 9 Mar 2015 16:20:24 +0530
Message-ID: <CAAkXHpZObcWC920-eNoACZC63Qi=_DzmKVKypT2JPFUK_LRh=Q@mail.gmail.com>
References: <465F1943-32F1-4759-A713-3A5EB8B88E91@csc.fi>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0855105827=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <465F1943-32F1-4759-A713-3A5EB8B88E91-Gn+qtVAUx6s@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Karan Singh <karan.singh-Gn+qtVAUx6s@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============0855105827==
Content-Type: multipart/alternative; boundary=047d7bdc12b05ae7090510d8ce79

--047d7bdc12b05ae7090510d8ce79
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

*Check Max Threadcount:* If you have a node with a lot of OSDs, you may be
hitting the default maximum number of threads (e.g., usually 32k),
especially during recovery. You can increase the number of threads using
sysctl to see if increasing the maximum number of threads to the maximum
possible number of threads allowed (i.e., 4194303) will help. For example:

sysctl -w kernel.pid_max=3D4194303

 If increasing the maximum thread count resolves the issue, you can make it
permanent by including a kernel.pid_max setting in the /etc/sysctl.conf
file. For example:

kernel.pid_max =3D 4194303


On Mon, Mar 9, 2015 at 4:11 PM, Karan Singh <karan.singh-Gn+qtVAUx6s@public.gmane.org> wrote:

> Hello Community need help to fix a long going Ceph problem.
>
> Cluster is unhealthy , Multiple OSDs are DOWN. When i am trying to restar=
t
> OSD=E2=80=99s i am getting this error
>
>
> *2015-03-09 12:22:16.312774 7f760dac9700 -1 common/Thread.cc
> <http://Thread.cc>: In function 'void Thread::create(size_t)' thread
> 7f760dac9700 time 2015-03-09 12:22:16.311970*
> *common/Thread.cc <http://Thread.cc>: 129: FAILED assert(ret =3D=3D 0)*
>
>
> *Environment *:  4 Nodes , OSD+Monitor , Firefly latest , CentOS6.5 ,
> 3.17.2-1.el6.elrepo.x86_64
>
> Tried upgrading from 0.80.7 to 0.80.8  but no Luck
>
> Tried centOS stock kernel 2.6.32  but no Luck
>
> Memory is not a problem more then 150+GB is free
>
>
> Did any one every faced this problem ??
>
> *Cluster status *
>
>  *  cluster 2bd3283d-67ef-4316-8b7e-d8f4747eae33*
> *     health HEALTH_WARN 7334 pgs degraded; 1185 pgs down; 1 pgs
> incomplete; 1735 pgs peering; 8938 pgs stale; 1*
> *736 pgs stuck inactive; 8938 pgs stuck stale; 10320 pgs stuck unclean;
> recovery 6061/31080 objects degraded (19*
> *.501%); 111/196 in osds are down; clock skew detected on mon.pouta-s02,
> mon.pouta-s03*
> *     monmap e3: 3 mons at
> {pouta-s01=3D10.XXX.50.1:6789/0,pouta-s02=3D10.XXX.50.2:6789/0,pouta-s03=
=3D10.XXX.50.3:6789*
> */0}, election epoch 1312, quorum 0,1,2 pouta-s01,pouta-s02,pouta-s03*
> *     osdmap e26633: 239 osds: 85 up, 196 in*
> *      pgmap v60389: 17408 pgs, 13 pools, 42345 MB data, 10360 objects*
> *            4699 GB used, 707 TB / 711 TB avail*
> *            6061/31080 objects degraded (19.501%)*
> *                  14 down+remapped+peering*
> *                  39 active*
> *                3289 active+clean*
> *                 547 peering*
> *                 663 stale+down+peering*
> *                 705 stale+active+remapped*
> *                   1 active+degraded+remapped*
> *                   1 stale+down+incomplete*
> *                 484 down+peering*
> *                 455 active+remapped*
> *                3696 stale+active+degraded*
> *                   4 remapped+peering*
> *                  23 stale+down+remapped+peering*
> *                  51 stale+active*
> *                3637 active+degraded*
> *                3799 stale+active+clean*
>
> *OSD :  Logs *
>
> *2015-03-09 12:22:16.312774 7f760dac9700 -1 common/Thread.cc
> <http://Thread.cc>: In function 'void Thread::create(size_t)' thread
> 7f760dac9700 time 2015-03-09 12:22:16.311970*
> *common/Thread.cc <http://Thread.cc>: 129: FAILED assert(ret =3D=3D 0)*
>
> * ceph version 0.80.8 (69eaad7f8308f21573c604f121956e64679a52a7)*
> * 1: (Thread::create(unsigned long)+0x8a) [0xaf41da]*
> * 2: (SimpleMessenger::add_accept_pipe(int)+0x6a) [0xae84fa]*
> * 3: (Accepter::entry()+0x265) [0xb5c635]*
> * 4: /lib64/libpthread.so.0() [0x3c8a6079d1]*
> * 5: (clone()+0x6d) [0x3c8a2e89dd]*
> * NOTE: a copy of the executable, or `objdump -rdS <executable>` is neede=
d
> to interpret this.*
>
>
> *More information at Ceph Tracker Issue :  *
> http://tracker.ceph.com/issues/10988#change-49018
>
>
> ****************************************************************
> Karan Singh
> Systems Specialist , Storage Platforms
> CSC - IT Center for Science,
> Keilaranta 14, P. O. Box 405, FIN-02101 Espoo, Finland
> mobile: +358 503 812758
> tel. +358 9 4572001
> fax +358 9 4572302
> http://www.csc.fi/
> ****************************************************************
>
>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
>


--=20
   Warm Regards,  Azad Aliyar
 Linux Server Engineer
 *Email* :  azad.aliyar-tQhtAXQzQEb0d+JFtaHRRQ@public.gmane.org   *|*   *Skype* :   spark.azad
<http://www.sparksupport.com> <http://www.sparkmycloud.com>
<https://www.facebook.com/sparksupport>
<http://www.linkedin.com/company/244846>  <https://twitter.com/sparksupport=
>
3rd Floor, Leela Infopark, Phase -2,Kakanad, Kochi-30, Kerala, India
*Phone*:+91 484 6561696 , *Mobile*:91-8129270421.   *Confidentiality
Notice:* Information in this e-mail is proprietary to SparkSupport. and is
intended for use only by the addressed, and may contain information that is
privileged, confidential or exempt from disclosure. If you are not the
intended recipient, you are notified that any use of this information in
any manner is strictly prohibited. Please delete this mail & notify us
immediately at info-tQhtAXQzQEb0d+JFtaHRRQ@public.gmane.org

--047d7bdc12b05ae7090510d8ce79
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><li><p class=3D""><strong>Check Max Threadcount:</strong> =
If you have a node with a lot of OSDs, you may be
hitting the default maximum number of threads (e.g., usually 32k), especial=
ly
during recovery. You can increase the number of threads using <tt class=3D"=
"><span class=3D"">sysctl</span></tt> to
see if increasing the maximum number of threads to the maximum possible
number of threads allowed (i.e.,  4194303) will help. For example:</p>
<div class=3D""><pre>sysctl -w kernel.pid_max=3D4194303</pre>
</div>
<p>If increasing the maximum thread count resolves the issue, you can make =
it
permanent by including a <tt class=3D""><span class=3D"">kernel.pid_max</sp=
an></tt> setting in the
<tt class=3D""><span class=3D"">/etc/sysctl.conf</span></tt> file. For exam=
ple:</p>
<div class=3D""><div class=3D""><pre><span class=3D"">kernel</span><span cl=
ass=3D"">.</span><span class=3D"">pid_max</span> <span class=3D"">=3D</span=
> <span class=3D"">4194303</span>
</pre></div>
</div>
</li></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Mon=
, Mar 9, 2015 at 4:11 PM, Karan Singh <span dir=3D"ltr">&lt;<a href=3D"mail=
to:karan.singh-Gn+qtVAUx6s@public.gmane.org" target=3D"_blank">karan.singh-Gn+qtVAUx6s@public.gmane.org</a>&gt;</span> =
wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex"><div style=3D"word-wrap:break-word=
"><div>Hello Community need help to fix a long going Ceph problem.</div><di=
v><br></div><div>Cluster is unhealthy , Multiple OSDs are DOWN. When i am t=
rying to restart OSD=E2=80=99s i am getting this error=C2=A0</div><div><br>=
</div><div><div><br></div><div><i>2015-03-09 12:22:16.312774 7f760dac9700 -=
1 common/<a href=3D"http://Thread.cc" target=3D"_blank">Thread.cc</a>: In f=
unction &#39;void Thread::create(size_t)&#39; thread 7f760dac9700 time 2015=
-03-09 12:22:16.311970</i></div><div><i>common/<a href=3D"http://Thread.cc"=
 target=3D"_blank">Thread.cc</a>: 129: FAILED assert(ret =3D=3D 0)</i></div=
></div><div><br></div><div><br></div><div><b>Environment </b>: =C2=A04 Node=
s , OSD+Monitor , Firefly latest , CentOS6.5 ,=C2=A0<span style=3D"color:rg=
b(55,66,74);font-family:Helvetica,Arial,sans-serif;line-height:9.5999994277=
9541px;background-color:rgb(255,255,240)">3.17.2-1.el6.elrepo.x86_64</span>=
</div><div><span style=3D"color:rgb(55,66,74);font-family:Helvetica,Arial,s=
ans-serif;line-height:9.59999942779541px;background-color:rgb(255,255,240)"=
><br></span></div><div><font face=3D"Helvetica, Arial, sans-serif" color=3D=
"#37424a"><span style=3D"line-height:9.59999942779541px;background-color:rg=
b(255,255,240)">Tried upgrading from 0.80.7 to 0.80.8 =C2=A0but no Luck</sp=
an></font></div><div><font face=3D"Helvetica, Arial, sans-serif" color=3D"#=
37424a"><span style=3D"line-height:9.59999942779541px;background-color:rgb(=
255,255,240)"><br></span></font></div><div><font face=3D"Helvetica, Arial, =
sans-serif" color=3D"#37424a"><span style=3D"line-height:9.59999942779541px=
;background-color:rgb(255,255,240)">Tried centOS stock kernel 2.6.32 =C2=A0=
but no Luck</span></font></div><div><font face=3D"Helvetica, Arial, sans-se=
rif" color=3D"#37424a"><span style=3D"line-height:9.59999942779541px;backgr=
ound-color:rgb(255,255,240)"><br></span></font></div><div><font face=3D"Hel=
vetica, Arial, sans-serif" color=3D"#37424a"><span style=3D"line-height:9.5=
9999942779541px;background-color:rgb(255,255,240)">Memory is not a problem =
more then 150+GB is free=C2=A0</span></font></div><div><font face=3D"Helvet=
ica, Arial, sans-serif" color=3D"#37424a"><span style=3D"line-height:9.5999=
9942779541px;background-color:rgb(255,255,240)"><br></span></font></div><di=
v><font face=3D"Helvetica, Arial, sans-serif" color=3D"#37424a"><span style=
=3D"line-height:9.59999942779541px;background-color:rgb(255,255,240)"><br><=
/span></font></div><div style=3D"font-size:14px">Did any one every faced th=
is problem ??</div><div><br></div><div><font size=3D"3"><b>Cluster status=
=C2=A0</b></font></div><div><font size=3D"3"><b><br></b></font></div><div><=
div>=C2=A0<i> =C2=A0cluster 2bd3283d-67ef-4316-8b7e-d8f4747eae33</i></div><=
div><i>=C2=A0 =C2=A0 =C2=A0health HEALTH_WARN 7334 pgs degraded; 1185 pgs d=
own; 1 pgs incomplete; 1735 pgs peering; 8938 pgs stale; 1</i></div><div><i=
>736 pgs stuck inactive; 8938 pgs stuck stale; 10320 pgs stuck unclean; rec=
overy 6061/31080 objects degraded (19</i></div><div><i>.501%); 111/196 in o=
sds are down; clock skew detected on mon.pouta-s02, mon.pouta-s03</i></div>=
<div><i>=C2=A0 =C2=A0 =C2=A0monmap e3: 3 mons at {pouta-s01=3D10.XXX.50.1:6=
789/0,pouta-s02=3D10.XXX.50.2:6789/0,pouta-s03=3D10.XXX.50.3:6789</i></div>=
<div><i>/0}, election epoch 1312, quorum 0,1,2 pouta-s01,pouta-s02,pouta-s0=
3</i></div><div><i>=C2=A0 =C2=A0<b> =C2=A0osdmap e26633: 239 osds: 85 up, 1=
96 in</b></i></div><div><i>=C2=A0 =C2=A0 =C2=A0 pgmap v60389: 17408 pgs, 13=
 pools, 42345 MB data, 10360 objects</i></div><div><i>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 4699 GB used, 707 TB / 711 TB avail</i></div><div><i>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6061/31080 objects degraded (19.5=
01%)</i></div><div><i>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 14 down+remapped+peering</i></div><div><i>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 39 active</i></div><div><i>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3289 active+clean</i></di=
v><div><i>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0547=
 peering</i></div><div><i>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0663 stale+down+peering</i></div><div><i>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0705 stale+active+remapped</i></div=
><div><i>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A01 active+degraded+remapped</i></div><div><i>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01 stale+down+incomplete</i></div><=
div><i>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0484 do=
wn+peering</i></div><div><i>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0455 active+remapped</i></div><div><i>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3696 stale+active+degraded</i></div><div=
><i>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04 =
remapped+peering</i></div><div><i>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 23 stale+down+remapped+peering</i></div><div><i>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 51 stale+active=
</i></div><div><i>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3=
637 active+degraded</i></div><div><i>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 3799 stale+active+clean</i></div></div><div><br></div><di=
v style=3D"font-size:16px"><b>OSD : =C2=A0Logs=C2=A0</b></div><div><br></di=
v><div><i>2015-03-09 12:22:16.312774 7f760dac9700 -1 common/<a href=3D"http=
://Thread.cc" target=3D"_blank">Thread.cc</a>: In function &#39;void Thread=
::create(size_t)&#39; thread 7f760dac9700 time 2015-03-09 12:22:16.311970</=
i></div><div><i>common/<a href=3D"http://Thread.cc" target=3D"_blank">Threa=
d.cc</a>: 129: FAILED assert(ret =3D=3D 0)</i></div><div><i><br></i></div><=
div><i>=C2=A0ceph version 0.80.8 (69eaad7f8308f21573c604f121956e64679a52a7)=
</i></div><div><i>=C2=A01: (Thread::create(unsigned long)+0x8a) [0xaf41da]<=
/i></div><div><i>=C2=A02: (SimpleMessenger::add_accept_pipe(int)+0x6a) [0xa=
e84fa]</i></div><div><i>=C2=A03: (Accepter::entry()+0x265) [0xb5c635]</i></=
div><div><i>=C2=A04: /lib64/libpthread.so.0() [0x3c8a6079d1]</i></div><div>=
<i>=C2=A05: (clone()+0x6d) [0x3c8a2e89dd]</i></div><div><i>=C2=A0NOTE: a co=
py of the executable, or `objdump -rdS &lt;executable&gt;` is needed to int=
erpret this.</i></div><div><br></div><div><br></div><div><font size=3D"3"><=
b>More information at Ceph Tracker Issue : =C2=A0</b></font><a href=3D"http=
://tracker.ceph.com/issues/10988#change-49018" target=3D"_blank">http://tra=
cker.ceph.com/issues/10988#change-49018</a></div><div><br></div><div>
<div style=3D"color:rgb(0,0,0);letter-spacing:normal;text-align:start;text-=
indent:0px;text-transform:none;white-space:normal;word-spacing:0px;word-wra=
p:break-word"><div style=3D"color:rgb(0,0,0);letter-spacing:normal;text-ali=
gn:start;text-indent:0px;text-transform:none;white-space:normal;word-spacin=
g:0px;word-wrap:break-word"><div style=3D"color:rgb(0,0,0);font-family:Helv=
etica;font-size:12px;font-style:normal;font-variant:normal;font-weight:norm=
al;letter-spacing:normal;line-height:normal;text-align:start;text-indent:0p=
x;text-transform:none;white-space:normal;word-spacing:0px;word-wrap:break-w=
ord"><br>****************************************************************</=
div><div style=3D"color:rgb(0,0,0);font-family:Helvetica;font-size:12px;fon=
t-style:normal;font-variant:normal;font-weight:normal;letter-spacing:normal=
;line-height:normal;text-align:start;text-indent:0px;text-transform:none;wh=
ite-space:normal;word-spacing:0px;word-wrap:break-word">Karan Singh=C2=A0</=
div><div style=3D"color:rgb(0,0,0);font-family:Helvetica;font-size:12px;fon=
t-style:normal;font-variant:normal;font-weight:normal;letter-spacing:normal=
;line-height:normal;text-align:start;text-indent:0px;text-transform:none;wh=
ite-space:normal;word-spacing:0px;word-wrap:break-word">Systems Specialist =
,=C2=A0Storage Platforms</div><div style=3D"color:rgb(0,0,0);font-family:He=
lvetica;font-size:12px;font-style:normal;font-variant:normal;font-weight:no=
rmal;letter-spacing:normal;line-height:normal;text-align:start;text-indent:=
0px;text-transform:none;white-space:normal;word-spacing:0px;word-wrap:break=
-word">CSC - IT Center for Science,</div><div style=3D"color:rgb(0,0,0);fon=
t-family:Helvetica;font-size:12px;font-style:normal;font-variant:normal;fon=
t-weight:normal;letter-spacing:normal;line-height:normal;text-align:start;t=
ext-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;word=
-wrap:break-word">Keilaranta 14, P. O. Box 405, FIN-02101 Espoo, Finland<br=
>mobile: +358 503 812758<br>tel. +358 9 4572001<br>fax +358 9 4572302<br><a=
 href=3D"http://www.csc.fi/" target=3D"_blank">http://www.csc.fi/</a></div>=
<div style=3D"color:rgb(0,0,0);font-family:Helvetica;font-size:12px;font-st=
yle:normal;font-variant:normal;font-weight:normal;letter-spacing:normal;lin=
e-height:normal;text-align:start;text-indent:0px;text-transform:none;white-=
space:normal;word-spacing:0px;word-wrap:break-word">***********************=
*****************************************</div></div></div>
</div>
<br></div><br>_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><=
br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" target=
=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a><br>
<br></blockquote></div><br><br clear=3D"all"><br>-- <br><div class=3D"gmail=
_signature"><div dir=3D"ltr"><div><div dir=3D"ltr">

<table width=3D"100%" border=3D"0">


<tbody><tr>
<td>

<table style=3D"border-bottom:solid 1px #999;padding-bottom:10px" width=3D"=
100%" border=3D"0">

  <tbody><tr>

=20
       <td style=3D"width:100%;float:left;font-family:Arial,Helvetica,sans-=
serif;font-size:12px;color:#666c6e;line-height:10px;font-weight:bold;margin=
-bottom:0px">Warm Regards,</td>
       </tr>
      =20
      <tr>
     <td style=3D"font-family:Arial,Helvetica,sans-serif;font-size:18px;col=
or:#1491d3;font-weight:bold;margin-bottom:3px;width:100%;line-height:20px;p=
adding-top:0px">Azad Aliyar<br></td>
 </tr>
=20
   <tr>
  <td style=3D"float:left;margin-bottom:0px"><font face=3D"Arial, Helvetica=
, sans-serif" color=3D"#666c6e"><span style=3D"line-height:10px">Linux Serv=
er Engineer</span></font><br></td>
    </tr>
   =20
     =20
  <tr>
   <td style=3D"float:left;font-family:Arial,Helvetica,sans-serif;font-size=
:13px;color:#666c6e;line-height:10px;font-weight:normal;margin-bottom:0px;p=
adding-top:5px"><b style=3D"color:#1491d3">Email</b> :=C2=A0 <a href=3D"mai=
lto:azad.aliyar-tQhtAXQzQEb0d+JFtaHRRQ@public.gmane.org" target=3D"_blank">azad.aliyar@sparksuppor=
t.com</a>  =C2=A0=C2=A0<b>|</b>=C2=A0=C2=A0  <b style=3D"color:#1491d3">Sky=
pe</b> :=C2=A0=C2=A0 spark.azad </td>
   =20
    </tr>
   =20
 =20
</tbody></table>



<table width=3D"550px" border=3D"0">
  <tbody><tr>
    <td style=3D"width:400px;float:left;font-family:Arial,Helvetica,sans-se=
rif;font-size:12px;color:#666c6e;line-height:10px;font-weight:normal;margin=
-bottom:0px;padding-top:1px"> <a href=3D"http://www.sparksupport.com" targe=
t=3D"_blank"> <img src=3D"http://sparklabs.in/signature/images/spark-suppor=
t.jpg"></a>    <a href=3D"http://www.sparkmycloud.com" target=3D"_blank"><i=
mg src=3D"http://sparklabs.in/signature/images/cloud.jpg" style=3D"padding-=
left:13px"></a>  =20
  </td>
 =20
  <td valign=3D"middle" width=3D"150px" align=3D"left">
<a href=3D"https://www.facebook.com/sparksupport" target=3D"_blank"> <img s=
rc=3D"http://sparklabs.in/signature/images/fb.jpg" style=3D"margin-left:10p=
x"></a> =20
<a href=3D"http://www.linkedin.com/company/244846" target=3D"_blank"><img s=
rc=3D"http://sparklabs.in/signature/images/linked-in.jpg" style=3D"margin-l=
eft:10px"></a>=20
<a href=3D"https://twitter.com/sparksupport" target=3D"_blank"> <img src=3D=
"http://sparklabs.in/signature/images/twitter.jpg" style=3D"margin-left:10p=
x"> </a>

</td>
=20


  </tr>
</tbody></table>



<table width=3D"100%" border=3D"0">
  <tbody><tr>
    <td style=3D"float:left;font-family:Arial,Helvetica,sans-serif;font-siz=
e:11px;color:#666c6e;line-height:10px;font-weight:normal;margin-bottom:0px;=
padding-top:1px"> 3rd Floor, Leela Infopark, Phase -2,Kakanad, Kochi-30, Ke=
rala, India </td>
  </tr>
   <tr>
    <td style=3D"float:left;font-family:Arial,Helvetica,sans-serif;font-siz=
e:11px;color:#666c6e;line-height:9px;font-weight:normal;margin-bottom:0px;p=
adding-top:1px"><b>Phone</b>:+91 484 6561696 , <b>Mobile</b>:91-8129270421.=
 =20
       </td>
  </tr>
 =20
 =20
 =20
  <tr>
    <td style=3D"float:left;font-family:Arial,Helvetica,sans-serif;font-siz=
e:10px;color:#666c6e;line-height:10px;font-style:normal;margin-bottom:0px;p=
adding-top:3px">
    <b>Confidentiality Notice:</b>  Information in this e-mail
 is proprietary to SparkSupport. and is intended for use only by the =20
addressed,
 and may contain information that is privileged, confidential or exempt=20
from disclosure. If you are not the intended recipient,=20
 you are notified that any use of this information in any manner is=20
strictly prohibited. Please delete this mail &amp; notify us immediately
 at <a href=3D"mailto:info-tQhtAXQzQEb0d+JFtaHRRQ@public.gmane.org" target=3D"_blank">info@sparksu=
pport.com</a>
    </td>
  </tr>
</tbody></table>



 =20
 =20
  </td>
  </tr>
</tbody></table>



</div></div></div></div>
</div>

--047d7bdc12b05ae7090510d8ce79--

--===============0855105827==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0855105827==--
