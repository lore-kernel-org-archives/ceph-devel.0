From: Sage Weil <sage@newdream.net>
Subject: Re: continuous writing of same file
Date: Wed, 3 Nov 2010 11:13:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1011031111040.8814@cobra.newdream.net>
References: <AANLkTin9ZnME53-wE_ZLNn5TAm+3ibmBZXfBF0G55Oc-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-809346371-1288807996=:8814"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39845 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755849Ab0KCSJt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Nov 2010 14:09:49 -0400
In-Reply-To: <AANLkTin9ZnME53-wE_ZLNn5TAm+3ibmBZXfBF0G55Oc-@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: srimugunthan dhandapani <srimugunthan.dhandapani@gmail.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-809346371-1288807996=:8814
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 3 Nov 2010, srimugunthan dhandapani wrote:
> Hi all,
> I am using kernel client based Ceph version 0.21.1 on linux kernel
> 2.6.35. I am using a six node cluster with 3 machines and 3 virtual
> machines.
> =A0I wrote a simple program to continuously write to a file. After a few
> iterations, the test gets stuck. Sometimes i am unable to unmount the
> ceph mountpt subsequently.

Can you cat /sys/kernel/debug/ceph/*/mdsc and=20
/sys/kernel/debug/ceph/*/osdc?  That will tell us whether it's an mds or=20
osd request that is hanging.  If /sys/kernel/debug isn't there you=20
may need to 'mount -t debugfs none /sys/kernel/debug'.

Is there a reason you're using the versions you are?  Are those the=20
versions in ubuntu?  (They're a bit out of date.)

Thanks-
sage


> I am using the following code
> --
> int main()
> {
>=20
> =A0=A0=A0 FILE *fp;
> =A0=A0=A0 int i;
> =A0=A0=A0 int written_before_stat;
> =A0=A0=A0 int ret_value;
>=20
>=20
> =A0=A0=A0 /* some junk buffer*/
> =A0=A0=A0 char buffer[1024* SIZEOF_ONE_NODE];
>=20
> =A0=A0=A0 char tbuffer[30];
> =A0=A0=A0 struct timeval tv;
>=20
> =A0=A0=A0 time_t curtime;
>=20
> =A0=A0=A0 gettimeofday(&tv, NULL);
> =A0=A0=A0 curtime=3Dtv.tv_sec;
>=20
> =A0=A0=A0 strftime(tbuffer,30,"%m-%d-%Y=A0 %T.",localtime(&curtime));
> =A0=A0=A0 printf("%s%ld\t|",tbuffer,tv.tv_usec);
>=20
>=20
> =A0=A0=A0 printf("starting....\n");
> =A0=A0=A0 printf("infinite loop. Ctrl+C when you wish !!\n");
>=20
> =A0=A0=A0 /* keep writing to the ceph file*/
> =A0=A0=A0 /* infinite loop. Ctrl+C when you wish*/
> =A0=A0=A0 while(1)
> =A0=A0=A0 {
>=20
> =A0=A0=A0 =A0=A0=A0 /* the frenetic writing phase */
>=20
> =A0=A0=A0 =A0=A0=A0 fp =3D fopen("/ceph/test_file1","w");
> =A0=A0=A0 =A0=A0=A0 if(fp =3D=3D NULL)
> =A0=A0=A0 =A0=A0=A0 {
> =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 printf("ceph dir write file open err\n");
>=20
> =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 exit(-1);
> =A0=A0=A0 =A0=A0=A0 }
> =A0=A0=A0 =A0=A0=A0 for(i =3D 0; i < 1024 ;i++)
> =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 fwrite(buffer, sizeof(buffer[0]),
> sizeof(buffer)/sizeof(buffer[0]), fp);
>=20
> =A0=A0=A0 =A0=A0=A0 fclose(fp);
> =A0=A0=A0 =A0=A0=A0 gettimeofday(&tv, NULL);
> =A0=A0=A0 =A0=A0=A0 curtime=3Dtv.tv_sec;
>=20
> =A0=A0=A0 =A0=A0=A0 strftime(tbuffer,30,"%m-%d-%Y=A0 %T.",localtime(&curt=
ime));
> =A0=A0=A0 =A0=A0=A0 printf("%s%ld\t|",tbuffer,tv.tv_usec);
>=20
> =A0=A0=A0 =A0=A0=A0 printf("120MB written..\n");
> =A0=A0=A0 =A0=A0=A0 fflush(stdout);
> =A0=A0=A0 =A0=A0=A0 usleep(1000);
>=20
> =A0=A0=A0 }
>=20
>=20
> }
> --------
> Am i missing something?. Thanks for any help.
>=20
> Thanks,
> Mugunthan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-809346371-1288807996=:8814--
