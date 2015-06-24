From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: radosgw crash within libfcgi
Date: Wed, 24 Jun 2015 17:40:24 -0400 (EDT)
Message-ID: <445856759.19469749.1435182024677.JavaMail.zimbra@redhat.com>
References: <BLU175-W1310E96C473E9ABED62D65DFAF0@phx.gbl> <460832233.19349487.1435171225932.JavaMail.zimbra@redhat.com> <BLU175-W467685E9DD4BACB37D7AB3DFAF0@phx.gbl> <463953216.19442278.1435179845477.JavaMail.zimbra@redhat.com> <BLU175-W7F6E88F53F4EF4DF45248DFAF0@phx.gbl> <935875968.19447031.1435180864559.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:45789 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbbFXVk1 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Jun 2015 17:40:27 -0400
In-Reply-To: <935875968.19447031.1435180864559.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: GuangYang <yguang11@outlook.com>
Cc: ceph-devel@vger.kernel.org, ceph-users@lists.ceph.com

Also, looking at the code, I see an extra call to FCGX_Finish_r():

diff --git a/src/rgw/rgw_main.cc b/src/rgw/rgw_main.cc
index 9a8aa5f..0aa7ded 100644
--- a/src/rgw/rgw_main.cc
+++ b/src/rgw/rgw_main.cc
@@ -669,8 +669,6 @@ void RGWFCGXProcess::handle_request(RGWRequest *r)
     dout(20) << "process_request() returned " << ret << dendl;
   }
=20
-  FCGX_Finish_r(fcgx);
-
   delete req;
 }
=20

Maybe this is a problem on the specific libfcgi version that you're usi=
ng?

