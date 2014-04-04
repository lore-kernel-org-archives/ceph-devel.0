From: Scottix <scottix-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Ceph User Committee monthly meeting #1 : executive
	summary
Date: Fri, 4 Apr 2014 11:11:56 -0700
Message-ID: <CANKFHZ8rwXQXg94eC2tw-gefcCQ0Q5f5uZd3HF+DcuRjftUVYw@mail.gmail.com>
References: <533EDF0E.70409@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0529092663=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <533EDF0E.70409-cLsNCMjd+0JAfugRpC6u6w@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
Cc: Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0529092663==
Content-Type: multipart/alternative; boundary=001a1132efa261b7d904f63b76c8

--001a1132efa261b7d904f63b76c8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

CephFS use case
Wanted to throw in our use case.

We store massive amount of timeseries data files that we need to process as
they come in. Right now raid is holding us over but we are hitting the
upper limits, we would have to spend some serious amount of money to go to
the next level, even then will start needing more throughput. That is where
Ceph would be great, although RBD is feasible, we need it to be reliably
expandable.
This is where Gluster has one up on Ceph. I have put off gluster because I
don't want to deal with split-brain scenarios, anyway we have been
experimenting with CephFS and we believe that is the way to go but we are
very cautious at the moment.



On Fri, Apr 4, 2014 at 9:34 AM, Loic Dachary <loic-cLsNCMjd+0JAfugRpC6u6w@public.gmane.org> wrote:

> Hi Ceph,
>
> This month Ceph User Committee meeting was about:
>
>     Tiering, erasure code
>     Using http://tracker.ceph.com/
>     CephFS
>     Miscellaneous
>
> You will find an executive summary at:
>
>
> https://wiki.ceph.com/Community/Meetings/Ceph_User_Committee_meeting_2014=
-04-03
>
> The full log of the IRC conversation is also included to provide more
> context when needed. Feel free to edit if you see a mistake.
>
> Cheers
>
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
>
>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
>


--=20
Follow Me: @Scottix <http://www.twitter.com/scottix>
http://about.me/scottix
Scottix-o4GsF6Y0fuwAvxtiuMwx3w@public.gmane.org

--001a1132efa261b7d904f63b76c8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">CephFS use case<div>Wanted to throw in our use case.</div>=
<div><br></div><div>We store massive amount of timeseries data files that w=
e need to process as they come in. Right now raid is holding us over but we=
 are hitting the upper limits, we would have to spend some serious amount o=
f money to go to the next level, even then will start needing more throughp=
ut. That is where Ceph would be great, although RBD is feasible, we need it=
 to be reliably expandable.</div>

<div>This is where Gluster has one up on Ceph. I have put off gluster becau=
se I don&#39;t want to deal with split-brain scenarios, anyway we have been=
 experimenting with CephFS and we believe that is the way to go but we are =
very cautious at the moment.</div>

<div><br></div></div><div class=3D"gmail_extra"><br><br><div class=3D"gmail=
_quote">On Fri, Apr 4, 2014 at 9:34 AM, Loic Dachary <span dir=3D"ltr">&lt;=
<a href=3D"mailto:loic-cLsNCMjd+0JAfugRpC6u6w@public.gmane.org" target=3D"_blank">loic-cLsNCMjd+0JAfugRpC6u6w@public.gmane.org</a>&=
gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi Ceph,<br>
<br>
This month Ceph User Committee meeting was about:<br>
<br>
=A0 =A0 Tiering, erasure code<br>
=A0 =A0 Using <a href=3D"http://tracker.ceph.com/" target=3D"_blank">http:/=
/tracker.ceph.com/</a><br>
=A0 =A0 CephFS<br>
=A0 =A0 Miscellaneous<br>
<br>
You will find an executive summary at:<br>
<br>
=A0 =A0<a href=3D"https://wiki.ceph.com/Community/Meetings/Ceph_User_Commit=
tee_meeting_2014-04-03" target=3D"_blank">https://wiki.ceph.com/Community/M=
eetings/Ceph_User_Committee_meeting_2014-04-03</a><br>
<br>
The full log of the IRC conversation is also included to provide more conte=
xt when needed. Feel free to edit if you see a mistake.<br>
<br>
Cheers<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
Lo=EFc Dachary, Artisan Logiciel Libre<br>
<br>
</font></span><br>_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><=
br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" target=
=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a><br>
<br></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>Follow M=
e: <a href=3D"http://www.twitter.com/scottix" target=3D"_blank">@Scottix</a=
><br><a href=3D"http://about.me/scottix" target=3D"_blank">http://about.me/=
scottix</a><br>

Scottix-o4GsF6Y0fuwAvxtiuMwx3w@public.gmane.org
</div>

--001a1132efa261b7d904f63b76c8--

--===============0529092663==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0529092663==--
