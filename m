From: Italo Santos <okdokk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: RGW + erasure coding
Date: Tue, 5 May 2015 22:48:32 -0300
Message-ID: <ABACEE296F334616AE79B9075D49C8D1@gmail.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD86F12@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1210385157=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD86F12-cXZ6iGhjG0il5HHZYNR2WTJ2aSJ780jGSxCzGc5ayCJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Somnath Roy <Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>
Cc: "=?utf-8?Q?ceph-users=40lists.ceph.com?=" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1210385157==
Content-Type: multipart/alternative; boundary="554972f0_53299938_d885"

--554972f0_53299938_d885
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I use RGW with the .rgw.bucktes as EC pool and works fine as well, I=E2=80=
=99m able to reach =7E300MB/s using a physical RGW server with 4 OSD node=
s with SAS 10K drives w/out SSD journal. =20

Also, I=E2=80=99ve tested create all other pools as EC pool too but RGW d=
aemon doesn=E2=80=99t start, so I realised that the only pool should be E=
C was the data pool (.rgw.buckets) =20

Regards.

Italo Santos
http://italosantos.com.br/


On Tuesday, May 5, 2015 at 22:35, Somnath Roy wrote:

> Hi,
> I am planning to setup RGW on top of Erasure coded pool. RGW stores all=
 of its data in the .rgw.buckets pool and I am planning to configure this=
 pool as erasure-coded. I think configuring all other rgw pools as replic=
ated should be fine as they don't store lot of data.
> Please let me know if I am missing anything, any comments/suggestion/pe=
rformance tuning insight on this will be very helpful.
> =20
> Thanks & Regards
> Somnath
> =20
> =5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F
> =20
> PLEASE NOTE: The information contained in this electronic mail message =
is intended only for the use of the designated recipient(s) named above. =
If the reader of this message is not the intended recipient, you are here=
by notified that you have received this message in error and that any rev=
iew, dissemination, distribution, or copying of this message is strictly =
prohibited. If you have received this communication in error, please noti=
fy the sender by telephone or e-mail (as shown above) immediately and des=
troy any and all copies of this message in your possession (whether hard =
copies or electronically stored copies).
> =20
> =5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
> ceph-users mailing list
> ceph-users=40lists.ceph.com (mailto:ceph-users=40lists.ceph.com)
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> =20
> =20



--554972f0_53299938_d885
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


                <div>
                    I use RGW with the .rgw.bucktes as EC pool and works =
fine as well, I=E2=80=99m able to reach =7E300MB/s using a physical RGW s=
erver with 4 OSD nodes with SAS 10K drives w/out SSD journal.
                </div><div><br></div><div>Also, I=E2=80=99ve tested creat=
e all other pools as EC pool too but RGW daemon doesn=E2=80=99t start, so=
 I realised that the only pool should be EC was the data pool (.rgw.bucke=
ts)</div>
                <div><div><br></div><div style=3D=22background-color: rgb=
(255, 255, 255);=22>Regards.</div><div style=3D=22background-color: rgb(2=
55, 255, 255);=22><br></div><div style=3D=22background-color: rgb(255, 25=
5, 255);=22><b>Italo Santos</b></div><div style=3D=22background-color: rg=
b(255, 255, 255);=22><a href=3D=22http://italosantos.com.br/=22 style=3D=22=
color: rgb(0, 106, 227);=22>http://italosantos.com.br/</a></div><div><br>=
</div></div>
                =20
                <p style=3D=22color: =23A0A0A8;=22>On Tuesday, May 5, 201=
5 at 22:35, Somnath Roy wrote:</p>
                <blockquote type=3D=22cite=22 style=3D=22border-left-styl=
e:solid;border-width:1px;margin-left:0px;padding-left:10px;=22>
                    <span><div><div><div>Hi,</div><div>I am planning to s=
etup RGW on top of Erasure coded pool. RGW stores all of its data in the =
.rgw.buckets pool and I am planning to configure this pool as erasure-cod=
ed. I think configuring all other rgw pools as replicated should be fine =
as they don't store lot of data.</div><div>Please let me know if I am mis=
sing anything, any comments/suggestion/performance tuning insight  on thi=
s will be very helpful.</div><div><br></div><div>Thanks &amp; Regards</di=
v><div>Somnath</div><div><br></div><div>=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F</div><div=
><br></div><div>PLEASE NOTE: The information contained in this electronic=
 mail message is intended only for the use of the designated recipient(s)=
 named above. If the reader of this message is not the intended recipient=
, you are hereby notified that you have received this message in error an=
d that any review, dissemination, distribution, or copying of this messag=
e is strictly prohibited. If you have received this communication in erro=
r, please notify the sender by telephone or e-mail (as shown above) immed=
iately and destroy any and all copies of this message in your possession =
(whether hard copies or electronically stored copies).</div><div><br></di=
v><div>=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
</div><div>ceph-users mailing list</div><div><a href=3D=22mailto:ceph-use=
rs=40lists.ceph.com=22>ceph-users=40lists.ceph.com</a></div><div><a href=3D=
=22http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com=22>http://lists=
.ceph.com/listinfo.cgi/ceph-users-ceph.com</a></div></div></div></span>
                =20
                =20
                =20
                =20
                </blockquote>
                =20
                <div>
                    <br>
                </div>
            
--554972f0_53299938_d885--


--===============1210385157==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1210385157==--