----- Original Message -----
> From: "Yehuda Sadeh-Weinraub" <yehuda@redhat.com>
> To: "GuangYang" <yguang11@outlook.com>
> Cc: ceph-devel@vger.kernel.org, ceph-users@lists.ceph.com
> Sent: Wednesday, June 24, 2015 2:21:04 PM
> Subject: Re: radosgw crash within libfcgi
>=20
>=20
>=20
> ----- Original Message -----
> > From: "GuangYang" <yguang11@outlook.com>
> > To: "Yehuda Sadeh-Weinraub" <yehuda@redhat.com>
> > Cc: ceph-devel@vger.kernel.org, ceph-users@lists.ceph.com
> > Sent: Wednesday, June 24, 2015 2:12:23 PM
> > Subject: RE: radosgw crash within libfcgi
> >=20
> > ----------------------------------------
> > > Date: Wed, 24 Jun 2015 17:04:05 -0400
> > > From: yehuda@redhat.com
> > > To: yguang11@outlook.com
> > > CC: ceph-devel@vger.kernel.org; ceph-users@lists.ceph.com
> > > Subject: Re: radosgw crash within libfcgi
> > >
> > >
> > >
> > > ----- Original Message -----
> > >> From: "GuangYang" <yguang11@outlook.com>
> > >> To: "Yehuda Sadeh-Weinraub" <yehuda@redhat.com>
> > >> Cc: ceph-devel@vger.kernel.org, ceph-users@lists.ceph.com
> > >> Sent: Wednesday, June 24, 2015 1:53:20 PM
> > >> Subject: RE: radosgw crash within libfcgi
> > >>
> > >> Thanks Yehuda for the response.
> > >>
> > >> We already patched libfcgi to use poll instead of select to over=
come the
> > >> limitation.
> > >>
> > >> Thanks,
> > >> Guang
> > >>
> > >>
> > >> ----------------------------------------
> > >>> Date: Wed, 24 Jun 2015 14:40:25 -0400
> > >>> From: yehuda@redhat.com
> > >>> To: yguang11@outlook.com
> > >>> CC: ceph-devel@vger.kernel.org; ceph-users@lists.ceph.com
> > >>> Subject: Re: radosgw crash within libfcgi
> > >>>
> > >>>
> > >>>
> > >>> ----- Original Message -----
> > >>>> From: "GuangYang" <yguang11@outlook.com>
> > >>>> To: ceph-devel@vger.kernel.org, ceph-users@lists.ceph.com,
> > >>>> yehuda@redhat.com
> > >>>> Sent: Wednesday, June 24, 2015 10:09:58 AM
> > >>>> Subject: radosgw crash within libfcgi
> > >>>>
> > >>>> Hello Cephers,
> > >>>> Recently we have several radosgw daemon crashes with the same
> > >>>> following
> > >>>> kernel log:
> > >>>>
> > >>>> Jun 23 14:17:38 xxx kernel: radosgw[68180]: segfault at f0 ip
> > >>>> 00007ffa069996f2 sp 00007ff55c432710 error 6 in
> > >
> > > error 6 is sigabrt, right? With invalid pointer I'd expect to get
> > > segfault.
> > > Is the pointer actually invalid?
> > With (ip - {address_load_the_sharded_library}) to get the instructi=
on which
> > caused this crash, the objdump shows the crash happened at instruct=
ion 46f2
> > (see below), which was to assign '-1' to the CGX_Request::ipcFd to =
-1, but
> > I
> > don't quite understand how/why it could crash there.
> >=20
> > 0000000000004690 <FCGX_Free>:
> > =C2=A0 =C2=A0 4690: =C2=A0 =C2=A0 =C2=A0 48 89 5c 24 f0=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 mov=C2=A0 =C2=A0 %rbx,-0x10(%rsp)
> > =C2=A0 =C2=A0 4695: =C2=A0 =C2=A0 =C2=A0 48 89 6c 24 f8=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 mov=C2=A0 =C2=A0 %rbp,-0x8(%rsp)
> > =C2=A0 =C2=A0 469a: =C2=A0 =C2=A0 =C2=A0 48 83 ec 18 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 sub=C2=A0 =C2=A0 $0x18,%rsp
> > =C2=A0 =C2=A0 469e: =C2=A0 =C2=A0 =C2=A0 48 85 ff=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test =C2=A0 %rdi,%rdi
> > =C2=A0 =C2=A0 46a1: =C2=A0 =C2=A0 =C2=A0 48 89 fb=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mov=C2=A0 =C2=A0 %rdi,%rbx
> > =C2=A0 =C2=A0 46a4: =C2=A0 =C2=A0 =C2=A0 89 f5 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mov=C2=A0 =C2=A0 %esi,%ebp
> > =C2=A0 =C2=A0 46a6: =C2=A0 =C2=A0 =C2=A0 74 28 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 je =C2=A0 =C2=A0 46d0 <FCGX_=
=46ree+0x40>
> > =C2=A0 =C2=A0 46a8: =C2=A0 =C2=A0 =C2=A0 48 8d 7f 08 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 lea=C2=A0 =C2=A0 0x8(%rdi),%rdi
> > =C2=A0 =C2=A0 46ac: =C2=A0 =C2=A0 =C2=A0 e8 67 e3 ff ff=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 callq=C2=A0 2a18 <FCGX_FreeStream@plt>
> > =C2=A0 =C2=A0 46b1: =C2=A0 =C2=A0 =C2=A0 48 8d 7b 10 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 lea=C2=A0 =C2=A0 0x10(%rbx),%rdi
> > =C2=A0 =C2=A0 46b5: =C2=A0 =C2=A0 =C2=A0 e8 5e e3 ff ff=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 callq=C2=A0 2a18 <FCGX_FreeStream@plt>
> > =C2=A0 =C2=A0 46ba: =C2=A0 =C2=A0 =C2=A0 48 8d 7b 18 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 lea=C2=A0 =C2=A0 0x18(%rbx),%rdi
> > =C2=A0 =C2=A0 46be: =C2=A0 =C2=A0 =C2=A0 e8 55 e3 ff ff=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 callq=C2=A0 2a18 <FCGX_FreeStream@plt>
> > =C2=A0 =C2=A0 46c3: =C2=A0 =C2=A0 =C2=A0 48 8d 7b 28 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 lea=C2=A0 =C2=A0 0x28(%rbx),%rdi
> > =C2=A0 =C2=A0 46c7: =C2=A0 =C2=A0 =C2=A0 e8 d4 f4 ff ff=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 callq=C2=A0 3ba0 <FCGX_PutS+0x40>
> > =C2=A0 =C2=A0 46cc: =C2=A0 =C2=A0 =C2=A0 85 ed =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test =C2=A0 %ebp,%ebp
> > =C2=A0 =C2=A0 46ce: =C2=A0 =C2=A0 =C2=A0 75 10 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 jne=C2=A0 =C2=A0 46e0 <FCGX_=
=46ree+0x50>
> > =C2=A0 =C2=A0 46d0: =C2=A0 =C2=A0 =C2=A0 48 8b 5c 24 08=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 mov=C2=A0 =C2=A0 0x8(%rsp),%rbx
> > =C2=A0 =C2=A0 46d5: =C2=A0 =C2=A0 =C2=A0 48 8b 6c 24 10=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 mov=C2=A0 =C2=A0 0x10(%rsp),%rbp
> > =C2=A0 =C2=A0 46da: =C2=A0 =C2=A0 =C2=A0 48 83 c4 18 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 add=C2=A0 =C2=A0 $0x18,%rsp
> > =C2=A0 =C2=A0 46de: =C2=A0 =C2=A0 =C2=A0 c3=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retq
> > =C2=A0 =C2=A0 46df: =C2=A0 =C2=A0 =C2=A0 90=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nop
> > =C2=A0 =C2=A0 46e0: =C2=A0 =C2=A0 =C2=A0 31 f6 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 xor=C2=A0 =C2=A0 %esi,%esi
> > =C2=A0 =C2=A0 46e2: =C2=A0 =C2=A0 =C2=A0 83 7b 4c 00 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmpl =C2=A0 $0x0,0x4c(%rbx)
> > =C2=A0 =C2=A0 46e6: =C2=A0 =C2=A0 =C2=A0 8b 7b 30=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mov=C2=A0 =C2=A0 0x30(%rbx),%edi
> > =C2=A0 =C2=A0 46e9: =C2=A0 =C2=A0 =C2=A0 40 0f 94 c6 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 sete =C2=A0 %sil
> > =C2=A0 =C2=A0 46ed: =C2=A0 =C2=A0 =C2=A0 e8 86 e6 ff ff=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 callq=C2=A0 2d78 <OS_IpcClose@plt>
> > =C2=A0 =C2=A0 46f2: =C2=A0 =C2=A0 =C2=A0 c7 43 30 ff ff ff ff=C2=A0=
 =C2=A0 movl =C2=A0 $0xffffffff,0x30(%rbx)
>=20
> info registers?
>=20
> Not too familiar with the specific message, but it could be that
> OS_IpcClose() aborts (not highly unlikely) and it only dumps the retu=
rn
> address of the current function (shouldn't be referenced as ip though=
).
>=20
> What's rbx? Is the memory at %rbx + 0x30 valid?
>=20
> Also, did you by any chance upgrade the binaries while the code was r=
unning?
> is the code running over nfs?
>=20
> Yehuda
>=20
> > >
> > > Yehuda
> > >
> > >
> > >>>> libfcgi.so.0.0.0[7ffa06995000+a000] in
> > >>>> libfcgi.so.0.0.0[7ffa06995000+a000]
> > >>>>
> > >>>> Looking at the assembly, it seems crashing at this point -
> > >>>> http://github.com/sknown/fcgi/blob/master/libfcgi/fcgiapp.c#L2=
035,
> > >>>> which
> > >>>> confused me. I tried to see if there is any other reference ho=
lding
> > >>>> the
> > >>>> FCGX_Request which release the handle without any luck.
> > >>>>
> > >>>> There are also other observations:
> > >>>> 1> Several radosgw daemon across different hosts crashed aroun=
d the
> > >>>> same
> > >>>> time.
> > >>>> 2> Apache's error log has some fcgi error complaining ##idle t=
imeout##
> > >>>> during the time.
> > >>>>
> > >>>> Does anyone experience similar issue?
> > >>>>
> > >>>
> > >>> In the past we've had issues with libfcgi that were related to =
the
> > >>> number
> > >>> of open fds on the process (> 1024). The issue was a buggy libf=
cgi that
> > >>> was using select() instead of poll(), so this might be the issu=
e you're
> > >>> noticing.
> > >>>
> > >>> Yehuda
> > >>> --
> > >>> To unsubscribe from this list: send the line "unsubscribe ceph-=
devel"
> > >>> in
> > >>> the body of a message to majordomo@vger.kernel.org
> > >>> More majordomo info at http://vger.kernel.org/majordomo-info.ht=
ml
> > >> N=E5=AB=A5=E5=8F=89=E9=9D=A3=E7=AC=A1y=EE=8C=B7=E6=B0=8Ab=E7=9E=82=
=EE=83=91=E5=8D=83v=E8=B1=9D=EF=BF=BD=E8=97=93{.n=EF=BF=BD=E5=A3=8F=E6=B8=
=AE=E6=A6=8Fz=E9=B3=90=E5=A6=A0ay=EF=BF=BD=E8=95=A0=E8=B7=88=EF=BF=BDj=EE=
=84=9Bf=EF=BC=82=E7=A9=90=E6=AE=9D=E9=84=97=EF=BF=BD=E7=95=90=E3=82=A2=EF=
=BF=BD=E2=92=8E=EE=9B=90:+v=E5=A2=BE=E5=A6=9B=E9=91=9A=E8=B1=B0=E7=A8=9B=
=EF=BF=BD=E7=8F=A3=E8=B5=99zZ+=E5=87=92=E6=AE=A0=E5=A8=B8=EE=95=90"=E6=BF=
=9F!=E7=A7=88
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe ceph-de=
vel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at http://vger.kernel.org/majordomo-info.html
> >=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
